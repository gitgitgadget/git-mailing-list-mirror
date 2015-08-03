From: Ben Boeckel <mathstuf@gmail.com>
Subject: [PATCH v2] add git-url subcommand
Date: Mon,  3 Aug 2015 17:00:13 -0400
Message-ID: <1438635614-11174-1-git-send-email-mathstuf@gmail.com>
References: <1438364321-14646-1-git-send-email-mathstuf@gmail.com>
Cc: Ben Boeckel <mathstuf@gmail.com>, git@vger.kernel.org
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Mon Aug 03 23:00:34 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZMMqX-0002JB-Hu
	for gcvg-git-2@plane.gmane.org; Mon, 03 Aug 2015 23:00:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755413AbbHCVA3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 Aug 2015 17:00:29 -0400
Received: from mail-ig0-f169.google.com ([209.85.213.169]:36090 "EHLO
	mail-ig0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753932AbbHCVA2 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Aug 2015 17:00:28 -0400
Received: by igbij6 with SMTP id ij6so62224704igb.1
        for <git@vger.kernel.org>; Mon, 03 Aug 2015 14:00:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=oolz7sCofAeNhFfKncSZh7wuch7KO+sWDdqBxo/Zuxc=;
        b=jfHgejstS8ySzuN+dwvfuTYnv60COkhecLJ5wDIj6rIB0iCcTjNsDHLfTR8+uLEqtn
         wtmCYQh7GuF/hFvE3AZafqjqPpf2MDMI/NsG8VsIICChvV2m9uMQjBVlu5q1Q3m5Te9c
         zhQ4cs1sbZ1FphK4BSJWCGF6Xk7DYkP4XNNkMvkUb8PvZMHQI9CDJ3wUI9NUvKqzIGy6
         wo3d65r0/wnPoUr/JqOAOLZYC2OcaH04g69wAopnT6GsyxEwAehnFvsaACtY4nTeMrQs
         9qTD4PS+M/0GPWdBnBxHOnih+WNT3ifUEAkAe+neqwkLloBtp9ZoMYZBcm1Air6c+NNi
         tniQ==
X-Received: by 10.50.50.229 with SMTP id f5mr24144092igo.35.1438635628320;
        Mon, 03 Aug 2015 14:00:28 -0700 (PDT)
Received: from megas (tripoint.kitware.com. [66.194.253.20])
        by smtp.gmail.com with ESMTPSA id y6sm6559321igl.17.2015.08.03.14.00.25
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Mon, 03 Aug 2015 14:00:26 -0700 (PDT)
X-Mailer: git-send-email 2.1.0
In-Reply-To: <1438364321-14646-1-git-send-email-mathstuf@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/275199>

Implements a get-url subcommand to git-remote which allows for querying the
URLs for a remote while expanding insteadOf and pushInsteadOf.

--Ben

Ben Boeckel (1):
  remote: add get-url subcommand

 Documentation/git-remote.txt | 10 ++++++++
 builtin/remote.c             | 55 ++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 65 insertions(+)

-- 
2.1.0

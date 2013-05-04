From: Stefano Lattarini <stefano.lattarini@gmail.com>
Subject: Re: [PATCH v2 2/2] remote-bzr: avoid bad refs
Date: Sat, 04 May 2013 10:39:21 +0200
Message-ID: <5184C939.4080505@gmail.com>
References: <1367627467-15132-1-git-send-email-felipe.contreras@gmail.com> <1367627467-15132-3-git-send-email-felipe.contreras@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Sat May 04 10:39:50 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UYY0U-0003EV-7E
	for gcvg-git-2@plane.gmane.org; Sat, 04 May 2013 10:39:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759059Ab3EDIjj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 4 May 2013 04:39:39 -0400
Received: from mail-ee0-f54.google.com ([74.125.83.54]:36762 "EHLO
	mail-ee0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758962Ab3EDIj2 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 4 May 2013 04:39:28 -0400
Received: by mail-ee0-f54.google.com with SMTP id e49so1090494eek.13
        for <git@vger.kernel.org>; Sat, 04 May 2013 01:39:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:message-id:date:from:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=q0/EAMFT8Tr7ekwHS7SW23KA4iWJhb6Q8/jYP7Qbb0w=;
        b=BF73FtiS/zPr/WX4fOBiYdAXewEzcz9LkR5gRf3bDiALE3Z8Nb6eGxREDxuwo9p39K
         37RO23hXoChHXA/6AYvmE3m2Eua4Fgv/Ss+nmXHwtCqqEzCsSpT2fA4yjjK+2AZ4lXms
         357+YIxzp0QLqSA3cYOdlP9OLuymtsJ+YU6st+13dOFoKWNNZGZO0eW0z4VFO5iTiATu
         0hlTk3hQ2p44ZUw6sNxlZBExY02yVX0K7ozy8xhkBR8OYcjVJwwZsNCh2gQ1wwKzBFl6
         ZszQ6bQE3lFm+0RBE+fJWHioBgru+ogqK7DHoiV7YBXgR6TZkIEVWj+Ubwv/HH8k0CDH
         r43g==
X-Received: by 10.14.214.3 with SMTP id b3mr12088402eep.24.1367656763946;
        Sat, 04 May 2013 01:39:23 -0700 (PDT)
Received: from [192.168.178.20] (host93-95-dynamic.6-79-r.retail.telecomitalia.it. [79.6.95.93])
        by mx.google.com with ESMTPSA id m48sm20461842eeu.15.2013.05.04.01.39.22
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sat, 04 May 2013 01:39:23 -0700 (PDT)
In-Reply-To: <1367627467-15132-3-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/223361>

On 05/04/2013 02:31 AM, Felipe Contreras wrote:
> Turns out fast-export throws bad 'reset' commands because of a behavior
> in transport-helper that is not even needed.
> 
> We should ignore them, otherwise we will threat
>
s/threat/treat/

> them as branches and fail.
> 
> This was fixed in v1.8.2, but some people use this script in older
> versions of git.
> 
> Also, check if the ref was a tag, and skip it for now.

Regards,
  Stefano

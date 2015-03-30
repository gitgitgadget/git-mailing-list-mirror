From: phillip <phillip.szelat@gmail.com>
Subject: Re: [PATCH] l10n: de.po: translate 99 new messages
Date: Mon, 30 Mar 2015 19:27:06 +0200
Message-ID: <9AAB1D29-C6D6-4F4D-996C-81213E62691B@gmail.com>
References: <1427571482-7508-1-git-send-email-ralf.thielow@gmail.com> <55181ED4.7020805@gmail.com> <CAN0XMOJyU+03A1bTdgVc10PLgkg9HjH51zt19oC7A-cARxcmgg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: git <git@vger.kernel.org>, Thomas Rast <tr@thomasrast.ch>,
	=?ISO-8859-1?Q?Jan_Kr=FCger?= <jk@jk.gs>,
	Christian Stimming <stimming@tuhh.de>,
	=?ISO-8859-1?Q?Matthias_R=FCster?= <matthias.ruester@gmail.com>,
	=?ISO-8859-1?Q?Magnus_G=F6rlitz?= <magnus.goerlitz@googlemail.com>
To: Ralf Thielow <ralf.thielow@gmail.com>
X-From: git-owner@vger.kernel.org Mon Mar 30 19:27:29 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YcdT3-0000Kf-0m
	for gcvg-git-2@plane.gmane.org; Mon, 30 Mar 2015 19:27:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753491AbbC3R1N (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 30 Mar 2015 13:27:13 -0400
Received: from mail-wi0-f180.google.com ([209.85.212.180]:37859 "EHLO
	mail-wi0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753246AbbC3R1L (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Mar 2015 13:27:11 -0400
Received: by wiaa2 with SMTP id a2so139585403wia.0
        for <git@vger.kernel.org>; Mon, 30 Mar 2015 10:27:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=user-agent:in-reply-to:references:mime-version
         :content-transfer-encoding:content-type:subject:from:date:to:cc
         :message-id;
        bh=9kDmbqMA2bTFBA7FZa0kaSLRls1/wFJcbwT3YxTGI3s=;
        b=0Fjh0PRCob5h4vdlewOUP6xMRCFlwiIsxQU0u3bXZmRuKlpC2cUwY2BmZ/n2AuULbV
         p2E32N+L9NobnCs3Z5VQEKXSk6AmCybLcSpdJPTrcPsAfnLGqDSHBQQXnuVaSbtRu+Lr
         1OhyRyj/XzsMzPl6yIWkHlf271eQqwn9pjfZybMWMWEZfEhu8pMwBMBXWhDOGvqxKG5G
         RcmTz7632EVv4uPrQMwPw6akTPYRehc7r3RcAo0sULT7jA6mgYyqvbVu2JYbC0uk3bR7
         QvGOJ7GfgFaih9ARi8beA+YoDnTpZEnOwgVP3TiOMWP2jWJLPqKDfgB086+upyOvj0gH
         mXHQ==
X-Received: by 10.194.89.195 with SMTP id bq3mr66648413wjb.123.1427736430352;
        Mon, 30 Mar 2015 10:27:10 -0700 (PDT)
Received: from android-b7bb6bce7d91de53.fritz.box (i59F45514.versanet.de. [89.244.85.20])
        by mx.google.com with ESMTPSA id hl15sm17253655wib.3.2015.03.30.10.27.07
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 30 Mar 2015 10:27:09 -0700 (PDT)
User-Agent: K-9 Mail for Android
In-Reply-To: <CAN0XMOJyU+03A1bTdgVc10PLgkg9HjH51zt19oC7A-cARxcmgg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/266459>



Hi,

>If I read the code correctly, this is an error message that appears
>when
>someone tries to apply a patch that modifies a file with the leading
>directory
>being a symlink.
>

Okey.

>What about skipping the "read" part (because it's an implementation
>detail)
>and translate it as
>"'%s' ist hinter einem symbolischen Verweis"
>to match other similar messages?
>

Good idea, let's use that.

Phillip

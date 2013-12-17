From: =?UTF-8?B?Sm9lIEJvcsSh?= <mail@jdborg.com>
Subject: Fwd: instaweb fails with mongoose
Date: Tue, 17 Dec 2013 15:26:03 +0000
Message-ID: <CAFFYk1W4BcJ5V3OdQWtpmbBdYwt3ZqSd441YOixGDuT1w945Dg@mail.gmail.com>
References: <CAFFYk1VaXCcGXbSXSGmU2TO0bAGQEDvVxKFKtK4PO3a4L8SgAA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Dec 17 16:26:48 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VswXh-0007zF-2C
	for gcvg-git-2@plane.gmane.org; Tue, 17 Dec 2013 16:26:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754134Ab3LQP0c convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 17 Dec 2013 10:26:32 -0500
Received: from starscream.3v0.net ([46.249.202.240]:52249 "EHLO
	starscream.3v0.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753325Ab3LQP0b convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 17 Dec 2013 10:26:31 -0500
Received: from mail-oa0-f46.google.com ([209.85.219.46]:46933)
	by starscream.3v0.net with esmtpsa (TLSv1:RC4-SHA:128)
	(Exim 4.82)
	(envelope-from <mail@jdborg.com>)
	id 1VswXS-000NsT-3m
	for git@vger.kernel.org; Tue, 17 Dec 2013 15:26:26 +0000
Received: by mail-oa0-f46.google.com with SMTP id o6so6761071oag.33
        for <git@vger.kernel.org>; Tue, 17 Dec 2013 07:26:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :content-type:content-transfer-encoding;
        bh=2x6TKTp09eF52qDXAMJcw5Y8tWeEn+XcVELInRDH8wI=;
        b=SyD5Fz+ObuGrM1vdo4rE83vfii2cAqLrSL6GEJqjpUVvGOpz82cKz0S64uQnrJ9x7Q
         kHjjcwmfiYQ28mSWGqcqfnDSAo1+8VBbUxfR2nZgtpOQQqhB/dh4U1XcqouGDCM4hEbg
         WU6wzerE27a4LHdNlQiIoBaPO/rt2gFz/0MosY94WtOi7LuDDvWZIFjxQAPdp4vqOamL
         Beya39WM8OKGGMhUGfsGe31R1V/M4No8ddMrasmQPRNhb4lsGmUfUp8iyt/wg3Nsy/VO
         3QWZgJiilZL3dsEFvkkEh2acxHUSsEbElPhr0LxbzjaZPvvd2JCdNmP+pWcdcqcorH3h
         v5nA==
X-Received: by 10.60.98.69 with SMTP id eg5mr16755757oeb.42.1387293984116;
 Tue, 17 Dec 2013 07:26:24 -0800 (PST)
Received: by 10.76.104.206 with HTTP; Tue, 17 Dec 2013 07:26:03 -0800 (PST)
In-Reply-To: <CAFFYk1VaXCcGXbSXSGmU2TO0bAGQEDvVxKFKtK4PO3a4L8SgAA@mail.gmail.com>
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - starscream.3v0.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - jdborg.com
X-Get-Message-Sender-Via: starscream.3v0.net: authenticated_id: mail+jdborg.com/only user confirmed/virtual account not confirmed
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/239390>

Using git 1.8.5 and Mongoose 3.7 (also tried 5.0), I cannot start the
instaweb server.

$ git instaweb --httpd=3Dmongoose
Loading config file /scratch/workspace/git/myproject/.git/gitweb/mongoo=
se.conf
=46ailed to set option [root]: No such option
Waiting for 'mongoose' to start
=2E....................................................................=
=2E..........^C

Regards,
Joseph David Bor=C4=A1

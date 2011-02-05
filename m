From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: GIT - cloning torvalds/linux-2.6.git repository trouble.
Date: Sat, 5 Feb 2011 20:10:41 +0100
Message-ID: <AANLkTim996+Ho_=xjkzOrGx65-6ajtObLVLwD5E0v4MW@mail.gmail.com>
References: <AANLkTikiKagzJMh_xuOSzfA4c-qxOHhVeU2jhmbaDHji@mail.gmail.com>
 <AANLkTi=FAWh9T3HaocdKB7V4osRPsehTo=hTP0U-JbfR@mail.gmail.com>
 <AANLkTi=E3gWG2-3nLBW6JP+Wks2=4oUWSNSpk0=qEaU-@mail.gmail.com> <AANLkTikYPHhVaKYsQpZ2FhjxAdLetPgkPFQ-b-VtkBTJ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Valentin QUEQUET <valentin.quequet@gmail.com>
X-From: git-owner@vger.kernel.org Sat Feb 05 20:11:29 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PlnXb-0004ud-R0
	for gcvg-git-2@lo.gmane.org; Sat, 05 Feb 2011 20:11:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753436Ab1BETLX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 5 Feb 2011 14:11:23 -0500
Received: from mail-iw0-f174.google.com ([209.85.214.174]:38324 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753273Ab1BETLW (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 5 Feb 2011 14:11:22 -0500
Received: by iwn9 with SMTP id 9so3280357iwn.19
        for <git@vger.kernel.org>; Sat, 05 Feb 2011 11:11:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type;
        bh=VGPIsCbOITe798//vF9hbQ2gHG/1ZXLfFTTVW/cJDpA=;
        b=ApM7+QVsVrXxERubrqqJqmWMjpwM4C/7mdNvDzHo0JhdjyMK6A5bwedJB6bsJK4cl1
         0pq1HunKI6NLQ1Sw6iv/ocodM7fQJwqU7W5XfHzbmwl8LcvWLjZscD8a1t3FtXjspCom
         9yQpCEjPtENSbT7zyXjVDv3MMfwmSHpfMgHp0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=SqK9+sVxWQODfFd9wMw4hXpb3UWh0Im7hrbNkPNvNKm5yniAWdTAxHECoN8x+2Rby5
         82B4aWpaJTJEmKrI3MKakuJ6gisujuJ0gEdtLB+QGpOHwAmTo3wbZImnb+d0B4kt4xDU
         HWQJKCHzzxb0TrM3stbhnjLKPH6Vh9eG3ajOA=
Received: by 10.231.207.71 with SMTP id fx7mr14782821ibb.127.1296933081850;
 Sat, 05 Feb 2011 11:11:21 -0800 (PST)
Received: by 10.231.39.140 with HTTP; Sat, 5 Feb 2011 11:10:41 -0800 (PST)
In-Reply-To: <AANLkTikYPHhVaKYsQpZ2FhjxAdLetPgkPFQ-b-VtkBTJ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/166114>

Heya,

On Sat, Feb 5, 2011 at 20:08, Valentin QUEQUET
<valentin.quequet@gmail.com> wrote:
> This was one of the 1st things I tried in order to get a
> fully-functional repository.

Ok, so what happened when you tried? What did 'git fsck' tell you? If
it doesn't error out, try running 'git repack' followed by 'git
checkout -t origin/master'?

-- 
Cheers,

Sverre Rabbelier

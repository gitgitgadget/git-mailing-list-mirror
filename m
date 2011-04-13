From: Joshua Juran <jjuran@gmail.com>
Subject: Re: Gitbox
Date: Wed, 13 Apr 2011 15:23:49 -0700
Message-ID: <4238CC86-13A5-4DB8-B8B2-BC3AA2F2DA5E@gmail.com>
References: <BANLkTikfCDm-5Yde=2Cm-ROc1dcMwopvOg@mail.gmail.com>
Mime-Version: 1.0 (Apple Message framework v936)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Cc: "Randal L. Schwartz" <merlyn@stonehenge.com>,
	Drew Northup <drew.northup@maine.edu>, oleganza@gmail.com,
	Junio C Hamano <gitster@pobox.com>,
	Chris Perkins <cperkins@medialab.com>, git@vger.kernel.org,
	Daniel Searles <dsearles@medialab.com>
To: Daniel Searles <daniel.paul.searles@gmail.com>
X-From: git-owner@vger.kernel.org Thu Apr 14 00:24:01 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QA8Tg-0002Lw-3z
	for gcvg-git-2@lo.gmane.org; Thu, 14 Apr 2011 00:24:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933299Ab1DMWXy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Apr 2011 18:23:54 -0400
Received: from mail-yw0-f46.google.com ([209.85.213.46]:51067 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933296Ab1DMWXx (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Apr 2011 18:23:53 -0400
Received: by ywj3 with SMTP id 3so443820ywj.19
        for <git@vger.kernel.org>; Wed, 13 Apr 2011 15:23:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:cc:message-id:from:to:in-reply-to:content-type
         :content-transfer-encoding:mime-version:subject:date:references
         :x-mailer;
        bh=Ba7gANzZMgm3DN3CL5CCJad22ssfb/kvWAD73N484Ec=;
        b=v4xFdZqA8LSSNZUWA+ZhuUW1Xf8LwNCxoVH7VRwp022sTHt2k2lsDPZ3GGtbAJFoyZ
         1sTE5S7/RvyvQhjom7yIYyUfZyKVgok1yTtUYAw29xpAQUTKa387NlSD25CmHHX9u8iZ
         in8izFUyQAfoHMX/FvKoIeLM1AUkPS1FL5OFE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=cc:message-id:from:to:in-reply-to:content-type
         :content-transfer-encoding:mime-version:subject:date:references
         :x-mailer;
        b=dhm2Ltm9wOxpgILK0qc+QfTkUIID6/kMODM8sm1Mjl21n/hApKuoBwRqJ8ZgoT038n
         1LStlxNz/ItRJuTkqCWv2VzeJosQ/FjEIE/0Fp1gCvpC/gWQZBfoaExG6FxBP3OLZfas
         dpxfIQqyUk7IK2FnXriwX2u0K7d/otOQPV8Y8=
Received: by 10.42.73.9 with SMTP id q9mr44407icj.44.1302733432968;
        Wed, 13 Apr 2011 15:23:52 -0700 (PDT)
Received: from zaphod.jjuran.dyndns.org (c-71-227-175-60.hsd1.wa.comcast.net [71.227.175.60])
        by mx.google.com with ESMTPS id o3sm709023ibd.27.2011.04.13.15.23.50
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 13 Apr 2011 15:23:51 -0700 (PDT)
In-Reply-To: <BANLkTikfCDm-5Yde=2Cm-ROc1dcMwopvOg@mail.gmail.com>
X-Mailer: Apple Mail (2.936)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/171493>

On Apr 13, 2011, at 3:17 PM, Daniel Searles wrote:

> I apologize for the empty email. My SMTP server is having problems.  
> That is why I'm going to use this email address to write to the list.

Gah, stop doing that!  :-)

> I feel that gitbox and perhaps other commercial tools for git are in  
> violation of the GPL simply since they rely on git in order to be  
> useful. Take git away from gitbox and it serves no purpose. The  
> thread in the following link goes into depth with regards to a  
> program relying on code that is under a GPL license. The conclusion  
> made in the thread may be due to an older version of the GPL. Could  
> it be that gitbox isn't in violation of the GPL since git uses GPL  
> version 2.0 exclusively?
>
> http://clisp.cvs.sourceforge.net/viewvc/clisp/clisp/doc/Why-CLISP-is-under-GPL


My shell scripts that call git are also useless without Git.  Am I not  
allowed to distribute my scripts under non-GPL terms?  (And what about  
a script that calls the nonexistent blort utility, and then someone  
writes blort and distributes it under the GPL?)  As I understand it,  
the GPL (and the thread you mention) address linking, not utility.

RMS seemed to win this debate by arguing that his position was better  
for the community.  I have colleagues who understand that Git is the  
best VCS available but are concerned about having to train users who  
are used to IDEs.  I've used a couple open source Git viewers and  
would hesitate to recommend them.  The option to use GitBox makes  
adoption of Git more likely in this case.

CVS is a GNU project.  Did FSF go after proprietary cvs wrappers?

Josh

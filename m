From: Ray Chen <rchen@cs.umd.edu>
Subject: Re: [PATCH/RFC] git-svn: New flag to add a file in empty directories
Date: Wed, 18 May 2011 07:10:23 -0400
Message-ID: <BANLkTinvFKAsh5N92rSH26Y12dV6bPQFUw@mail.gmail.com>
References: <1305669635-10861-1-git-send-email-rchen@cs.umd.edu>
 <4DD373CD.6010607@alum.mit.edu> <20110518083314.GA22204@dcvr.yhbt.net> <4DD38DEE.4080604@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Eric Wong <normalperson@yhbt.net>,
	Michael Haggerty <mhagger@alum.mit.edu>, git@vger.kernel.org
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Wed May 18 13:10:50 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QMeeP-0005pG-Fm
	for gcvg-git-2@lo.gmane.org; Wed, 18 May 2011 13:10:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932900Ab1ERLKo convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 18 May 2011 07:10:44 -0400
Received: from mail-yi0-f46.google.com ([209.85.218.46]:64337 "EHLO
	mail-yi0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932763Ab1ERLKn convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 18 May 2011 07:10:43 -0400
Received: by yia27 with SMTP id 27so486631yia.19
        for <git@vger.kernel.org>; Wed, 18 May 2011 04:10:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:sender:in-reply-to:references:from
         :date:x-google-sender-auth:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=DjDxIrqL9nAybfIizQmHH/Z0i9/GCDfKR73YA1Yypik=;
        b=LPGY8ZRVlcHbQp6qpZsU9iGbSUwaBLItCf8sGoVUAWRvp7sTeoqkMaLeNL2BQh8f5A
         b+C4cF3ZTNFjimiGT/d/3Ouaq5YdO0nSpYioIN2mJo1vs9Soq64UTo3ZMndyJRxhdCDc
         KTmk5H+ieMjXdBZexaPvvalPQe/FHkIHS6tqk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:sender:in-reply-to:references:from:date
         :x-google-sender-auth:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        b=TLh1g4+i655pffjF/X/4Cbo1lMN6mLQ2G0HK1FMTRuXaXnbKJo/O9YhQZ0e/qdAdCd
         laPe54PjEUqbcIWz4w7JeuatsteXklGBD9SLFyEVwe9wnRRlqAQU+/xYazxdwqQYol7x
         U53XTfdSGqHXzPK4Vpp35dVyGCAnq+TSDV0c4=
Received: by 10.236.156.202 with SMTP id m50mr1777641yhk.407.1305717043084;
 Wed, 18 May 2011 04:10:43 -0700 (PDT)
Received: by 10.236.111.44 with HTTP; Wed, 18 May 2011 04:10:23 -0700 (PDT)
In-Reply-To: <4DD38DEE.4080604@drmicha.warpmail.net>
X-Google-Sender-Auth: hKrS8M2xyQAL1P-NYHI_j4ejR2o
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/173872>

On Wed, May 18, 2011 at 5:14 AM, Michael J Gruber
<git@drmicha.warpmail.net> wrote:
>>
>> I strongly believe git-svn should leave no trace. =A0Nobody but the =
user
>> using git-svn should know they're using git-svn to interact with an =
SVN
>> repo. =A0This allows users to stay under the radar of any idiotic ru=
les
>> (or knee-jerk reactions of FUD) their organization may have against
>> using non-standard SVN clients. =A0So far, it's worked out pretty we=
ll,
>> git-svn users slowly and quietly develop clout and influence to migr=
ate
>> their repos from SVN to git.
>
> git-svn's maintenance of these files would be simpler if we used a
> special file for that, say .git-svn-empty-dir, and teach dcommit to
> ignore it. That way git clones can share it and git svn dcommit is
> unimpaired. The only problem occurs when a new git-svn commits these,
> and old git clones that and an old git-svn dcommits from that clone.
>

I'll let people more experienced than I come to a conclusion on this on=
e.

I can say I'm loath to spend a lot of time on this, given that it
might all be replaced within two months by Dmitry Ivankov's GSoC
project.

- Ray

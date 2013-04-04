From: Jed Brown <jed@59a2.org>
Subject: Re: [PATCH v2 11/13] remote-hg: force remote push
Date: Thu, 04 Apr 2013 15:48:08 -0500
Message-ID: <87li8yqayf.fsf@59A2.org>
References: <1365089422-8250-1-git-send-email-felipe.contreras@gmail.com> <1365089422-8250-12-git-send-email-felipe.contreras@gmail.com> <87y5cyqhya.fsf@59A2.org> <CAMP44s1b_SWkVXe2Vyzs2yj1M9Z-2KcCXbp9LCJ_oWxuC+2pAg@mail.gmail.com> <87ppyaqcie.fsf@59A2.org> <CAMP44s16Yt0mL8FKXMVgLBXw7s9_S8hGyS0YNHX7GrsAXYNDfg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>, Max Horn <max@quendi.de>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Thu Apr 04 22:48:44 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UNr5O-0002xY-MC
	for gcvg-git-2@plane.gmane.org; Thu, 04 Apr 2013 22:48:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761445Ab3DDUsM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Apr 2013 16:48:12 -0400
Received: from mail-oa0-f46.google.com ([209.85.219.46]:45649 "EHLO
	mail-oa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761378Ab3DDUsL (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Apr 2013 16:48:11 -0400
Received: by mail-oa0-f46.google.com with SMTP id k1so3292467oag.19
        for <git@vger.kernel.org>; Thu, 04 Apr 2013 13:48:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:sender:from:to:cc:subject:in-reply-to:references
         :user-agent:date:message-id:mime-version:content-type;
        bh=Demm2okNPeC1A0A+6q8P4nmjCeMbCzinNITMTIHsVI0=;
        b=jPKfQglW6tS+TmeucJkIrtEFae0s23t5pSkK+gxAE1iC9D06k3snZtPc9Yk5WAOSzg
         OgkXedXBPZi8WU2HXpoVbz//scrpf1BrX7HrZL1BXJdzvhVrVKiFG06Nrk9ZERLkmYty
         5xNViywyL5j/nk9YT9cjgfUOVN923+IeJlqUglSqzYqCTdm5xzRm2F8W2XhrAefUYoXZ
         rUqzaGveKb/jGlPoAgqCVnanrXhqoeKsZP9Pn8O1TEGyTmVnc6T5C9sxiT0guca3rh61
         Y3RrFj3DQCBD0sf809V4FyjRmAhUCkKQIOTTS/wPlWH5O1wjUpHSFKFRm+MiFuRL37hb
         vd4A==
X-Received: by 10.60.172.84 with SMTP id ba20mr5666468oec.10.1365108490345;
        Thu, 04 Apr 2013 13:48:10 -0700 (PDT)
Received: from localhost (vis-v410v070.mcs.anl-external.org. [130.202.17.70])
        by mx.google.com with ESMTPS id a3sm8856887oee.8.2013.04.04.13.48.08
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Thu, 04 Apr 2013 13:48:09 -0700 (PDT)
In-Reply-To: <CAMP44s16Yt0mL8FKXMVgLBXw7s9_S8hGyS0YNHX7GrsAXYNDfg@mail.gmail.com>
User-Agent: Notmuch/0.15.2 (http://notmuchmail.org) Emacs/24.3.1 (x86_64-unknown-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/220098>

Felipe Contreras <felipe.contreras@gmail.com> writes:


[...]

>> will need to play by those rules.
>
> No, we don't. The fact that you say so doesn't make it so.

Then perhaps we have different goals [1].  I don't know any Git User that
would prefer to have an Hg upstream accessed through remote-hg.  We have
to assume that every Git (remote-hg) User is dealing with Hg Team that
is setting the rules, since otherwise Git User would just change the
whole damn project to Git and be done with it.  In that sense, it is
inappropriate to do things that are likely to make Hg Team yell at Git
User.

> I create a branch felipec-bookmarks, and I push as many heads as I
> wish. Who will get affected? Nobody.

Every Hg user will see those heads by default every time they run 'hg
log' or 'hg heads'.

> And who says we are committing upstream?

The discussion is moot if you don't want to push your commits upstream.


[1] As I mentioned earlier, I don't need either tool any more.

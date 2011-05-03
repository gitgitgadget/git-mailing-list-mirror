From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: Creating remote branch called HEAD corrupts remote clones
Date: Tue, 3 May 2011 22:20:32 +0300
Message-ID: <BANLkTik18oTdNa1A99QAXJ9vz105jC3gLA@mail.gmail.com>
References: <ih1449$ul6$1@dough.gmane.org>
	<7v62tjs66r.fsf@alter.siamese.dyndns.org>
	<20110120203840.GA11468@sigill.intra.peff.net>
	<7vbp3bqmiy.fsf@alter.siamese.dyndns.org>
	<20110120215456.GB11468@sigill.intra.peff.net>
	<AANLkTikBbSt5_WdbuE8a96w1pWBCYLNjMCUCBThjdLdG@mail.gmail.com>
	<7vk4hyp38i.fsf@alter.siamese.dyndns.org>
	<AANLkTikmbWkpjioARZrmySpLM8t7kqCX0v1+NKibk_ar@mail.gmail.com>
	<AANLkTinRcmevXz3zV0wtxd7+Q3F4zcH2AZOQk1XVxYXa@mail.gmail.com>
	<BANLkTim1gW_L-9DKo9p_VFQFUBUGWAPxoA@mail.gmail.com>
	<BANLkTinKDHM-RU2wqZECFcjQEoRWADnTGQ@mail.gmail.com>
	<BANLkTimFas5YLt37RLuCppkQ4ZGhmj56Cg@mail.gmail.com>
	<BANLkTinkR+jEKkno30fiHBZ-PMVvvv7FxQ@mail.gmail.com>
	<BANLkTi=DgXrWZ0ObBYi2mgk-+8w8iXM7VQ@mail.gmail.com>
	<BANLkTimLnggco_+mQZ2_T_myAHsDD-=g1w@mail.gmail.com>
	<BANLkTikxS-_9h4rBdbbJ2e-RkjMWyiC1Mg@mail.gmail.com>
	<BANLkTinqxy6jCJLNVPKmMW3CErbfN7Hm=g@mail.gmail.com>
	<BANLkTinJvt=Nnt8YG-D1wpWKbBei+m+4XA@mail.gmail.com>
	<BANLkTinCSotWC-kbPDJc57NZM29hizYKpA@mail.gmail.com>
	<BANLkTimHfH-o6Fyoo61xVFxAhELNmD=4xg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: kusmabite@gmail.com, Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>, git@vger.kernel.org
To: Stephen Kelly <steveire@gmail.com>
X-From: git-owner@vger.kernel.org Tue May 03 21:20:40 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QHL9D-0006nQ-F3
	for gcvg-git-2@lo.gmane.org; Tue, 03 May 2011 21:20:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754558Ab1ECTUe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 May 2011 15:20:34 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:55372 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754508Ab1ECTUd (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 May 2011 15:20:33 -0400
Received: by fxm17 with SMTP id 17so330875fxm.19
        for <git@vger.kernel.org>; Tue, 03 May 2011 12:20:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=9MYoyOf0L44IxM7WQmm3N1Byq6VqaZqNTu8KdhaUs68=;
        b=bN5CLiNmtG7U0ElrmT0xFEvVT7wov9iFB0O8t+2y+bd3ZUk/SSvCtyvLUxlSgC57hJ
         dwMyTJUblOhSqgMXIIE2MvBFLzsVoQmOXNziFf/BCwJQYOLM6RP1Ki/0Irg3VQo8dsK/
         uFldIhgyiaw1sPZkleraKByVrUvkTMV+gX0m8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=nvRzlMYO8nvpOY0gaBycgxGXGsTTFdy3HbOa7p3mlRNKMDgxA+ORXHdHw346frlcwO
         kRb3o8kn9LLVRgIitEDHjAkIO/mRpWx2W7o0m55Bu4bOgrOj8Xb0EzardiOmbbPAGfBm
         dCwTcIX5grmHkJXKXYtua36UbtU4KtanBN2AM=
Received: by 10.223.24.134 with SMTP id v6mr206507fab.146.1304450432401; Tue,
 03 May 2011 12:20:32 -0700 (PDT)
Received: by 10.223.74.130 with HTTP; Tue, 3 May 2011 12:20:32 -0700 (PDT)
In-Reply-To: <BANLkTimHfH-o6Fyoo61xVFxAhELNmD=4xg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/172686>

On Tue, May 3, 2011 at 9:08 PM, Stephen Kelly <steveire@gmail.com> wrote:
> On Tue, May 3, 2011 at 7:54 PM, Felipe Contreras
> <felipe.contreras@gmail.com> wrote:
>> On Mon, May 2, 2011 at 10:43 PM, Erik Faye-Lund <kusmabite@gmail.com> wrote:
>>> No, it's still an issue, and I believe I pin-pointed it in my first
>>> mail. You can try out the patch I sent, and see if that helps in your
>>> case. If it does, I think it'd make sense to do something (preferably
>>> a bit more robust) with it.
>
> I don't have a build of git at the moment to test it as I'm using
> distro packages again. The only test case I have is the alice and bob
> stuff already posted, so if your patch fixes that for you that's good
> enough from my POV.

As I said, 'gitk --all' works fine, the patch would fix 'gitk'.

-- 
Felipe Contreras

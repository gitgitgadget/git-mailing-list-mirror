From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 2/3] t: mailmap: add 'git blame -e' tests
Date: Sat, 4 Feb 2012 15:13:51 -0600
Message-ID: <20120204211351.GB3278@burratino>
References: <1328385024-6955-1-git-send-email-felipe.contreras@gmail.com>
 <1328385024-6955-3-git-send-email-felipe.contreras@gmail.com>
 <20120204201027.GE22928@burratino>
 <CAMP44s3tmiPGgAUakUgoen2aJcsKw4CygtF5f=4x2dxNTrGbGA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Marius Storm-Olsen <marius@trolltech.com>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Sat Feb 04 22:14:26 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RtmwC-00011m-KS
	for gcvg-git-2@plane.gmane.org; Sat, 04 Feb 2012 22:14:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753928Ab2BDVOU convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 4 Feb 2012 16:14:20 -0500
Received: from mail-iy0-f174.google.com ([209.85.210.174]:45397 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753238Ab2BDVOT convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 4 Feb 2012 16:14:19 -0500
Received: by iacb35 with SMTP id b35so6496999iac.19
        for <git@vger.kernel.org>; Sat, 04 Feb 2012 13:14:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=X+V382bBMSxRrqsP97hQ5DDItTaXnk3GvpAOyfw4G9I=;
        b=Ys01qtDnROoZoSrFGQWfyKzoIwM2qE54kB7j6Uhi4welpsjQWr3CnoLHgl69dbJ/te
         1c952Qtsj4+x9wKrM612Isri2p+Ch5wZ7smEa7ncG6b6owDXePN3fUjTSS/akRGgBKVg
         civ1rkJlO+mUlv2QnjPMe0dKQQFJlkHDn60Rg=
Received: by 10.50.213.41 with SMTP id np9mr11886015igc.21.1328390059103;
        Sat, 04 Feb 2012 13:14:19 -0800 (PST)
Received: from burratino (c-24-1-56-9.hsd1.il.comcast.net. [24.1.56.9])
        by mx.google.com with ESMTPS id ey5sm464831igb.4.2012.02.04.13.14.18
        (version=SSLv3 cipher=OTHER);
        Sat, 04 Feb 2012 13:14:18 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <CAMP44s3tmiPGgAUakUgoen2aJcsKw4CygtF5f=4x2dxNTrGbGA@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/189910>

=46elipe Contreras wrote:
> On Sat, Feb 4, 2012 at 10:10 PM, Jonathan Nieder <jrnieder@gmail.com>=
 wrote:

>> Since I didn't receive a copy of the cover letter or patch 1, I don'=
t
>> know what this is intended to test _for_. =C2=A0Good --- I can more =
easily
>> convey the reaction of future readers who do not necessarily know th=
e
>> context in which the patch was written (and the commit message does
>> not seem to say).
[...]
> Look at the title:
> add 'git blame -e' tests
>
> s/blame/blame -e/

And?  After copy/pasting this particular test with that substitution,
what do we get a test for?  What class of problem is it supposed to
catch?  I do not think a sentence or two is too much to ask for.

By the way, "I blindly copy/pasted" does not seem like a very sensible
excuse for writing meaningless code (such as the "# git blame" comment
line).  Before the code contained one riddle.  Afterwards it has two.

Hope that helps,
Jonathan

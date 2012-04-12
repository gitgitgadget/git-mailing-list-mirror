From: Michael Witten <mfwitten@gmail.com>
Subject: Re: [PATCH RESEND] send-email: add 'specify-author' option
Date: Thu, 12 Apr 2012 15:59:41 -0000
Message-ID: <87520431c0b04cd4b78aac481d81002b-mfwitten@gmail.com>
References: <1333714876-21895-1-git-send-email-felipe.contreras@gmail.com>
            <7vobr4236g.fsf@alter.siamese.dyndns.org>
            <CAMP44s1b=HfhPNkmiEjPnQpupd0FPBNgVyp5Sw=zFVTdqmJXEg@mail.gmail.com>
            <7vbon41ugg.fsf@alter.siamese.dyndns.org>
            <CAMP44s1m2exUVRTzcBJrY8hnWxF+uEt58AQOP5vKiA3tfeRXRQ@mail.gmail.com>
            <7vobr4ze5z.fsf@alter.siamese.dyndns.org>
Cc: Felipe Contreras <felipe.contreras@gmail.com>,
	Thomas Rast <trast@student.ethz.ch>,
	Pierre Habouzit <madcoder@debian.org>,
	Pascal Obry <pascal@obry.net>,
	Jay Soffian <jaysoffian@gmail.com>,
	David Brown <git@davidb.org>, Matthew Wilcox <matthew@wil.cx>,
	"Robin H. Johnson" <robbat2@gentoo.org>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Apr 12 18:01:21 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SIMSQ-00077o-IE
	for gcvg-git-2@plane.gmane.org; Thu, 12 Apr 2012 18:01:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932991Ab2DLQBJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 Apr 2012 12:01:09 -0400
Received: from mail-lb0-f174.google.com ([209.85.217.174]:59338 "EHLO
	mail-lb0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932965Ab2DLQBH (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Apr 2012 12:01:07 -0400
Received: by lbbgm6 with SMTP id gm6so1726891lbb.19
        for <git@vger.kernel.org>; Thu, 12 Apr 2012 09:01:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=subject:date:from:to:cc:message-id:in-reply-to:references;
        bh=TwTk7R3BLW6OOa7s0DVADlj/a0wPqeRaZccotLxz6X0=;
        b=hKzJ6aMBJkOWhbjnmosm8x9LOFekLrsMGNKmGWVa0cpM4td4JaM1Rfgm9XrunICo9L
         ysAnWaBe+vsUi0IrxdKsd0sh0aoHnhf1rdOAmCL1U15MuzKEC7h2rhGQtB4HQfos83S5
         GlvGsXCVBp/pIcEUqj3sIvGxqotsTqeV17cWOmcOR7oBUAQ3bn5rbYllPiBFphklkuAy
         k30ptGYGalcUrKMwqco+ebbuTgvn8V6UnM/7ubANcEjnIo4awDnScCxdw/bTMmaWHdxI
         iRQRya0YcD1Vzf9o0JCGH6BcVHuPgnRkI2C/cilihR2eXZKz5Q2wQD3ZFPvT83YtXSEH
         SBVQ==
Received: by 10.152.129.137 with SMTP id nw9mr2643673lab.48.1334246466079;
        Thu, 12 Apr 2012 09:01:06 -0700 (PDT)
Received: from gmail.com (exit2.ipredator.se. [93.182.132.103])
        by mx.google.com with ESMTPS id mm11sm6593029lab.2.2012.04.12.09.00.42
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 12 Apr 2012 09:01:04 -0700 (PDT)
In-Reply-To: <7vobr4ze5z.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/195342>

On Fri, 06 Apr 2012 15:30:32 -0700, Junio C Hamano wrote:

> Felipe Contreras <felipe.contreras@gmail.com> writes:
>
>> I can't foresee that, but I guess we can do it anyway. So which would
>> be the fields to repeat? From, Date, and Subject?
> 
> I would say From and Subject are equally worth considering.

Famous last words: "I can't foresee that."

My impression from Junio's initial comment:

>>> The first paragraph of the proposed commit log message states the problem
>>> it tries to address very clearly, which is good, but is "From: " the only
>>> thing that needs this?  I am wondering if this should be named and behave
>>> more like "--duplicate-header" or "--in-body-header".

is that a more general solution should be sought, particularly because we
indeed can't foresee people's needs. I envisioned `--in-body-header' taking
as an argument a colon-separated list of headers that should be inlined;
let the user mix and match as he pleases, and save us trouble in the
future when new headers pop up (I can't forsee that happening, but, well,
who knows?).

Naturally, a configuration variable could be useful.

Sincerely,
Michael Witten

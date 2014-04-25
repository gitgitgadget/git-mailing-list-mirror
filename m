From: Philippe Vaucher <philippe.vaucher@gmail.com>
Subject: Re: What is missing from Git v2.0
Date: Fri, 25 Apr 2014 09:35:53 +0200
Message-ID: <CAGK7Mr5aR36X3x=jcsRWyuo9cS0qGud114gSJECPW0rOWqUFKw@mail.gmail.com>
References: <5356c1a61f6d8_463e11ef310a5@nysa.notmuch> <20140422213039.GB21043@thunk.org>
 <alpine.DEB.2.02.1404221523060.14881@nftneq.ynat.uz> <53588713347b7_59ed83d308cf@nysa.notmuch>
 <CAHYYfeHeJYZ67chSTQk2grsFGr07KXcVNR-T6kOPo0bVYDm59g@mail.gmail.com>
 <53588f448d817_59ed83d3084e@nysa.notmuch> <CAHYYfeFKW93GH+6-ssR5L_uoo3OL2-LFAsj-4+8uEmL0BhT3ow@mail.gmail.com>
 <5358bae8ab550_1f7b143d31037@nysa.notmuch> <877g6fb2h6.fsf@fencepost.gnu.org>
 <5358ca1a55a69_1f7b143d3101c@nysa.notmuch> <20140424134106.GA27035@thunk.org> <CALbm-EbBj1hCF=rFfeBbzeVmffRHVEEE=HSbVZxw-=-=p2BvEQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "Theodore Ts'o" <tytso@mit.edu>,
	Felipe Contreras <felipe.contreras@gmail.com>,
	David Kastrup <dak@gnu.org>,
	James Denholm <nod.helm@gmail.com>, David Lang <david@lang.hm>,
	Junio C Hamano <gitster@pobox.com>,
	Sebastian Schuberth <sschuberth@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Stefan Beller <stefanbeller@gmail.com>
X-From: git-owner@vger.kernel.org Fri Apr 25 09:36:33 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WdagT-00044O-5Y
	for gcvg-git-2@plane.gmane.org; Fri, 25 Apr 2014 09:36:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752122AbaDYHg2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 25 Apr 2014 03:36:28 -0400
Received: from mail-ob0-f171.google.com ([209.85.214.171]:50520 "EHLO
	mail-ob0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751664AbaDYHgZ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 Apr 2014 03:36:25 -0400
Received: by mail-ob0-f171.google.com with SMTP id uy5so3879548obc.30
        for <git@vger.kernel.org>; Fri, 25 Apr 2014 00:36:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=wxFQQjYSaMV0pyRzq8TS/WO8s4wkDdRgaHkVcLgq+p0=;
        b=lnYS/KLW0nNgRWK3nZ1JeMprOu34nYGsi39bepdl5WDS5AM6wfhgw6lHUNC9G4u5WU
         TNMt4V163j0rwaltOhq2oxCHW2Bzay+9CyF3K3L1gEuS9C5GCbkhDTJI2LBs9ygmAxAx
         PVSgcv2RZj+ks1D3hZDDB3NblmBxeu2/yIcso/mkGff1khsRUgclQ6Y0ta9rjOUKWK9w
         d+xbT7iq17rBv3DQ9akR24Q42D8dK5uXiwJoZ38NQC8Wk6Y/TVl/c9FlEPrTrDRo8Djj
         QEINrO3Znci3b601JrcZ0ZAzhJqM/xtGuJ+ETkyUC2lS8Kour65rCTmRVCvM4/Cvf3dZ
         U7QQ==
X-Received: by 10.182.142.229 with SMTP id rz5mr5750798obb.12.1398411384911;
 Fri, 25 Apr 2014 00:36:24 -0700 (PDT)
Received: by 10.76.85.229 with HTTP; Fri, 25 Apr 2014 00:35:53 -0700 (PDT)
In-Reply-To: <CALbm-EbBj1hCF=rFfeBbzeVmffRHVEEE=HSbVZxw-=-=p2BvEQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/247036>

> > I don't even think we need to query the user to fill out all of the
> > fields.  We can prepopulate a lot of the fields (name, e-mail address,
> > etc.) from OS specific defaults that are available on most systems ---
> > specifically, the default values we would use the name and e-mail
> > address are not specified in a config file.
>
> Please don't. Or you end up again with Commiters like sb@localhost,
> sbeller@(None) or alike. I mean it's just one question once you setup
> a new computer, so I'd really like to see that question and then
> answer myself (at university/employer I might put in another email
> address than at home anyway, and I'm sure my boxes have no sane
> defaults)

Yes, try to guess a good default but let the user change it if he
wants to, and if he presses enter the default is used. It's not a big
deal to have to press enter a few times the first time you use git.

That or make a new "git setup" command which interactively sets up
your .gitconfig.

Philippe

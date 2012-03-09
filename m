From: Jeremy Morton <jeremy@configit.com>
Subject: Re: git push default behaviour?
Date: Fri, 9 Mar 2012 11:28:58 +0000
Message-ID: <CAFsnPqoWEv_Mp5-WXZo9TOjf67CxbNzuzeK_EikK20u0DuF3bQ@mail.gmail.com>
References: <CAFsnPqp1+jX3ZY0LZ1QDmvA=2_ebApPBttwFjr36OuTX2_MHug@mail.gmail.com>
	<87k42vs8pi.fsf@thomas.inf.ethz.ch>
	<CAFsnPqopZEZeeuFzK4ZoUjGnfpiv5oMs=xV5XBSgSyGLXOwgqA@mail.gmail.com>
	<1331202483.21444.11.camel@beez.lab.cmartin.tk>
	<CAFsnPqpnH2CTki8zz6Mpz=qrdxF_aTA92cPrn1L9MQZVMoxdeg@mail.gmail.com>
	<1331203321.21444.13.camel@beez.lab.cmartin.tk>
	<CAFsnPqpoBLHoshgv0MsUUStA3Q=niM8hP9yaHr+rSQvh-JWHZA@mail.gmail.com>
	<7vlinbdkb0.fsf@alter.siamese.dyndns.org>
	<vpq1up3aqk8.fsf@bauges.imag.fr>
	<7vty1ydh7p.fsf@alter.siamese.dyndns.org>
	<vpqr4x26vyp.fsf@bauges.imag.fr>
	<7vipie85nk.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	=?ISO-8859-1?Q?Carlos_Mart=EDn_Nieto?= <cmn@elego.de>,
	Thomas Rast <trast@inf.ethz.ch>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Mar 09 12:29:14 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S5y0S-0006yv-T9
	for gcvg-git-2@plane.gmane.org; Fri, 09 Mar 2012 12:29:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752934Ab2CIL3E convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 9 Mar 2012 06:29:04 -0500
Received: from mail-lpp01m010-f46.google.com ([209.85.215.46]:52348 "EHLO
	mail-lpp01m010-f46.google.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752541Ab2CIL3D convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>); Fri, 9 Mar 2012 06:29:03 -0500
Received: by lahj13 with SMTP id j13so1537553lah.19
        for <git@vger.kernel.org>; Fri, 09 Mar 2012 03:28:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding:x-gm-message-state;
        bh=z0flX91eF/KCZPl69tALMHcbpT3pGnZQ2K3y3FQODC4=;
        b=NfbsFpzdChnBZTJY7soWiZurW75jv/9CNKMzLpwGxR2bhwGp0dr406VEdb9nBINwID
         0GI+Xss1RvIF0RMowwE3ECrS5BJuF6cxG5nnOf06rvdoTNexpJAYOSUoCxEBMpopmnZF
         MgUvZEJCowbx8v+C+hocuO/cdhQBs4VzTrdH5uYQMKMvGb/ZdKbcSfcjh80cEWaYmoKS
         myQA6o2/r8mZS56oRz/Y/9G6eaX2wzKc7ZBJf6pk6tqnItZJHHEJxC0PRAjMFcAaBJkZ
         ycyQn/D+LAxlkrtUZneUHZGVp+dvMfJ3YuYhEGZe5+YJpBEQM7p51jeAzVurF+/VIfeZ
         xSoQ==
Received: by 10.112.39.133 with SMTP id p5mr632009lbk.101.1331292538795; Fri,
 09 Mar 2012 03:28:58 -0800 (PST)
Received: by 10.112.23.225 with HTTP; Fri, 9 Mar 2012 03:28:58 -0800 (PST)
In-Reply-To: <7vipie85nk.fsf@alter.siamese.dyndns.org>
X-Gm-Message-State: ALoCoQk1HXwHznIHJVKmKVQNCBZi8W1iT0g6oT5q7Km2zRqMk3PREyrIViXiVGtNdiu5MbtOkvt6
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/192711>

On Fri, Mar 9, 2012 at 9:50 AM, Junio C Hamano <gitster@pobox.com> wrot=
e:
> Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> writes:
>
>> And regardless of the danger, if I look around me, I see almost only
>> people working with shared archives, and a few projects (including G=
it,
>> obviously) using the "one commiter per repository" workflow (I teach=
 Git
>
> These days, you do not have to even go to kernel.org to find people
> and projects that use "publish to be pulled" model. =A0I hear that
> there is a popular site called GitHub where people create their own
> fork, publish their work there and ask the project they forked from
> to pull their work.

Github also offer a paid service where you can host private
repositories, which you're probably going to work on as part of a team
in a business.  FWIW, I discovered the problem with this default
behaviour because someone accidentally did a 'git push --force' to our
github repo.  There is currently no hook mechanism with github that
allows you to abort a push, either, so you can't stop the problem that
way.

Best regards,
Jeremy Morton (Jez)

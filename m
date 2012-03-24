From: chaitanyaa nalla <nallachaitu@gmail.com>
Subject: Re: [RFH] SoC 2012 Guidelines
Date: Sat, 24 Mar 2012 21:48:17 +0530
Message-ID: <CACeyogeTep3WL0f=FDTzaN8osvKyYa0VLVZJWPgbfVCquEp4yg@mail.gmail.com>
References: <201203241711.30270.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Shawn Pearce <spearce@spearce.org>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Sat Mar 24 17:18:52 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SBTg2-0006Vc-CD
	for gcvg-git-2@plane.gmane.org; Sat, 24 Mar 2012 17:18:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754318Ab2CXQST convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 24 Mar 2012 12:18:19 -0400
Received: from mail-ob0-f174.google.com ([209.85.214.174]:33431 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752815Ab2CXQSS convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 24 Mar 2012 12:18:18 -0400
Received: by obbeh20 with SMTP id eh20so3410460obb.19
        for <git@vger.kernel.org>; Sat, 24 Mar 2012 09:18:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=zcXNMzRiQ2Tfui+E0O6O/yRboyoZfywdCSL9x1nzbnw=;
        b=jZm4xO9UUBymNwZdH0cQbtLboAcSUJHJCDdb01Oqwc6U6BAh093rQ9w0JGJWpEMr0n
         oPjbbHJ/lPGMJXQBrFCinGgtGJBPVwbMuwIB3hYyyd0Uzi3iqTR+Bt/eDalMGu/qjmpr
         dIK2D01VqRbDwTKlGzq4Junxm1hSqkocBkfS5S0GZC2xf+p90GIaQgI19IcaJxv8Zzxc
         gbR9/TuDXHE034Peesazp2XySRbEqlKq6vWISHJMgJvCzo7ESi7YC9Gyfu4//X3muPzm
         PnaMv9W6RsU0ZUnILrlCWr7fSibpg+aJYqF9dTNZ1re13Hk+fnlc+ad7KPQjPsFo9IS2
         e/RA==
Received: by 10.182.188.38 with SMTP id fx6mr10084990obc.77.1332605897560;
 Sat, 24 Mar 2012 09:18:17 -0700 (PDT)
Received: by 10.182.39.234 with HTTP; Sat, 24 Mar 2012 09:18:17 -0700 (PDT)
In-Reply-To: <201203241711.30270.jnareb@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/193831>

Those are very good ideas and everyone should think about implementing =
these :).

On Sat, Mar 24, 2012 at 9:41 PM, Jakub Narebski <jnareb@gmail.com> wrot=
e:
> First, I'd like to thank Jeff King for creating and hosting GSoC wiki
> pages for Git. =A0Without his initiative, and even more his volunteer=
ing
> to be GSoC Git organizator we (as the Git Development Community)
> wouldn't be in Google Summer of Code 2012.
>
> The https://github.com/peff/git/wiki/ includes the following pages:
>
> * "SoC 2012 Application", which should probably be renamed to
> =A0"SoC 2012 Organization Application"; it was here to help (crowd)cr=
aft
> =A0organization application.
>
> * "SoC 2012 Template", which perhaps should be better named
> =A0"SoC 2012 Student Application Template"; it is here for prospectiv=
e
> =A0(would-be) student to help craft better project application.
>
> * "SoC 2012 Ideas", to gather ideas for GSoC project from Git develop=
ers
> =A0and others, as _example_ ideas for students applications.
>
> =A0We really should have more ideas, as it looks like students would =
be
> =A0battling for a few projects (I think there are two would-be studen=
ts
> =A0for any proposed project). =A0Well, too late now.
>
> I'd really like to see blue-sky proposals not mentioned on ideas list=
,
> or at least greatly expanded on proposed ideas.
>
> When students proposals would get accepted at April 23, there would
> be created "SoC 2012 Projects", listing accepted projects and hopeful=
ly
> tracking their status. =A0I guess we would try to list git-related GS=
oC
> projects from other organizations, like in previous years.
>
>
> What is lacking (for me) is something like "SoC 2012 Guidelines" wiki
> page, which would gather guidelines and suggestions both for mentors
> and for students.
>
> One can find some information buried in GSoC FAQ:
>
> http://www.google-melange.com/gsoc/document/show/gsoc_program/google/=
gsoc2012/faqs
>
> It would be nice however to have it extracted and make easier to find=
=2E
>
> This page could also serve to gather organization-specific requiremen=
ts,
> for example:
>
> * That the discussion of GSoC project application ideas with mentorin=
g
> =A0organization (i.e. with us) should take place in the open, here on=
 git
> =A0mailing list, git@vger.kernel.org.
>
> * That each student should examine relevant parts of existing git cod=
e,
> =A0read SubmittingPatches and Coding Guidelines, and at least lurk (r=
ead)
> =A0on git mailing list during the Community Bonding Period (e.g. via
> =A0GMane; I don't think we should require subscribing to git mailing
> =A0list).
>
> * That for each project there should be created a public git reposito=
ry
> =A0on one of git hosting sites like repo.or.cz, Gitorious or GitHub.
>
> * How often students (and/or mentors) should send updates about statu=
s
> =A0of a project (once per week perhaps?), and what should those
> =A0announcements include.
>
>
> And to gather help:
>
> * There should be some information about what parts of discussion and
> =A0work should take place in private communication between student an=
d
> =A0mentor, and how much should it take place in public, on git mailin=
g
> =A0list.
>
> * How can and how should mentors help students.
>
> * How to make use of comments on patches (or design ideas), while not
> =A0getting bogged down in "bikeshed"-ding :-)
>
> * Perhaps also some advice from successfull students to students,
> =A0and from mentors to mentors.
>
>
> [I was neither GSoC student, or GSoC mentor.]
>
> --
> Jakub Narebski
> Poland
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html

From: PJ Weisberg <pj@irregularexpressions.net>
Subject: Re: organizing multiple repositories with dependencies
Date: Tue, 24 Apr 2012 14:09:25 -0700
Message-ID: <CAJsNXTmk_A1NxR3ZcuEkEcX-+LyWPq2yY0mdDwAfVLX=Eg9coA@mail.gmail.com>
References: <1334568432.53977.YahooMailNeo@web65906.mail.ac4.yahoo.com>
	<m3hawjagw9.fsf@localhost.localdomain>
	<nng3983phhc.fsf@transit.us.cray.com>
	<CAE1pOi1KnvRk4yxK8OQHi9h_ueNnh5Ar3tbKFBKTA69=Aje0TQ@mail.gmail.com>
	<201204171837.q3HIbbcW013784@no.baka.org>
	<CAE1pOi29dKd2LHW7MJ+TTN4HzFkOPFEyf7Sf2emSsBYm93uYUA@mail.gmail.com>
	<nng1unmnksx.fsf@transit.us.cray.com>
	<CAE1pOi38krwXZuiYxtpLwm92N=NvWkP30V_=6cnHw=sdyk6QhA@mail.gmail.com>
	<nnghaw93v8n.fsf@transit.us.cray.com>
	<CAE1pOi2KgeLPg7UVRP7dbqLFJErsKUx22Mi5aSkphy7KMJhoUQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: dag@cray.com, Git Users <git@vger.kernel.org>
To: Hilco Wijbenga <hilco.wijbenga@gmail.com>
X-From: git-owner@vger.kernel.org Tue Apr 24 23:09:37 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SMmzM-000797-Dl
	for gcvg-git-2@plane.gmane.org; Tue, 24 Apr 2012 23:09:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757656Ab2DXVJ2 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 24 Apr 2012 17:09:28 -0400
Received: from mail-wi0-f178.google.com ([209.85.212.178]:35186 "EHLO
	mail-wi0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755888Ab2DXVJ1 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 24 Apr 2012 17:09:27 -0400
Received: by wibhq7 with SMTP id hq7so1095534wib.1
        for <git@vger.kernel.org>; Tue, 24 Apr 2012 14:09:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=q0MyS+2WioA0pWNzro8jfJ0gDemjMmpK1gSooNTC67w=;
        b=F0zAR3d8M8hBaZfdnaCtkbjD5CFYyyqD9X0nzxDs78Xaj/EHGq1nu6ue5br4/DpB6Y
         lElWaeDE9kRo0NyesjqoZmWvvBQpcJB7JxMAsL4s6MT5f57KBMyhFapBw6tvLqEWZKnw
         wlWW9/Q6Q/pewymI1+h6Mx1UVrN54+XVYg50D2SCCXCNJlVNg2G5CBo1C69aDMsb1Iyy
         bpfQGD7TyWdeIuoWR87wy3Q8P3JX0zfhxI1u8q8WS84jDw60m7O7q7TuVNq3VvuIvsQl
         BgYElfPKC5VXoRfyt3Kw8zrvUmUJ+sXF4DYGvfSe0Ilbr3p075lUu5ESVNqlGTDOf4Mf
         s7Tg==
Received: by 10.180.93.196 with SMTP id cw4mr149482wib.19.1335301765622; Tue,
 24 Apr 2012 14:09:25 -0700 (PDT)
Received: by 10.223.116.200 with HTTP; Tue, 24 Apr 2012 14:09:25 -0700 (PDT)
In-Reply-To: <CAE1pOi2KgeLPg7UVRP7dbqLFJErsKUx22Mi5aSkphy7KMJhoUQ@mail.gmail.com>
X-Google-Sender-Auth: Nf1MrXOAR6NANPp_lVqoXS1zwEM
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/196252>

On Tue, Apr 24, 2012 at 11:54 AM, Hilco Wijbenga
<hilco.wijbenga@gmail.com> wrote:
> On 24 April 2012 10:17, =A0<dag@cray.com> wrote:
>> Hilco Wijbenga <hilco.wijbenga@gmail.com> writes:
>>
>>> I'm assuming that if you have subproject S in umbrella project U an=
d a
>>> branch "topic" in U then that same branch should exist in S.
>>
>> No, I think that is actually very rare. =A0If topic branches really =
should
>> be mirrored then U and S should be one repository. =A0They are too c=
losely
>> coupled to be separated. =A0But see the but about git-subtree and to=
pic
>> branches below.
>
> Too closely coupled? I do not think breaking up a project into a set
> of libraries makes everything tightly coupled. I would argue the
> opposite. :-) Anyway, you answer my concern below.

Indeed.  But when you make a branch in your main project, wouldn't you
usually still want to use the master branch of the libraries?  Or if
there's an experimental branch in a library and you want to use that
branched version, wouldn't you still use the master version of all the
other libraries?  What if you have two projects that both use a
library, but are otherwise unrelated?  If you create a branch called
'hotfix' in one project, do you automatically find your library
version switching to an unrelated 'hotfix' from another project?

-PJ

Gehm's Corollary to Clark's Law: Any technology distinguishable from
magic is insufficiently advanced.

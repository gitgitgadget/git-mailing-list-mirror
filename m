From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 0/2] git checkout: one bugfix and one cosmetic change
Date: Sun, 15 Mar 2009 12:38:55 -0700
Message-ID: <7viqma7f00.fsf@gitster.siamese.dyndns.org>
References: <cover.1237115791.git.barvik@broadpark.no>
 <7vab7m8x5w.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Kjetil Barvik <barvik@broadpark.no>
To: Scott Chacon <schacon@gmail.com>
X-From: git-owner@vger.kernel.org Sun Mar 15 20:41:18 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LiwCq-0004nS-Dh
	for gcvg-git-2@gmane.org; Sun, 15 Mar 2009 20:41:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760189AbZCOTjL convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 15 Mar 2009 15:39:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757730AbZCOTjK
	(ORCPT <rfc822;git-outgoing>); Sun, 15 Mar 2009 15:39:10 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:53133 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760459AbZCOTjI convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 15 Mar 2009 15:39:08 -0400
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id BEECBA28A8;
	Sun, 15 Mar 2009 15:39:01 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 63AD9A28A7; Sun,
 15 Mar 2009 15:38:57 -0400 (EDT)
In-Reply-To: <7vab7m8x5w.fsf@gitster.siamese.dyndns.org> (Junio C. Hamano's
 message of "Sun, 15 Mar 2009 11:21:15 -0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: EF7177B6-1198-11DE-A1D1-CFA5EBB1AA3C-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/113295>

Junio C Hamano <gitster@pobox.com> writes:

> Kjetil Barvik <barvik@broadpark.no> writes:
>
>> Just one small bugfix patch, and one small cosmetic change.
>>
>> By the way, I wonder how often the list of 'Primary Authors' and
>> 'Contributors' on the webpage http://git-scm.com/about is updated.
>> Should'nt it be updated when a new release, like v1.6.2, is made?
>
> Thanks for noticing.  Though git-scm.com is not under my control, the=
 site
> is considered the official git homepage these days, and I am glad to =
see
> improvements to its contents discussed here.  I do not see Scott very
> often on this list these days, so I am CC'ing him.

Ragarding the list on the page, I have one thought (not complete enough=
 to
be called suggestion) and one datapoint:

 (1) The boundary between the "Primary Authors" vs "Contributors" seems=
 to
     be set at 50 commits with the current table.  This would mean that=
 we
     will have a lot more primary authors as project progresses.  Is th=
is
     desirable?

     We have 14999 non-merge commits as of 1.6.2; perhaps a per-cent (o=
r a
     half per-cent) cutoff rule would give a more balanced and consiste=
nt
     view in the longer term [*1*]?

 (2) This script:

     $ git shortlog -s v1.6.1 | sed -e 's/^[ 0-9]*//' >/var/tmp/1
     $ git shortlog -s v1.6.2 | sed -e 's/^[ 0-9]*//' >/var/tmp/2
     $ comm -13 /var/tmp/[12]

     produces the list of new contributors.  There are 39 names [*2*].

[Footnotes]

*1* A more drastic change would be not to have two lists, but just one.

*2* Thanks and welcome.

    Allan Caffee, Ben Walton, Benjamin Kramer, Benjamin Sergeant, Benoi=
t
    Sigoure, Danijel Tasov, David J. Mellor, Devin Doucette, D=C3=A9vai=
 Tam=C3=A1s,
    Elijah Newren, Eric Kidd, Fabian Franz, Felipe Contreras, Geoffrey
    Thomas, Henrik Austad, Jacob Helwig, Jake Goulding, Jeremy White,
    Johannes Gilger, Jonas Flod=C3=A9n, Keith Cascio, Kjetil Barvik, Ma=
rc
    Branchaud, Marc-Andre Lureau, Nazri Ramliy, Pat Notz, Paul Jarc, Pe=
ter
    Oberndorfer, Ray Chuan, Roy Lee, Serge van den Boom, Sergei Organov=
,
    Stefan Karpinski, Tay Ray Chuan, Ted Pavlic, Tor Arne Vestb=C3=B8, =
Vitaly
    "_Vi" Shukela, V=C3=A4in=C3=B6 J=C3=A4rvel=C3=A4, jidanni@jidanni.o=
rg.

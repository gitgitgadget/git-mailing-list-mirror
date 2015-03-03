From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Git for design
Date: Tue, 03 Mar 2015 12:48:06 -0800
Message-ID: <xmqqvbihajuh.fsf@gitster.dls.corp.google.com>
References: <CAAcjnBVBeuYL1kuCG1yF5W1KUNik3hO8e2R0g0DdXDS6u+eOyQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Ernesto Alonso =?utf-8?Q?Monta=C3=B1o_Ram=C3=ADrez?= 
	<ernestoalonso.mr@gmail.com>
X-From: git-owner@vger.kernel.org Tue Mar 03 21:48:16 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YStjk-0004t8-3g
	for gcvg-git-2@plane.gmane.org; Tue, 03 Mar 2015 21:48:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757295AbbCCUsL convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 3 Mar 2015 15:48:11 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:53498 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1757223AbbCCUsK convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 3 Mar 2015 15:48:10 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 372B03D079;
	Tue,  3 Mar 2015 15:48:09 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=gXbdWUBrldXY
	pXtKlMoq9C4yKe0=; b=XKpkW6nfrVT0xgMEG+Dp53VpPbfsfBx8IfXEuqmnFqai
	zCXjE/3TRMa2nR6dkEkKtevxcXX58okscCSgNhUi4+RgqnN+sU7CT9OJt2HWs57X
	j2nHXMocxiAE3WAoC77MWau1lrtc36CCe6yitU1gLo42l8j87yyumIdhxZ31ax8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=EEj64O
	nM4JdCGDBcCpaenwpSJ9vqdXngewHjqxDt61JoKi6fPvuwtIkfWubIlu4PqRhqEg
	UIKEDtaKMqPAbqrqqIVum8MwmHC9foyzSPbei0XvImLT59HXqsQyn2BwugKdAue3
	wLnQqbqBFgQlLHGAmSXlKmeNlMGU7hELfFIoc=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 300F93D078;
	Tue,  3 Mar 2015 15:48:09 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id A89B43D077;
	Tue,  3 Mar 2015 15:48:08 -0500 (EST)
In-Reply-To: <CAAcjnBVBeuYL1kuCG1yF5W1KUNik3hO8e2R0g0DdXDS6u+eOyQ@mail.gmail.com>
	("Ernesto Alonso =?utf-8?Q?Monta=C3=B1o_Ram=C3=ADrez=22's?= message of
 "Tue, 3 Mar 2015
	13:23:15 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 99544E58-C1E6-11E4-B345-29999F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/264687>

Ernesto Alonso Monta=C3=B1o Ram=C3=ADrez  <ernestoalonso.mr@gmail.com> =
writes:

> I've a question about Git, can I use this application for design
> (architecture, no programming)? for example, controlling the versions
> of designs on AUTOCAD, PHOTOSHOP, ILLUSTRATOR, etc; management of
> documents...

Yes you can use this application.

But it depends on your definition of "use" how "useful" the end
result would be.  The features programmers find helpful by placing
their end products (i.e. the source code and text files in general)
under control in Git are:

 1. You can go back to any arbitrary version.

 2. You can inspect what the textual differences between two
    arbitrary versions A and B (but most often, two adjacent
    versions) are.  This is called "diff".

 3. You can take the "textual differences" from 2. and replay the
    change between A and C on top of another version C, which lets
    you pretend as if you did the same work you did going from A to
    B but starting at version C.  This is "apply", "merge",
    "cherry-pick", and "rebase".

Using Git (or any version control system) on non-text files, you
would still get the same benefit 1., obviously.

If the assets you feed Git are not something intelligible as "text"
(and I am guessing AUTOCAD, PHOTOSHOP and ILLUSTRATOR files are
not), you would not gain 2. or 3. immediately.

You however can still gain benefit 2., if you have a way to
"compare" two versions of these files in a non-textual way.  For
example, I do not know AUTOCAD at all, but if the program "autocad"
has a mode where it lets you feed two AUTOCAD files and point out
how the two are different visually (let's assume there is such a
program "autocad-compare" that takes two filename parameters to
compare), Git has a way for you to plug into its machinery so that
"git diff v1.0 v2.0 -- an-autocad-file" will write out the file at
version 1 and version 2 into two temproary files and call out to
"autocad-compare tmp1 tmp2" to have them compared.

=46or 3., too, Git has a mechanism to plug in a "merge-driver" of your
own, e.g. if you have a version of an AUTOCAD file A that was
modified to B by you and modified to C by your colleague and an
AUTOCAD program "autocad-merge A B C" is a way to merge the work you
two did starting from the same A to produce B and C into a single
unified version, then "git merge" can be told to use such an
external program as a plug-in to perform the file-level merge.

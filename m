From: Jari Aalto <jari.aalto@cante.net>
Subject: Re: [PATCH] git-commit.txt: Order options alphabetically
Date: Thu, 02 Dec 2010 01:02:15 +0200
Organization: Private
Message-ID: <87aakpt7uw.fsf@picasso.cante.net>
References: <1291215526-11428-1-git-send-email-jari.aalto@cante.net>
	<20101201165043.GF26120@burratino> <87r5e1v2g8.fsf@picasso.cante.net>
	<7vzkspuw8g.fsf@alter.siamese.dyndns.org>
	<295D1E95-1C61-4960-8C9C-BDB0BD4A1A50@sb.org>
	<87mxopt8my.fsf@picasso.cante.net>
	<E02740CE-37EE-4701-BB2D-18AD493D1C05@sb.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Dec 02 00:02:45 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PNvh9-0005cN-Pg
	for gcvg-git-2@lo.gmane.org; Thu, 02 Dec 2010 00:02:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756385Ab0LAXCd convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 1 Dec 2010 18:02:33 -0500
Received: from lo.gmane.org ([80.91.229.12]:36868 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756169Ab0LAXCb (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Dec 2010 18:02:31 -0500
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1PNvgz-0005Y0-Lt
	for git@vger.kernel.org; Thu, 02 Dec 2010 00:02:29 +0100
Received: from a91-155-187-216.elisa-laajakaista.fi ([91.155.187.216])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 02 Dec 2010 00:02:29 +0100
Received: from jari.aalto by a91-155-187-216.elisa-laajakaista.fi with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 02 Dec 2010 00:02:29 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@dough.gmane.org
X-Gmane-NNTP-Posting-Host: a91-155-187-216.elisa-laajakaista.fi
User-Agent: Gnus/5.110011 (No Gnus v0.11) Emacs/23.2 (gnu/linux)
Cancel-Lock: sha1:2IIFW8JzJLT6X8JLwN9MaXTW1kQ=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/162636>

2010-12-02 00:52 Kevin Ballard <kevin@sb.org>:
> On Dec 1, 2010, at 2:45 PM, Jari Aalto wrote:
>> What is the reason --reset-author is in that position? What
>
> It's entirely possible...

The reader have to guess "imagined groups"? Hm, that's interesting.

>> To me the git-pages do not look that professional...
>
> You seem overly concerned with the visual aesthetics and not at all w=
ith the
> actual content.

Humans read visually. It's built in. Distractions slow down. Try writin=
g

    abcdef =3D 1
    x123.213.123..123. =3D 4
    sda=C3=B6lkasd =3D 1

vs.

    abcdef              =3D 1
    x123.213.123..123.  =3D 4
    sda=C3=B6lkasd           =3D 1

There is a reason why people like Excel cells. Not my invention.

>> When the pages list options in alphabetical order, it doesn't take l=
ong
>> to compare commands: similarities and differences in options, or mis=
sing
>> options, or inconsistencies for that matter.
>
> Why would you compare commands like that? There's really no reason at=
 all to
> believe that the -c flag for one command is even related to the -c fl=
ag for
> another command.

I take it you have written loads of software. The reasons come from
standard Software Development and Quality auditions. Git's command line
is inconsistent in many places and there is room for improvement.
Documentation is one way to spot those.

And ther eis perfect reasons to, again, expect consistency on some leve=
l
of command options to mean same thing

Like why some commands need number in:

    -n NUMBER

Whereas other's use:

    -NUMBER

Examples like that.

Jari

From: Miles Bader <miles@gnu.org>
Subject: Re: [PATCH 09/10] user-manual.txt: explain better the remote(-tracking) branch terms
Date: Tue, 26 Oct 2010 13:16:15 +0900
Message-ID: <buoy69llhbk.fsf@dhlpc061.dev.necel.com>
References: <1287851481-27952-1-git-send-email-Matthieu.Moy@imag.fr>
	<1287851481-27952-10-git-send-email-Matthieu.Moy@imag.fr>
	<9A09AA7C-BAE2-4571-8453-17CB3F3256D4@gmail.com>
	<vpqr5fdmywj.fsf@bauges.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Thore Husfeldt <thore.husfeldt@gmail.com>, git@vger.kernel.org,
	gitster@pobox.com, Jonathan Nieder <jrnieder@gmail.com>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Tue Oct 26 06:16:41 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PAaxk-0000YT-Vl
	for gcvg-git-2@lo.gmane.org; Tue, 26 Oct 2010 06:16:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751279Ab0JZEQf convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 26 Oct 2010 00:16:35 -0400
Received: from TYO201.gate.nec.co.jp ([202.32.8.193]:32789 "EHLO
	tyo201.gate.nec.co.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751166Ab0JZEQf convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 26 Oct 2010 00:16:35 -0400
Received: from mailgate3.nec.co.jp ([10.7.69.160])
	by tyo201.gate.nec.co.jp (8.13.8/8.13.4) with ESMTP id o9Q4GG8Q027911;
	Tue, 26 Oct 2010 13:16:16 +0900 (JST)
Received: (from root@localhost) by mailgate3.nec.co.jp (8.11.7/3.7W-MAILGATE-NEC)
	id o9Q4GGb13577; Tue, 26 Oct 2010 13:16:16 +0900 (JST)
Received: from relay21.aps.necel.com ([10.29.19.50])
	by vgate02.nec.co.jp (8.14.4/8.14.4) with ESMTP id o9Q490Qe024715;
	Tue, 26 Oct 2010 13:16:16 +0900 (JST)
Received: from relay21.aps.necel.com ([10.29.19.16] [10.29.19.16]) by relay21.aps.necel.com with ESMTP; Tue, 26 Oct 2010 13:16:16 +0900
Received: from dhlpc061 ([10.114.96.148] [10.114.96.148]) by relay21.aps.necel.com with ESMTP; Tue, 26 Oct 2010 13:16:16 +0900
Received: by dhlpc061 (Postfix, from userid 31295)
	id E7C5B124042; Tue, 26 Oct 2010 13:16:15 +0900 (JST)
System-Type: x86_64-unknown-linux-gnu
Blat: Foop
In-Reply-To: <vpqr5fdmywj.fsf@bauges.imag.fr> (Matthieu Moy's message of "Tue,
	26 Oct 2010 05:11:08 +0200")
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/159979>

Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> writes:
>> No. Git does not =E2=80=9Cmaintain a copy of [the remote] branches=E2=
=80=9D.
>
> Which part of the sentence is problematic to you ?
>
> Remote-tracking branches _are_ a copy of the branches. The copy is
> made at "git clone" time, and is periodically updated with "git fetch=
"
> later. And it seems to me that "periodically update" is a way to
> "maintain" the copy up-to-date.
>
> In the latest version of the patch, I changed "maintain" to "keep",
> following Jakub's remark. Is that better?

Yup.

As far as I can tell, Thore's complaint is that the copy is not kept
perfectly up-to-date automatically, but I think he's incorrect to assum=
e
that the language here implies that.  It doesn't.  "Maintaining a copy"
simply means to keep a copy, so your change seems valid, though.

I supposes git is also used by many people with a less-than-perfect
command of english though, so perhaps using simpler language is
sometimes warranted...

-Miles

--=20
Ocean, n. A body of water covering seven-tenths of a world designed for=
 Man -
who has no gills.

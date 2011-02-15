From: Miles Bader <miles@gnu.org>
Subject: Re: [1.8.0 RFD] Homogeneous use of short options
Date: Tue, 15 Feb 2011 09:52:01 +0900
Message-ID: <871v3a2k7i.fsf@catnip.gol.com>
References: <4D594460.1040206@drmicha.warpmail.net>
	<AANLkTim1GUnyqkNbFPhkPEOitGG7PxsW1eeubkN69hf5@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Michael J Gruber <git@drmicha.warpmail.net>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Feb 15 01:52:18 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pp99N-0002Yl-CI
	for gcvg-git-2@lo.gmane.org; Tue, 15 Feb 2011 01:52:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752966Ab1BOAwM convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 14 Feb 2011 19:52:12 -0500
Received: from smtp12.dentaku.gol.com ([203.216.5.74]:54647 "EHLO
	smtp12.dentaku.gol.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751791Ab1BOAwL convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 14 Feb 2011 19:52:11 -0500
Received: from 218.33.195.219.eo.eaccess.ne.jp ([218.33.195.219] helo=catnip.gol.com)
	by smtp12.dentaku.gol.com with esmtpa (Dentaku)
	(envelope-from <miles@gnu.org>)
	id 1Pp998-0003Ph-Fj; Tue, 15 Feb 2011 09:52:02 +0900
Received: by catnip.gol.com (Postfix, from userid 1000)
	id 75F70DF8A; Tue, 15 Feb 2011 09:52:01 +0900 (JST)
System-Type: x86_64-unknown-linux-gnu
In-Reply-To: <AANLkTim1GUnyqkNbFPhkPEOitGG7PxsW1eeubkN69hf5@mail.gmail.com>
	(Junio C. Hamano's message of "Mon, 14 Feb 2011 13:00:02 -0800")
X-Virus-Scanned: ClamAV GOL (outbound)
X-Abuse-Complaints: abuse@gol.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/166803>

Junio C Hamano <gitster@pobox.com> writes:
>> add -A: Why capital A? Compare commit -a etc.
>
> IIRC, this was in anticipation for a similar interface to include
> _new_ files in the commit in the form of "commit -A", which _is_
> different from the existing "commit -a".

I look up the meaning of "git commit -u":

$ git commit --help
=2E..
       -u[<mode>], --untracked-files[=3D<mode>]
           Show untracked files (Default: all).

           The mode parameter is optional, and is used to specify the h=
andling
           of untracked files.

           The possible options are:

           =C2=B7    no - Show no untracked files
           =C2=B7    normal - Shows untracked files and directories
           =C2=B7    all - Also shows individual files in untracked dir=
ectories.

               See git-config(1) for configuration variable used to cha=
nge the
               default for when the option is not specified.

I guess it means it only affects the status-display for --dry-run, but
it seems a little confusing to not say that explicitly...

-miles

--=20
Cabbage, n. A familiar kitchen-garden vegetable about as large and wise=
 as a
man's head.

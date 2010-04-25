From: Miles Bader <miles@gnu.org>
Subject: Re: Please default to 'commit -a' when no changes were added
Date: Sun, 25 Apr 2010 11:47:08 +0900
Message-ID: <87mxwsgser.fsf@catnip.gol.com>
References: <20100422155806.GC4801@progeny.tock>
	<87wrvzs590.fsf@frosties.localdomain>
	<alpine.LFD.2.00.1004221445310.7232@xanadu.home>
	<87sk6n4426.fsf@frosties.localdomain>
	<alpine.LFD.2.00.1004221651590.7232@xanadu.home>
	<87vdbitu9v.fsf@frosties.localdomain>
	<25441792-181D-456D-8182-F33B49209EFF@wincent.com>
	<87aastx6sa.fsf@frosties.localdomain>
	<alpine.LFD.2.00.1004231639180.7232@xanadu.home>
	<8739yktuvs.fsf@frosties.localdomain>
	<20100424214024.GA8044@progeny.tock>
Reply-To: Miles Bader <miles@gnu.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Goswin von Brederlow <goswin-v-b@web.de>,
	Nicolas Pitre <nico@fluxnic.net>,
	Wincent Colaiuta <win@wincent.com>, 578764@bugs.debian.org,
	git@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Sun Apr 25 04:47:20 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O5rsN-0008TA-MJ
	for gcvg-git-2@lo.gmane.org; Sun, 25 Apr 2010 04:47:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752045Ab0DYCrO convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 24 Apr 2010 22:47:14 -0400
Received: from smtp11.dentaku.gol.com ([203.216.5.73]:54305 "EHLO
	smtp11.dentaku.gol.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750940Ab0DYCrO convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 24 Apr 2010 22:47:14 -0400
Received: from 218.231.253.147.eo.eaccess.ne.jp ([218.231.253.147] helo=catnip.gol.com)
	by smtp11.dentaku.gol.com with esmtpa (Dentaku)
	id 1O5rsC-0007EE-CK; Sun, 25 Apr 2010 11:47:08 +0900
Received: by catnip.gol.com (Postfix, from userid 1000)
	id 3928FDF93; Sun, 25 Apr 2010 11:47:08 +0900 (JST)
System-Type: x86_64-unknown-linux-gnu
In-Reply-To: <20100424214024.GA8044@progeny.tock> (Jonathan Nieder's message
	of "Sat, 24 Apr 2010 16:40:25 -0500")
X-Virus-Scanned: ClamAV GOL (outbound)
X-Abuse-Complaints: abuse@gol.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/145716>

Jonathan Nieder <jrnieder@gmail.com> writes:
> But dense as I am, I still can=E2=80=99t imagine why
>
> echo '[alias] ci =3D commit -a' >>$HOME/.gitconfig
>
> wouldn=E2=80=99t be better in every way (especially if Jakub=E2=80=99=
s
> commit.preserveindex is enabled).

If the latter is enabled, you can't use "git add" to add new files,
you'll have to remember to use "add -N" (or add some alias for that
too).

-Miles

--=20
/\ /\
(^.^)
(")")
*This is the cute kitty virus, please copy this into your sig so it can=
 spread.

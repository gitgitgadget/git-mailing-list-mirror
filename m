From: Andreas Schwab <schwab@linux-m68k.org>
Subject: Re: [PATCH] Fix formatting in git-config(1)
Date: Thu, 21 Jun 2012 01:05:12 +0200
Message-ID: <m2r4t94maf.fsf@igel.home>
References: <m2vcil4n0w.fsf@igel.home>
	<7v4nq5twwg.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jun 21 01:05:25 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ShTxj-0006M5-4i
	for gcvg-git-2@plane.gmane.org; Thu, 21 Jun 2012 01:05:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757685Ab2FTXFT convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 20 Jun 2012 19:05:19 -0400
Received: from mail-out.m-online.net ([212.18.0.9]:58087 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754776Ab2FTXFS (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Jun 2012 19:05:18 -0400
Received: from frontend1.mail.m-online.net (unknown [192.168.8.180])
	by mail-out.m-online.net (Postfix) with ESMTP id 3WHhTT58y8z4Kn96;
	Thu, 21 Jun 2012 01:05:13 +0200 (CEST)
Received: from igel.home (ppp-93-104-134-134.dynamic.mnet-online.de [93.104.134.134])
	by mail.mnet-online.de (Postfix) with ESMTPA id 3WHhTP5nPyz4KK3X;
	Thu, 21 Jun 2012 01:05:13 +0200 (CEST)
Received: by igel.home (Postfix, from userid 501)
	id 7E52CCA2A3; Thu, 21 Jun 2012 01:05:13 +0200 (CEST)
X-Yow: ..  does your DRESSING ROOM have enough ASPARAGUS?
In-Reply-To: <7v4nq5twwg.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
	message of "Wed, 20 Jun 2012 15:56:47 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.1 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/200376>

Junio C Hamano <gitster@pobox.com> writes:

> Andreas Schwab <schwab@linux-m68k.org> writes:
>
>> Remove the open block markers from the status.showUntrackedFiles ent=
ry
>> as they cause all remaining entries to be indented one level too muc=
h.
>
> Hrm...
>
> I looked at http://git-htmldocs.googlecode.com/git/git-config.html
> and am unsure what "one level too much" you are referring to.

I'm using asciidoc 8.4.5.  Probably version dependent.

> Also looking at the output from
>
> $ git config --help
>
> I see (RHS end truncated to avoid line wrapping in MUA):

This is what I see:

       status.showUntrackedFiles
           By default, git-status(1) and git-commit(1) show files which=
 are
           not currently tracked by Git. Directories which contain only
           untracked files, are shown with the directory name only. Sho=
wing
           untracked files means that Git needs to lstat() all all the =
files
           in the whole repository, which might be slow on some systems=
=2E So,
           this variable controls how the commands displays the untrack=
ed
           files. Possible values are:

           =C2=B7    no - Show no untracked files.

           =C2=B7    normal - Show untracked files and directories.

           =C2=B7    all - Show also individual files in untracked dire=
ctories.
               If this variable is not specified, it defaults to normal=
=2E This
               variable can be overridden with the -u|--untracked-files=
 option
               of git-status(1) and git-commit(1).

           status.submodulesummary
               Defaults to false. If this is set to a non zero number o=
r true
               (identical to -1 or an unlimited number), the submodule =
summary
               will be enabled and a summary of commits for modified
               submodules will be shown (see --summary-limit option of =
git-
               submodule(1)).


Andreas.

--=20
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint =3D 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4=
ED5
"And now for something completely different."

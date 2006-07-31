From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: gitweb: how to name main "action" subroutines?
Date: Mon, 31 Jul 2006 19:50:19 +0200
Organization: At home
Message-ID: <ealfsa$hho$1@sea.gmane.org>
References: <eal2ic$14o$1@sea.gmane.org> <20060731172625.48437.qmail@web31811.mail.mud.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
X-From: git-owner@vger.kernel.org Mon Jul 31 19:50:48 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G7buU-00028u-9y
	for gcvg-git@gmane.org; Mon, 31 Jul 2006 19:50:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030292AbWGaRub convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Mon, 31 Jul 2006 13:50:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030293AbWGaRub
	(ORCPT <rfc822;git-outgoing>); Mon, 31 Jul 2006 13:50:31 -0400
Received: from main.gmane.org ([80.91.229.2]:11909 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1030292AbWGaRua (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 31 Jul 2006 13:50:30 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1G7bu7-00024M-1z
	for git@vger.kernel.org; Mon, 31 Jul 2006 19:50:11 +0200
Received: from 193.0.122.19 ([193.0.122.19])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 31 Jul 2006 19:50:11 +0200
Received: from jnareb by 193.0.122.19 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 31 Jul 2006 19:50:11 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: 193.0.122.19
Mail-Copies-To: jnareb@gmail.com
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/24531>

<opublikowany i wys=B3any>

Luben Tuikov wrote:

> --- Jakub Narebski <jnareb@gmail.com> wrote:
>> I'm going to rename some gitweb subroutines to better correspond to =
what
>> given subroutine does. I have problem: how to name main "action"
>> subroutines? Currently they use git_ prefix, e.g. git_logo.
>> git_project_list, git_rss, git_summary, git_heads,...
>>=20
>> I have thought about do_logo, or gitweb_logo, or out_logo etc., but =
somehow
>> none is best.
>=20
> "git_<noun>_<verb>" ?  So then you'd have, for example "git_logo_show=
".

I'd rather reserve git_ prefix for subroutines which deal with git repo=
sitory,=20
either by calling git commands (e.g. git_get_type), or accessing git re=
pository
directly (e.g. git_read_hash, git_read_description).

I'm partial to either out_foo or gitweb_foo...

--=20
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git

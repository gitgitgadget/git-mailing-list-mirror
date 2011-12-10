From: Gioele Barabucci <gioele@svario.it>
Subject: Re: [RFC/PATCH] add update to branch support for "floating submodules"
Date: Sat, 10 Dec 2011 14:16:22 +0000
Message-ID: <4EE369B6.7060602@svario.it>
References: <20111109174027.GA28825@book.fritz.box> <7vr51htbsy.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Heiko Voigt <hvoigt@hvoigt.net>, git@vger.kernel.org
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Dec 10 15:20:24 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RZNmp-0002X2-N3
	for gcvg-git-2@lo.gmane.org; Sat, 10 Dec 2011 15:20:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751346Ab1LJOUL convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 10 Dec 2011 09:20:11 -0500
Received: from lo.gmane.org ([80.91.229.12]:53269 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751319Ab1LJOUK (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 10 Dec 2011 09:20:10 -0500
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1RZNma-0002QG-A7
	for git@vger.kernel.org; Sat, 10 Dec 2011 15:20:08 +0100
Received: from host86-175-212-128.wlms-broadband.com ([86.175.212.128])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 10 Dec 2011 15:20:08 +0100
Received: from gioele by host86-175-212-128.wlms-broadband.com with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 10 Dec 2011 15:20:08 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@dough.gmane.org
X-Gmane-NNTP-Posting-Host: host86-175-212-128.wlms-broadband.com
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:8.0) Gecko/20111110 Thunderbird/8.0
In-Reply-To: <7vr51htbsy.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/186779>

On 09/11/2011 18:01, Junio C Hamano wrote:
>> This is almost ready but I would like to know what users of the
>> "floating submodule" think about this.
 >
> I do like to hear from potential users as well, because the general
> impression we got was that floating submodules is not a real need of
> anybody,

=46loating modules are something much sought after by those who use Git=
=20
for non-development purposes, like those who have most of their $HOME=20
versioned with Git [1]. For example, part of what Joey Hess's `mr` tool=
=20
[2] does is to simulate floating submodules for Git-versioned $HOMEs.

In the context of versioned $HOMEs, or with backups in general, precise=
=20
tracking of submodules updates is not that important. To quote [3]:=20
=C2=ABLast, change tracking is a bit more lenient with home directories=
=2E I=20
may shuffle some stuff around, and I don't need to explain the changes=20
to anyone else.=C2=BB. In my case, I want my ~/Documents dir (that is i=
n a=20
different repo from $HOME) to be always updated; I would prefer not to=20
deal with submodule updates, merges and detached HEADs.

Bye,

[1] http://vcs-home.branchable.com/
[2] http://kitenet.net/~joey/code/mr/
[3] http://joshcarter.com/productivity/svn_hg_git_for_home_directory

--
Gioele Barabucci <gioele@svario.it>

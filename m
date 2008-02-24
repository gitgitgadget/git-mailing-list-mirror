From: Remi Vanicat <vanicat@debian.org>
Subject: Re: [Q] Tell Git to follow symlinks?
Date: Sun, 24 Feb 2008 16:08:28 +0100
Message-ID: <87zltq2xzn.dlv@maison.homelinux.org>
References: <c6c947f60802240305w40a7af96yc47f90e573384c04@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: "Alexander Gladysh" <agladysh@gmail.com>
X-From: git-owner@vger.kernel.org Sun Feb 24 16:09:16 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JTITY-0002N5-AZ
	for gcvg-git-2@gmane.org; Sun, 24 Feb 2008 16:09:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751011AbYBXPIf convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 24 Feb 2008 10:08:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751125AbYBXPIf
	(ORCPT <rfc822;git-outgoing>); Sun, 24 Feb 2008 10:08:35 -0500
Received: from neuf-infra-smtp-out-sp604003av.neufgp.fr ([84.96.92.124]:60909
	"EHLO neuf-infra-smtp-out-sp604003av.neufgp.fr" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750962AbYBXPIf convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 Feb 2008 10:08:35 -0500
Received: from neuf-infra-smtp-out-sp604011av.neufgp.fr ([84.96.92.116])
	by neuf-infra-smtp-out-sp604003av.neufgp.fr with neuf telecom
	id tJ1n1Y0042We0qU030uQ00; Sun, 24 Feb 2008 15:08:33 +0000
Received: from maison.homelinux.org ([84.103.71.93])
	by neuf-infra-smtp-out-sp604011av.neufgp.fr with neuf telecom
	id tT8Y1Y00Q20lBGc0B00000; Sun, 24 Feb 2008 16:08:33 +0100
Received: from moi by maison.homelinux.org with local (Exim 4.69)
	(envelope-from <moi@vanicat.homelinux.org>)
	id 1JTISs-0003ug-CF; Sun, 24 Feb 2008 16:08:32 +0100
In-Reply-To: <c6c947f60802240305w40a7af96yc47f90e573384c04@mail.gmail.com> (Alexander Gladysh's message of "Sun\, 24 Feb 2008 14\:05\:36 +0300")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.1 (gnu/linux)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: moi@vanicat.homelinux.org
X-Spam-Checker-Version: SpamAssassin 3.2.3 (2007-08-08) on maison.homelinux.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.0 required=5.0 tests=NO_RELAYS autolearn=ham
	version=3.2.3
X-SA-Exim-Version: 4.2.1 (built Tue, 21 Aug 2007 23:39:36 +0000)
X-SA-Exim-Scanned: Yes (on maison.homelinux.org)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/74938>

"Alexander Gladysh" <agladysh@gmail.com> writes:

> I thought to construct my repo of the number of symlinks to other
> places, but apparently Git does not follow any simlinks.

Hope so, I use this feature, for example to manage my debian
alternatives.=20

> Please give me some directions on the building such dumb backup
> system I want :)

I use "reverse" symlinks: the files i want to manage are replaced by
symlink to the file that is in then git repository:

my home contain:

=2Eabbrev_defs -> .myconfig/abbrev_defs
=2Ebash_logout -> .myconfig/bash_logout
=2Ebash_profile -> .myconfig/bash_profile
=2Ebashrc -> .myconfig/bashrc
=2Ecustom -> .myconfig/custom
=2Edircolors -> .myconfig/dircolors
=2Eemacs -> .myconfig/emacs
=2Egnomerc -> .myconfig/gnomerc
=2Egnus -> .myconfig/gnus
=2Eirssi -> .myconfig/irssi/
=2Eprofile -> .myconfig/profile
=2EScrollZ -> .myconfig/ScrollZ/
=2Escrollzrc -> .myconfig/scrollzrc
=2Exchat2 -> .myconfig/xchat2/

and a .myconfig git repository that manage those file.

--=20
R=C3=A9mi Vanicat

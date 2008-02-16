From: =?us-ascii?Q?=3D=3Futf-8=3Fq=3FR=3DC3=3DA9mi=3D20Vanicat=3F=3D?= 
	<vanicat@debian.org>
Subject: [patch v2] switching and creating branch, merging and rebasing with Emacs
Date: Sat, 16 Feb 2008 20:17:28 +0100
Message-ID: <87lk5ku2wn.dlv_-_@maison.homelinux.org>
References: <87wsp8u9m7.dlv@maison.homelinux.org>
	<20080213163002.GA5670@diana.vm.bytemark.co.uk>
	<20080213164356.GA5828@diana.vm.bytemark.co.uk>
	<87zlu4vhon.fsf@osv.gnss.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Karl =?utf-8?Q?Hasselstr=C3=B6m?= <kha@treskal.com>,
	<vanicat@debian.org>, Sergei Organov <osv@javad.com>,
	Alexandre Julliard <julliard@winehq.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Feb 16 20:18:33 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JQSYR-0008Py-P9
	for gcvg-git-2@gmane.org; Sat, 16 Feb 2008 20:18:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756350AbYBPTR5 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 16 Feb 2008 14:17:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756341AbYBPTR5
	(ORCPT <rfc822;git-outgoing>); Sat, 16 Feb 2008 14:17:57 -0500
Received: from neuf-infra-smtp-out-sp604007av.neufgp.fr ([84.96.92.120]:52429
	"EHLO neuf-infra-smtp-out-sp604007av.neufgp.fr" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756309AbYBPTR4 convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 16 Feb 2008 14:17:56 -0500
Received: from neuf-infra-smtp-out-sp604002av.neufgp.fr ([84.96.92.126])
	by neuf-infra-smtp-out-sp604007av.neufgp.fr with neuf telecom
	id qAnE1Y0052jakD8070PJ00; Sat, 16 Feb 2008 20:17:51 +0100
Received: from maison.homelinux.org ([84.103.71.93])
	by neuf-infra-smtp-out-sp604002av.neufgp.fr with neuf telecom
	id qKHX1Y00520lBGc0200000; Sat, 16 Feb 2008 20:17:50 +0100
Received: from moi by maison.homelinux.org with local (Exim 4.69)
	(envelope-from <moi@vanicat.homelinux.org>)
	id 1JQSXQ-0004um-De; Sat, 16 Feb 2008 20:17:30 +0100
In-Reply-To: <87zlu4vhon.fsf@osv.gnss.ru> (Sergei Organov's message of "Wed\, 13 Feb 2008 21\:23\:52 +0300")
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/74065>

I've a new version, in the form of a patch series that follow:
first I add some function for asking user commitish
then some code for checkouting commitish and branching, mostly
following the idea of Sergei,
then some code for merging.

I've look to add rebase, but when thinking about how to do about
conflict and continued rebasing, I feel lazy, and didn't try. As
someone a good idea for the interface?
--=20
R=C3=A9mi Vanicat

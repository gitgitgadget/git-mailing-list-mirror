From: =?utf-8?Q?R=C3=A9mi?= Vanicat <vanicat@debian.org>
Subject: [PATCH v3 00/03] switching, branch creating branch and merging within Emacs
Date: Mon, 18 Feb 2008 17:24:04 +0100
Message-ID: <87zltyp717.dlv@maison.homelinux.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Alexandre Julliard <julliard@winehq.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Feb 18 17:24:59 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JR8nX-0002Sq-Ky
	for gcvg-git-2@gmane.org; Mon, 18 Feb 2008 17:24:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754198AbYBRQYT convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 18 Feb 2008 11:24:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754680AbYBRQYT
	(ORCPT <rfc822;git-outgoing>); Mon, 18 Feb 2008 11:24:19 -0500
Received: from neuf-infra-smtp-out-sp604007av.neufgp.fr ([84.96.92.120]:33583
	"EHLO neuf-infra-smtp-out-sp604007av.neufgp.fr" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753708AbYBRQYS convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Feb 2008 11:24:18 -0500
Received: from neuf-infra-smtp-out-sp604002av.neufgp.fr ([84.96.92.126])
	by neuf-infra-smtp-out-sp604007av.neufgp.fr with neuf telecom
	id qt7V1Y0022jakD8070hx00; Mon, 18 Feb 2008 17:24:08 +0100
Received: from maison.homelinux.org ([84.103.71.93])
	by neuf-infra-smtp-out-sp604002av.neufgp.fr with neuf telecom
	id r4Q71Y00C20lBGc0200000; Mon, 18 Feb 2008 17:24:07 +0100
Received: from moi by maison.homelinux.org with local (Exim 4.69)
	(envelope-from <moi@vanicat.homelinux.org>)
	id 1JR8mi-0003UB-Ry; Mon, 18 Feb 2008 17:24:06 +0100
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/74306>

So, I resend my patch series, with better keys binding, reworked refs
reading (using git-for-each-ref), and a common framework for building
menu for merge/checkout/rebase/branching (even if it is for now only
use for checkout and merge).

--=20
R=C3=A9mi Vanicat

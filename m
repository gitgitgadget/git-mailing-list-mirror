From: Remi Vanicat <vanicat@debian.org>
Subject: Re: [PATCH] git.el: Add a git-grep command
Date: Thu, 21 Feb 2008 14:12:15 +0100
Message-ID: <87ve4itpw0.dlv@maison.homelinux.org>
References: <87odaa4tcl.fsf@lysator.liu.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Alexandre Julliard <julliard@winehq.org>,
	Git Mailing List <git@vger.kernel.org>
To: David =?utf-8?Q?K=C3=A5gedal?= <davidk@lysator.liu.se>
X-From: git-owner@vger.kernel.org Thu Feb 21 14:13:13 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JSBEc-00006n-3A
	for gcvg-git-2@gmane.org; Thu, 21 Feb 2008 14:13:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752465AbYBUNMe convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 21 Feb 2008 08:12:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754130AbYBUNMd
	(ORCPT <rfc822;git-outgoing>); Thu, 21 Feb 2008 08:12:33 -0500
Received: from neuf-infra-smtp-out-sp604007av.neufgp.fr ([84.96.92.120]:38065
	"EHLO neuf-infra-smtp-out-sp604007av.neufgp.fr" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750850AbYBUNMb convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Feb 2008 08:12:31 -0500
Received: from neuf-infra-smtp-out-sp604002av.neufgp.fr ([84.96.92.126])
	by neuf-infra-smtp-out-sp604007av.neufgp.fr with neuf telecom
	id sBsR1Y0042jakD80705V00; Thu, 21 Feb 2008 14:12:26 +0100
Received: from maison.homelinux.org ([84.103.71.93])
	by neuf-infra-smtp-out-sp604002av.neufgp.fr with neuf telecom
	id sDCJ1Y00J20lBGc0200000; Thu, 21 Feb 2008 14:12:19 +0100
Received: from moi by maison.homelinux.org with local (Exim 4.69)
	(envelope-from <moi@vanicat.homelinux.org>)
	id 1JSBDj-00020H-Lv; Thu, 21 Feb 2008 14:12:17 +0100
In-Reply-To: <87odaa4tcl.fsf@lysator.liu.se> ("David =?utf-8?Q?K=C3=A5geda?=
 =?utf-8?Q?l=22's?= message of "Tue\, 19 Feb 2008 14\:03\:18 +0100")
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/74614>

David K=C3=A5gedal <davidk@lysator.liu.se> writes:

> This allows easy access to git grep from Emacs.
>


You might want to add a menu:

@@ -1497,6 +1497,7 @@ amended version of it."
       ["Diff File" git-diff-file t]
       ["Interactive Diff File" git-diff-file-idiff t]
       ["Log" git-log-file t]
+      ["Grep" git-grep t]
       "--------"
       ["Mark" git-mark-file t]
       ["Mark All" git-mark-all t]

--=20
R=C3=A9mi Vanicat

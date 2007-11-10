From: ludo@chbouib.org (Ludovic =?iso-8859-1?Q?Court=E8s?=)
Subject: `git-send-email' doesn't specify `Content-Type'
Date: Sat, 10 Nov 2007 01:14:48 +0100
Message-ID: <87ode3klc7.fsf@chbouib.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Nov 10 01:20:25 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Iqe5I-0000dO-4E
	for gcvg-git-2@gmane.org; Sat, 10 Nov 2007 01:20:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751055AbXKJAUH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 Nov 2007 19:20:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751407AbXKJAUG
	(ORCPT <rfc822;git-outgoing>); Fri, 9 Nov 2007 19:20:06 -0500
Received: from main.gmane.org ([80.91.229.2]:43662 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750847AbXKJAUF (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Nov 2007 19:20:05 -0500
Received: from root by ciao.gmane.org with local (Exim 4.43)
	id 1Iqe4w-000352-JL
	for git@vger.kernel.org; Sat, 10 Nov 2007 00:20:02 +0000
Received: from adh419.fdn.fr ([80.67.176.9])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 10 Nov 2007 00:20:02 +0000
Received: from ludo by adh419.fdn.fr with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 10 Nov 2007 00:20:02 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: adh419.fdn.fr
X-URL: http://www.laas.fr/~lcourtes/
X-PGP-Key-ID: 0xEB1F5364
X-PGP-Key: http://www.laas.fr/~lcourtes/ludovic.asc
X-PGP-Fingerprint: 821D 815D 902A 7EAB 5CEE  D120 7FBA 3D4F EB1F 5364
X-OS: i486-pc-linux-gnu
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.1 (gnu/linux)
Cancel-Lock: sha1:0IpOSVLblxypFqLpAXfDbwfrQPg=
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/64285>

Hi,

Apparently, `git-send-email' doesn't specify the email's `Content-Type',
notably its charset, while it should really add something like:

  Content-Type: text/plain; charset=UTF-8

Or did I miss an option or something?

Thanks,
Ludovic.

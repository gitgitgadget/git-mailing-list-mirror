From: =?utf-8?Q?Santi_B=C3=A9jar?= <sbejar@gmail.com>
Subject: [PATCH/RFC 0/3] Split fetch and merge logic
Date: Fri, 16 Feb 2007 09:06:00 +0100
Message-ID: <874ppmplw7.fsf@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Feb 16 09:06:20 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HHy6i-0000fG-Pz
	for gcvg-git@gmane.org; Fri, 16 Feb 2007 09:06:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966173AbXBPIGP convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Fri, 16 Feb 2007 03:06:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S966176AbXBPIGP
	(ORCPT <rfc822;git-outgoing>); Fri, 16 Feb 2007 03:06:15 -0500
Received: from ifae-s0.ifae.es ([192.101.162.68]:47853 "EHLO ifae-s0.ifae.es"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S966173AbXBPIGN (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 Feb 2007 03:06:13 -0500
Received: from bela (caronte.ifae.es [192.101.162.199])
	by ifae-s0.ifae.es (8.11.6/8.11.6) with ESMTP id l1G867B32628
	for <git@vger.kernel.org>; Fri, 16 Feb 2007 09:06:11 +0100
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/22.0.93 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/39900>


This series implements the split of the fetch and merge logic.

The first patch adds tests for the merge logic. It is very extensive an=
d
expensive (in time), so I just post this to show that (almost) nothing
changes (although some part of if could be included). And the third
patch shows what changes.

Santi B=C3=A9jar (3):
      t/t5515-fetch-merge-logic.sh: Added tests for the merge login in =
git-fetch
      git-fetch: Split fetch and merge logic
      t/t5515: fixes for the separate fetch and merge logic

From: Mattias Ulbrich <mulbrich@ira.uka.de>
Subject: git-mergetool
Date: Fri, 28 Sep 2007 10:56:15 +0200
Message-ID: <200709281056.15844.mulbrich@ira.uka.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Sep 28 11:24:31 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IbC5H-0001QD-Bk
	for gcvg-git-2@gmane.org; Fri, 28 Sep 2007 11:24:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757670AbXI1JYR convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 28 Sep 2007 05:24:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753630AbXI1JYR
	(ORCPT <rfc822;git-outgoing>); Fri, 28 Sep 2007 05:24:17 -0400
Received: from iramx2.ira.uni-karlsruhe.de ([141.3.10.81]:59377 "EHLO
	iramx2.ira.uni-karlsruhe.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756934AbXI1JYQ convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 28 Sep 2007 05:24:16 -0400
X-Greylist: delayed 1673 seconds by postgrey-1.27 at vger.kernel.org; Fri, 28 Sep 2007 05:24:16 EDT
Received: from irams2.ira.uni-karlsruhe.de ([141.3.10.82])
	by iramx2.ira.uni-karlsruhe.de with esmtps 
	id 1IbBdz-0000ez-7t
	for <git@vger.kernel.org>; Fri, 28 Sep 2007 10:56:21 +0200
Received: from irams1.ira.uni-karlsruhe.de ([141.3.10.5])
	by irams2.ira.uni-karlsruhe.de with esmtps 
	for <git@vger.kernel.org>
	id 1IbBdx-0002yF-Q9; Fri, 28 Sep 2007 10:56:18 +0200
Received: from i12pc3.ilkd.uni-karlsruhe.de ([141.3.27.53])
	by irams1.ira.uni-karlsruhe.de with esmtp 
	for <git@vger.kernel.org>
	id 1IbBdx-0006W0-HH; Fri, 28 Sep 2007 10:56:17 +0200
User-Agent: KMail/1.9.1
Content-Disposition: inline
X-Spam-Status: No
X-Spam-Score: -1.3 (-)
X-Spam-Report: -1.4 ALL_TRUSTED            Passed through trusted hosts only via SMTP
	0.1 AWL                    AWL: From: address is in the auto white-list
X-Spam-Host: irams2.ira.uni-karlsruhe.de
X-ATIS-Checksum: v3zoCAcc32ckk
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/59380>


Hello everybody,

There might by a tiny typo-bug in the git-mergetool:

-----------
 case "$merge_tool" in
	kdiff3)
	    if base_present ; then
		(kdiff3 --auto --L1 "$path (Base)" -L2 "$path (Local)" --L3 "$path (R=
emote)"=20
\
		    -o "$path" -- "$BASE" "$LOCAL" "$REMOTE" > /dev/null 2>&1)
	    else
		(kdiff3 --auto -L1 "$path (Local)" --L2 "$path (Remote)" \
		    -o "$path" -- "$LOCAL" "$REMOTE" > /dev/null 2>&1)
	    fi
-----------

In the first call to kdiff3 the argument is only -L2 but should be --L2=
 (two=20
minus signs) like in the second call - where -L1 misses its second "-".

Thank you for a very mighty set of tool

Sincerely

	Mattias

--=20
Mattias Ulbrich
=46orschungsgruppe Prof. Dr. P.H. Schmitt
Institut f=FCr Theoretische Informatik
Universit=E4t Karlsruhe

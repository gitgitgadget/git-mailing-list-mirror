From: SZEDER =?iso-8859-1?Q?G=E1bor?= <szeder@ira.uka.de>
Subject: gitk: can't reload commits with new key binding
Date: Sun, 30 Sep 2012 12:19:32 +0200
Message-ID: <20120930101932.GA15672@goldbirke>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Felipe Contreras <felipe.contreras@gmail.com>,
	Paul Mackerras <paulus@samba.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Sep 30 12:19:48 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TIGcl-0007eE-9Q
	for gcvg-git-2@plane.gmane.org; Sun, 30 Sep 2012 12:19:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750805Ab2I3KTi convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 30 Sep 2012 06:19:38 -0400
Received: from moutng.kundenserver.de ([212.227.17.10]:50830 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750724Ab2I3KTh (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 30 Sep 2012 06:19:37 -0400
Received: from localhost6.localdomain6 (p5B1309E4.dip0.t-ipconnect.de [91.19.9.228])
	by mrelayeu.kundenserver.de (node=mrbap1) with ESMTP (Nemesis)
	id 0MQd8X-1Sr8Rt3lS1-00U4aO; Sun, 30 Sep 2012 12:19:33 +0200
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Provags-ID: V02:K0:Q1QrlICEzlBctukp6eEpnL0tDBFc8rb2OVrhqLJg+ur
 MrgIshA+qpEU/NLEMiKefCp7GulpNomNo4Fs9pQNO/w3rOyWOG
 SowYKeVo05MnSeZp6Vx0iIzynPbJBdTd4W1eY5Z6IGvpVNTrS0
 BK8D7pAdzugv0UkQ6l+d1sHDKelMBX4CjycLzZ73b4Ld2UlgMB
 i0hmb9fRcGA9t0nBEnDpaEauCQlRW4KGOI4ca3zJeuBN4GNfeA
 vFDa+05xYRJsvuGFqE8QpjO4PRd3khWtFWD3Z1D0B7hUw+pHjw
 7+ehBaXBolknmxbSLyOA5uN2S4ox73thj7tFJ16N8SnWWHMot7
 xvQW9pUZe0y9V32r8g3qQFSokz4sjjHiEHVS8gJIT
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/206686>

Hi,

a135f214 (gitk: Avoid Meta1-F5, 2012-04-07) changed the key binding
for reloading commits to shift-F5, but this new key binding doesn't
seem to be working here, because it doesn't call reloadcommits().
Choosing the reload menu item works.  Shift-F5 works properly in other
applications.

Any ideas?

Thanks,
G=E1bor

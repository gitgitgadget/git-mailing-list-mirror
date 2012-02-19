From: Nikolaus Demmel <nikolaus@nikolaus-demmel.de>
Subject: git-svn support for svn:externals
Date: Sun, 19 Feb 2012 06:58:16 +0100
Message-ID: <A3C07D7C-954D-4648-AA54-0DF5205B39EC@nikolaus-demmel.de>
Mime-Version: 1.0 (Apple Message framework v1084)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Feb 19 06:58:55 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RyznS-0001Rh-Mr
	for gcvg-git-2@plane.gmane.org; Sun, 19 Feb 2012 06:58:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751560Ab2BSF6U (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 19 Feb 2012 00:58:20 -0500
Received: from moutng.kundenserver.de ([212.227.126.186]:61917 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751375Ab2BSF6T convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 19 Feb 2012 00:58:19 -0500
Received: from [192.168.178.100] (c-cca272d5.015-455-73746f34.cust.bredbandsbolaget.se [213.114.162.204])
	by mrelayeu.kundenserver.de (node=mreu3) with ESMTP (Nemesis)
	id 0MPeS5-1S3gc41sDR-005Roq; Sun, 19 Feb 2012 06:58:17 +0100
X-Mailer: Apple Mail (2.1084)
X-Provags-ID: V02:K0:N2jlO/7RPTUukoFwFh4IUZdgCXEPS46uhhLq1rRkvq7
 BeY+TNAaVZjm608f3OiBXbtcvuj6f6bSyD0cDJBZNQnDqsLV9z
 QlUoAwDi3d8kE6YEt71ycXMPmfJfBvIQNbaqWfDMQcjnlTMC0G
 O+tJPT9Om+1738LOAujZ4mut0n7i0FRLuxDME9I45zV3HqitCC
 UDz+qdA+H5D393udW0sEJ0EPz1iTW0ue6P05ULOqy9GKvwyKR9
 RpZQi7A5ZbcWc01SqF3jMPWClN/c6F9oC7C2TJxssw007m3/M/
 FPXpV8rDQErSq4mFPADG3fRj6PbLuciwXwfWNtuxlTTREYq9FV
 4iB3lH/SoH/TIeYqZd2t2cY8PgWATcJfOW+iNn4hD8r4QF2tLk
 SiKP3u2SJniDaWeU0hGJiRTUaOREhnXuDY=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/191019>

Hi,

has there been any recent interest / activity in getting support for svn:externals? Digging in the archives [1,2,3] I found a couple of initiatives, but none seem to have ever been completed. Also, there are a couple of independent scripts floating around the web, that implement some special cases, but most don't work very well, e.g. because they only serve the pre-1.5 syntax for svn:externals.

Support for svn:externals would make my live so much simpler :-).

Cheers,
Nikolaus

[1] http://git.661346.n2.nabble.com/Re-git-svn-and-svn-externals-was-Re-Hackontest-ideas-tc667598.html
[2] http://git.661346.n2.nabble.com/PATCH-0-3-git-svn-externals-PoC-in-a-sh-script-tc791045.html#none
[3] http://git.661346.n2.nabble.com/git-svn-importing-internal-externals-tc2982345.html#none
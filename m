From: Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: [PATCH 0/4] Git for Windows fixes in preparation for 2.8.0
Date: Tue, 22 Mar 2016 18:42:34 +0100 (CET)
Message-ID: <cover.1458668543.git.johannes.schindelin@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: git@vger.kernel.org, Lars Schneider <larsxschneider@gmail.com>,
	Johannes Sixt <j6t@kdbg.org>,
	Kazutoshi SATODA <k_satoda@f2.dion.ne.jp>,
	Eric Wong <normalperson@yhbt.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Mar 22 18:43:04 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aiQKc-000380-Ta
	for gcvg-git-2@plane.gmane.org; Tue, 22 Mar 2016 18:43:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755094AbcCVRmy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Mar 2016 13:42:54 -0400
Received: from mout.gmx.net ([212.227.15.19]:58491 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751365AbcCVRmw (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Mar 2016 13:42:52 -0400
Received: from virtualbox ([37.24.143.127]) by mail.gmx.com (mrgmx003) with
 ESMTPSA (Nemesis) id 0LwZtX-1ZhzgQ0GBL-018NKO; Tue, 22 Mar 2016 18:42:37
 +0100
X-X-Sender: virtualbox@virtualbox
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
X-Provags-ID: V03:K0:zizxKocbGHAbbwkEjO7pJS3K3s4pXl8gRzIgRSqbJyRmCID725x
 5Z0AE9so2DR1HGWyET3OPrT7xTo1zp8JmkBcya5kZl1P4oaIic5PjZ9bOdlCtYs0XPrzF2n
 E8aLTfnIbVor0gKd82oebmjM4P0D9kgGYaro3MeYTW08/Hbbv9mxxo8/yzgc02+Qi9gDL3z
 qTdnKa0z8yfvbS5bk37Sw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:MDVh+ODYxWk=:EeuvhM7cdQQ3ivhl6KmXS4
 PoVTkIzztAM9ANv/Z/4OOaT1NPlz9znE7iDsKNmXNLdbC4VJBUPYqkjukQmjDBYWdnInlBrXK
 PP2jA/oNJkxOsilxLi8UoM2jbxb3hF4CYIwZJhSPHB1Wmmajb5YsD4E6Iqf4oEKrzkmYnegza
 R4GAlxgoS7vVoWlSQhM5KUbab2XvZHnzRpZkROg1Mwu7LN/zG3aY8cMPSX5+e9ZplHHMTG/FD
 o8YEMLkEJ2W3QzN4YPO64aucwYPal2zeHVZYU4VDzLVYdNMLF1lmY2sPrLxNstwt+lgd51F9s
 wgNihq2NmpJPZ14P6TV1cat+aqfPvuzO10+fNF7t9R43tN0XwC0D9M0KldeIfaQQtgkSbx/4r
 zQuHfr0o7UdyOyTQ1abvWbaELgpULrb9A77e2BWDw4c+NjPqDZ962YluOL03lRpbWrAPfBsn+
 HMpIJWkodJAXAlqeRmgf9cHdD1X+813wPH2SCduH7AiYQZ6201Hvn71VVe/jyIxqhYHzUDH8I
 ZexOuKCfI3NB7KH5nTPJ8VBWd5ljU5CzaP+mV09A/9WO3eiu7ZWX3YTPdP6qT+ZPpgH3Q7H5H
 nx3PIeuAZxaTzJorrfHtYHtyLWH/DgZqvaPNs9HB67XTPKRQ7yJOb6hZib479ntIiAFk//dd1
 XCJIRCna29GT/OwAx5EmTNssIk8AndiWB6DlrAQzOGJqmKw/82IzvSFAsydrglsFtDTa8na/2
 FmpjbEiZOe71mESgedY15boULsLRC2KaLoIG5bj/Gdl2iKDd1pmCViZ4wscKsob8o6wh12sN 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/289523>

The t1300 and t9115 tests regressed on Windows. These patches fix that.


Johannes Schindelin (4):
  config --show-origin: report paths with forward slashes
  Make t1300-repo-config resilient to being run via 'sh -x'
  t1300: fix the new --show-origin tests on Windows
  mingw: skip some tests in t9115 due to file name issues

 compat/mingw.h                           |  6 ++++++
 path.c                                   |  3 +++
 t/t1300-repo-config.sh                   | 23 ++++++++++++++---------
 t/t9115-git-svn-dcommit-funky-renames.sh |  4 ++--
 4 files changed, 25 insertions(+), 11 deletions(-)

-- 
2.7.4.windows.1

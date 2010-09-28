From: Zbyszek Szmek <zbyszek@in.waw.pl>
Subject: Re: [PATCH] Makefile: implement help target
Date: Tue, 28 Sep 2010 16:57:13 +0200
Message-ID: <20100928145713.GE6756@in.waw.pl>
References: <4CA1E10F.4080906@op5.se> <c16e8df7c8e9b562ce0e6cd6e543a83779cd2b25.1285684868.git.git@drmicha.warpmail.net> <AANLkTin9JZ1CErBaZjyLXBuBaX4Da7-2dgzotex+bu8X@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Michael J Gruber <git@drmicha.warpmail.net>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>,
	Stephen Boyd <bebarino@gmail.com>, Andreas Ericsson <ae@op5.se>
To: Sverre Rabbelier <srabbelier@gmail.com>
X-From: git-owner@vger.kernel.org Tue Sep 28 16:57:28 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P0bcU-0008VG-Ft
	for gcvg-git-2@lo.gmane.org; Tue, 28 Sep 2010 16:57:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756618Ab0I1O5V (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 28 Sep 2010 10:57:21 -0400
Received: from cwm83.internetdsl.tpnet.pl ([83.19.120.83]:4793 "EHLO
	cwm83.internetdsl.tpnet.pl" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754281Ab0I1O5U (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 28 Sep 2010 10:57:20 -0400
Received: from zbyszek by cwm83.internetdsl.tpnet.pl with local (Exim 4.69)
	(envelope-from <zbyszek@in.waw.pl>)
	id 1P0bcH-0006pf-OT; Tue, 28 Sep 2010 16:57:13 +0200
Content-Disposition: inline
In-Reply-To: <AANLkTin9JZ1CErBaZjyLXBuBaX4Da7-2dgzotex+bu8X@mail.gmail.com>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/157432>

Hi,
the original output (divided into documentation, building, cleaning, etc.)
seems to be much more readable. Maybe a sort key could be added to the
begging of the help message and then stripped before output?
Something like:
  # Help: Building: compile everything
  all:
  
  # Help: Cleaning: remove things
  clean:

Best,
Zbyszek

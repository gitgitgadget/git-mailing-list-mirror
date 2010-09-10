From: Marat Radchenko <marat@slonopotamus.org>
Subject: Re: [PATCH v2] hash binary sha1 into patch id
Date: Fri, 10 Sep 2010 09:17:30 +0400
Message-ID: <1284095850.1728.5.camel@n900.home.ru>
References: <20100813094027.GA20906@localhost>
	 <20100813200031.GD2003@burratino> <20100813212331.GA24127@localhost>
	 <20100813213726.GB2516@burratino> <20100813215801.GA24534@localhost>
	 <20100815072043.GA368@localhost>
Reply-To: Marat Radchenko <marat@slonopotamus.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Michael J Gruber <git@drmicha.warpmail.net>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Clemens Buchacher <drizzd@aon.at>,
	Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Sep 10 07:13:27 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OtvvR-00040F-VJ
	for gcvg-git-2@lo.gmane.org; Fri, 10 Sep 2010 07:13:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753603Ab0IJFNT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 10 Sep 2010 01:13:19 -0400
Received: from static.247.67.47.78.clients.your-server.de ([78.47.67.247]:51774
	"EHLO slonopotamus.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750922Ab0IJFNS (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 10 Sep 2010 01:13:18 -0400
Received: from [83.149.8.164] (helo=[10.215.72.138])
	by slonopotamus.org with esmtpsa (SSLv3:CAMELLIA256-SHA:256)
	(Exim 4.72)
	(envelope-from <marat@slonopotamus.org>)
	id 1OtvvH-0002bx-Eg; Fri, 10 Sep 2010 09:13:15 +0400
X-Mailer: Modest 3.2
In-Reply-To: <20100815072043.GA368@localhost>
Content-ID: <1284095850.1728.4.camel@n900.home.ru>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/155919>

As I see, this recently hit git master. I want to say big thanks since it improved git rebase from tens of minutes to just minutes here (warm disk caches).

However, I can't say I'm completely satisfied with git rebase speed (I'd like it to be < 1 min). So, are there known performance hotspots in 'git rev-list --cherry-pick'/'git format-patch --ignore-if-in-upstream' (these are two flags have biggest impact on git rebase [-i] speed) or I should run some kind of profiles in order to determine what else could be improved?

From: Paolo Bonzini <paolo.bonzini@lu.unisi.ch>
Subject: Re: [PATCH 1/3] git-branch: add --track and --no-track options
Date: Tue, 06 Mar 2007 08:23:26 +0100
Message-ID: <45ED16EE.8020303@lu.unisi.ch>
References: <esgm1m$33f$1@sea.gmane.org>	<Pine.LNX.4.63.0703051520340.22628@wbgn013.biozentrum.uni-wuerzburg.de>	<45EC3905.7070406@lu.unisi.ch>	<Pine.LNX.4.63.0703051648330.22628@wbgn013.biozentrum.uni-wuerzburg.de>	<45EC4B55.3090505@lu.unisi.ch>	<Pine.LNX.4.63.0703051812030.22628@wbgn013.biozentrum.uni-wuerzburg.de>	<45EC51C6.5080505@lu.unisi.ch>	<Pine.LNX.4.63.0703051930560.22628@wbgn013.biozentrum.uni-wuerzburg.de>	<45EC8959.1090303@lu.unisi.ch> <7v3b4jxtx8.fsf@assigned-by-dhcp.cox.net>
Reply-To: bonzini@gnu.org
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: bonzini@gnu.org, Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Tue Mar 06 08:23:33 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HOU1C-0003xp-G6
	for gcvg-git@gmane.org; Tue, 06 Mar 2007 08:23:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932725AbXCFHX2 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 6 Mar 2007 02:23:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932739AbXCFHX2
	(ORCPT <rfc822;git-outgoing>); Tue, 6 Mar 2007 02:23:28 -0500
Received: from server.usilu.net ([195.176.178.200]:23154 "EHLO mail.usilu.net"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S932725AbXCFHX2 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Mar 2007 02:23:28 -0500
Received: from [192.168.68.211] ([192.168.68.211] RDNS failed) by mail.usilu.net over TLS secured channel with Microsoft SMTPSVC(6.0.3790.1830);
	 Tue, 6 Mar 2007 08:23:25 +0100
User-Agent: Thunderbird 1.5.0.10 (Macintosh/20070221)
In-Reply-To: <7v3b4jxtx8.fsf@assigned-by-dhcp.cox.net>
X-OriginalArrivalTime: 06 Mar 2007 07:23:25.0290 (UTC) FILETIME=[541D14A0:01C75FC0]
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/41550>


> Yes, that is correct.  Some C lib implementations seem to count
> %n and others don't so it is not reliable.  That is one of the
> reasons I personally have stayed away from fancier sscanf()
> constructs, both inside and outside git project.

So, should I remove it?  As I said, the code using sscanf is already the second try, and the first was utterly illegible, so I'd rather stay with it.

Paolo

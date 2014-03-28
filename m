From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [PATCH 09/10] t4213: test --function-name option
Date: Fri, 28 Mar 2014 12:45:36 +0100
Message-ID: <533560E0.3010106@viscovery.net>
References: <1395946256-67124-1-git-send-email-dad-bgl@mit.edu> <4eb91822043e730bf8a47f12a9129d02f6fc135d.1395942768.git.davidad@alum.mit.edu> <533523F9.2000108@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, peff@peff.net, l.s.r@web.de,
	"David Dalrymple (on zayin)" <davidad@alum.mit.edu>
To: "David A. Dalrymple (and Bhushan G. Lodha)" <dad-bgl@mit.edu>
X-From: git-owner@vger.kernel.org Fri Mar 28 12:45:48 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WTVEI-00065K-Vi
	for gcvg-git-2@plane.gmane.org; Fri, 28 Mar 2014 12:45:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752496AbaC1Lpm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 28 Mar 2014 07:45:42 -0400
Received: from so.liwest.at ([212.33.55.23]:60940 "EHLO so.liwest.at"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751185AbaC1Lpl (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 28 Mar 2014 07:45:41 -0400
Received: from [81.10.228.254] (helo=theia.linz.viscovery)
	by so.liwest.at with esmtpa (Exim 4.80.1)
	(envelope-from <j.sixt@viscovery.net>)
	id 1WTVE8-0000a4-Ho; Fri, 28 Mar 2014 12:45:36 +0100
Received: from [192.168.1.95] (J6T.linz.viscovery [192.168.1.95])
	by theia.linz.viscovery (Postfix) with ESMTP id 48F8116613;
	Fri, 28 Mar 2014 12:45:36 +0100 (CET)
User-Agent: Mozilla/5.0 (Windows NT 5.1; rv:24.0) Gecko/20100101 Thunderbird/24.1.0
In-Reply-To: <533523F9.2000108@viscovery.net>
X-Spam-Score: -1.0 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/245381>

>> +	sed -i -e "s/void newfunc2/void newfunc4/" file &&

I forgot to mention that sed -i is not portable.

-- Hannes

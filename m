From: Mr_and_Mrs_D <the.ubik@gmail.com>
Subject: Re: [PATCH master] convert: The native line-ending is \r\n on MinGW
Date: Sun, 25 Nov 2012 07:39:00 -0800 (PST)
Message-ID: <1353857940941-7571889.post@n2.nabble.com>
References: <1275679748-7214-1-git-send-email-eyvind.bernhardsen@gmail.com> <20100904082509.GC10140@burratino> <7vbp8aqtuz.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Nov 25 16:39:25 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TceIg-0007IJ-RS
	for gcvg-git-2@plane.gmane.org; Sun, 25 Nov 2012 16:39:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753146Ab2KYPjD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 25 Nov 2012 10:39:03 -0500
Received: from 216-139-250-139.aus.us.siteprotect.com ([216.139.250.139]:33136
	"EHLO joe.nabble.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753142Ab2KYPjB (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 25 Nov 2012 10:39:01 -0500
Received: from jim.nabble.com ([192.168.236.80])
	by joe.nabble.com with esmtp (Exim 4.72)
	(envelope-from <the.ubik@gmail.com>)
	id 1TceIO-0002sK-V8
	for git@vger.kernel.org; Sun, 25 Nov 2012 07:39:01 -0800
In-Reply-To: <7vbp8aqtuz.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/210370>

I am on windows 7 Pro - mingwin

I decided to turn autocrlf to false and use .gitattributes instead and was
bitten by this bug :

http://stackoverflow.com/questions/13531988/git-line-endings-renormalize-does-not-seem-to-checkout-the-right-line-endings

It took me 2 days to figure this out

Please fix



--
View this message in context: http://git.661346.n2.nabble.com/PATCH-v6-Add-core-eol-config-variable-tp5140844p7571889.html
Sent from the git mailing list archive at Nabble.com.

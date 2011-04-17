From: madmarcos <fru574@my.utsa.edu>
Subject: Re: Java Inflater problem decompressing packfile
Date: Sat, 16 Apr 2011 21:06:15 -0700 (PDT)
Message-ID: <1303013175664-6280295.post@n2.nabble.com>
References: <1302919505984-6278154.post@n2.nabble.com> <20110416063729.GC28853@sigill.intra.peff.net> <1302963832717-6279028.post@n2.nabble.com> <1302964576373-6279050.post@n2.nabble.com> <1302965899845-6279085.post@n2.nabble.com> <1302969047343-6279183.post@n2.nabble.com> <1303000824677-6280097.post@n2.nabble.com> <1303012970295-6280285.post@n2.nabble.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Apr 17 06:06:21 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QBJFc-000815-SV
	for gcvg-git-2@lo.gmane.org; Sun, 17 Apr 2011 06:06:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751070Ab1DQEGR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 17 Apr 2011 00:06:17 -0400
Received: from sam.nabble.com ([216.139.236.26]:57377 "EHLO sam.nabble.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751139Ab1DQEGP (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 17 Apr 2011 00:06:15 -0400
Received: from jim.nabble.com ([192.168.236.80])
	by sam.nabble.com with esmtp (Exim 4.69)
	(envelope-from <fru574@my.utsa.edu>)
	id 1QBJFX-0003V3-Lg
	for git@vger.kernel.org; Sat, 16 Apr 2011 21:06:15 -0700
In-Reply-To: <1303012970295-6280285.post@n2.nabble.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/171713>

I hit send too quickly. 
beneath the readFile call in the test4() method are several commented-out
System.arraycopy lines. you can uncomment any one of them to see the blob or
tree decompressed. all but the the last arraycopy line work fine. the last
one is the problem.

thanks for any light you can shed on the problem. I am pulling my hair out.

--
View this message in context: http://git.661346.n2.nabble.com/Java-Inflater-problem-decompressing-packfile-tp6278154p6280295.html
Sent from the git mailing list archive at Nabble.com.

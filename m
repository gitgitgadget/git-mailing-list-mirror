From: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
Subject: Re: Any plans to support JTA and XA in jgit?
Date: Thu, 13 Nov 2008 20:59:16 +0100
Message-ID: <200811132059.16616.robin.rosenberg.lists@dewire.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Farrukh Najmi <farrukh@wellfleetsoftware.com>
X-From: git-owner@vger.kernel.org Thu Nov 13 21:00:52 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L0iMu-0007kZ-Vq
	for gcvg-git-2@gmane.org; Thu, 13 Nov 2008 21:00:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754616AbYKMT72 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 13 Nov 2008 14:59:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751823AbYKMT70
	(ORCPT <rfc822;git-outgoing>); Thu, 13 Nov 2008 14:59:26 -0500
Received: from pne-smtpout2-sn1.fre.skanova.net ([81.228.11.159]:60650 "EHLO
	pne-smtpout2-sn1.fre.skanova.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755427AbYKMT7Z (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 13 Nov 2008 14:59:25 -0500
Received: from sleipner.localnet (213.67.100.250) by pne-smtpout2-sn1.fre.skanova.net (7.3.129)
        id 4843FAEB02778C40; Thu, 13 Nov 2008 20:59:17 +0100
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/100904>

torsdag 13 november 2008 20:20:49 skrev Farrukh Najmi:
> 
> Does the gjit team have any plans to implement support for JTA in gjit 
> so as to allow distributed transactions using 2 phase commit? This would 
> be very powerful when git is being used in conjunction with other 
> transaction resource managers such as databases.

No such plans exist. We do not even have a J2EE Resource Manager yet. I
did some toying implementing one. As for XA support, I guess that would
not be very hard per se, but my thoughts on JEE support was more in the direction
of gitweb-like stuff, i.e. reading.

Trying to involve git in distributed database transactions might be cool, but seriously: Do you
need it? As for JEE my ideas are: A nice JSP tag library and a resource manager. When is
an entirely different question, as is who. Did you look at  my experiment in a reply of mine
in another recent jgit thread?

The term "distributed" in XA is not quite the same as in distributed verison control. If it would,
then we'd send SQL commands over e-mail (now, /that/ would be cool :).

-- robin

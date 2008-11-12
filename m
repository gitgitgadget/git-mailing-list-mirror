From: Thomas Koch <thomas@koch.ro>
Subject: hosting git on a nfs
Date: Wed, 12 Nov 2008 10:29:34 +0100
Organization: Young Media Concepts
Message-ID: <200811121029.34841.thomas@koch.ro>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: dabe@ymc.ch
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Nov 12 10:56:15 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L0CSC-0002Qg-5P
	for gcvg-git-2@gmane.org; Wed, 12 Nov 2008 10:56:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751261AbYKLJyg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 Nov 2008 04:54:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751155AbYKLJyg
	(ORCPT <rfc822;git-outgoing>); Wed, 12 Nov 2008 04:54:36 -0500
Received: from koch.ro ([195.34.83.107]:33446 "EHLO
	ve825703057.providerbox.net" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751081AbYKLJyf (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 12 Nov 2008 04:54:35 -0500
X-Greylist: delayed 1495 seconds by postgrey-1.27 at vger.kernel.org; Wed, 12 Nov 2008 04:54:35 EST
Received: from 80-218-104-120.dclient.hispeed.ch ([80.218.104.120] helo=jona.local)
	by ve825703057.providerbox.net with esmtpsa (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.69)
	(envelope-from <thomas@koch.ro>)
	id 1L0C2Y-0000wI-Rf; Wed, 12 Nov 2008 10:29:34 +0100
User-Agent: KMail/1.9.9
X-Face: ##Diipbu!WHqpJ%Eb+k:m;]n%VcrM\f\MJ-:0\<0.r?ULf7g"kC!"Cg,o;D]
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/100732>

Hi,

finally I managed to convince a critical mass of developers (our chief
dev :-) in our company so that we are starting to migrate to GIT.

The final question is, whether GIT will life peacefully on our cluster
fileservers. The GIT repository dir (/var/cache/git) should be mounted
via NFS via PAN on top of DRBD (so I was told).

Are there any known problems with this setup? We're asking, because
there are problems with SVN on such a setup[1].

[1] http://subversion.tigris.org/faq.html#nfs

Best regards,
-- 
Thomas Koch, Software Developer
http://www.koch.ro

Young Media Concepts GmbH
Sonnenstr. 4
CH-8280 Kreuzlingen
Switzerland

Tel    +41 (0)71 / 508 24 86
Fax    +41 (0)71 / 560 53 89
Mobile +49 (0)170 / 753 89 16
Web    www.ymc.ch

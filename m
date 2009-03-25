From: Thomas Koch <thomas@koch.ro>
Subject: Use alternate GIT servers to share traffic
Date: Wed, 25 Mar 2009 21:45:29 +0100
Organization: Young Media Concepts
Message-ID: <200903252145.30226.thomas@koch.ro>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Mar 25 22:34:40 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lmak5-0004Eh-7n
	for gcvg-git-2@gmane.org; Wed, 25 Mar 2009 22:34:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752142AbZCYVdB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Mar 2009 17:33:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752391AbZCYVdA
	(ORCPT <rfc822;git-outgoing>); Wed, 25 Mar 2009 17:33:00 -0400
Received: from koch.ro ([93.90.184.107]:47599 "EHLO
	ve825703057.providerbox.net" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1752361AbZCYVc7 (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 25 Mar 2009 17:32:59 -0400
X-Greylist: delayed 2837 seconds by postgrey-1.27 at vger.kernel.org; Wed, 25 Mar 2009 17:32:59 EDT
Received: from 32-18.78-83.cust.bluewin.ch ([83.78.18.32] helo=jona.localnet)
	by ve825703057.providerbox.net with esmtpsa (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.69)
	(envelope-from <thomas@koch.ro>)
	id 1LmZyk-0006gM-3H
	for git@vger.kernel.org; Wed, 25 Mar 2009 21:45:38 +0100
User-Agent: KMail/1.11.1 (Linux/2.6.28-1-amd64; KDE/4.2.1; x86_64; ; )
X-Face: ##Diipbu!WHqpJ%Eb+k:m;]n%VcrM\f\MJ-:0\<0.r?ULf7g"kC!"Cg,o;D]
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/114669>

Hi,

we host a public GIT repository on our high availability company
cluster. Cloning the repo causes a trafic volume of 326 MB. We'd like to
avoid that much trafic while still leaving the GIT repo where it is.

I could imagine the following conversation between the GIT client and
server:

Client: Wanna clone!
Server: You're welcome. Please note, that while I serve the most current
state, you can get objects much faster from my collegue Server
CHEAPHOST.
Client: Thank you. Will take all the objects I can get from CHEAPHOST
and come back if I should need anything else!

The enduser should not need to specify anything, but only the regular
git clone EXPENSIVEHOST line.

Your thoughts?

Best regards,
-- 
Thomas Koch, http://www.koch.ro
YMC AG, http://www.ymc.ch

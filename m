From: Holger Hellmuth <hellmuth@ira.uka.de>
Subject: git log --objects
Date: Thu, 24 Jun 2010 17:33:59 +0200
Message-ID: <4C237AE7.8000003@ira.uka.de>
References: <7viq59e6zn.fsf@alter.siamese.dyndns.org> <4C23702F.8030707@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jun 24 17:52:17 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ORoiu-0007ns-M4
	for gcvg-git-2@lo.gmane.org; Thu, 24 Jun 2010 17:52:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755923Ab0FXPwL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 Jun 2010 11:52:11 -0400
Received: from iramx2.ira.uni-karlsruhe.de ([141.3.10.81]:57565 "EHLO
	iramx2.ira.uni-karlsruhe.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755862Ab0FXPwK (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 24 Jun 2010 11:52:10 -0400
X-Greylist: delayed 1135 seconds by postgrey-1.27 at vger.kernel.org; Thu, 24 Jun 2010 11:52:09 EDT
Received: from irams1.ira.uni-karlsruhe.de ([141.3.10.5])
	by iramx2.ira.uni-karlsruhe.de with esmtps port 25 
	id 1ORoQI-00079I-U9
	for <git@vger.kernel.org>; Thu, 24 Jun 2010 17:33:13 +0200
Received: from i20smtp.iaks.uni-karlsruhe.de ([141.3.32.226])
	by irams1.ira.uni-karlsruhe.de with esmtps port 25 
	for <git@vger.kernel.org>
	id 1ORoQI-0007qr-Qs; Thu, 24 Jun 2010 17:33:02 +0200
Received: from throatwobbler.iaks.uka.de ([172.16.22.120])
	by i20smtp.iaks.uni-karlsruhe.de with esmtp (Exim 4.50)
	id 1ORoRJ-0002ml-V4
	for git@vger.kernel.org; Thu, 24 Jun 2010 17:34:05 +0200
User-Agent: Thunderbird 2.0.0.24 (X11/20100302)
In-Reply-To: <4C23702F.8030707@viscovery.net>
X-ATIS-AV: ClamAV (irams1.ira.uni-karlsruhe.de)
X-ATIS-AV: ClamAV (iramx2.ira.uni-karlsruhe.de)
X-ATIS-AV: Kaspersky (iramx2.ira.uni-karlsruhe.de)
X-ATIS-Timestamp: iramx2.ira.uni-karlsruhe.de 1277393593.653984000
X-ATIS-Timestamp: iramx2.ira.uni-karlsruhe.de 1277394728.529155000
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/149601>

Shouldn't 'git log --objects' print out a list of all objects in the
file tree of the commits it lists?

I tried git log with lots of other parameters, for example '-p' and
never saw any difference to the normal output and definitely no list of
hash ids.

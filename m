From: James Spencer <jss43@cam.ac.uk>
Subject: diff-files inconsistency with touched files
Date: Wed, 02 Sep 2009 18:27:15 +0100
Message-ID: <4A9EAAF3.3000002@cam.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Sep 02 19:27:33 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MitcF-00058K-0B
	for gcvg-git-2@lo.gmane.org; Wed, 02 Sep 2009 19:27:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753137AbZIBR1Q (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 2 Sep 2009 13:27:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753134AbZIBR1P
	(ORCPT <rfc822;git-outgoing>); Wed, 2 Sep 2009 13:27:15 -0400
Received: from ppsw-1.csi.cam.ac.uk ([131.111.8.131]:54085 "EHLO
	ppsw-1.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753132AbZIBR1P (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Sep 2009 13:27:15 -0400
X-Cam-AntiVirus: no malware found
X-Cam-SpamDetails: not scanned
X-Cam-ScannerInfo: http://www.cam.ac.uk/cs/email/scanner/
Received: from host81-132-51-142.range81-132.btcentralplus.com ([81.132.51.142]:63309 helo=[192.168.1.66])
	by ppsw-1.csi.cam.ac.uk (smtp.hermes.cam.ac.uk [131.111.8.151]:25)
	with esmtpsa (PLAIN:jss43) (TLSv1:DHE-RSA-AES256-SHA:256)
	id 1Mitc5-0006uc-3J (Exim 4.70) for git@vger.kernel.org
	(return-path <jss43@cam.ac.uk>); Wed, 02 Sep 2009 18:27:17 +0100
User-Agent: Thunderbird 2.0.0.23 (X11/20090817)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/127610>

Hi,

I am puzzled by the following behaviour:

$ git --version
git version 1.6.4.2
$ git diff-files
$ touch test
$ git diff-files
:100644 100644 9daeafb9864cf43055ae93beb0afd6c7d144bfa4 
0000000000000000000000000000000000000000 M  test
$ git diff
$ git diff-files
$

I don't understand why git diff-files reports a file is changed when 
that file is touched nor why running git diff changes this to (what I 
think is) the correct behaviour.

Thanks in advance,

    --James

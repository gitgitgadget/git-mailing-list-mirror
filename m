From: =?ISO-8859-2?Q?V=EDt_Proch=E1zka?= <vitpro@atlas.cz>
Subject: GIT v(+) database versioning question
Date: Sat, 26 Mar 2016 11:50:33 +0100
Message-ID: <56F66979.2050301@atlas.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Mar 26 12:10:25 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ajm6q-0004NA-LH
	for gcvg-git-2@plane.gmane.org; Sat, 26 Mar 2016 12:10:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751363AbcCZLKO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 26 Mar 2016 07:10:14 -0400
Received: from smtp-out4.iol.cz ([194.228.2.92]:33986 "EHLO smtp-out4.iol.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751135AbcCZLKM (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 26 Mar 2016 07:10:12 -0400
X-Greylist: delayed 1175 seconds by postgrey-1.27 at vger.kernel.org; Sat, 26 Mar 2016 07:10:12 EDT
Received: from port8.iol.cz (unknown [192.168.30.98])
	by smtp-out4.iol.cz (Postfix) with ESMTP id 86DBD46419D
	for <git@vger.kernel.org>; Sat, 26 Mar 2016 11:50:33 +0100 (CET)
X-SBRS: None
X-RECVLIST: MTA-OUT-IOL
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: A2CVAQAtafZW/z9LRlUNUcFeiAMBAQEBAQGGDEA9FhgDAgECARs9CAEBiA0Br1KLVQKFbY9qhQoFl2GOBoFQh1mFYo8LghiCMIoIAQEB
X-IPAS-Result: A2CVAQAtafZW/z9LRlUNUcFeiAMBAQEBAQGGDEA9FhgDAgECARs9CAEBiA0Br1KLVQKFbY9qhQoFl2GOBoFQh1mFYo8LghiCMIoIAQEB
X-IronPort-AV: E=Sophos;i="5.24,395,1454972400"; 
   d="scan'208";a="452867849"
Received: from 63.75.broadband3.iol.cz (HELO [10.0.0.35]) ([85.70.75.63])
  by smtp.iol.cz with ESMTP/TLS/DHE-RSA-AES128-SHA; 26 Mar 2016 11:50:33 +0100
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:31.0) Gecko/20100101 Thunderbird/31.3.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/289982>

Hello,

may I ask a question: what would be the best way to achieve this with GIT:

Database versioning scripts shall be (1) numbered (due to DBmaintain)  
and (2) incremental.

ad 1) When a developer commits a script, I should get the next higher 
number
than the last committed script. E.g. 045_customers.SQL, 046_orders.SQL etc

ad 2) Scripts, which are once committed, should be immutable -- developers
should not be able to change them. They can only add new scripts.

Many thanks in advance,
V. Prochazka

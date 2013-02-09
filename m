From: Dasa Paddock <dpaddock@esri.com>
Subject: git-completion.bash --local
Date: Sat, 9 Feb 2013 18:37:28 +0000
Message-ID: <85E0E68E8961D64E9200C534AC5E1B240A443EDC@RED-INF-EXMB-P1.esri.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
To: "git@vger.kernel.org" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Feb 09 19:55:49 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U4FaT-0005OH-Dp
	for gcvg-git-2@plane.gmane.org; Sat, 09 Feb 2013 19:55:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760825Ab3BISzW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 9 Feb 2013 13:55:22 -0500
Received: from esrismtp2.esri.com ([198.102.62.103]:40001 "EHLO esri3.esri.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1760819Ab3BISzV convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 9 Feb 2013 13:55:21 -0500
X-Greylist: delayed 1071 seconds by postgrey-1.27 at vger.kernel.org; Sat, 09 Feb 2013 13:55:21 EST
Received: from RED-INF-EXCS-P3.esri.com (red-inf-excs-p3.esri.com [10.50.4.83])
	by esri3.esri.com (8.11.7p3+Sun/8.11.7) with ESMTP id r19IbTr07356
	for <git@vger.kernel.org>; Sat, 9 Feb 2013 10:37:30 -0800 (PST)
Received: from RED-INF-EXMB-P1.esri.com ([169.254.1.59]) by
 RED-INF-EXCS-P3.esri.com ([::1]) with mapi id 14.02.0328.009; Sat, 9 Feb 2013
 10:37:29 -0800
Thread-Topic: git-completion.bash --local
Thread-Index: AQHOBvSD5EGk2V/ZYkWakVgIXh2aKw==
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.50.254.250]
Content-ID: <E18C9B68DB5C19418B93776B2112289D@esri.local>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/215867>

I think this line should include --local:

https://github.com/git/git/blob/next/contrib/completion/git-completion.bash#L1782
    "--global|--system|--file=*)"

This would help for:
    git config -l --local

Thanks,
Dasa Paddock
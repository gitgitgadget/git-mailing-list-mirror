From: =?UTF-8?B?VG9yc3RlbiBCw7ZnZXJzaGF1c2Vu?= <tboegi@web.de>
Subject: t5539 broken under Mac OS X
Date: Wed, 14 Jan 2015 16:39:05 +0100
Message-ID: <54B68D99.2040906@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Jan 14 16:39:25 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YBQ2T-0003iY-6o
	for gcvg-git-2@plane.gmane.org; Wed, 14 Jan 2015 16:39:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753550AbbANPjQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 Jan 2015 10:39:16 -0500
Received: from mout.web.de ([212.227.17.12]:61724 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752500AbbANPjN (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Jan 2015 10:39:13 -0500
Received: from macce.local ([78.72.72.190]) by smtp.web.de (mrweb103) with
 ESMTPSA (Nemesis) id 0Md4pC-1YSXTo1RvG-00IHag for <git@vger.kernel.org>; Wed,
 14 Jan 2015 16:39:10 +0100
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.6; rv:31.0) Gecko/20100101 Thunderbird/31.3.0
X-Provags-ID: V03:K0:lKmwdI0B905Ejz/BSXFwkfq5hYDXjbOyp+uJtrvwc372mUK+15g
 o26aHq5/UPandp+G9zNDgWyV3/PbMJbmX25WYR0bJ1dgTEaEb3eVdzyGpUr372EtE3O8yMv
 MPovJN0bLZP6dtEvcV7IGxpg2WOoMU9uSs7HuGab39uPiemI/i+sbjSd7UKRrDGSYYTLSYg
 SZ9Vm9dhAXVQSERAV6O7g==
X-UI-Out-Filterresults: notjunk:1;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/262389>

t5539 doesn't seem to work as expected under Mac OX X 10.6
(10.9 is OK)

I am not root.
Are there any ideas how we can improve the situation, or how to debug ?


t>
t> ./t5539-fetch-http-shallow.sh ; echo $?

1..0 # SKIP Cannot run httpd tests as root
0
t>
t> GIT_TEST_HTTPD=t ./t5539-fetch-http-shallow.sh ; echo $?
error: Cannot run httpd tests as root
1
t>

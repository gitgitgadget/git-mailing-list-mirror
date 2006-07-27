From: Robert White <kranki@mac.com>
Subject: testing for cloned repository
Date: Thu, 27 Jul 2006 09:46:20 -0400
Message-ID: <0AC9E5E7-52CC-4715-BB26-622A2177308B@mac.com>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Thu Jul 27 15:46:51 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G66C5-0000z9-Tr
	for gcvg-git@gmane.org; Thu, 27 Jul 2006 15:46:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161077AbWG0Nq0 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 27 Jul 2006 09:46:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161076AbWG0Nq0
	(ORCPT <rfc822;git-outgoing>); Thu, 27 Jul 2006 09:46:26 -0400
Received: from smtpout.mac.com ([17.250.248.171]:227 "EHLO smtpout.mac.com")
	by vger.kernel.org with ESMTP id S1161077AbWG0NqZ (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 27 Jul 2006 09:46:25 -0400
Received: from mac.com (smtpin02-en2 [10.13.10.147])
	by smtpout.mac.com (Xserve/8.12.11/smtpout01/MantshX 4.0) with ESMTP id k6RDkOkY005917
	for <git@vger.kernel.org>; Thu, 27 Jul 2006 06:46:24 -0700 (PDT)
Received: from [192.168.2.31] (c-71-196-35-31.hsd1.fl.comcast.net [71.196.35.31])
	(authenticated bits=0)
	by mac.com (Xserve/smtpin02/MantshX 4.0) with ESMTP id k6RDkMh4018281
	(version=TLSv1/SSLv3 cipher=RC4-SHA bits=128 verify=NO)
	for <git@vger.kernel.org>; Thu, 27 Jul 2006 06:46:24 -0700 (PDT)
To: git@vger.kernel.org
X-Mailer: Apple Mail (2.752.2)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/24287>

I am using:
if [ -f ".git/remotes/origin" ]; then
	# this repository is a clone
fi
in a bash script to test if a repository was cloned and then do  
appropriate pulls and pushes which fit my situation.
Is this the proper way to test this or should I be using something  
different?

Thanks in advance for your help and for providing git.  I have been  
using it on my Linux and MacOSX machines without any problems.

Bob White

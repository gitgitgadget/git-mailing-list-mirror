From: Mark Rada <marada@uwaterloo.ca>
Subject: [PATCHv5 0/6] Gitweb: fill in missing parts of minify support
Date: Thu, 01 Apr 2010 01:35:15 -0400
Message-ID: <4BB43093.20501@mailservices.uwaterloo.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Jakub Narebski <jnareb@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 01 07:36:49 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NxD5E-00030I-M1
	for gcvg-git-2@lo.gmane.org; Thu, 01 Apr 2010 07:36:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753012Ab0DAFgq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 1 Apr 2010 01:36:46 -0400
Received: from mailservices.uwaterloo.ca ([129.97.128.141]:35544 "EHLO
	mailchk-m05.uwaterloo.ca" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1753000Ab0DAFgo (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 1 Apr 2010 01:36:44 -0400
Received: from karakura.local (bas1-toronto01-1177657512.dsl.bell.ca [70.49.160.168])
	(authenticated bits=0)
	by mailchk-m05.uwaterloo.ca (8.13.8/8.13.8) with ESMTP id o315ZFAM006649
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Thu, 1 Apr 2010 01:35:17 -0400
User-Agent: Mozilla/5.0 (Macintosh; U; Intel Mac OS X 10.6; en-US; rv:1.9.1.8) Gecko/20100227 Thunderbird/3.0.3
X-UUID: 93c57ab5-7adc-4fe5-a326-8ed8fe96fb87
X-Miltered: at mailchk-m05 with ID 4BB43094.000 by Joe's j-chkmail (http://j-chkmail.ensmp.fr)!
X-Virus-Scanned: clamav-milter 0.95.2 at mailchk-m05
X-Virus-Status: Clean
X-Greylist: Sender succeeded SMTP AUTH authentication, not delayed by milter-greylist-3.0 (mailchk-m05.uwaterloo.ca [129.97.128.141]); Thu, 01 Apr 2010 01:35:18 -0400 (EDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/143711>

This version of the patch breaks everything apart into a patch
series for more managablity.

It bothers me a bit that the same line will be changed more than
once in the given patch set, but having everything in one patch
doesn't work either. Am I doing something wrong?

Changes in this revision are noted in individual patches.

-- 
Mark Rada (ferrous26)
marada@uwaterloo.ca

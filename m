From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Recursive merge still doesn't handle reorganized repositories
Date: Tue, 03 Jan 2006 17:58:50 -0800
Message-ID: <43BB2BDA.6070404@zytor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Wed Jan 04 02:59:15 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Etxve-0000Nx-3s
	for gcvg-git@gmane.org; Wed, 04 Jan 2006 02:59:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965160AbWADB66 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 3 Jan 2006 20:58:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965161AbWADB66
	(ORCPT <rfc822;git-outgoing>); Tue, 3 Jan 2006 20:58:58 -0500
Received: from terminus.zytor.com ([192.83.249.54]:20171 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S965160AbWADB65
	(ORCPT <rfc822;git@vger.kernel.org>); Tue, 3 Jan 2006 20:58:57 -0500
Received: from [10.4.1.13] (yardgnome.orionmulti.com [209.128.68.65])
	(authenticated bits=0)
	by terminus.zytor.com (8.13.4/8.13.4) with ESMTP id k041wtGw023793
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Tue, 3 Jan 2006 17:58:55 -0800
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
To: Git Mailing List <git@vger.kernel.org>
X-Virus-Scanned: ClamAV version 0.87.1, clamav-milter version 0.87 on localhost
X-Virus-Status: Clean
X-Spam-Status: No, score=-2.6 required=5.0 tests=AWL,BAYES_00 autolearn=ham 
	version=3.0.4
X-Spam-Checker-Version: SpamAssassin 3.0.4 (2005-06-05) on terminus.zytor.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/14170>

Well, I got the chance to try out "git-merge -s recursive" to try to 
deal with the two different reorganized klibc repositories.  I'm sad to 
report that it doesn't really work, and that every merge has to be 
propagated manually.

The two repos are at:

	git://git.kernel.org/pub/scm/libs/klibc/klibc.git
	git://git.kernel.org/pub/scm/libs/klibc/klibc-renamed.git
	
What I want is for a change to the first to propagate naturally to the 
second.

	-hpa

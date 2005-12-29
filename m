From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Cogito: cg-push doesn't push tags?
Date: Thu, 29 Dec 2005 13:59:21 -0800
Message-ID: <43B45C39.8040501@zytor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Thu Dec 29 23:00:06 2005
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Es5o5-0003nC-U1
	for gcvg-git@gmane.org; Thu, 29 Dec 2005 22:59:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751041AbVL2V73 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 29 Dec 2005 16:59:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751042AbVL2V73
	(ORCPT <rfc822;git-outgoing>); Thu, 29 Dec 2005 16:59:29 -0500
Received: from terminus.zytor.com ([192.83.249.54]:10905 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S1751039AbVL2V72
	(ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 Dec 2005 16:59:28 -0500
Received: from [10.4.1.13] (yardgnome.orionmulti.com [209.128.68.65])
	(authenticated bits=0)
	by terminus.zytor.com (8.13.4/8.13.4) with ESMTP id jBTLxQfC001971
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Thu, 29 Dec 2005 13:59:26 -0800
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/14106>

It seems that cg-push in cogito 0.16.2 doesn't push new tags when used 
over git+ssh transport?  Am I completely wet behind the ears, or is that 
a bug?

In particular, it seems to manifest itself when the *only* thing that 
has changed is tags.

	-hpa

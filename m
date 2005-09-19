From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Why does git-core 0.99.7 require python 2.4?
Date: Mon, 19 Sep 2005 12:07:18 -0700
Message-ID: <432F0C66.7060402@zytor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Mon Sep 19 21:07:29 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EHQz9-0001i1-9O
	for gcvg-git@gmane.org; Mon, 19 Sep 2005 21:07:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932588AbVISTHY (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 19 Sep 2005 15:07:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932589AbVISTHY
	(ORCPT <rfc822;git-outgoing>); Mon, 19 Sep 2005 15:07:24 -0400
Received: from terminus.zytor.com ([209.128.68.124]:17618 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S932588AbVISTHY
	(ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 Sep 2005 15:07:24 -0400
Received: from [10.4.1.13] (yardgnome.orionmulti.com [209.128.68.65])
	(authenticated bits=0)
	by terminus.zytor.com (8.13.1/8.13.1) with ESMTP id j8JJ7Nah005909
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Mon, 19 Sep 2005 12:07:23 -0700
User-Agent: Mozilla Thunderbird 1.0.6-1.1.fc4 (X11/20050720)
X-Accept-Language: en-us, en
To: Git Mailing List <git@vger.kernel.org>
X-Virus-Scanned: ClamAV version 0.87, clamav-milter version 0.87 on localhost
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/8896>

I just tried to update the kernel.org hosts to git-core 0.99.7, but I 
got stuck due to the fact that git-core 0.99.7 requires python >= 2.4, 
which isn't in RHEL4 (python-2.3.2) nor in FC3 (python-2.3.4).

Updating Python beyond what the distribution provides is a major operation.

Can it be changed to work with python 2.3, to give a bit of leeway?

	-hpa

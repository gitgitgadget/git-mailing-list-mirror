From: =?UTF-8?B?0JTQuNC70Y/QvSDQn9Cw0LvQsNGD0LfQvtCy?= 
	<dilyan.palauzov@aegee.org>
Subject: git log --graph --color inconsistency
Date: Sat, 22 Mar 2014 14:10:00 +0100
Message-ID: <532D8BA8.1040803@aegee.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Mar 22 14:10:51 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WRLhK-0003Yg-RJ
	for gcvg-git-2@plane.gmane.org; Sat, 22 Mar 2014 14:10:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751094AbaCVNKH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 22 Mar 2014 09:10:07 -0400
Received: from mailout-aegee.scc.kit.edu ([129.13.185.235]:50531 "EHLO
	mailout-aegee.scc.kit.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751016AbaCVNKF (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 22 Mar 2014 09:10:05 -0400
Received: from smtp.aegee.org (aegeepc1.aegee.uni-karlsruhe.de [129.13.131.81])
	by scc-mailout-02.scc.kit.edu with esmtp (Exim 4.72 #1)
	id 1WRLgY-0001Ie-Ei; Sat, 22 Mar 2014 14:10:02 +0100
Authentication-Results: aegeeserv.aegee.org; auth=pass (PLAIN) smtp.auth=didopalauzov
DKIM-Filter: OpenDKIM Filter v2.9.0 smtp.aegee.org s2MDA7MX029173
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aegee.org; s=k4096;
	t=1395493808; i=dkim+MSA-ssl@aegee.org;
	bh=YHzfZGsXGAfkbYalJUu6t2aGfiK522bOEwZSwMTgb7Y=;
	h=Date:From:To:Subject;
	b=I3L7TV5rM6OrcB+kqs4Fjs26QTmGrnFHEAM9hjDYD6xjP050M195T8+EUi0vOqmpa
	 CYTYgF/odFnJoMPsuzysqYfzN9TfT9zHXHnr32BYQY7lsBHedVwIfmHUYhuhc9OIc0
	 Lx5GhQLGy5k2EVvDSqQAZQ9jYQPDr4R9GkTeQMATTW4F8Zf0odqz7aomTpB7AFqDZM
	 cG7+EqO+ScdSi9EcmsIiHLAl/lygrVUe6yrFp0BzeZUPFaASaver6b1elW+891nm2v
	 nMriORNFy+zv4LS7ghawQhQ6SwzX/OWBZWharkQzKRnGijt6wlPjpC5TC4KmBBPShV
	 gwuFeVcVIZ95+y/bSHxeJLqwVpfNswEx8GlgWIJbPOT3i8P4ejY5o49aSk72CqNpUd
	 XSbYrYPFde8EoaWweu038Ufri38/6ICcHPlbzGgl2wuSdHas/HvU4O4J/Q7gxUqHxJ
	 mRfYM0YZW4o24DAsSDVcdtaAK/B/7TMmdukKeimOB+tBscVSF5pcJULrGjSSEJ0+Ml
	 91cMStxhpqkbSMk6a2Oq8cRJUU3CiTpW8ul3AT5VH0wZqqi/HwwFYLeoSSIjAucGD0
	 NiO8ULPCPxKvk4w70UUVpz/+v7aoHoeOx2oPsAvsTOghulL+LrL9hZBHs4s8ZN/cjs
	 v8nsKgZJrNKWl6o9 
Received: from [192.168.0.7] (port-212-202-110-243.static.qsc.de [212.202.110.243])
	(authenticated bits=0)
	by smtp.aegee.org (8.14.8/8.14.5) with ESMTP id s2MDA7MX029173
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NO)
	for <git@vger.kernel.org>; Sat, 22 Mar 2014 13:10:08 GMT
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:24.0) Gecko/20100101 Thunderbird/24.4.0
X-Virus-Scanned: clamav-milter 0.98.1 at aegeeserv
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/244769>

Hello,

I use git version 1.9.1 . With

   git clone git://github.com/pocoproject/poco.git
   cd poco
   git log --graph --color=always

and scrolling a bit, I see 
http://mail.aegee.org/dpa/git-log-graph-color/git-log-graph-color.png . 
  My expectation is, that one branch keeps its color consistent in "log 
--graph", but here it changes from red to green without any obvious reason.

Any ideas?

Greetings
   Dilyan

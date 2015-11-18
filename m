From: Erik Blake <erik@icefield.yk.ca>
Subject: Unhelpful shortcut parameters for git bash
Date: Wed, 18 Nov 2015 17:45:14 +0100
Message-ID: <564CAB1A.20106@icefield.yk.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Nov 18 18:16:55 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zz6Lh-0003fv-9B
	for gcvg-git-2@plane.gmane.org; Wed, 18 Nov 2015 18:16:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754502AbbKRRQn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 Nov 2015 12:16:43 -0500
Received: from bosmailout10.eigbox.net ([66.96.184.10]:50587 "EHLO
	bosmailout10.eigbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751843AbbKRRQm convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 18 Nov 2015 12:16:42 -0500
X-Greylist: delayed 1875 seconds by postgrey-1.27 at vger.kernel.org; Wed, 18 Nov 2015 12:16:42 EST
Received: from bosmailscan07.eigbox.net ([10.20.15.7])
	by bosmailout10.eigbox.net with esmtp (Exim)
	id 1Zz5rK-0007GO-95
	for git@vger.kernel.org; Wed, 18 Nov 2015 11:45:26 -0500
Received: from [10.115.3.32] (helo=bosimpout12)
	by bosmailscan07.eigbox.net with esmtp (Exim)
	id 1Zz5rK-0001Xv-5I
	for git@vger.kernel.org; Wed, 18 Nov 2015 11:45:26 -0500
Received: from bosauthsmtp19.yourhostingaccount.com ([10.20.18.19])
	by bosimpout12 with 
	id j4lM1r00K0QhFXN014lQNk; Wed, 18 Nov 2015 11:45:26 -0500
X-Authority-Analysis: v=2.1 cv=R+2NGLhX c=1 sm=1 tr=0
 a=9UqFsMnAB6EOkiq4MrOclQ==:117 a=xP2CbvXzu5dUCFSWO2QZHA==:17 a=pq4jwCggAAAA:8
 a=QPcu4mC3AAAA:8 a=TtUpKRI4puIA:10 a=IkcTkHD0fZMA:10 a=qtqOOiqGOCEA:10
 a=DecGTpQOfcVzWkJ_SKAA:9 a=QEXdDO2ut3YA:10 a=eLX30sZZgF4A:10
Received: from [82.194.202.50] (port=56943 helo=[192.168.20.164])
	by bosauthsmtp19.eigbox.net with esmtpsa (TLSv1.2:DHE-RSA-AES128-SHA:128)
	(Exim)
	id 1Zz5rF-0006Wu-1v
	for git@vger.kernel.org; Wed, 18 Nov 2015 11:45:21 -0500
X-Enigmail-Draft-Status: N1010
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:38.0) Gecko/20100101
 Thunderbird/38.3.0
X-EN-UserInfo: 20c972d92b49a3da013d5f179c4005f2:931c98230c6409dcc37fa7e93b490c27
X-EN-AuthUser: erik@icefield.yk.ca
X-EN-OrigIP: 82.194.202.50
X-EN-OrigHost: unknown
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/281451>

When creating shortcuts for git bash on Windows machines, the "Target"
contains the command "C:\PF\Git\git-bash.exe --cd-to-home" and the
"Start In" field contains %HOMEDRIVE%%HOMEPATH%.

This is redundant, and makes it harder to modify the shortcut to start
bash in the user's directory of choice.

The option "--cd-to-home" should be removed. If was not present in 1.9.5

From: Phillip Susi <psusi@ubuntu.com>
Subject: stash refuses to pop
Date: Tue, 10 Apr 2012 13:52:16 -0400
Message-ID: <4F847350.3000409@ubuntu.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Apr 10 19:52:24 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SHfEt-0007rS-OQ
	for gcvg-git-2@plane.gmane.org; Tue, 10 Apr 2012 19:52:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753085Ab2DJRwT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Apr 2012 13:52:19 -0400
Received: from cdptpa-omtalb.mail.rr.com ([75.180.132.120]:6296 "EHLO
	cdptpa-omtalb.mail.rr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752259Ab2DJRwS (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Apr 2012 13:52:18 -0400
X-Authority-Analysis: v=2.0 cv=bLSU0YCZ c=1 sm=0 a=/DbS/tiKggfTkRRHPZEB4g==:17 a=Qsx_du5GiBkA:10 a=vnNYxAp2wzwA:10 a=S1A5HrydsesA:10 a=8nJEP1OIZ-IA:10 a=rVWt50Gm2ph8onM1jDUA:9 a=wPNLvfGTeEIA:10 a=/DbS/tiKggfTkRRHPZEB4g==:117
X-Cloudmark-Score: 0
X-Originating-IP: 67.78.168.186
Received: from [67.78.168.186] ([67.78.168.186:55437] helo=[10.1.1.230])
	by cdptpa-oedge03.mail.rr.com (envelope-from <psusi@ubuntu.com>)
	(ecelerity 2.2.3.46 r()) with ESMTP
	id 29/D2-29249-053748F4; Tue, 10 Apr 2012 17:52:16 +0000
User-Agent: Mozilla/5.0 (Windows NT 6.1; rv:11.0) Gecko/20120327 Thunderbird/11.0.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/195110>

git stash refuses to apply a stash if it touches files that are 
modified.  Using stash -p to selectively stash some hunks of a file and 
then immediately trying to pop that stash causes this failure every 
time.  This seems incredibly  broken, and there does not seem to be a 
force switch.  How can you get the stash applied?

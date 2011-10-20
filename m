From: Phillip Susi <psusi@cfl.rr.com>
Subject: Tracking cherry picks
Date: Thu, 20 Oct 2011 10:21:32 -0400
Message-ID: <4EA02E6C.2040608@cfl.rr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Oct 20 16:53:24 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RGtzo-0004zQ-1b
	for gcvg-git-2@lo.gmane.org; Thu, 20 Oct 2011 16:53:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753378Ab1JTOxT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 20 Oct 2011 10:53:19 -0400
Received: from cdptpa-omtalb.mail.rr.com ([75.180.132.123]:44238 "EHLO
	cdptpa-omtalb.mail.rr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752950Ab1JTOxT (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 Oct 2011 10:53:19 -0400
Received: from cdptpa-omtalb.mail.rr.com ([10.127.143.53])
          by cdptpa-qmta01.mail.rr.com with ESMTP
          id <20111020142237524.LTJU22085@cdptpa-qmta01.mail.rr.com>
          for <git@vger.kernel.org>; Thu, 20 Oct 2011 14:22:37 +0000
X-Authority-Analysis: v=1.1 cv=gqMFsD3PqRa+9IMRRYznR/JjFzasGotwKYCDC6iWcAk= c=1 sm=0 a=69kAZAqfIPEA:10 a=8nJEP1OIZ-IA:10 a=/DbS/tiKggfTkRRHPZEB4g==:17 a=Cfl_uY7xT_Gr_kko8WkA:9 a=wPNLvfGTeEIA:10 a=/DbS/tiKggfTkRRHPZEB4g==:117
X-Cloudmark-Score: 0
X-Originating-IP: 67.78.168.186
Received: from [67.78.168.186] ([67.78.168.186:50564] helo=[10.1.1.230])
	by cdptpa-oedge03.mail.rr.com (envelope-from <psusi@cfl.rr.com>)
	(ecelerity 2.2.3.46 r()) with ESMTP
	id 31/EB-02308-C6E20AE4; Thu, 20 Oct 2011 14:21:32 +0000
User-Agent: Mozilla/5.0 (Windows NT 6.1; rv:7.0.1) Gecko/20110929 Thunderbird/7.0.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/184022>

I need to maintain a few stable release branches in addition to the 
master branch.  Sometimes a bug is found and the fix needs applied to 
multiple branches.  I would like to be able to list what branches the 
fix has been applied to to validate that it went in everywhere it was 
needed, but after cherry-picking the fix from master to the stable 
branches, the SHA1 of the commit is different, and so git branch 
--contains does not think the commit was applied to each of the stable 
branches.

Is there a way around this?  Why doesn't git-cherrypick record the 
original SHA1 it was picked from in the commit?

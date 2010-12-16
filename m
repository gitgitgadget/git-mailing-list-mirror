From: Phillip Susi <psusi@cfl.rr.com>
Subject: How to unpack recent objects?
Date: Thu, 16 Dec 2010 15:33:43 -0500
Message-ID: <4D0A77A7.9080702@cfl.rr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Dec 16 21:32:47 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PTKVK-0002xa-TN
	for gcvg-git-2@lo.gmane.org; Thu, 16 Dec 2010 21:32:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756591Ab0LPUcm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 16 Dec 2010 15:32:42 -0500
Received: from cdptpa-omtalb.mail.rr.com ([75.180.132.120]:54911 "EHLO
	cdptpa-omtalb.mail.rr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756467Ab0LPUcl (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 Dec 2010 15:32:41 -0500
Authentication-Results: cdptpa-omtalb.mail.rr.com smtp.user=psusi@cfl.rr.com; auth=pass (PLAIN)
X-Authority-Analysis: v=1.1 cv=uESSSoDEku2quKX/oFXS2Smn5+55LTFcWFr5T5T8nFs= c=1 sm=0 a=bOe1Slac_QYA:10 a=8nJEP1OIZ-IA:10 a=pg4Dpxby4z7sZisWVyJ9NA==:17 a=3v70qjlt-e1xyyJ1YW0A:9 a=2DTXvtCFsFRuloQgSolqQAaj7loA:4 a=wPNLvfGTeEIA:10 a=pg4Dpxby4z7sZisWVyJ9NA==:117
X-Cloudmark-Score: 0
X-Originating-IP: 72.242.190.170
Received: from [72.242.190.170] ([72.242.190.170:4492] helo=[10.1.1.235])
	by cdptpa-oedge01.mail.rr.com (envelope-from <psusi@cfl.rr.com>)
	(ecelerity 2.2.3.46 r()) with ESMTPA
	id 99/80-07087-7677A0D4; Thu, 16 Dec 2010 20:32:39 +0000
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.9.2.12) Gecko/20101027 Thunderbird/3.1.6
X-Enigmail-Version: 1.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/163811>

It looks like you can use git-unpack-objects to unpack ALL objects, but
how can you unpack only recent ones that you are likely to use while
leaving the ancient stuff packed?  Ideally I want to unpack all file
objects from the current commit, and a reasonable number of commit
objects going back into the history so accessing them with checkout,
diff, log, etc will be fast.

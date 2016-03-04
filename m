From: =?UTF-8?B?0JTQuNC70Y/QvSDQn9Cw0LvQsNGD0LfQvtCy?= 
	<dilyan.palauzov@aegee.org>
Subject: git-completion.bash emitting error messages
Date: Fri, 4 Mar 2016 22:21:23 +0100
Message-ID: <56D9FC53.9060706@aegee.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Mar 04 22:27:32 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1abxFz-0005fA-E2
	for gcvg-git-2@plane.gmane.org; Fri, 04 Mar 2016 22:27:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760177AbcCDV11 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 4 Mar 2016 16:27:27 -0500
Received: from mail.aegee.org ([144.76.142.78]:38754 "EHLO mail.aegee.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759879AbcCDV10 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 4 Mar 2016 16:27:26 -0500
X-Greylist: delayed 524 seconds by postgrey-1.27 at vger.kernel.org; Fri, 04 Mar 2016 16:27:26 EST
Authentication-Results: aegeeserv.aegee.org; auth=pass (PLAIN) smtp.auth=didopalauzov
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.aegee.org u24LIrjh027997
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aegee.org; s=k4096;
	t=1457126334; i=dkim+MSA-tls@aegee.org;
	bh=6lV99BLZlURGLr9CXbRJ4HyKAXVkdKwoMjd21Vtkh/s=;
	h=From:Subject:To:Date;
	b=NKvbjA89PYBuPuYe1TMNfqewSLJ/zbglJTfT28dfFwlC1C4PtiTSLjdwmRVj9ZaHs
	 j9pl04ZedV74DP1Q1ZpORY32iThBp2xq+I0LuK0auJ5hiNWZlS1feAgBU6BDoVc+no
	 W78X7msgdF+E+CZNNA3eDzCoU/dRxiKfOzCdZjxydI8YHFHOEtd44dMj06wuGkg578
	 WsQHRk43bFuDKdn5ai0wZ8nxDRRoZHRY2s51oZC7TEO6XzfXqqUKxWGkB/eAXhB05p
	 s7pzlEGkCPusBih5uXqqA0EMW7OrDtE29QG34wbMe1SXyYCJ1iHuRABbhkSP6PJWZB
	 OzxAHhTIzF+EjdchtiDAb8FXB9ACwqQqFyhx9f+MQAAwn5DplNPSItNuPug0/bQTs/
	 /zEXJtULhsuK8TqlJpQ8qPGc0YB7+HmIkwCtYiuaaXrlfxhCjLLxrz2hS5hTX3s4c2
	 ULJGJdRae8Vdi5E/d7LyjDlG0PeGD5vi6md2SNtu+4NrXjrtXI8pARRxTAkYOyKExZ
	 TVlJD2ZSTO8k4PyrOk2bqr9sVFqJoXcZIqgRPf8TM71EQgQCzPCZun+2uCITUDHbLD
	 qB58qh4Cx6kdouHNH99P82DQOnxlwIj0js8TuIV9DLCERt5koLVedakMoS9Yq1DxRU
	 N8N5iuVcoYakX0Vb 
Authentication-Results: mail.aegee.org; dkim=none
Received: from [192.168.1.25] (x55b5d384.dyn.telefonica.de [85.181.211.132])
	(authenticated bits=0)
	by mail.aegee.org (8.15.2/8.15.1) with ESMTPSA id u24LIrjh027997
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NO)
	for <git@vger.kernel.org>; Fri, 4 Mar 2016 22:18:54 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Icedove/38.6.0
X-Virus-Scanned: clamav-milter 0.99.1 at mail.aegee.org
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/288275>

Hello,

I use ./bash 4.3.42 with bundled libreadline and 
git/contrib/completion/git-completion.bash , as modified by commit 
8716bdca268 from 22 Feb 2016.

I cd to git.git (non-bare, with working tree) and type

git b62c.. ori<TAB> to force TAB-completion. And then on the shell comes 
the output  (on the same line) "error: key does not contain variable 
name: alias.b62c.."  Pressing again TAB repeats the message.  Even if 
TAB is pressed once, the printed text cannot be deleted with the 
backspace, so the only way to do something useful is to press ENTER.

While the command is indeed nonsense, in my understanding tab-completion 
shall do nothing, if completion is not possible.  In particular it shall 
not print error messages and even the user types stupid things, he shall 
not be required to force ENTER to come back to a clear state, where a 
command can by types.

Greetings
   Dilian

From: Andreas Ericsson <ae@op5.se>
Subject: Re: MinGW port usable
Date: Tue, 30 Jan 2007 09:41:30 +0100
Message-ID: <45BF04BA.3020606@op5.se>
References: <200701292320.43888.johannes.sixt@telecom.at> <Pine.LNX.4.64.0701291944290.20138@iabervon.org> <45BF0098.8FF978CE@eudaptics.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Johannes Sixt <J.Sixt@eudaptics.com>
X-From: git-owner@vger.kernel.org Tue Jan 30 09:41:39 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HBoYa-0006ch-OW
	for gcvg-git@gmane.org; Tue, 30 Jan 2007 09:41:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965128AbXA3Ild (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 30 Jan 2007 03:41:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752648AbXA3Ild
	(ORCPT <rfc822;git-outgoing>); Tue, 30 Jan 2007 03:41:33 -0500
Received: from linux-server1.op5.se ([193.201.96.2]:57106 "EHLO
	smtp-gw1.op5.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752645AbXA3Ild (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Jan 2007 03:41:33 -0500
Received: from [192.168.1.20] (unknown [213.88.215.14])
	by smtp-gw1.op5.se (Postfix) with ESMTP
	id 366486BCBC; Tue, 30 Jan 2007 09:41:31 +0100 (CET)
User-Agent: Thunderbird 1.5.0.9 (X11/20070102)
In-Reply-To: <45BF0098.8FF978CE@eudaptics.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/38138>

Johannes Sixt wrote:
> Daniel Barkalow wrote:
>> On Mon, 29 Jan 2007, Johannes Sixt wrote:
>>
>>> (*) The reason is that on Windows read() and write() cannot operate on
>>> descriptors created by socket(). A work-around is to implement a (threaded)
>>> proxy, but that's almost the same as if netcat were used as
>>> GIT_PROXY_COMMAND.
>> Can you do
>>
>> #define read(fd, buffer, len) recv(fd, buffer, len, 0)
>> #define write(fd, buffer, len) send(fd, buffer, len, 0)
>>
>> in the appropriate file?
> 
> I doubt that recv and send can operate on regular file descriptors, as
> opened by _pipe(), open(), can they?
> 

Hence "in the appropriate file", I guess.

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231

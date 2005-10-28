From: Andreas Ericsson <ae@op5.se>
Subject: Re: [PATCH gitweb] Visually indicating patch size with horizontal
 bars
Date: Fri, 28 Oct 2005 10:29:09 +0200
Message-ID: <4361E155.2020201@op5.se>
References: <20051027203945.GC1622@pe.Belkin> <7vfyqm1uvx.fsf@assigned-by-dhcp.cox.net> <20051027234813.GA512@pe.Belkin> <Pine.LNX.4.64.0510271709120.4664@g5.osdl.org> <20051028005029.GA2654@pe.Belkin> <43617B47.3070008@zytor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Fri Oct 28 10:30:31 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EVPbv-0005DD-3U
	for gcvg-git@gmane.org; Fri, 28 Oct 2005 10:29:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751618AbVJ1I3M (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 28 Oct 2005 04:29:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751620AbVJ1I3M
	(ORCPT <rfc822;git-outgoing>); Fri, 28 Oct 2005 04:29:12 -0400
Received: from linux-server1.op5.se ([193.201.96.2]:22196 "EHLO
	smtp-gw1.op5.se") by vger.kernel.org with ESMTP id S1751618AbVJ1I3L
	(ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 28 Oct 2005 04:29:11 -0400
Received: from [192.168.1.19] (unknown [213.88.215.14])
	by smtp-gw1.op5.se (Postfix) with ESMTP id D0AB56BD01
	for <git@vger.kernel.org>; Fri, 28 Oct 2005 10:29:09 +0200 (CEST)
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc3 (X11/20050929)
X-Accept-Language: en-us, en
To: git@vger.kernel.org
In-Reply-To: <43617B47.3070008@zytor.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/10761>

H. Peter Anvin wrote:
> Chris Shoemaker wrote:
> 
>>
>> Ok, but that cache would live inside GIT_DIR an be shared with gitk,
>> right?
>>
> 
> That would be bad.  Don't assume that the person running gitweb (or 
> gitk, for that matter) has write permission.
> 

Not necessarily in the archive, but it could support a --cache-dir 
option. If no cache-dir directive is used it could try GIT_DIR/cache and 
go on as usual if that fails too.

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231

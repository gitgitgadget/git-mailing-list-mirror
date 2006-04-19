From: Andreas Ericsson <ae@op5.se>
Subject: Re: [RFC] get_sha1() shorthands for blob/tree objects
Date: Wed, 19 Apr 2006 10:15:44 +0200
Message-ID: <4445F1B0.4060105@op5.se>
References: <Pine.LNX.4.64.0604181627101.3701@g5.osdl.org> <7vy7y2csv8.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.64.0604181735480.3701@g5.osdl.org> <Pine.LNX.4.64.0604181745410.3701@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 19 10:16:04 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FW7qy-0006z0-Gu
	for gcvg-git@gmane.org; Wed, 19 Apr 2006 10:16:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750756AbWDSIPr (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 19 Apr 2006 04:15:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750750AbWDSIPr
	(ORCPT <rfc822;git-outgoing>); Wed, 19 Apr 2006 04:15:47 -0400
Received: from linux-server1.op5.se ([193.201.96.2]:57017 "EHLO
	smtp-gw1.op5.se") by vger.kernel.org with ESMTP id S1750760AbWDSIPq
	(ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Apr 2006 04:15:46 -0400
Received: from [192.168.1.2] (1-2-9-7a.gkp.gbg.bostream.se [82.182.116.44])
	by smtp-gw1.op5.se (Postfix) with ESMTP
	id 19BC76BCC2; Wed, 19 Apr 2006 10:15:45 +0200 (CEST)
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0604181745410.3701@g5.osdl.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/18912>

Linus Torvalds wrote:
> 
> On Tue, 18 Apr 2006, Linus Torvalds wrote:
> 
>>And I thought we already disallowed ':' in branch names because cogito 
>>uses them for the strange <rev>:<rev> syntax.. 
> 
> 
> Btw, pathnames with ':' in them aren't a problem. It's only revision
> names that can't have ':' in them and still be used together with this 
> syntax.
> 
> If you have a pathname with ':', it's fine to do
> 
> 	git cat-file v1.2.4:pathname:with:colon
> 
> because the magic revision parsing only cares about the _first_ colon, and 
> will split that into "v1.2.4" and "pathname:with:colon" without ever even 
> looking at the other ones.
> 

Except that you'll have to explicitly state HEAD:pathname:with:colon, or 
does it try finding a file with the argument verbatim first?

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231

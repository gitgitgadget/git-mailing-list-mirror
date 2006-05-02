From: Andreas Ericsson <ae@op5.se>
Subject: Re: [PATCH] built-in "git grep" (git grip).
Date: Tue, 02 May 2006 10:33:43 +0200
Message-ID: <44571967.7080807@op5.se>
References: <7v1wvetfuj.fsf@assigned-by-dhcp.cox.net> <e34bdf$ho4$1@sea.gmane.org> <7vhd4as00i.fsf@assigned-by-dhcp.cox.net> <e34cb4$is1$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 02 10:33:56 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FaqKM-0008HD-1t
	for gcvg-git@gmane.org; Tue, 02 May 2006 10:33:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932510AbWEBIdr (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 2 May 2006 04:33:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932511AbWEBIdr
	(ORCPT <rfc822;git-outgoing>); Tue, 2 May 2006 04:33:47 -0400
Received: from linux-server1.op5.se ([193.201.96.2]:55245 "EHLO
	smtp-gw1.op5.se") by vger.kernel.org with ESMTP id S932510AbWEBIdq
	(ORCPT <rfc822;git@vger.kernel.org>); Tue, 2 May 2006 04:33:46 -0400
Received: from [192.168.1.20] (host-213.88.215.14.addr.se.sn.net [213.88.215.14])
	by smtp-gw1.op5.se (Postfix) with ESMTP
	id 49A186BCBC; Tue,  2 May 2006 10:33:44 +0200 (CEST)
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
To: Jakub Narebski <jnareb@gmail.com>
In-Reply-To: <e34cb4$is1$1@sea.gmane.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/19408>

Jakub Narebski wrote:
> Junio C Hamano wrote:
> 
> Jakub Narebski <jnareb@gmail.com> writes:
> 
> 
>>Wouldn't "git ggrep" (from git-aware grep) or "git bgrep" (from built-in
>>grep), similar to the egrep and fgrep from the grep package?
> 
> 
> Yes, I understand, but I just don't like using 'grip'. And it would be nice
> to have some convention for further not-ready-yet built-in replacements for
> script versions of commands, for example adding letter 'b' as 'built-in' at
> the beginning of command name: 'bgrep', 'bdiff'. Or use postfix 'n' or
> '-ng' to denote transitionary not-ready-yet new version of command:
> 'grepn', 'diffn' or 'grep-ng', 'diff-ng'.
> 

Forcing the user to remember what's implemented as built-ins is not a 
good idea. It was for that exact reason the "git-<command>-script" were 
all renamed "git-<command>" once upon a time.

"git grip" work just fine for me, since it's only intended for testing 
and performance improvements so far. I also think it's clearer for 
end-users looking for a grep command if they're not faced with 
fgrep/egrep/ggrep/bgrep alongside plain "grep".

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231

From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH 1/2] Use tabs for indent in shell scripts
Date: Tue, 01 Aug 2006 12:01:19 +0200
Organization: At home
Message-ID: <ean8oq$amb$1@sea.gmane.org>
References: <200607292239.11034.jnareb@gmail.com> <ean0a1$irf$1@sea.gmane.org> <7vd5bk3mqo.fsf@assigned-by-dhcp.cox.net> <200608011134.52006.jnareb@gmail.com> <7vr70023aj.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
X-From: git-owner@vger.kernel.org Tue Aug 01 12:02:08 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G7r4Y-0006aY-23
	for gcvg-git@gmane.org; Tue, 01 Aug 2006 12:01:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161038AbWHAKBz (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 1 Aug 2006 06:01:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161077AbWHAKBz
	(ORCPT <rfc822;git-outgoing>); Tue, 1 Aug 2006 06:01:55 -0400
Received: from main.gmane.org ([80.91.229.2]:40339 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1161038AbWHAKBy (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 1 Aug 2006 06:01:54 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1G7r48-0006Sc-4w
	for git@vger.kernel.org; Tue, 01 Aug 2006 12:01:32 +0200
Received: from 193.0.122.19 ([193.0.122.19])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 01 Aug 2006 12:01:32 +0200
Received: from jnareb by 193.0.122.19 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 01 Aug 2006 12:01:32 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: 193.0.122.19
Mail-Copies-To: jnareb@gmail.com
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/24590>

Junio C Hamano wrote:

> Jakub Narebski <jnareb@gmail.com> writes:
> 
>>  if [ -n "$GIT_SSL_NO_VERIFY" ]; then
>> -    curl_extra_args="-k"
>> +    curl_extra_args="-k"
>>  fi
> 
> Things like this makes some sense...
> 
>>              if test -n "$use_separate_remote" &&
>> -               branch_name=`expr "z$name" : 'zheads/\(.*\)'`
>> +                    branch_name=`expr "z$name" : 'zheads/\(.*\)'`
>>              then
> 
> ... but not this, which is not just indent but an alignment.

Sorry, my mistake. Tabs for indent, spaces for align, of course. So discard
this chunk, please.


I'm not sure how to indent sequences like the following:

  command arg \
    arg arg arg \
    arg arg arg

The above I think everybody would agree on.

  command &&
    command &&
    command

  command ||
    command ||
    command

Not so sure about above

[...]
> Also shell scripts tend to become too deeply indented, and 4-column
> indentation helps to keep things within typical screen width.
> 
> In short, not very enthused.

I use tab-width 2 and script didn't get too indented. All changed scripts
except git-clone.sh fit in 80 column window for tab width 2, and the lines
in git-clone.sh which do not fit in 80 columns are not indented at all. 

-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git

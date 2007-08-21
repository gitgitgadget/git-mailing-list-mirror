From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [RFC] Clean way to disable pager
Date: Tue, 21 Aug 2007 04:11:46 +0200
Organization: At home
Message-ID: <fadhkv$amj$2@sea.gmane.org>
References: <vpq1wdz307k.fsf@bauges.imag.fr> <7vodh3bbmx.fsf@gitster.siamese.dyndns.org> <vpq643bz4vx.fsf@bauges.imag.fr> <325563A3-050A-4830-9ACB-9ED15322F038@apple.com> <85ps1jp2w9.fsf@lola.goethe.zz> <vpqzm0mvcz0.fsf@bauges.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Aug 21 04:15:17 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1INJH2-0005l5-65
	for gcvg-git@gmane.org; Tue, 21 Aug 2007 04:15:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752407AbXHUCPN (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 20 Aug 2007 22:15:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752156AbXHUCPN
	(ORCPT <rfc822;git-outgoing>); Mon, 20 Aug 2007 22:15:13 -0400
Received: from main.gmane.org ([80.91.229.2]:44166 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752008AbXHUCPL (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Aug 2007 22:15:11 -0400
Received: from root by ciao.gmane.org with local (Exim 4.43)
	id 1INJGo-0005V7-IG
	for git@vger.kernel.org; Tue, 21 Aug 2007 04:15:02 +0200
Received: from host-89-229-8-65.torun.mm.pl ([89.229.8.65])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 21 Aug 2007 04:15:02 +0200
Received: from jnareb by host-89-229-8-65.torun.mm.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 21 Aug 2007 04:15:02 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-89-229-8-65.torun.mm.pl
Mail-Copies-To: Jakub Narebski <jnareb@gmail.com>
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/56274>

Matthieu Moy wrote:
> David Kastrup <dak@gnu.org> writes:
>> Adam Roben <aroben@apple.com> writes:
>>> On Aug 19, 2007, at 12:44 PM, Matthieu Moy wrote:
>>>
>>>> +    [-p|--paginate] [--no-pager]
>>>
>>>   I think that [-p|--[no-]paginate] would be more consistent with the
>>> way negatable options are normally specified.
>>
>> Disregard previously existing code, I'd vote for using an option set
>> like the following:
>>
>> --pager
>> --pager=less
>> --pager=cat
>> --no-pager
>>
>> "--paginate" is rather artificial in contrast.
> 
> ACK. I thought of naming the option --no-paginate, but I don't think
> that good english. --dont-paginate would be good english, but doesn't
> match the --[no-]whatever scheme.
> 
> Perhaps using David's proposal, and keeping the --paginate as a
> backward compatibility, deprecated switch is the way to go.

I like it too. ACK.

-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git

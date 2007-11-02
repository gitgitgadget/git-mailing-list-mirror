From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH 1/2] War on whitespace: first, a bit of retreat.
Date: Fri, 02 Nov 2007 13:25:32 +0100
Organization: At home
Message-ID: <fgf4qu$e8c$1@ger.gmane.org>
References: <7vwst15ceq.fsf@gitster.siamese.dyndns.org> <ee77f5c20711020314h43290dbs8141cb3905c867@mail.gmail.com> <472AFFE4.9060004@op5.se> <ee77f5c20711020450hdfe064fsace9349fe6494ec9@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Nov 02 13:23:34 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1InvYY-0006hT-Va
	for gcvg-git-2@gmane.org; Fri, 02 Nov 2007 13:23:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753541AbXKBMXI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 2 Nov 2007 08:23:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753579AbXKBMXH
	(ORCPT <rfc822;git-outgoing>); Fri, 2 Nov 2007 08:23:07 -0400
Received: from main.gmane.org ([80.91.229.2]:38718 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753518AbXKBMXG (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 Nov 2007 08:23:06 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1InvYC-0003nl-6O
	for git@vger.kernel.org; Fri, 02 Nov 2007 12:23:00 +0000
Received: from abvq154.neoplus.adsl.tpnet.pl ([83.8.214.154])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 02 Nov 2007 12:23:00 +0000
Received: from jnareb by abvq154.neoplus.adsl.tpnet.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 02 Nov 2007 12:23:00 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: abvq154.neoplus.adsl.tpnet.pl
Mail-Copies-To: Jakub Narebski <jnareb@gmail.com>
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/63109>

David Symonds wrote:
> On 11/2/07, Andreas Ericsson <ae@op5.se> wrote:
>> David Symonds wrote:
>>> On 11/2/07, Junio C Hamano <gitster@pobox.com> wrote:
>>>> This introduces core.whitespace configuration variable that lets
>>>> you specify the definition of "whitespace error".
>>>>
>>>> Currently there are two kinds of whitespace errors defined:
>>>>
>>>>  * trailing-space: trailing whitespaces at the end of the line.
>>>>
>>>>  * space-before-tab: a SP appears immediately before HT in the
>>>>    indent part of the line.
>>>
>>>>         [core]
>>>>                 whitespace = -trailing-space
>>>
>>> Could I suggest naming the option 'whitespaceError', so it's clearer
>>> that it's a negative setting?
>>
>> Which would also open the window for "WhitespaceWarning" and "WhitespaceAutofix"
>> later on, using the same semantics.
> 
> Maybe cut straight to the chase:
> 
> [core]
>         whitespace.trailing = error
>         whitespace.space-before-tab = error
>         whitespace.8-spaces = warn
> 
> There'd be at least "error", "warn"; "okay" and "autofix" would be
> other sensible values. I'm willing to help code this up if this sounds
> good.

Nice idea, but the syntax is

[core "whitespace"]
        trailing = error
        space-before-tab = error
        indent-with-space = warn

-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git

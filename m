From: Gelonida N <gelonida@gmail.com>
Subject: Re: git alias and --help
Date: Fri, 28 Oct 2011 22:23:58 +0200
Message-ID: <j8f30u$ghe$2@dough.gmane.org>
References: <j8clg9$ldh$1@dough.gmane.org>	<7vfwiexe6m.fsf@alter.siamese.dyndns.org>	<7v8vo6xd4u.fsf@alter.siamese.dyndns.org>	<buoty6t9937.fsf@dhlpc061.dev.necel.com> <m362j95jv3.fsf@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-4
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Oct 28 22:25:17 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RJszM-00086G-Ue
	for gcvg-git-2@lo.gmane.org; Fri, 28 Oct 2011 22:25:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933259Ab1J1UZK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 28 Oct 2011 16:25:10 -0400
Received: from lo.gmane.org ([80.91.229.12]:50327 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752993Ab1J1UZJ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 28 Oct 2011 16:25:09 -0400
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1RJszE-00083x-Dv
	for git@vger.kernel.org; Fri, 28 Oct 2011 22:25:08 +0200
Received: from unicorn.dungeon.de ([81.56.82.123])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 28 Oct 2011 22:25:08 +0200
Received: from gelonida by unicorn.dungeon.de with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 28 Oct 2011 22:25:08 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@dough.gmane.org
X-Gmane-NNTP-Posting-Host: unicorn.dungeon.de
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.23) Gecko/20110921 Lightning/1.0b2 ""
In-Reply-To: <m362j95jv3.fsf@localhost.localdomain>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/184430>

On 10/28/2011 03:26 PM, Jakub Narebski wrote:
> Miles Bader <miles@gnu.org> writes:
>> Junio C Hamano <gitster@pobox.com> writes:
> 
>>>>> git branch --help
>>>>
>>>> How about "git help branch"?
>>>
>>> The reason why we do not do what you seem to be suggesting is because
>>> giving the same behaviour to "git b --help" as "git branch --help" is
>>> wrong.
>>
>> I agree with Gelonida's followup:  although what you say makes sense,
>> it's still pretty annoying behavior for the very common case of a
>> simple renaming alias...
>>
>> E.g., I have "co" aliased to "checkout", and so my fingers are very
>> very inclined to say "co" when I mean checkout... including when
>> asking for help.  I actually end up typing "git co --help", grumbling,
>> and retyping with the full command name, quite reguarly.
>>
>> What I've often wished is that git's help system would output
>> something like:
>>
>>    $ git help co
>>    `git co' is aliased to `checkout'
>>
>>    Here's the help entry for `checkout':
>>
>>    GIT-CHECKOUT(1)                   Git Manual                   GIT-CHECKOUT(1)
> 
> Wouldn't it be more useful to say something like this:
> 
>   $ git co --help
>   `git co' is aliased to `checkout'
>  
>   You can see help entry for `checkout' with "git checkout --help"
> 
> Then help is only copy'n'paste away.  
> 
> (This helping text probably should be controlled by some advice.*
> config variable).

This is definitely an option and something which I suggested as one
option myself (however my example had a typo and was perhaps therefore
not understandable)

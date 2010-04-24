From: Goswin von Brederlow <goswin-v-b@web.de>
Subject: Re: Please default to 'commit -a' when no changes were added
Date: Sat, 24 Apr 2010 23:15:19 +0200
Message-ID: <8739yktuvs.fsf@frosties.localdomain>
References: <20100422151037.2310.2429.reportbug@frosties.localdomain>
	<20100422155806.GC4801@progeny.tock>
	<87wrvzs590.fsf@frosties.localdomain>
	<alpine.LFD.2.00.1004221445310.7232@xanadu.home>
	<87sk6n4426.fsf@frosties.localdomain>
	<alpine.LFD.2.00.1004221651590.7232@xanadu.home>
	<87vdbitu9v.fsf@frosties.localdomain>
	<25441792-181D-456D-8182-F33B49209EFF@wincent.com>
	<87aastx6sa.fsf@frosties.localdomain>
	<alpine.LFD.2.00.1004231639180.7232@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Wincent Colaiuta <win@wincent.com>,
	Jonathan Nieder <jrnieder@gmail.com>, 578764@bugs.debian.org,
	git@vger.kernel.org
To: Nicolas Pitre <nico@fluxnic.net>
X-From: git-owner@vger.kernel.org Sat Apr 24 23:15:36 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O5mhJ-0005Av-N6
	for gcvg-git-2@lo.gmane.org; Sat, 24 Apr 2010 23:15:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752293Ab0DXVP2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 24 Apr 2010 17:15:28 -0400
Received: from fmmailgate03.web.de ([217.72.192.234]:33143 "EHLO
	fmmailgate03.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752231Ab0DXVP1 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 24 Apr 2010 17:15:27 -0400
Received: from smtp07.web.de (fmsmtp07.dlan.cinetic.de [172.20.5.215])
	by fmmailgate03.web.de (Postfix) with ESMTP id 5BD2714E3FA19;
	Sat, 24 Apr 2010 23:15:25 +0200 (CEST)
Received: from [78.43.204.177] (helo=frosties.localdomain)
	by smtp07.web.de with asmtp (TLSv1:AES256-SHA:256)
	(WEB.DE 4.110 #4)
	id 1O5mhB-0000Dw-00; Sat, 24 Apr 2010 23:15:25 +0200
Received: from mrvn by frosties.localdomain with local (Exim 4.71)
	(envelope-from <goswin-v-b@web.de>)
	id 1O5mh5-0007vW-T6; Sat, 24 Apr 2010 23:15:20 +0200
In-Reply-To: <alpine.LFD.2.00.1004231639180.7232@xanadu.home> (Nicolas Pitre's
	message of "Fri, 23 Apr 2010 17:01:41 -0400 (EDT)")
User-Agent: Gnus/5.110009 (No Gnus v0.9) XEmacs/21.4.22 (linux, no MULE)
X-Sender: goswin-v-b@web.de
X-Provags-ID: V01U2FsdGVkX1877ElgfbfUd+6Tz9KqGkkwI6YtXa9vZ2dzOMm4
	ChRtSjXv8CyyVfuTsEEdPk7K/CEdEbt1HK+ShcKqJfJDTwJN1C
	JYIeIEcYQ=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/145705>

Nicolas Pitre <nico@fluxnic.net> writes:

> On Fri, 23 Apr 2010, Goswin von Brederlow wrote:
>
>> I personaly have to work with different SCMs every day and every time I
>> have to switch minds to work with each specific one. Making git commit
>> work less surprising would be one less thing to keep in mind.
>
> Please make yourself some git aliases and your problem will be solved.  
> After all, the alias mechanism was created for a reason.

I would accept an alias. But so far two people have suggested an alias
for this and both have completly failed to achived the desired result.

If you know of a test to check if an index exists or not, preferably one
that does consider new files being added or files being removed as
"index exists", then please do speak up.

>> You like that Git is different so don't use the --a-if-empty option. You
>> will have lost nothing by allowing that option in. So far I have read
>> arguments from people saying they don't want to USE the option. But no
>> arguments why there could not be such an option. And I'm not the only
>> one that would welcome such an option. Is there no room for a compromise?
>
> I suggest you have a look at all the examples (some are simple, some are 
> complex) here: https://git.wiki.kernel.org/index.php/Aliases. It should 
> be simple to make an alias with all the safety valves you might think 
> of, and then it could even be contributed to section 7 of that page.

None of the examples have anything to do with checking for an index so
that page is rather useless. I know how to set an alias. I just don't
know what to put into it.

> Nicolas

MfG
        Goswin

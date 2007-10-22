From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [PATCH] Add some fancy colors in the test library when terminal
   supports it.
Date: Mon, 22 Oct 2007 14:18:22 +0200
Message-ID: <471C950E.40702@viscovery.net>
References: <20071022081341.GC32763@artemis.corp> <471C6510.8010300@viscovery.net> <20071022112401.GE32763@artemis.corp> <471C8B02.6080202@viscovery.net> <20071022121106.GA7151@artemis.corp>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org
To: Pierre Habouzit <madcoder@debian.org>
X-From: git-owner@vger.kernel.org Mon Oct 22 14:18:42 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IjwEz-0007dM-My
	for gcvg-git-2@gmane.org; Mon, 22 Oct 2007 14:18:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752231AbXJVMSa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Oct 2007 08:18:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752349AbXJVMSa
	(ORCPT <rfc822;git-outgoing>); Mon, 22 Oct 2007 08:18:30 -0400
Received: from lilzmailso02.liwest.at ([212.33.55.13]:54884 "EHLO
	lilzmailso02.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752289AbXJVMS3 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Oct 2007 08:18:29 -0400
Received: from cm56-163-160.liwest.at ([86.56.163.160] helo=linz.eudaptics.com)
	by lilzmailso02.liwest.at with esmtpa (Exim 4.66)
	(envelope-from <j.sixt@viscovery.net>)
	id 1IjwEV-0007Zn-LH; Mon, 22 Oct 2007 14:18:12 +0200
Received: from [192.168.1.42] (J6T.linz.viscovery [192.168.1.42])
	by linz.eudaptics.com (Postfix) with ESMTP
	id 9F5606B7; Mon, 22 Oct 2007 14:18:22 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.6 (Windows/20070728)
In-Reply-To: <20071022121106.GA7151@artemis.corp>
X-Spam-Score: 1.7 (+)
X-Spam-Report: ALL_TRUSTED=-1.8, BAYES_99=3.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/61996>

Pierre Habouzit schrieb:
> On Mon, Oct 22, 2007 at 11:35:30AM +0000, Johannes Sixt wrote:
>> Pierre Habouzit schrieb:
>>> On Mon, Oct 22, 2007 at 08:53:36AM +0000, Johannes Sixt wrote:
>>>> Pierre Habouzit schrieb:
>>>>> +say_color () {
>>>>> +	[ "$nocolor" = 0 ] &&  [ "$1" != '-1' ] && tput setaf "$1"
>>>>> +	shift
>>>>> +	echo "* $*"
>>>>> +	tput op
        ^^^^^^^^
I am talking about this line.

>>>>> +}
>> I wanted to point out that if tput is not 
>> available, the second invocation will leave "tput: command not found" 
>> behind on stderr. Therefore, I proposed to make the definition of 
>> say_color() different depending on whether $color is set or not. Then you 
>> don't need to test for $color twice inside the function.
> 
>   Right we can do that. I'll try to rework the patch. and no it
> shouldn't leave tput: command not found as I 2>/dev/null and I think the
> shell doesn't print that in that case. At least my zsh doesn't.

There is no 2>/dev/null. Am I missing something?

-- Hannes

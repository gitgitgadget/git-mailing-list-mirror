From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: fsck --full is Ok, but clones are not, "missing commits"?!
Date: Tue, 06 May 2008 13:12:51 +0200
Message-ID: <48203D33.5020900@viscovery.net>
References: <20080416062925.8028e952@zebulon.innova-card.com>	 <a537dd660805050744h7602e553u21c70168a621fe76@mail.gmail.com>	 <481F23D4.2090909@viscovery.net>	 <200805061231.30135.brian.foster@innova-card.com> <a537dd660805060358q6e39947blda348917d5853294@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Bryan Donlan <bdonlan@fushizen.net>
To: Brian Foster <brian.foster@innova-card.com>
X-From: git-owner@vger.kernel.org Tue May 06 13:14:14 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JtL7V-0006jU-Op
	for gcvg-git-2@gmane.org; Tue, 06 May 2008 13:14:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751547AbYEFLM4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 6 May 2008 07:12:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751375AbYEFLM4
	(ORCPT <rfc822;git-outgoing>); Tue, 6 May 2008 07:12:56 -0400
Received: from lilzmailso02.liwest.at ([212.33.55.13]:44164 "EHLO
	lilzmailso02.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751142AbYEFLMz (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 May 2008 07:12:55 -0400
Received: from cm56-163-160.liwest.at ([86.56.163.160] helo=linz.eudaptics.com)
	by lilzmailso02.liwest.at with esmtpa (Exim 4.66)
	(envelope-from <j.sixt@viscovery.net>)
	id 1JtL6J-0003bx-Rg; Tue, 06 May 2008 13:12:52 +0200
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.42])
	by linz.eudaptics.com (Postfix) with ESMTP
	id 9D4886B7; Tue,  6 May 2008 13:12:51 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.6 (Windows/20070728)
In-Reply-To: <a537dd660805060358q6e39947blda348917d5853294@mail.gmail.com>
X-Enigmail-Version: 0.95.5
X-Spam-Score: 2.2 (++)
X-Spam-Report: ALL_TRUSTED=-1.8, BAYES_99=3.5, PLING_QUERY=0.514
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/81350>

Brian Foster schrieb:
> Johannes Sixt wrote:
>> What happens if you fire up gitk as simple as
>>
>>    $ gitk
>>
>> in the history if no grafts are present? Some months ago this took ages to
>> complete, and even today you get a *huge* list of commits in a *short*
>> window; hence, the scrollbar thumb is tiny, and if you succeed to get hold
>> of it without a magnifying glass, it scrolls way more than a page of
>> commits if you move it by only one pixel.
>>
>> No wonder that $user wants to have a shorter history. So $user, being
>> smart, truncates the history at a suitable point with a graft.
> 
> Hannes,
> 
>  Unfortunately, I cannot fire up `gitk' in the exact
>  same configuration anymore (that server machine is now
>  being used for other purposes, albeit I'm supposed to
>  get the hard disc).  The git on the now-vanished server
>  was v1.5.3, but that's probably not relevant, since the
>  repository must have been created with a much older git
>  (it goes back multiple years).
> 
>  All the (now-)installed gits I've seen are 1.5.<something>.
>  I do not see any noticeable performance issue with 1.5.2.5
>  (nor with 1.5.5)?  The scrollbar is, as you say, unusable.

For me, the unusable scrollbar alone would be reason enough to truncate
the history. Once it is truncated, performance is no longer an issue
(whether or not it was an issue in the first place).

>  But how important is `gitk'?  Is it something that'd be
>  used frequently enough for the formerly-poor performance
>  to be such an issue that creating and maintaining such a
>  "truncated" repository is worthwhile?

Well, I have gitk running all the time. So, yes, it is "important." But I
 run it basically as 'gitk --all --not origin' and press F5 frequently.
With this set of arguments the scrollbar remains usable, and performance
is not an issue, even on Windows.

-- Hannes

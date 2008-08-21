From: ir0s <imirene@gmail.com>
Subject: Re: Local branch ahead of tracked remote branch but git push claims
 everything up-to-date
Date: Thu, 21 Aug 2008 09:53:40 -0700 (PDT)
Message-ID: <1219337620037-740662.post@n2.nabble.com>
References: <1219263969579-736663.post@n2.nabble.com> <8585F10E-C33C-481E-B044-A7125F3316F2@web.de> <32541b130808201401l2ad105ccnc37acdacd08d4c3a@mail.gmail.com> <7vbpznpeup.fsf@gitster.siamese.dyndns.org> <32541b130808201422l2b128beer142544ff91de5ca3@mail.gmail.com> <alpine.LNX.1.00.0808201808400.19665@iabervon.org> <7v4p5fnw3i.fsf@gitster.siamese.dyndns.org> <1219332938839-740444.post@n2.nabble.com> <g8k4or$tf$1@ger.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Aug 21 18:54:46 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KWDQr-0004fM-Hn
	for gcvg-git-2@gmane.org; Thu, 21 Aug 2008 18:54:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751697AbYHUQxl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 21 Aug 2008 12:53:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751827AbYHUQxl
	(ORCPT <rfc822;git-outgoing>); Thu, 21 Aug 2008 12:53:41 -0400
Received: from kuber.nabble.com ([216.139.236.158]:33440 "EHLO
	kuber.nabble.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751562AbYHUQxk (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Aug 2008 12:53:40 -0400
Received: from tervel.nabble.com ([192.168.236.150])
	by kuber.nabble.com with esmtp (Exim 4.63)
	(envelope-from <lists+1217463532682-661346@n2.nabble.com>)
	id 1KWDPo-0001u9-4E
	for git@vger.kernel.org; Thu, 21 Aug 2008 09:53:40 -0700
In-Reply-To: <g8k4or$tf$1@ger.gmane.org>
X-Nabble-From: imirene@gmail.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/93175>


Hi Michael,

Here are my results:

$ git ls-remote origin 
138ea08f9680a8def085b793c9cee70eed0e1f3b        HEAD
138ea08f9680a8def085b793c9cee70eed0e1f3b        refs/heads/master
75290a081feebcc4265825d017d9af07c7646951        refs/heads/remotebranch
f11c723119cd9938e91e1ed5328ef143fb477f15        refs/heads/mybranch
f11c723119cd9938e91e1ed5328ef143fb477f15        refs/heads/groups
...
There are a few more

Is it the case that mybranch somehow became a remote branch?

Here are the results for this one:
$ git log --pretty=oneline mybranch...origin/remotebranch
f11c723119cd9938e91e1ed5328ef143fb477f15 Merge branch 'remotebranch' of
gitosis@sorry.must.obfuscate.url.com:my-repo into mybranch
eb41bd8f4f43d483b4a58bc98386c468bb69173c Ticket #1032 
5e76a7c9bce92519b308c031357794904bf0f4a6 Ticket #1038 
cu5ceaf670c83f77c1b48e8d31a23456b744f1af0f Ticket #1044

Thank you!
-Irene


Michael J Gruber wrote:
> 
> ir0s venit, vidit, dixit 21.08.2008 17:35:
>> Sorry if you get this twice, oddly my first attempt to send this bounced.
>> Thank you for all the good advice however, none of it seemed to resolve
>> my
>> issue.
>> 
>> Attempting to call:
>> $git push origin mybranch
>> 
>> Results in the same message: Everything up to date =/
>> I also tried to call $git fetch origin just in case, and doing a pull
>> doesn't return anything (which makes sense, no one pushed anything to the
>> branch -- although I seem to be the only one with this issue.)
>> 
>> Could my branch have somehow diverged from the origin remotebranch?
>> 
>> -- Irene
> 
> What do the following report:
> 
> git ls-remote origin
> git ls-remote .
> git log --pretty=oneline mybranch...origin/remotebranch
> 
> Michael
> 
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 

-- 
View this message in context: http://n2.nabble.com/Local-branch-ahead-of-tracked-remote-branch-but-git-push-claims-everything-up-to-date-tp736663p740662.html
Sent from the git mailing list archive at Nabble.com.

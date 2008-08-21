From: ir0s <imirene@gmail.com>
Subject: Re: Local branch ahead of tracked remote branch but git push claims
 everything up-to-date
Date: Thu, 21 Aug 2008 09:55:39 -0700 (PDT)
Message-ID: <1219337739561-740670.post@n2.nabble.com>
References: <1219263969579-736663.post@n2.nabble.com> <8585F10E-C33C-481E-B044-A7125F3316F2@web.de> <32541b130808201401l2ad105ccnc37acdacd08d4c3a@mail.gmail.com> <7vbpznpeup.fsf@gitster.siamese.dyndns.org> <32541b130808201422l2b128beer142544ff91de5ca3@mail.gmail.com> <alpine.LNX.1.00.0808201808400.19665@iabervon.org> <7v4p5fnw3i.fsf@gitster.siamese.dyndns.org> <1219332938839-740444.post@n2.nabble.com> <g8k4or$tf$1@ger.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Aug 21 18:57:02 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KWDSk-0005S7-TD
	for gcvg-git-2@gmane.org; Thu, 21 Aug 2008 18:56:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754326AbYHUQzl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 21 Aug 2008 12:55:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753198AbYHUQzk
	(ORCPT <rfc822;git-outgoing>); Thu, 21 Aug 2008 12:55:40 -0400
Received: from kuber.nabble.com ([216.139.236.158]:33467 "EHLO
	kuber.nabble.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754046AbYHUQzj (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Aug 2008 12:55:39 -0400
Received: from tervel.nabble.com ([192.168.236.150])
	by kuber.nabble.com with esmtp (Exim 4.63)
	(envelope-from <lists+1217463532682-661346@n2.nabble.com>)
	id 1KWDRj-0001yj-IL
	for git@vger.kernel.org; Thu, 21 Aug 2008 09:55:39 -0700
In-Reply-To: <g8k4or$tf$1@ger.gmane.org>
X-Nabble-From: imirene@gmail.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/93176>


Sorry, and one more:
$ git ls-remote .
f11c723119cd9938e91e1ed5328ef143fb477f15         HEAD
138ea08f9680a8def085b793c9cee70eed0e1f3b        refs/heads/master
75290a081feebcc4265825d017d9af07c7646951        refs/heads/remotebranch
f11c723119cd9938e91e1ed5328ef143fb477f15         refs/heads/mybranch
138ea08f9680a8def085b793c9cee70eed0e1f3b        refs/remotes/origin/HEAD
138ea08f9680a8def085b793c9cee70eed0e1f3b        refs/remotes/origin/master
75290a081feebcc4265825d017d9af07c7646951       
refs/remotes/origin/remotebranch
f11c723119cd9938e91e1ed5328ef143fb477f15        
refs/remotes/origin/mybranch

Thank you!!
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
View this message in context: http://n2.nabble.com/Local-branch-ahead-of-tracked-remote-branch-but-git-push-claims-everything-up-to-date-tp736663p740670.html
Sent from the git mailing list archive at Nabble.com.

From: Sam Vilain <sam.vilain@catalyst.net.nz>
Subject: Re: [PATCH] Amend git-push refspec documentation
Date: Tue, 22 Apr 2008 20:27:13 +1200
Organization: Catalyst IT (NZ) Ltd
Message-ID: <480DA161.3070107@catalyst.net.nz>
References: <1208748684-28253-1-git-send-email-sam.vilain@catalyst.net.nz> <7vk5iq5tj2.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Apr 22 10:48:20 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JoEAj-00086n-Vu
	for gcvg-git-2@gmane.org; Tue, 22 Apr 2008 10:48:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757059AbYDVIrc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Apr 2008 04:47:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756977AbYDVIrc
	(ORCPT <rfc822;git-outgoing>); Tue, 22 Apr 2008 04:47:32 -0400
Received: from godel.catalyst.net.nz ([202.78.240.40]:44503 "EHLO
	mail1.catalyst.net.nz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754798AbYDVIrb (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Apr 2008 04:47:31 -0400
X-Greylist: delayed 1206 seconds by postgrey-1.27 at vger.kernel.org; Tue, 22 Apr 2008 04:47:31 EDT
Received: from [2404:130:0:1000:240:c7ff:fe97:5623]
	by mail1.catalyst.net.nz with esmtpsa (TLS-1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.63)
	(envelope-from <sam.vilain@catalyst.net.nz>)
	id 1JoDqM-00018T-CR; Tue, 22 Apr 2008 20:27:14 +1200
User-Agent: Icedove 1.5.0.12 (X11/20070606)
In-Reply-To: <7vk5iq5tj2.fsf@gitster.siamese.dyndns.org>
X-Enigmail-Version: 0.94.2.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/80081>

Junio C Hamano wrote:
>> -The <src> side can be an
>> -arbitrary "SHA1 expression" that can be used as an
>> -argument to `git-cat-file -t`.  E.g. `master~4` (push
>> -four parents before the current master head).
>> +The <src> side represents the source branch (or arbitrary
>> +"SHA1 expression"; see linkgit:git-rev-parse[1]) that you want to
>> +push.  The <dst> side represents the destination location.
>>  +
> 
> Hmm.  We lost an example but refer to a more authoritative information,
> which is probably Ok.

Well, the example I think was quite confusing to people who have never
seen `master~4` before.

>> @@ -179,9 +180,10 @@ git push origin master:satellite/master::
>>  
>>  git push origin master:refs/heads/experimental::
>>  	Create the branch `experimental` in the `origin` repository
>> -	by copying the current `master` branch.  This form is usually
>> -	needed to create a new branch in the remote repository as
>> -	there is no `experimental` branch to match.
>> +	by copying the current `master` branch.  This form is only
>> +	needed to create a new branch in the remote repository when
>> +	the local name and the remote name are different; otherwise,
>> +	the branch name on its own will work.
> 
> Note that writing "refs/tags/xprm" instead would allow you to create a
> lightweight tag over there.

True.  You could probably replace 'branch' with 'ref' in the two places
it occurs in the last sentence to encompass that meaning, too.

Cheers,
Sam.

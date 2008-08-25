From: "Paolo Ciarrocchi" <paolo.ciarrocchi@gmail.com>
Subject: Re: [PATCH] Add a reference to gitk localbranc remote/branch in gittutorial
Date: Mon, 25 Aug 2008 22:42:44 +0030
Message-ID: <4d8e3fd30808251512x126502bj5f154b58d7ae51a2@mail.gmail.com>
References: <20080825215023.11822a20@paolo-desktop>
	 <loom.20080825T200956-169@post.gmane.org>
	 <7v63pog3rn.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Eric Raible" <raible@gmail.com>, git@vger.kernel.org
To: "Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Aug 26 00:13:56 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KXkJt-0004bj-Kb
	for gcvg-git-2@gmane.org; Tue, 26 Aug 2008 00:13:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753342AbYHYWMs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 Aug 2008 18:12:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753705AbYHYWMs
	(ORCPT <rfc822;git-outgoing>); Mon, 25 Aug 2008 18:12:48 -0400
Received: from qb-out-0506.google.com ([72.14.204.224]:46140 "EHLO
	qb-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751679AbYHYWMr (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Aug 2008 18:12:47 -0400
Received: by qb-out-0506.google.com with SMTP id a16so2865549qbd.17
        for <git@vger.kernel.org>; Mon, 25 Aug 2008 15:12:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=Qq9kMUq8F2r/rN7hDDIFIX4hUlO8l4+1hhN5GSvy5GM=;
        b=xNgEBbcfoziuqOzOn7cyE0oCHOVTcVQBb8YFTnXUb0Bl9XAkHxsxL7UInaG1aEC8LE
         qq4a0NJK0YXUdMTUWvNCLrzQGFC9Ns8htpRLVff6a2ErQ1W4Qu/I9/MdfXjaF7fp0B6P
         AoSJNnmNC3NnctW+cHFsHqXlgfYgDzuyO8U0A=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=DJtDMV/AAY5uimu5gYPs+qkVHqqI0IBIF8C6Sq+MCVJISU961kEpFhu2DbPM4fTSkB
         1FoemEh2wkmy1YGWXP/ExW6Ad3TWelMSDGKK17kBhohm2qQxB5v38dW7wYuCzv5EGoCt
         dWjcEgex15oQ41GW1qbjwbOc2paVaimwCCEz8=
Received: by 10.114.177.1 with SMTP id z1mr4040541wae.37.1219702364509;
        Mon, 25 Aug 2008 15:12:44 -0700 (PDT)
Received: by 10.114.135.2 with HTTP; Mon, 25 Aug 2008 15:12:44 -0700 (PDT)
In-Reply-To: <7v63pog3rn.fsf@gitster.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/93690>

On 8/25/08, Junio C Hamano <gitster@pobox.com> wrote:
> Eric Raible <raible@gmail.com> writes:
>
>> Paolo Ciarrocchi <paolo.ciarrocchi <at> gmail.com> writes:
>>
>>> +Alice can also use gitk to browse that Bob did:
>>
>> s/that/what/ ?
>>
>>> +------------------------------------------------
>>> +alice$ gitk master origin/master
>>> +------------------------------------------------
>>
>> I think that you meant:
>>
>> alice$ gitk master..origin/master
>
>
> I'd suggest rewording the explanation to have Alice "compare what both of
> them did", not just "browse what Bob did".

yes, what i wrote was unclear. I managed to confuse myself too :-)

> And for that purpose, I think the original form used by Paolo's patch is
> the most appropriate here in an early part of the tutorial, as it teaches
> how to view full histories leading to the tips of these two branches.

well, it might be a good idea to mention both.

do you think we should add a note about git log --graph as well?

> Earlier in the tutorial sequence we teach "gitk" without any parameter to
> view the history of the current branch, and here the user learns one new
> thing, to view more than just the current branch.

i think we should use the nice gitk output in other sections of the
document as well, i'll send some more patches.

> Limiting the output with "..origin/master" (or "...origin/master") can be
> taught after demonstrating this most basic form.


what wording would you use to clearly explain the difference between
..origin/master and ...origin/master ?

anyway, thanks for the commentr. I'll send a new patch in 24 hours.

ciao,
-- 
Paolo
http://paolo.ciarrocchi.googlepages.com/

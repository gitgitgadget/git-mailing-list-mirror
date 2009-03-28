From: Lachlan Deck <lachlan.deck@gmail.com>
Subject: Re: git svn clone failure
Date: Sun, 29 Mar 2009 04:29:24 +1100
Message-ID: <FD1B54BB-EB43-4F53-B737-6CB8096BC512@gmail.com>
References: <A5DCF978-5D10-4A6C-BE4B-1024FA475E2F@gmail.com> <200903281359.34412.markus.heidelberg@web.de> <F76E6356-60EB-4FDE-B97E-CB34FF2D7017@gmail.com> <200903281620.29564.markus.heidelberg@web.de>
Mime-Version: 1.0 (Apple Message framework v930.3)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: markus.heidelberg@web.de
X-From: git-owner@vger.kernel.org Sat Mar 28 18:32:33 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LncN8-00082r-Dl
	for gcvg-git-2@gmane.org; Sat, 28 Mar 2009 18:31:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753445AbZC1R3e (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 28 Mar 2009 13:29:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753291AbZC1R3e
	(ORCPT <rfc822;git-outgoing>); Sat, 28 Mar 2009 13:29:34 -0400
Received: from ti-out-0910.google.com ([209.85.142.186]:31455 "EHLO
	ti-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753209AbZC1R3d (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 28 Mar 2009 13:29:33 -0400
Received: by ti-out-0910.google.com with SMTP id i7so1168625tid.23
        for <git@vger.kernel.org>; Sat, 28 Mar 2009 10:29:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:cc:message-id:from:to
         :in-reply-to:content-type:content-transfer-encoding:mime-version
         :subject:date:references:x-mailer;
        bh=BfWIhc4wqfPGs6BGl93DaDzboBdn+LULbp2H6BSBrjI=;
        b=Mhyj/l3eZGow7rN8yLmq6MR885oSNSi/lHc8wJ1NOpYruPkjbLBJjicE+K5YER9LM8
         VznIv8RJm8mqlDMFHc9e17ZozPdHE8GK+Aq8RIV9zL4xeko2my4zNIVXQuVlecY044eb
         ERtkrs15EKRc+T0t05tJaSw2QVNoWwtA9c7iQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=cc:message-id:from:to:in-reply-to:content-type
         :content-transfer-encoding:mime-version:subject:date:references
         :x-mailer;
        b=DZGaUcRN/pj3JfEmQpCTQzfInnxN4MKbTWnzqEL9Tj68SIluzCGUfJ3+IL+gPDsNZj
         AY3ldYvTgjGaJiSPE+sib6LPqijhnA0Kdkt4Mf33KOHvk36TJVmlWKdAD61jGZtdDacZ
         kyAp7J9/dAr+k1T0MCrUwoZYHFvWln6Bq3mV0=
Received: by 10.110.43.16 with SMTP id q16mr5034100tiq.34.1238261370749;
        Sat, 28 Mar 2009 10:29:30 -0700 (PDT)
Received: from ?10.0.1.200? (208.198.233.220.exetel.com.au [220.233.198.208])
        by mx.google.com with ESMTPS id d1sm5973024tid.34.2009.03.28.10.29.28
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 28 Mar 2009 10:29:29 -0700 (PDT)
In-Reply-To: <200903281620.29564.markus.heidelberg@web.de>
X-Mailer: Apple Mail (2.930.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/114970>

On 29/03/2009, at 2:20 AM, Markus Heidelberg wrote:

> Lachlan Deck, 28.03.2009:
>> On 28/03/2009, at 11:59 PM, Markus Heidelberg wrote:
>>
>>> Lachlan Deck, 27.03.2009:
>>>> Hi there,
>>>>
>>>> I'm trying to clone an existing svn repository with git (just  
>>>> getting
>>>> started with git) and it keeps failing with:
>>>> ...
>>>> r604 = 6428e63734a21ee5fcb4593274747e2758578a91 (git-svn)
>>>> fatal: unable to run 'git-svn'
>>>
>>> Are you sure r604 isn't the latest svn revision?
>>
>> A few thousand out, yes.
>>
>>> I always get this error when doing "git svn fetch" with an http URL,
>>> it
>>> doesn't occur with an svn URL. But everything seems to work fine,
>>> though.
>>
>> Interesting. Yes, it's from an https url. I'll try svn+ssh://..
>> But are you saying there's no way to get more info about the error?
>
> At least I don't have more info about it except for this:
> I use Gentoo Linux and the git ebuild (I have the distribution package
> installed, but use the self-compiled git) says
>
>    "Per Gentoo bugs #223747, #238586, when subversion is built"
>    "with USE=dso, there may be weird crashes in git-svn. You"
>    "have been warned."
>
> I have subversion compiled with dso (Enable runtime module search),  
> it's
> enabled per default. And since it worked, I didn't change it. But it
> would be interesting to see, if this error has something to do with  
> it.
> Maybe I'll try it out.

It may well have been a network issue for me when I tried the other  
day. It seemed to work fine now.

with regards,
--

Lachlan Deck

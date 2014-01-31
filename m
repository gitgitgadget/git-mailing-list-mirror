From: David Lang <david@lang.hm>
Subject: Re: A few contributor's questions
Date: Fri, 31 Jan 2014 15:58:54 -0800 (PST)
Message-ID: <alpine.DEB.2.02.1401311556410.2733@nftneq.ynat.uz>
References: <8738k44808.fsf@fencepost.gnu.org> <20140131161924.GA4332@google.com> <87mwic2ijo.fsf@fencepost.gnu.org> <20140131184842.GA30398@google.com> <87iosz3lpz.fsf@fencepost.gnu.org>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="680960-329727675-1391212734=:2733"
Cc: Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org
To: David Kastrup <dak@gnu.org>
X-From: git-owner@vger.kernel.org Sat Feb 01 01:12:42 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W9OCP-0004rM-Ff
	for gcvg-git-2@plane.gmane.org; Sat, 01 Feb 2014 01:12:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754220AbaBAAMM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 31 Jan 2014 19:12:12 -0500
Received: from mail.lang.hm ([64.81.33.126]:46726 "EHLO bifrost.lang.hm"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753235AbaBAAMM (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 31 Jan 2014 19:12:12 -0500
X-Greylist: delayed 787 seconds by postgrey-1.27 at vger.kernel.org; Fri, 31 Jan 2014 19:12:12 EST
Received: from asgard.lang.hm (asgard.lang.hm [10.0.0.100])
	by bifrost.lang.hm (8.13.4/8.13.4/Debian-3) with ESMTP id s0VNwsN9016895;
	Fri, 31 Jan 2014 15:58:54 -0800
X-X-Sender: dlang@asgard.lang.hm
In-Reply-To: <87iosz3lpz.fsf@fencepost.gnu.org>
User-Agent: Alpine 2.02 (DEB 1266 2009-07-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/241325>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--680960-329727675-1391212734=:2733
Content-Type: TEXT/PLAIN; charset=iso-8859-1; format=flowed
Content-Transfer-Encoding: 8BIT

when relicensing, people use git blame, not header copyright notices to track 
down the authors.

if you are bothered by the copyright notice at the top, modify it as part of 
your patchset, it's very unlikely that anyone will care enough to object.

But copyright assignment has very strict requirements, it can't just be implicit 
or in e-mail, it requires a signed document, so unless you sign a document 
stating that you are transferring copyright, you don't have to worry about that.

David Lang


  On Fri, 31 Jan 2014, David Kastrup wrote:

> Date: Fri, 31 Jan 2014 22:06:16 +0100
> From: David Kastrup <dak@gnu.org>
> To: Jonathan Nieder <jrnieder@gmail.com>
> Cc: git@vger.kernel.org
> Subject: Re: A few contributor's questions
> 
> Jonathan Nieder <jrnieder@gmail.com> writes:
>
>> I assume the problem you're trying to solve is that files don't have
>> clear enough notices of their licensing.
>
> No, just the file that I'm contributing to.  It has a single copyright
> attribution that arguably is already less than accurate _unless_ the
> respective authors can be considered to have been acting with the intent
> of letting Junio do whatever he wants to do with their contribution.
>
>> That could be a real problem for people using the code, since if you
>> no one gave you a license then you don't have a license at all.
>
> In that case, it is reasonably to revert to the general license.
>
>> It's also a problem in that it makes it harder to interpret the phrase
>> "under the same open source license" (though I have no idea how that
>> could be read as "I give up my copyright completely").
>
> If the existing notice is "(c) Junio Hamano" that means that Junio is
> fully able to license at his will.  And in the case of his work on Git,
> this includes his expressive permission to relicense under the
> conditions of libgit2, including a no-modification binary-only licensing
> option.
>
> So my problem is not as much that people might get the idea they might
> not use/copy my work at all (which would be silly), but rather that they
> have reasonable expectation to use it under the licensing scheme of
> libgit2 without getting back to me.
>
>>  * the code is copyright by the authors and we try not to waste fuss
>>    on maintaining a comprehensive list in notices.
>
> That's fine, but we are talking not about a list but a single named
> copyright holder.  I was proposing adding "and others" to clarify that
> the list is not exhaustive.
>
>>  * relicensing, when needed, happens by contacting all the copyright
>>    holders and getting their consent
>>
>> I don't see anything weird about that.
>
> Neither do I.
>
>> But people using the code might like clearer notices, so I personally
>> would not mind an extra line in most files stating the license.
>
> I was more concerned about amending the copyright attribution, though a
> single line pointing out GPLv2 and referring the reader to the general
> COPYING file does not seem excessive, either.
>
>>> It's verbose and cumbersome enough that I would not have been
>>> surprised if there'd be an established way of getting this
>>> information on record, preferably per-project rather than per-commit.
>>
>> For relicensing the existing practice is to just contact people.
>
> Well, that stops working once they are dead.  And it's probably rather
> tricky to locate their heirs even in case they have placed instructions
> concerning their copyrights into their last will.  While I am not in a
> rush here, I am still likely to turn decomposing into a fulltime
> occupation earlier than most other contributors: I started working with
> computers at a time when the single most imminent danger to long-term
> data archival were mice.
>
>> That has the advantage that I can make a decision about whether to
>> allow relicensing code I've written in the context of how I expect it
>> to be used.  I expect that if you had a stance on GPLv2+ licensing of
>> contributions to git published in some place easily found by search
>> engines (for example a message on the mailing list), interested people
>> would not have too much trouble finding it when the time comes.
>
> Maybe, maybe not.  There is a big hole in the indexing of the Google
> News history that was taken over from what once was Dejanews.  Putting
> the information regarding prospective licensing close to the actual
> source seems like a smart move.
>
> At any rate, if there is no stock procedure for that, that's it.
>
>
--680960-329727675-1391212734=:2733--

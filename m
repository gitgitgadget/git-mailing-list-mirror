From: Michael Witten <mfwitten@gmail.com>
Subject: Re: [doc] User Manual Suggestion
Date: Fri, 24 Apr 2009 18:26:06 -0500
Message-ID: <b4087cc50904241626h166c6b3bqa4ec714d4cb5662a@mail.gmail.com>
References: <m24owgqy0j.fsf@boostpro.com>
	 <200904240051.46233.johan@herland.net>
	 <b4087cc50904231730i1e8a005cpaf1921e23df11da6@mail.gmail.com>
	 <200904242230.13239.johan@herland.net>
	 <alpine.LNX.2.00.0904241655090.2147@iabervon.org>
	 <20090424213848.GA14493@coredump.intra.peff.net>
	 <b4087cc50904241518w625a9890vecdd36bb937e76d5@mail.gmail.com>
	 <b4087cc50904241525w7de597bfq7be89796947a14cc@mail.gmail.com>
	 <alpine.LNX.2.00.0904241852500.2147@iabervon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Jeff King <peff@peff.net>, Johan Herland <johan@herland.net>,
	git@vger.kernel.org, David Abrahams <dave@boostpro.com>,
	"J. Bruce Fields" <bfields@fieldses.org>
To: Daniel Barkalow <barkalow@iabervon.org>
X-From: git-owner@vger.kernel.org Sat Apr 25 01:28:02 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LxUoH-0001Mn-QS
	for gcvg-git-2@gmane.org; Sat, 25 Apr 2009 01:27:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753342AbZDXX0M (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 24 Apr 2009 19:26:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752515AbZDXX0K
	(ORCPT <rfc822;git-outgoing>); Fri, 24 Apr 2009 19:26:10 -0400
Received: from qw-out-2122.google.com ([74.125.92.24]:50752 "EHLO
	qw-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751825AbZDXX0I (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 Apr 2009 19:26:08 -0400
Received: by qw-out-2122.google.com with SMTP id 5so1146084qwd.37
        for <git@vger.kernel.org>; Fri, 24 Apr 2009 16:26:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=MmBxoLDX8qYDz7e8NdVuts3LRo1WR51kBMv5zBVqhwQ=;
        b=k04yM3Ud9uSsOT1liXnBPpxQM5bMoUVxGs7tuhOY7nhQ5/90KG1lCKOlBlgz3v/XM1
         177qB8VJfYrcDvWTFKXIY8/nOvGi5OgJOcrGqbCCC3bFFccSHyBvp+dGP8+17avtVcnn
         b/Cr5E+vs7ozFNGxasBAnLcGAK0PIu9PF3Ddo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=KuaPhvcuq7+HbdeUUyz92toQ1/eZ/Vg0uyyJSO//F2ZizwLB10iHoKqoFCQxFi19c+
         ok1BmLYVJ0Li63r9wB1o5qw0RKksaUbtxOIcgvzUY91KzngGD5sA+kDi51H9vxqYCDDV
         uu8mdJ0wbtm5VPcGcHmOFWtGLmfwpdFXumi+w=
Received: by 10.224.2.146 with SMTP id 18mr3593972qaj.297.1240615566579; Fri, 
	24 Apr 2009 16:26:06 -0700 (PDT)
In-Reply-To: <alpine.LNX.2.00.0904241852500.2147@iabervon.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/117519>

On Fri, Apr 24, 2009 at 18:11, Daniel Barkalow <barkalow@iabervon.org> wrote:
> On Fri, 24 Apr 2009, Michael Witten wrote:
>
>> On Fri, Apr 24, 2009 at 17:18, Michael Witten <mfwitten@gmail.com> wrote:
>> > In fact, I think masking this kind of thing with a catch-all word
>> > 'reference' is a bad idea. Rather than being hidden, it should be
>> > exposed: I think it would be beneficial to use the word 'address'
>> > rather than 'reference' when talking about the SHA-1 names. Then HEAD
>> > could be called a pointer variable, etc.
>> >
>> > So, a pointer variable's value is an object address that is the
>> > location of an object in git 'memory'. I think using this approach
>> > would make things significantly more transparent.
>>
>> In fact, it's not particularly important that SHA-1 is used to compute
>> the address into git memory. The only thing that's important is that
>> the address is determined by content alone (I'm not even sure that
>> specifying that the address is a cryptographically sound hash of the
>> content is important; shouldn't that follow from the declaration that
>> it must be uniquely based on content alone?); the fact that's a SHA-1
>> is purely an implementation detail, and so it shouldn't appear
>> prominently in the documentation.
>>
>> So, what do you say?
>>
>> Let's start a reformation of the git terminology to use analogies that
>> have been around since the dawn of computing: 'memory', 'address', and
>> 'pointer'.
>
> I actually think calling them "sha1s" is better, simply because this bit
> of jargon doesn't mean anything else (git deals with email, so "address"
> is overloaded).

I don't know if I buy that reason; the human brain is pretty good with context.

I would at least like 'location' better.

> And the term is already in use for this particular case,
> and it doesn't mean anything else at all (since, of course, the crypto
> thing is "SHA-1", not "sha1"), and it's short (which is important for
> making it easy to look at usage help).

What happens when SHA-1 is shown to be broken or there is a better
alternative? Then we'll see "sha1 for historical reasons"... bleh!

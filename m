From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: What's cooking in git.git (Nov 2010, #02; Wed, 17)
Date: Wed, 24 Nov 2010 22:26:45 +0100
Message-ID: <201011242226.47184.jnareb@gmail.com>
References: <7v1v6je9g8.fsf@alter.siamese.dyndns.org> <201011200142.26522.jnareb@gmail.com> <4CEC6E2A.9080605@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: "J.H." <warthog9@kernel.org>
X-From: git-owner@vger.kernel.org Wed Nov 24 22:27:11 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PLMrs-0004NS-Bo
	for gcvg-git-2@lo.gmane.org; Wed, 24 Nov 2010 22:27:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752698Ab0KXV1B (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 24 Nov 2010 16:27:01 -0500
Received: from mail-fx0-f46.google.com ([209.85.161.46]:58801 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751353Ab0KXV1A (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Nov 2010 16:27:00 -0500
Received: by fxm13 with SMTP id 13so180354fxm.19
        for <git@vger.kernel.org>; Wed, 24 Nov 2010 13:26:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=NnJSHcGh0lRAI4gP+Jik3s387j9m9smja/gw2kOXSww=;
        b=NibHCt1GnT1MMlP4QdHuMqcl3YcSmUufT10uKuRbwrT+k/I88Q2Wf2yiSvVXlZwZPM
         PKeujLzmjl9WOOmEa6zglGcBGfaS0UaDKuNtQFf5JbQ+iN/AoObo2VqdQLr1u0c761dQ
         Hcfh+W4x/OZ8BuqLMeMmqpjgxsm7M9bh/rs3o=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=q8TnPObnHAxFAFpEiBPQbd7nvigUd2rBELSEkxyYB+iGtx2tEUrxGupWFN1D0VS9Ak
         Zdr0+fxLMFuCAE4yCuqqJJLuLCQfk3Q56aaNC4GXBXpZEwMO2ZUxTTkXHzMi6waxNwY2
         adRqJ76WpFfsoJlT1rDNjX2RF933j54DRR4K0=
Received: by 10.223.81.79 with SMTP id w15mr2215553fak.72.1290634016706;
        Wed, 24 Nov 2010 13:26:56 -0800 (PST)
Received: from [192.168.1.13] (abwq109.neoplus.adsl.tpnet.pl [83.8.240.109])
        by mx.google.com with ESMTPS id r24sm2377444fax.3.2010.11.24.13.26.53
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 24 Nov 2010 13:26:54 -0800 (PST)
User-Agent: KMail/1.9.3
In-Reply-To: <4CEC6E2A.9080605@kernel.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/162087>

On Wed, 24 Nov 2010, J.H. wrote:

Note: "rewrite" is what I have in 'gitweb/cache-kernel-pu', "fixup" is
what I have in 'gitweb/gitweb-ml-v7'.

  http://repo.or.cz/w/git/jnareb-git.git
  https://github.com/jnareb/git

>>>>> * jh/gitweb-caching (2010-11-01) 4 commits
>>>>>  . gitweb: Minimal testing of gitweb caching
>>>>>  . gitweb: File based caching layer (from git.kernel.org)
>>>>>  . gitweb: add output buffering and associated functions
>>>>>  . gitweb: Prepare for splitting gitweb
>>>>>
>>>>> Temporarily ejected while I shuffled jn/gitweb-testing; will queue the
>>>>> latest back in pu or perhaps in next.
>>>>
>>>> The advantage of 'gitweb: File based caching layer (from git.kernel.org)'
>>>> is that it is tested in real-life on heavy load (assuming that 
>>>> git.kernel.org uses the same version as is/would be in pu/next).
>>>>
>>>> The disadvantage is that it is seriously messy code.  Something that I
>>>> wanted to improve in my rewrite.  This is only minimal fixup.
>>>
>>> Which is exactly what we want at this point (I want to release 1.7.4 by
>>> the end-of-year holidays, which means a feature-freeze will have to start
>>> soon).  My understanding is that the serious messiness does not come from
>>> the caching layer.
>> 
>> Well... the capturing, caching and actual gitweb operations are quite
>> intermixed in J.H. patch.
> 
> I'm not sure how they can be any less intermixed.  The biggest problem
> is getting the code launched into the caching engine, which gitweb in
> general has no good means of dealing with.  Now that said, since I
> switched how I'm capturing the output the diff into the main gitweb code
> is quite small, and easily bypassed.

It is not only matter of having cache-specific bits in gitweb.perl,
but also about using gitweb-specific bits in cache.pl: anything that
prevents turning cache.pl into proper Perl module (GitwebCache.pm aka
GitwebCache, or GitwebCache::CacheOutput, or similar), and using
alternate caching engine (e.g. memcached-based).

Eliminating cache-specific bits are what would makes it possible
to switch to other caching engine.  Eliminating gitweb-specific bits
is what would make unit-testing possible (like in my rewrite).

In the case of cache-specific bits in gitweb.perl itself, there are
four issues where caching code needs to be added:
 * configuration (turning caching on, configuring cache engine)
 * dispatch (run action, or get output from cache)
 * special cases and limitations (varying mimetype, non-cacheable actions,
   error handling)
 * notification (how old page is, or when it was generated)

> The only place there the code gets really intermixed at all is in the
> special case of binary files, and that's just because the entirety of
> that code in gitweb.perl assumes it can dump the data straight to the
> client, which I point out has a whole slew of disadvantages, not the
> least of which is the client has no idea how big the file should be and
> is accepting bits blindly until the stream closes.

The special case is not *binary* files: if you do it right then you have
to apply layers (':utf8' vs ':raw') only when capturing output; what you
have captured is bytes, and you can dump data from cache in ':raw'/binary
mode.  The transformation was already done.

The problem is *large* files; they are binary, but it is not binary-ness
that is the problem.  The problem is that output of 'blob_plain' and
especially of 'snapshot' action can be large file, and that is why you
want to avoid capturing output to memory.  That's a good idea, but it
makes implementing caching in gitweb more difficult.

But in case of cache.pl, where capturing and caching are intermixed the
binary-ness parts of gitweb.perl diff are not really necessary: just
capture directly to cache entry file, and apply PerlIO layers appropriately.


BTW. in the case of 'blob_plain' output we could use 'git cat-file --batch'
to get its contents length together with actual data dumped to client,
though it would make code a bit more complicated.  Unfortunately the real
problem is with 'snapshot', and we cannot get content length upfront here,
especially in the case when we use external compressor (e.g. 'tar.gz'/'tgz'
format).

>> I wanted to separate those issues, and have
>> them modularized in my rewrite[1], making it easy to use other caching engine
>> (tested with Cache::FileCache from Cache::Cache).  On the other hand 
>> intermixing allows capturing directly to cache file (although it is only
>> since v7), something that would be more difficult in my rewrite.
> 
> While I don't disagree, being able to support other caching systems
> would be nice, we have this now, it's tested and it works.  I'd argue
> this is a step 1, step 2 case at this point.

Well, to be able to support other caching engines and perhaps other
capturing engines in the future we need to plan caching infrastructure
so that it is possible.  I'd like very much to separate turning caching
on from selecting caching engine: something that you tried to implement
with $cache_enable being multi-valued (0, 1, possible other values),
and what I implemented in my rewrite with boolean $caching_enabled and
$cache + $capture variables.

In my minimal fixup in v7.1 and v7.2 I changed $cache_enable to 
$caching_enabled to make (possible) transition to my rewrite easier,
but now I think that I should have introduced at least $cache 
configuration variable too.


BTW. what do you think about putting variables configuring cache
(except $caching_enabled and $cache) to %cache_options hash?

> 
> I'd also point out that while caching the output has been exceedingly
> useful, and has proven to be fast, I can definitely see benefits to
> caching individual data pieces, however to do that the output and data
> accessing bits in gitweb really need to be re-written, and we should
> honestly move to some sort of templating engine.  That said, that's not
> part of this patch series anyway.

Well, there is always Gitalist[1], written using Catalyst MVC framework,
based initially on old (pre-incorporation) gitweb code ;-)

[1] http://www.gitalist.com/
    https://github.com/broquaint/Gitalist

>> The Perl code of J.H. patch does not follow style of other parts of gitweb,
>> doesn't follow best practices (like e.g. using lexical filehandles instead
>> of globs), does include some code repetitions... all of which made me
>> attempt rewrite rather than fix it.
> 
> Concerning the lexical filehandles vs. globs, I can not find any
> documentation anywhere as to why you would prefer one over the other.

Some documentation about "Modern Perl" practices:
* http://www.onyxneon.com/books/modern_perl/index.html (free PDF download) 
* http://perl-begin.org/tutorials/bad-elements/#open-function-style
* http://perlcritic.com/
  (Perl::Critic::Policy::InputOutput::ProhibitBarewordFileHandles)

The problem with globs (e.g. using open(cacheFile, '<', "$fullhashpath");
it has additional stylistic problem that it doesn't use ALLCAPS name to
make it easier to see that you use globs) is that they are *global* 
variables, and therefore the usual problems with actions at distance.
In the case of cache.pl, which is not meant as generic caching module
(at least in current form in v7+), and therefore should not conflict
with anything, it is more of maintenance burden.

Using lexical filehandles has the additional advantage that if filehandle
falls out of scope, the file would be closed automaticaly.

> Considering that the handles were being use globally the lexical way
> made sense (and was the way I wrote it 4 years ago).  I've already done
> the quick search and replace to move them over to globs.

I guess s/to globs/to lexicals/

> 
> Speaking to code repetitions the only thing that I really had repeated
> was the check for if the action involved a binary file, I've added a
> function that checks for that now.  Beyond that, I'm not really seeing
> anything.

Wouldn't it be better instead of separating _check_ (I guess misnamed
is_binary() ;-)), to refactor the act of dumping possibly large file
directly to browser into separate subroutine, named e.g. dump_file, or
print_file, or dump_fd?  It has the additional advantage that it would
make it possibly to improve it in the future e.g. to use code like in
File::Slurp::spew.

I see some code repetition in cache.pl / cache.pm

>> BTW. I didn't get any responses to "[RFC] Implementing gitweb output caching
>> - issues to solve".
> 
> Because you sent that while I was in Boston at Kernel Summit and LPC.
> It got lost in my inbox, and I've only gotten far enough in the last day
> or so to start digging back into the gitweb stuff.  I'm not sure how,
> but you have perfect timing in every time you send out stuff I'm in the
> middle of a big messy trip.  Clearly I should just travel less ;-)

Sorry about that.

> I should have fixes / cleanups and further commentary soon.  I've also
> got some changes that are a combination of requests from the gittogether
> and from irc that I'll be adding in.

Thanks a lot.
 
> I'm currently working from on top of Jakub's last tree, though I've got
> some questions about his reasoning on a few things now that I've been
> digging into it.

You mean 'gitweb/gitweb-ml-v7', aka "[RFC/PATCHv7.2 0/4] Gitweb caching v7.2"
http://thread.gmane.org/gmane.comp.version-control.git/160147/focus=161368

Looking forward to your questions.


BTW. should I send comment about style, or should cleanup be left to
be done in-tree, to have caching in gitweb in next git version?

-- 
Jakub Narebski
Poland

From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH 00/18] Gitweb caching v8
Date: Thu, 09 Dec 2010 15:26:59 -0800 (PST)
Message-ID: <m3bp4u34vj.fsf@localhost.localdomain>
References: <1291931844-28454-1-git-send-email-warthog9@eaglescrag.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jakub Narebski <jnareb@gmail.com>
To: "John 'Warthog9' Hawley" <warthog9@eaglescrag.net>
X-From: git-owner@vger.kernel.org Fri Dec 10 00:27:12 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PQptH-0001Tc-M0
	for gcvg-git-2@lo.gmane.org; Fri, 10 Dec 2010 00:27:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755783Ab0LIX1F (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 9 Dec 2010 18:27:05 -0500
Received: from mail-fx0-f43.google.com ([209.85.161.43]:44264 "EHLO
	mail-fx0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753153Ab0LIX1E (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 Dec 2010 18:27:04 -0500
Received: by fxm18 with SMTP id 18so3088805fxm.2
        for <git@vger.kernel.org>; Thu, 09 Dec 2010 15:27:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received
         :x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        bh=o+Xpnzdx20jff4kS8ruhM7sx9gJNxVOGVPx5MSzb8hY=;
        b=efQwZinZT+lh1ibY4kewyd7q4rEqx1VzT+kMGw1akeli/E34ajDTaAWC8kZObfznGu
         5ke3gd6gXp9qiqkX03zhTHLZKeQnaiAhCHysgfFQYQRFoZCPC2j/jNq3mXScdMfLBW8x
         mRUlN3TmMjwn2sfjZr8b6PAQd2qlk6NlqRjTQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        b=iYCx72w+1XEGvE85oS9dR6QGIURRjhcGZ8mnBklNWJuC+coph0u1UFxvebZlUN7Ex7
         qEjWPQLOvWP0Dh6wpjTfz8c/8mO2KDQsbU8CndbfiQerQvu5PrfAGtT5+OEKmphNoWzg
         0a+zrtav1am2KcPXF3UFNoiWLXUjRIVueRZyk=
Received: by 10.223.83.138 with SMTP id f10mr34737fal.114.1291937220579;
        Thu, 09 Dec 2010 15:27:00 -0800 (PST)
Received: from localhost.localdomain (abvv86.neoplus.adsl.tpnet.pl [83.8.219.86])
        by mx.google.com with ESMTPS id n2sm732286fam.4.2010.12.09.15.26.58
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 09 Dec 2010 15:26:59 -0800 (PST)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id oB9NQKp6019593;
	Fri, 10 Dec 2010 00:26:32 +0100
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id oB9NQ88S019589;
	Fri, 10 Dec 2010 00:26:08 +0100
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <1291931844-28454-1-git-send-email-warthog9@eaglescrag.net>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/163356>

John, could you please in the future Cc me?  I am interested in gitweb
output caching development.  Thanks in advance.

"John 'Warthog9' Hawley" <warthog9@eaglescrag.net> writes:

> Afternoon everyone,
> 
> (Afternoon is like morning, right?)
>  
> This is the latest incarnation of gitweb w/ caching.  Per the general
> consensus and requests from the recent GitTogether I'm re-submitting 
> my patches.
> 
> Bunch of re-works in the code, and several requested features.  Sadly the
> patch series has balloned as I've been adding things.  It was 3-4 patches,
> it's now 18.  This is based on top of Jakub's v7.2 patch series, but
> it should be more or less clean now.

Could you please rebase it on top of v7.2 version?  The v7.2 patch
series contained a few bugs that needs to be corrected.

> 
> As such there was a bunch of changes that I needed to do to Jakub's tree
> which are indicated in the series.  Why did I do them up as separate things?
> Mainly there's a bunch of history that's getting lost right now between
> going back and forth, and I wanted to have clear patches to discuss
> should further discussion be needed.

I guess that in the final submission (i.e. the one that is to be
merged in into git.git repository) those changes would be squashed in,
isn't it?

> 
> This still differs, by two patches, from whats in production on kernel.org.
> It's missing the index page git:// link, and kernel.org and kernel.org also
> has the forced version matching.  As a note I'll probably let this stew
> another day or so on kernel.org and then I'll push it into the Fedora update
> stream, as there's a couple of things in this patch series that would be 
> good for them to have.

There was some discussion about git:// link in the past; nevertheless
this issue is independent on gitweb caching and can (and should) be
sent as a aeparate patch.

IIRC we agreed that because of backward compatibility forced versions
match is quite useless (in general)...

> 
> There is one additional script I've written that the Fedora folks are using,
> and that might be useful to include, which is an 'offline' cache file generator.
> It basically wraps gitweb.cgi and at the end moves the cache file into the right
> place.  The Fedora folks were finding it took hours to generate their front
> page, and that doing a background generation almost never completed (due to 
> process death).  This was a simple way to handle that.  If people would like
> I can add it in as an additional patch.

Are you detaching the background process?

It would be nice to have it as separate patch.

> 
> v8:
> 	- Reverting several changes from Jakub's change set that make no sense
>                 - is_cacheable changed to always return true - nothing special about
>                   blame or blame_incremental as far as the caching engine is concerned

'blame_incremental' is just another version of 'blame' view.  I have
disabled it when caching is enabled in my rewrite (you instead disabled
caching for 'blame_incremental' in your v7 and mine v7.x) because I
couldn't get it to work together with caching.  Did you check that it
works?

Besides, withou "tee"-ing, i.e. printing output as it is captured,
cached 'blame_data' means that 'blame_incremental' is not incremental,
and therefore it vanishes its advantage over 'blame'.

In the case data is in cache, then 'blame_inremental' doesn't have
advantage over 'blame' either.

>                 - Reverted config file change "caching_enabled" back to "cache_enable" as this
>                   config file option is already in the wild in production code, as are all
>                   current gitweb-caching configuration variables.

[Explitive deleted.]  I dislike strongly this $cache_enable.  I think it
would be better for backward compatibility (should we keep backward
compatibility with out-of-tree patches?) to use the same mechanism as
provided in 

  [PATCHv6/RFC 22/24] gitweb: Support legacy options used by kernel.org caching engine
  http://thread.gmane.org/gmane.comp.version-control.git/163052/focus=163058
  http://repo.or.cz/w/git/jnareb-git.git/commitdiff/27ec67ad90ecd56ac3d05f6a9ea49b6faabf7d0a

in my rewrite.  Just set $caching_enabled to true if $cache_enable is
defined and true.

>                 - Reverted change to reset_output as
>                         open STDOUT, ">&", \*STDOUT_REAL;
>                   causes assertion failures:
>                   Assertion !((((s->var)->sv_flags & (0x00004000|0x00008000)) == 0x00008000) && (((svtype)((s->var)->sv_flags & 0xff)) == SVt_PVGV || ((svtype)((s->var)->sv_flags & 0xff)) == SVt_PVLV)) failed: file "scalar.xs", line 49 at gitweb.cgi line 1221.
>                   if we encounter an error *BEFORE* we've ever changed the output.

Which Perl version are you using?  Because I think you found error in Perl.
Well, at least I have not happen on this bug.

I have nothing againts using

  open STDOUT, ">&STDOUT_REAL";

though I really prefer that you used lexical filehandles, instead of
"globs" which are global variables.

The following works:

  open STDOUT, '>&', fileno($fh);

Note that fileno(Symbol::qualify_to_ref($fh)) might be needed...

>         - Cleanups there were indirectly mentioned by Jakub
>                 - Elimination of anything even remotely looking like duplicate code
>                         - Creation of isBinaryAction() and isFeedAction()

Could you please do not use mixedCase names?


First, that is what %actions_info from

  [PATCH 16/24] gitweb: Introduce %actions_info, gathering information about actions
  http://thread.gmane.org/gmane.comp.version-control.git/163052/focus=163038
  http://repo.or.cz/w/git/jnareb-git.git/commitdiff/305a10339b33d56b4a50708d71e8f42453c8cb1f

I have invented for.

Second, why 'isBinaryAction()'?  there isn't something inherently
different between binary (':raw') and text (':utf8') output, as I have
repeatedly said before.  See my rewrite: there is no special case for
binary output (or perhaps binary output as in the case of 'blob_plain'
action).

>         - Adding in blacklist of "dumb" clients for purposes of downloading content
>         - Added more explicit disablement of "Generating..." page

Good, I'll check this.

>         - Added better error handling
>                 - Creation of .err file in the cache directory
>                 - Trap STDERR output into $output_err as this was spewing data prior
>                   to any header information being sent

Why it is needed?  We capture output of "die" via CGI::Util::set_message,
and "warn" output is captured to web server logs... unless you explicitely
use "print STDERR <sth>" -- don't do that instead.

>         - Added hidden field in footer for url & hash of url, which is extremely useful
>           for debugging

Nice idea, I'll see it.  Can it be disabled (information leakage)?

-- 
Jakub Narebski
Poland
ShadeHawk on #git

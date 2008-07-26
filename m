From: "Scott Chacon" <schacon@gmail.com>
Subject: Re: Official Git Homepage change? Re: git-scm.com
Date: Sat, 26 Jul 2008 00:07:03 -0700
Message-ID: <d411cc4a0807260007i26791084lce6b6a8d74b831cc@mail.gmail.com>
References: <d411cc4a0807251035i7aed2ec9wef7e8f1b3ae4c585@mail.gmail.com>
	 <20080726015314.GU32184@machine.or.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Petr Baudis" <pasky@suse.cz>
X-From: git-owner@vger.kernel.org Sat Jul 26 09:08:09 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KMdsr-0007OF-Pz
	for gcvg-git-2@gmane.org; Sat, 26 Jul 2008 09:08:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752087AbYGZHHG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 26 Jul 2008 03:07:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752086AbYGZHHF
	(ORCPT <rfc822;git-outgoing>); Sat, 26 Jul 2008 03:07:05 -0400
Received: from rv-out-0506.google.com ([209.85.198.237]:34466 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752001AbYGZHHE (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 26 Jul 2008 03:07:04 -0400
Received: by rv-out-0506.google.com with SMTP id k40so3748259rvb.1
        for <git@vger.kernel.org>; Sat, 26 Jul 2008 00:07:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=M0mROziqgOuV8uWb6bxWqycb0QPktwDeAA3q+EAkDXE=;
        b=pFTQHnkXYM6wgkxh9OB0HSVleoX8VI4enV4iLpNp3upQ/iGS+cS9DgK/u3gNYyQWna
         y1U1nZB/OmnD7f+JCwweRJyranS980ntGhThGwyYwTp/taq+gbu4wXksBgu+uMdFT+mg
         qhjMwTQkJDZDBAQLmEPpSV8zocqOhK0Z5Bkyw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=I0yEjibI5GsqtXToDthtiZ1CYsOMymA/jB/4+E9n3Z+Y+voRtwEop/N/gu7vbbDM4j
         Cl+XIkMK06Qerq4MKVrVWBdBN0UraHPAYmzt5jPiJQCrW94eaK739jssHDUg5lg4mK4e
         nTFKYfumQdko+rF1p1NS0luWv2QeoDgnZLOHM=
Received: by 10.114.155.1 with SMTP id c1mr2960544wae.24.1217056023218;
        Sat, 26 Jul 2008 00:07:03 -0700 (PDT)
Received: by 10.115.22.20 with HTTP; Sat, 26 Jul 2008 00:07:03 -0700 (PDT)
In-Reply-To: <20080726015314.GU32184@machine.or.cz>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/90188>

On Fri, Jul 25, 2008 at 6:53 PM, Petr Baudis <pasky@suse.cz> wrote:
>  Hi,
>
> On Fri, Jul 25, 2008 at 10:35:43AM -0700, Scott Chacon wrote:
>> Anyhow, I'm discussing with Petr about where we want to go from here -
>> what changes he'd like to make, etc, but I obviously value your
>> opinion as well, so please let me know what you think.  The content
>> has barely changed, it's really just a usability overhaul.  I want to
>> make sure that whatever someone is looking for (especially someone
>> new), they can find in a few clicks and a few seconds.
>
>  when the initial NIH reaction passes, I have to admit that I do rather
> like it - and it's not only because you keep mentioning how awesome I am
> in your blog post. ;-)
>
>  I wonder if all the Git users find the heading rather funny as I did,
> instead of unprofessional - but maybe we don't care about users without
> a particular sense of humor. I'm also not overly fond of the color theme
> but I'm perhaps just too heavy of a blue fan.
>
>  Plenty of minor fixes are available for pull at
>
>        git://github.com/pasky/learn-github.git
>        (http://github.com/pasky/learn-github/tree/master)

I've pulled in all this stuff and it should be live now.

>
>  Other non-trivial nits:
>
>  * I'm feeling a bit uneasy about listing so many projects using Git;
> I haven't heard about quite a few of these and I'm not sure on what
> merit should we list projects. "Prototype" or "Liftweb" and probably
> even "Rubinius", is that going to ring a bell for major part of visitors
> so that they say "oh, even _those_ guys are using Git"?

Based on a conversation in the other thread, I think we should have a
list that is suggested by the community and just have the 3 or 4 that
are really famous (Git, Linux, RoR...) and have the rest randomly
pulled from that list - changed every day or so.


>  * Cut the contributors list at 4 or 5 commits? Below that, the list
> is getting fairly useless anyway and you have trouble with keeping the
> names reasonably well-formed.

Done and pushed.

>  * Reusing captions from command manpages in the Documentation page
> shows nicely how awful they sometimes are. :-) This is probably something
> to fix upstream, though.

I saw you changed some of these, I can take another pass.  I'm not
entirely sure how useful it is to have the commands on that page, to
tell the truth.  This may go away as the documentation page evolves.

>  * Is "Git for the lazy" really unique in some regard to deserve to be
> listed among the other resources? I think we should minimalize
> redundancy at the documentation page, the amount of material is already
> overwhelming and it should be obvious for the visitor which document to
> choose based on his needs. I have similar doubts about the 37signals
> resources.
>
>        In other words, "let's keep the resources orthogonal!"

I agree - I would like to pull a lot of the information in those links
into one open-source book that is kept up by the community and hosted
at this page.  The documentation page will change significantly as we
try to simplify and maximize the usefulness of the page.

>  * There is no reference to the Wiki in the documentation, only to the
> [GitDocumentation] page; I think there should be a reference to the
> [GitFaq] page too - a lot of important points that are not obvious
> to newcomers are covered there. I'm just not sure where exactly to put
> the link.
>
>  * I would go as far as put the link to the Wiki itself to the
> navigation bar, simply since it is such a crucial resource.


Perhaps I should just do this - would that cover the previous one as well?


>  * A guide on maintaining third-party patches is currently missing.
>
>  * The development page is not referenced anywhere; the missing
> information are mailing list details (how to subscribe) and a link to
> SubmittingPatches. Also, I have recently talked with Junio about adding
> a link to the Note from the Maintainer, but we didn't yet figure out
> where to stabilize the location of that page.

I would be happy to put the note somewhere, and I will work on getting
the other few pages from the original site put up and linked
somewhere.

>  How does that compare with the Git user manual? Have you considered
> collaborating on that one, or what are your reasons not to? Or are you
> trying to do something different?

I would like to - I have personally found that invaluable in learning
Git, but I would like it to be more digestible and I would like to add
a lot of supporting media to it - screencasts and diagrams, to help
people that are more visual learners. Loading up a document where the
TOC is several pages long is intimidating and difficult to start and
stop with.

Scott

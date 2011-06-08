From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Command-line interface thoughts (ad-hominem attacks)
Date: Wed, 8 Jun 2011 13:12:45 +0200
Message-ID: <201106081312.46377.jnareb@gmail.com>
References: <BANLkTikTWx7A64vN+hVZgL7cuiZ16Eobgg@mail.gmail.com> <7vd3ir9btd.fsf@alter.siamese.dyndns.org> <4DEDC124.3060302@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Scott Chacon <schacon@gmail.com>,
	Michael Nahas <mike@nahas.com>, git@vger.kernel.org
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Wed Jun 08 13:13:00 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QUGh1-0007yi-Np
	for gcvg-git-2@lo.gmane.org; Wed, 08 Jun 2011 13:13:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752055Ab1FHLMz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 8 Jun 2011 07:12:55 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:45774 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751153Ab1FHLMy (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 Jun 2011 07:12:54 -0400
Received: by bwz15 with SMTP id 15so316921bwz.19
        for <git@vger.kernel.org>; Wed, 08 Jun 2011 04:12:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:subject:date:user-agent:cc:references
         :in-reply-to:mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        bh=Mq/3+hRrxQMsoyLCyMnuFt1V/b9lJ6W5OgP5XHsm410=;
        b=ABjWIwJKmvvK1btWQpkWvGxTV9wBGDL3QrUAQsbbyhffN7NJZXcmBh4Nu/UsvqKXy7
         cXLCQTSJ4zwj5JMenaM7XOSUqrwtzqKIjqT3r16TCpwvWuM69UsDi3azDoFLFPOpF2Ia
         L1iamwlXkmTd3nNPk1a1vQB3X5WtBWJYgmB3Y=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=wOJUoVxMZydGsb5ZGIM7vuwcGkx3ZK1S4kwU8XCB+p1rD8oVouIJDTamN4cLMKf5Fe
         IHkQYK/7RTK5n52hyUN9jraEkSgDJHs5xMipHZ/UVR3MWv66flCnc6LK2ibDTTyQxxOV
         y/tB2xkHfKdrvdT7aapWf3x0FQJ0saD6laBa8=
Received: by 10.204.136.71 with SMTP id q7mr374315bkt.182.1307531569746;
        Wed, 08 Jun 2011 04:12:49 -0700 (PDT)
Received: from [192.168.1.15] (abvu41.neoplus.adsl.tpnet.pl [83.8.218.41])
        by mx.google.com with ESMTPS id g2sm446696bkz.23.2011.06.08.04.12.47
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 08 Jun 2011 04:12:48 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <4DEDC124.3060302@drmicha.warpmail.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/175354>

On Tue, 7 June 2011, Michael J Gruber wrote:
> Junio C Hamano venit, vidit, dixit 06.06.2011 18:14:
 
> > just repeating a fuzzy and uncooked "idea" around phoney
> > ref-looking names that will end up confusing the users, and selling that
> > as if it is a logical conclusion to "we want to give an easier to
> > understand UI", without presenting a solid user experience design that is
> > convincing enough that the "idea" will reduce confusion will not get us
> > anywhere, especially when it is sprinkled with ad hominem attack at me.
> 
> I've re-read all my posts in this thread and have no idea what you're
> referring to here.

I think one can see __ad hominem__ attack in *implication* that the idea
got shot down because of Junio (and Linus) _personal_ resistance to
fresh ideas.  And that is Junio stubborness than stand in the way of
new ideas.  Certainly somebody more sensitive might read it as such.

> If I were more sensitive I could spot attacks at 
> myself in the above, though. Just count your usage of terms like
> "phoney", "fuzzy" etc. directed at other people's ideas and arguments.

Those "attacks" are at ideas and arguments, not at people.

> I'm actually wondering whether there is any agreement on the sheer fact
> that there is a problem in the ui, namely having too many different
> commands or options (reset/commit/add/checkout resp. diff invocations;
> I've described that already) for different aspects of a "similar"
> concept (cp content version from A to B resp. diff it).
> 
> If we don't agree that there's a problem then there's no point
> discussing solutions (or ideas/brainstorms thereof).

Well, some of current overloading might be leftover result of "git is too
complicated, see how many commands it have [in $PATH]" criticism of git
and comparison with other (D)VCS... and in reducing number of commands
the pendulum perhaps went too far in opposite direction.

I don't quite think that we need "git diff NEXT WTREE"; the short
and sweet "git diff" is short for a reason, see my other response in this
thread:

  http://thread.gmane.org/gmane.comp.version-control.git/175061/focus=175265

and that the pseudo-almost-ref notation it would require for each such
pseudo-ref considering many corner cases:

  git diff <pseudo-ref-A> <pseudo-ref-B>
  git diff <commit or tree> <pseudo-ref>
  git diff <pseudo-ref>
  git show <pseudo-ref>

in normal and in conflicted case.


I am also not sure if replacing "context-sensitive" git-checkout behavior
by "git revert-file" (or rather "git revert-path", as you can use pathspec,
c.f. "git checkout ."), is something to consider without rock-solid UI
design and a very good name.  True, context dependent grammars are harder
than context-free grammars, but people do understand context, don't they?

Anyway, if one does not remember "git checkout -- <file>", one can always
use obvious alternative, namely "git show :./<file> > <file>"...


BUT I quite like "git unadd" (and/or "git unstage") idea.  

It is not obvious that "git reset" can be used for files, and it requires
bit of analysis that it resets index from HEAD: 
1. "git reset [<options>]" always resets from commit (defaults to HEAD),
2. "git reset" == "git reset --mixed" modifies current branch and index
   (HEAD -> index -> worktree progression of --soft -> --mixed -> --hard
   et al.),
3. modifying branch tip doesn't make sense for checking out file, so
4. "git reset -- <file>" must set index version of file from HEAD.

Truth to be told I really just follow what "git status" tells me ;-)

Though I am always wondering why there isn't "git reset --hard <file>"
to mean the same as "git checkout HEAD <file>".

So +1 from me for "git unadd [<commit>] [--] <path>..." (and "git unstage")
to do _exactly the same_ as "git reset [<commit>] [--] <path>...".

-- 
Jakub Narebski
Poland

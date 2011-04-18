From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: The future of gitweb - part 2: JavaScript
Date: Mon, 18 Apr 2011 20:13:13 +0200
Message-ID: <201104182013.14475.jnareb@gmail.com>
References: <201102142039.59416.jnareb@gmail.com> <201104171659.02950.jnareb@gmail.com> <BANLkTin80KQzp9=2Bu4rxJSwcnUj-aXaHw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, John Hawley <warthog9@kernel.org>,
	Kevin Cernekee <cernekee@gmail.com>,
	Petr Baudis <pasky@suse.cz>, Petr Baudis <pasky@ucw.cz>
To: Pau Garcia i Quiles <pgquiles@elpauer.org>
X-From: git-owner@vger.kernel.org Mon Apr 18 20:13:35 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QBsx0-0000gC-Hk
	for gcvg-git-2@lo.gmane.org; Mon, 18 Apr 2011 20:13:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756251Ab1DRSN0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 Apr 2011 14:13:26 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:64389 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754324Ab1DRSNY (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Apr 2011 14:13:24 -0400
Received: by bwz15 with SMTP id 15so4054359bwz.19
        for <git@vger.kernel.org>; Mon, 18 Apr 2011 11:13:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:subject:date:user-agent:cc:references
         :in-reply-to:mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        bh=Ii+5VwK5Pl3btaLkR/Mo6Djv5j0Cmx1vYW0KaBsVYKo=;
        b=btRaaPw6D+3GclDItHYIVDmvKKKjKvBgBeeVwQWtpe8J7Fngati2oDZT6UtiSJdp4I
         iXpXPk6DEd56155YZHiaJ8lYICN/0guAGPPnzk78UdoetDOvYGXNA6eCIX8Syog00p4Y
         /nudMuISQ8tLEHBw8MYET6oF/HAWNFNfF3DYk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=MukutTwSsw6NUHma8uxN4JAt6tRC6ywn/JAqOSW4kkrFPTr4THlg8ZcV/wksRlWSBf
         /F7qGr6MuLuJKKRpFdl0jfflQ8HP6J7nX/Dp41l0VpHAGHkVevhaUcQBZKsg6DHzhMcS
         D3+CJO1v2m5Tt74GaXnl2wnvA+29N+Nop7KBg=
Received: by 10.204.17.19 with SMTP id q19mr4392698bka.46.1303150403491;
        Mon, 18 Apr 2011 11:13:23 -0700 (PDT)
Received: from [192.168.1.13] (abvc126.neoplus.adsl.tpnet.pl [83.8.200.126])
        by mx.google.com with ESMTPS id l1sm3371553bkl.13.2011.04.18.11.13.19
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 18 Apr 2011 11:13:20 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <BANLkTin80KQzp9=2Bu4rxJSwcnUj-aXaHw@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/171751>

On Sun, 17 Apr 2011, Pau Garcia i Quiles wrote:
> On Sun, Apr 17, 2011 at 4:59 PM, Jakub Narebski <jnareb@gmail.com> wrote:
> 
>>> My suggestion is going to be tremendously unpopular, but still: if I
>>> were to develop my own gitweb, I'd use Wt ( http://webtoolkit.eu ) +
>>> libgit2. In fact, there is a very basic gitweb-like example bundled
>>> with Wt sources, it's available online at
>>> http://www.webtoolkit.eu/wt/examples/git
>>
>> Well, nothing prevents you or anybody else from writing (yet another)
>> web interface in C++ + Wt + libgit2.
> 
> I do not have the slightest intention of doing that, at least not in
> my spare time. The existing interfaces (gitweb, cgit, etc) are good 
> enough for me. 

I can certainly understand that... ;-)

> I made the suggestion of going with Wt just in case a 
> rewrite of gitweb was in mind.

No, major rewrite of gitweb is certainly not on agenda.  Besides IMVVHO
rewriting a long-lived existing application / project from scratch is
usually a bad idea; you would almost certainly repeat old mistakes.
If code is bad enough that it hinders maintenance and development, it is
better to do refactoring, trying to keep project working as it was.

The question was more about future features.

[...]
>> BTW. do I understand correctly that Wt generates JavaScript code, in
>> similar vein to GWT for Java, or Pyjamas for Python?
> 
> Wt generates Javascript only if the visitor has Javascript enabled. If
> Javascript is not available, it will generate plain HTML pages, with
> "update" buttons, etc and it will do that automatically: there is no
> need for you to write code "if Javascript is available { ... } else {
> ... }".

Well, actually sometimes you need to know if JavaScript is available...
for example in the case of gitweb there is separate 'blame' view which
runs 'git blame --porcelain' which can take a while, and Ajax-y
'blame_incremental' which runs 'git cat-file -p' + 'git blame --incremental'
in background via XmlHttpRequest.  Different server-side reactions;
and doing both would be really counterproductive wrt. performance.
 
On the other hand it would be nice to write almost the same algorithm
of parsing 'git blame --porcelain' and 'git blame --incremental' output,
and of generating or manipulating output to the same look ONCE, and not
one time in Perl, one time in JavaScript.


Unfortunately I haven't found anything on CPAN that would be Perl
equivalent of Java's GWT, C++'s Wt, or Python's Pyjamas... well except
not quite here CGI::Ajax.  Besides even using CGI::Ajax goes against
current "no non-core dependencies" policy...

BTW. there is Continuity Perl web framework which I think is similar
to Wt in that it manages state of web app like Wt does.

> The advantage of Wt is you can compile a hypothetical gitwebwt as a
> static executable and the result will be a single executable file that
> depends only on libc (or libc + git, if you call git instead of
> linking to libgit.a or libgit2). Also, performance and memory
> requirements are very good, which is important for not-that-powerful
> devices such as routers, etc.

Nice.

-- 
Jakub Narebski
Poland

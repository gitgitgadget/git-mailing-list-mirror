From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: suggestions for gitweb
Date: Sun, 13 May 2007 13:18:39 +0200
Message-ID: <200705131318.39723.jnareb@gmail.com>
References: <20070512205529.GS14859@MichaelsNB> <7v8xbtwtsy.fsf@assigned-by-dhcp.cox.net> <20070513000151.GT14859@MichaelsNB>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org,
	Petr Baudis <pasky@ucw.cz>
To: Michael Niedermayer <michaelni@gmx.at>
X-From: git-owner@vger.kernel.org Mon May 14 01:33:22 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HnNZ1-0002hy-39
	for gcvg-git@gmane.org; Mon, 14 May 2007 01:33:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758364AbXEMXci (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 13 May 2007 19:32:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758455AbXEMXci
	(ORCPT <rfc822;git-outgoing>); Sun, 13 May 2007 19:32:38 -0400
Received: from ug-out-1314.google.com ([66.249.92.170]:39498 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758392AbXEMXch (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 13 May 2007 19:32:37 -0400
Received: by ug-out-1314.google.com with SMTP id 44so1226383uga
        for <git@vger.kernel.org>; Sun, 13 May 2007 16:32:36 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=T0mahmFoZkfKMHHnI80ILf7QJwBvW78lLDS/xrJ6z/djrh0WU0bY752l6tNSBGjfO4P416uBpMXs/jXZk9y6Ihp4PQAqj5ZYtFN1sNWkjk6TwpNLbBHgJHBRZnUsfYajj6KV5/rHJn+kNhZ2Pz8V7x74ajBj5jt/pRwJvCZrXJA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=jX2DgvMDwHXwHYR2hBlln/Qmrc6l1J1ZIELgJrmHZz8G4VmaQAxy64D/WuqLubVArwa42vWDdAcy+98ud/nzWBzrC+yN2csSqv83Q6tYFFJPkUOI4juxo3Sqk2Z2RIHel+MedBf+8S1we+W1WN4mpxZiwmDRith0W5naqpibZ5U=
Received: by 10.67.118.8 with SMTP id v8mr4630156ugm.1179099156500;
        Sun, 13 May 2007 16:32:36 -0700 (PDT)
Received: from host-89-229-25-173.torun.mm.pl ( [89.229.25.173])
        by mx.google.com with ESMTP id e33sm12678053ugd.2007.05.13.16.32.34;
        Sun, 13 May 2007 16:32:35 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <20070513000151.GT14859@MichaelsNB>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/47193>

On Sun, 13 May 2007, Michael Niedermayer wrote:
> On Sat, May 12, 2007 at 03:39:25PM -0700, Junio C Hamano wrote:
>> Michael Niedermayer <michaelni@gmx.at> writes:
>> 
>>> * gitweb uses many terms which are new to a non git user, 
>>>   [...] so i belive  
>>>   a small help text linked to from all pages which contains a short
>>>   definition of all the git(web) specific terms would be very helpfull
>>>   something like
>>>     blob        - file      at a specific revision/date
>>>     tree        - directory at a specific revision/date
>>>     (short) log - project wide commit log
>>>     history     - short log equivalent for a file or directory
>> 
>> Coming fron non-CVS camp, I think changing this to non-git terms
>> is very harmful than educating users who are migrating from
>> other systems.
> 
> You must have misunderstand me :(
> I want to educate them, but I cannot as I am not speaking about ffmpeg
> developers/contributors but rather random people who are curious and 
> want to take a look at the ffmpeg source
> 
> For them a simple help link similar to "ViewVC Help" which ViewVC has
> on the bottom right of its pages would be great IMHO
> also the text above is a pure random suggestion by a svn user and was
> not intended to redefine any git terms

Back in the times where there was no git homepage, the git logo at
top right corner of gitweb page was link to git documentation
  http://www.kernel.org/pub/software/scm/git/docs/
(with the title of "git documentation"), or to be more exact to HTML
version of git(7) man page. This page has link to git glossary, where
you can find explanation of this terms. Now it is link to git homepage;
I'm not sure where / if there is here link to git glossary.

It is very easy to change URL where git logo points to; either via
setting appropriate variables when running make to get gitweb.cgi out
of gitweb.perl, or via configuration file for gitweb. You can point
git logo to lead to your documentation of gitweb terms.

But gitweb was primarly meant for developers which works which git,
and have knowledge of git terms (and gitweb terms, as gitweb uses them).

Adding some gitweb-help.html page, linked somewhere from within gitweb
pages (I think it shouldn't be embedded in gitweb, like help for search
options is), certainly is possible. And perhaps we should do that, now
that gitweb is more widely deployed, and used by "accidental" users
(developers) with no knowledge of git, and perhaps even without
knowledge of SCM [terms].

By the way, I think only "blob" and perhaps "tree" terms really needs
explanation...


Sidenote: we used to have some links to 'blob_plain' action, which
returns exact contents of file at given revision to the browser
(trying to set appropriate mime type), named "plain" and some named
"raw". This ambiguity was resolved in favor of "raw". Is it better?
I'm not sure...

> [...]
>>> * on the history page there are "blob", "commitdiff" and "diff to current"
>>>   the obvious missing one is "diff to previous" which would be the diff to
>>>   the previous blob of this file
>> 
>> Isn't that commitdiff, or commitdiff on that page does not limit
>> the diff to the blob?
> 
> commitdiff doesn't limit it to the blob ...

It should be fairly easy to add "diff to prev" link, but is it really
needed? It would be yet another link. Diff to previous version of blob
is contained in "commitdiff" and is easy to find and go to... well,
unless you are used to make large commits...

-- 
Jakub Narebski
Poland

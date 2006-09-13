From: "Martin Langhoff" <martin.langhoff@gmail.com>
Subject: Re: cvs import
Date: Thu, 14 Sep 2006 09:16:01 +1200
Message-ID: <46a038f90609131416s1a53b53xd12c3661140fec7a@mail.gmail.com>
References: <45084400.1090906@bluegap.ch>
	 <9e4733910609131201q7f583029r72dac66cd0dd098f@mail.gmail.com>
	 <46a038f90609131341se42b2dcne73c017cf757d13a@mail.gmail.com>
	 <4508724D.2050701@bluegap.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Jon Smirl" <jonsmirl@gmail.com>,
	"Git Mailing List" <git@vger.kernel.org>,
	monotone-devel@nongnu.org, dev@cvs2svn.tigris.org
X-From: git-owner@vger.kernel.org Wed Sep 13 23:16:17 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GNc5c-0000ru-Pf
	for gcvg-git@gmane.org; Wed, 13 Sep 2006 23:16:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751206AbWIMVQF (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 13 Sep 2006 17:16:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751209AbWIMVQF
	(ORCPT <rfc822;git-outgoing>); Wed, 13 Sep 2006 17:16:05 -0400
Received: from nf-out-0910.google.com ([64.233.182.185]:35237 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1751206AbWIMVQD (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Sep 2006 17:16:03 -0400
Received: by nf-out-0910.google.com with SMTP id o25so1818947nfa
        for <git@vger.kernel.org>; Wed, 13 Sep 2006 14:16:01 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=MQhfovJuDGaDcZrutSR/SWiuvkS85zZ5HBxh2AMN3u57FTwT3hFEc/YMfHlVwnV9iAzVv5HoEzzlGFVP8W0SKr4C8I+s1M8r7PnQC7FCqOkgdrxlluBB08wAAJnft0/MUizpNBQOJUCAeQiXeSB6T3PO8kxgeBLg/1EUHbgJESc=
Received: by 10.49.55.13 with SMTP id h13mr11366938nfk;
        Wed, 13 Sep 2006 14:16:01 -0700 (PDT)
Received: by 10.49.6.16 with HTTP; Wed, 13 Sep 2006 14:16:01 -0700 (PDT)
To: "Markus Schiltknecht" <markus@bluegap.ch>
In-Reply-To: <4508724D.2050701@bluegap.ch>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/26949>

On 9/14/06, Markus Schiltknecht <markus@bluegap.ch> wrote:
> Martin Langhoff wrote:
> > On 9/14/06, Jon Smirl <jonsmirl@gmail.com> wrote:
> >> Let's copy the git list too and maybe we can come up with one importer
> >> for everyone.
> >
> > It's a really good idea. cvsps has been for a while a (limited, buggy)
> > attempt at that. One thing that bothers me in the cvs2svn algorithm is
> > that is not stable in its decisions about where the branching point is
> > -- run the import twice at different times and it may tell you that
> > the branching point has moved.
>
> Huh? Really? Why is that? I don't see reasons for such a thing happening
> when studying the algorithm.
>
> For sure the proposed dependency-resolving algorithm which does not rely
> on timestamps does not have that problem.

IIRC, it places branch tags as late as possible. I haven't looked at
it in detail, but an import immediately after the first commit against
the branch may yield a different branchpoint from the same import done
a bit later.

cheers,


martin

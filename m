From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: Google Summer of Code 2013 (GSoC13)
Date: Tue, 19 Feb 2013 13:21:43 +0530
Message-ID: <CALkWK0=_kpmUOYS5J6L2+JPzmeW_9+bVAu4eN=dr8kPMbuTn8w@mail.gmail.com>
References: <87ehgd1qq2.fsf@pctrast.inf.ethz.ch> <20130218174239.GB22832@sigill.intra.peff.net>
 <CALkWK0nDEwgDwnVktmM8abv3ZgQmJCOm8LBe25UKR485PZMPfA@mail.gmail.com>
 <20130218185801.GA25673@sigill.intra.peff.net> <CALkWK0kFYP4k5=237PZ3XHhxkzF-RWwwe=3+Thb_xU2Jw5tg2g@mail.gmail.com>
 <878v6lwfrt.fsf@pctrast.inf.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org,
	Shawn Pearce <spearce@spearce.org>,
	Jakub Narebski <jnareb@gmail.com>,
	Christian Couder <christian.couder@gmail.com>,
	Pat Thoyts <patthoyts@users.sourceforge.net>,
	Paul Mackerras <paulus@samba.org>,
	=?UTF-8?Q?Carlos_Mart=C3=ADn_Nieto?= <cmn@elego.de>,
	Thomas Gummerer <t.gummerer@gmail.com>,
	David Barr <b@rr-dav.id.au>,
	Jens Lehmann <Jens.Lehmann@web.de>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>
To: Thomas Rast <trast@inf.ethz.ch>
X-From: git-owner@vger.kernel.org Tue Feb 19 08:52:35 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U7i06-0002f2-VI
	for gcvg-git-2@plane.gmane.org; Tue, 19 Feb 2013 08:52:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757618Ab3BSHwG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Feb 2013 02:52:06 -0500
Received: from mail-ie0-f169.google.com ([209.85.223.169]:39755 "EHLO
	mail-ie0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757317Ab3BSHwE (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Feb 2013 02:52:04 -0500
Received: by mail-ie0-f169.google.com with SMTP id 13so8170537iea.14
        for <git@vger.kernel.org>; Mon, 18 Feb 2013 23:52:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=qbA8JcimmbXS4Z4cut2TTuMc0gvkNj/NQ5yAv41pGpU=;
        b=oAz5bZlrMQZPdrimjR1z1CXJ45ORJP0S+bo0FJ38mMkFMb+fBgkHK16lPZJ/Vl01kc
         4AZH200Nt7l+Td2ajCcCthSTr0iEG1cA3dGQphNhnzl3QvyWW54eNV3SsHj0rKBQLXnV
         r/u2lCMtci66UXj1XcrvRVZnua2KA7YYmzAj1iWBLIyEUjrkzrrSTK7yeiXxGEtnVSKT
         J6NR4CDfCD9amkvpgakLkiLXNgPEYkgSEZzdJ+mQXuCgNaVnYZzTlBl838Z01Ub8dzVD
         QjNWJAtEqq03SnNvsMvhcEgxESXf0sRGdMNXsRfneEXVXA4bW2WP0A+tGUcjE1IpYSG4
         8U6g==
X-Received: by 10.50.222.195 with SMTP id qo3mr8033291igc.14.1361260323768;
 Mon, 18 Feb 2013 23:52:03 -0800 (PST)
Received: by 10.64.166.33 with HTTP; Mon, 18 Feb 2013 23:51:43 -0800 (PST)
In-Reply-To: <878v6lwfrt.fsf@pctrast.inf.ethz.ch>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/216573>

Thomas Rast wrote:
> Ramkumar Ramachandra <artagnon@gmail.com> writes:
>
> [...]
>>>> On a related note, I don't like our Wiki.  It's down half the time,
>>>> and it's very badly maintained.  I want to write content for our Wiki
>>>> from the comfort of my editor, with version control aiding me.  And I
>>>> can't stand archaic WikiText.
>>>
>>> Agreed on all of those points. Putting the Wiki on GitHub fixes that.
>>> But it means contributors need to have a GitHub account. On the other
>>> hand, I think kernel.org wiki contributors need an account these days?
>>> And GitHub is putting some active effort into finding and killing spammy
>>> accounts, which might keep wiki spam down (I do not pay too much
>>> attention to those efforts, but on kernel.org, it is mostly up to the
>>> Git community to do it ourselves).
>>
>> No, I'm against using the GitHub Wiki for neutrality reasons.  There
>> is one easy way to fight spam: don't expose a web-based editing
>> interface at all.  It's mainly going to be maintained by the
>> community, and we're all much more comfortable in our editors and git.
>>  We can give the regulars direct commit access and ask the rest to
>> submit pull requests.  Make it cost pennies, so any of us can easily
>> afford it: just a cheap domain, DNS, and static HTML hosting.
>
> I suppose since github's wiki system (gollum) is open source [1] it
> wouldn't be too hard to set up another instance somewhere.  Bonus points
> for importing all the old data in mediawiki format first, which is also
> apparently supported.

Yes, I am aware.  However, I don't think gollum fits our purposes
well: we really don't need much more than plain text.
What do you want to import?  We can copy out the text from the
previous GSoC pages, but most of the other pages are filled with
ancient junk.  We don't want a museum: we want a clean Wiki with
crisp, clean up-to-date information.

> But that just shifts the point of failure from the entire github team to
> one or two people who end up administering the server.

... which is the entire problem.  We don't want to "administer"
things.  We're programmers who're competent at writing plain text and
maintaining git repositories, so let's stick to doing that; I'm
pushing for static HTML hosting for exactly this reason: there is
nothing to "administer", no security exploits, no unexpected
breakages.  It also reflects our community's affinity for simplicity.

> Perhaps a better solution would be to ask Scott or Peff to create a
> gollum instance under git-scm.com, which they're already hosting?

Failing that, just a CNAME entry for "wiki" under git-scm.com would
suffice.  What does static HTML hosting cost anyway?

> (It
> seems people got over *that* neutrality issue quickly enough.)

There's a big difference between having git-scm.com as our official
website, and hosting our official Wiki on
https://github.com/git/git/wiki.  Although it is built by people
working in GitHub, with its sources in github.com/github/gitscm-next,
it makes no effort to reference GitHub directly.

Ofcourse, there are many things I dislike about the website, and would
have preferred a community-built one.  Unfortunately, building a
website involves doing design work that we programmers are incompetent
at.  So, I think of it as a practical compromise that we have to live
with.

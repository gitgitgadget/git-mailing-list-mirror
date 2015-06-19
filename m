From: Tuncer Ayaz <tuncer.ayaz@gmail.com>
Subject: Re: co-authoring commits
Date: Fri, 19 Jun 2015 23:11:12 +0200
Message-ID: <CAOvwQ4gYsQtZPWOA+1gBtdw9XkjQ4WGipk9grb+_ad9iiBj5Og@mail.gmail.com>
References: <CAOvwQ4i_HL7XGnxZrVu3oSnsbnTyxbg8Vh6vzi4c1isSrrexYQ@mail.gmail.com>
 <xmqq4mm66r99.fsf@gitster.dls.corp.google.com> <CAOvwQ4j2bjR1jnLVyZbw1OCE=xQxbCEFGKcK1bpuv1K3s_Y2EQ@mail.gmail.com>
 <20150617225224.GF4076@thunk.org> <CAOvwQ4jb-w4+Ah3ZhVE0j1aXLx1=8tRN3Wo98tz+G-wEqLGAcA@mail.gmail.com>
 <55845CFE.4070407@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "Theodore Ts'o" <tytso@mit.edu>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Josh Triplett <josh@joshtriplett.org>
To: =?UTF-8?Q?Jakub_Nar=C4=99bski?= <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jun 19 23:12:59 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z63ar-0007VZ-EE
	for gcvg-git-2@plane.gmane.org; Fri, 19 Jun 2015 23:12:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933031AbbFSVMw convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 19 Jun 2015 17:12:52 -0400
Received: from mail-ob0-f172.google.com ([209.85.214.172]:35194 "EHLO
	mail-ob0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932948AbbFSVLx convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 19 Jun 2015 17:11:53 -0400
Received: by obbgp2 with SMTP id gp2so82012316obb.2
        for <git@vger.kernel.org>; Fri, 19 Jun 2015 14:11:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=/SQk5UadmNNXzV8IGdNTbAYCWEwt0jIuU9LVpJWRZN0=;
        b=g4rgWU9Y6Q807IguWTvaj+9axvN7eumB5bGzwsKNA1KKlF0wcFs6/PwXEs1ptn9vu4
         +7hF6l9z3v6fte7z4b3uKgjwIwHb1rstOGREyw7QPpOM+XVpFwmpROxi53bnHrz2lS4L
         i6M4UDAuMCR/0W1jFG5U7sXUOG/wl+OF9sLqAN8Whn0f1abLuBr6TKDcCIYayfPSMBbT
         jOr6hrqtzayJx1wNzjgOt+eLIIBXB+keMMB+/AMTm/d7vuk16HN0idY/w/6sVJS+cg9X
         PYaLFm2XuCVo8MM7Kz/LPkSXUi0yl8edPRg54Iy+FwdROhGmWbj8/h1x9S8Cvr9W5yRe
         yDIg==
X-Received: by 10.202.170.82 with SMTP id t79mr14666400oie.40.1434748312811;
 Fri, 19 Jun 2015 14:11:52 -0700 (PDT)
Received: by 10.76.158.202 with HTTP; Fri, 19 Jun 2015 14:11:12 -0700 (PDT)
In-Reply-To: <55845CFE.4070407@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/272212>

On Fri, Jun 19, 2015 at 8:18 PM, Jakub Nar=C4=99bski <jnareb@gmail.com>=
 wrote:
> On 2015-06-18 at 23:25, Tuncer Ayaz wrote:
> > On Thu, Jun 18, 2015 at 12:52 AM, Theodore Ts'o wrote:
> > > On Wed, Jun 17, 2015 at 10:26:32PM +0200, Tuncer Ayaz wrote:
> [...]
> > > One could imagine some frankly, quite rare example where there
> > > is a team of people who votes on each commit before it gets sent
> > > out and where everyone is equal and there is no hierarchy. In
> > > that case, perhaps you could set the from field to a mailing
> > > list address. But honestly, how often is that *all* of the
> > > authors are completely equal[1]?
> >
> > For that case something like patchwork, phabricator, or gerrit
> > seems to be the logical tool to use, and should ideally leave a
> > trace of approvals and such in the resulting commit message(s). If
> > the patch management tool takes care of merging the commit(s), it
> > can be harder to misattribute signed-off/reviewed-by/etc, which is
> > a good thing.
>
> Doesn't Gerrit (at least) use trailer-like structured *notes* in the
> 'reviews' category (i.e. refs/notes/reviews ref) to store
> information about review process?

Don't remember if it does specifically, but I'm sure it can be
configured to. I know Phabricator appends a lot upon doing the
commit. I'll have to check it the next time I happen to use
Gerrit.

> > You could of course use multiple (everybody makes their own)
> > commits, where you risk breaking bisectability and avoid the need
> > for equal co-authorship support. In pair programming such
> > intermediate commits will quite often be fixups, and when you
> > attempt to squash the fixups for bisectability's sake, you may get
> > a desire for co-authorship of the resulting commit.
>
> Hmmm... I didn't think about the problem of attributing authorship
> for squashed commits. Though here multiple 'author' headers, or

Strictly speaking, in a live pair programming session usually the one
currently typing will be corrected by the other dev, and the roles
will switch when the typist changes.

> multiline 'author' header would be a better match than 'coauthor'
> header (which itself doesn't need, I think, the date filed, or does
> it?)

What makes sense to me is that the date is decoupled from the list of
authors and there is one date only. I think of it as an expanded
version of the previously single-entry author field, where the limit
has been lifted. With my purely git-user hat on, that is.

So, yes, a multiline author header sounds like a solution to me. Maybe
it should be sorted alphabetically upon commit regardless of the order
of --author ONE --author TWO.

> [This is sent from Thunderbird news, so it should be all right]

This is fine, the other one was broken. Out of curiosity what's the
difference between Thunderbird email and news?

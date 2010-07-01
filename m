From: Chris Packham <judge.packham@gmail.com>
Subject: Beg. Level: Send Radiant CMS w/extensions to Heroku
Date: Thu, 1 Jul 2010 10:47:55 -0700
Message-ID: <AANLkTimxEppGHi327xQA6ex8Q0-1EUPyWiOb104uOgkO@mail.gmail.com>
References: <29042313.post@talk.nabble.com>
	<4C2CBAD9.60701@gmail.com>
	<AANLkTin9XwWymJuxKOeoc5z9mIVMY2mQXYv-xcihBe96@mail.gmail.com>
	<4C2CD32A.80501@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: GIT <git@vger.kernel.org>
To: dsamay@gmail.com
X-From: git-owner@vger.kernel.org Thu Jul 01 19:48:05 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OUNro-00030F-In
	for gcvg-git-2@lo.gmane.org; Thu, 01 Jul 2010 19:48:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753172Ab0GARr5 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 1 Jul 2010 13:47:57 -0400
Received: from mail-gy0-f174.google.com ([209.85.160.174]:46977 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752912Ab0GARr5 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 1 Jul 2010 13:47:57 -0400
Received: by gyd12 with SMTP id 12so1202106gyd.19
        for <git@vger.kernel.org>; Thu, 01 Jul 2010 10:47:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=IunSKgQsskAYLLHFyAjz9cz3zM/LDxiD68l9vpPhHTk=;
        b=bDEB0xEW0boS6t4do37h+WdULEjfCj+1W4zl7sLIDrI3tQv9vEFR5xkBZrCWQxZOTl
         x8Kq5xME8IDWwugVhuJMemt5mS4xlMpGVmHuTK7SXQjCgaBT3tphYuvYBN4j6QifUUWN
         Yaw7ks5fc/PsHyFk05vjUPFu/1yi2JnAjFJ74=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=TYXk+qi92OnsL2rGiY9LtdJyMnzCb3B6qAQ0abO1x8xaWDGQjxYUhIbjp4YdPz0Bl6
         Al7tEXJUVy6Gnl+1ec6Qysero4w+uUL7MHq7R+hUPWxyJ3v0zd3wUXAsfLzMRhr9fLQV
         uctx0cNU02GxHhlQaIceQd/PddrCg4sABArOM=
Received: by 10.229.86.10 with SMTP id q10mr6474867qcl.36.1278006475540; Thu, 
	01 Jul 2010 10:47:55 -0700 (PDT)
Received: by 10.229.39.146 with HTTP; Thu, 1 Jul 2010 10:47:55 -0700 (PDT)
In-Reply-To: <4C2CD32A.80501@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/150060>

Sorry if there are double ups. I obviously haven't configured
Thunderbird not to sent HTML.Back to gmail web interface it is.

On 01/07/10 09:21, Daniel Samay wrote:
>
> On Thu, Jul 1, 2010 at 10:57 AM, Chris Packham <judge.packham@gmail.c=
om> wrote:
>
> On 30/06/10 23:15, Geirsman wrote:
> > Hey,
> >
> > I made the page I wanted locally with Radiant CMS and several exten=
sions.
> > Then when I went to send it to Heroku I ran into a variety of error=
s, first
> > SSH, then I think I sent over the gems but not the extensions. And =
in
> > attempting to fix things I think I only made them worse.
> >
> > Right now at http://freezing-night-21.heroku.com I believe I need t=
o send
> > over my extensions because the repo size is 17.6megs and the slug s=
ize is
> > 7.6megs. Also the way I read the error message I get.
> >
> > I'm lost so I start at the end,
> >
> > $ git push heroku
> >
> >> Everything up-to-date
> >>
> > $ git commit -a
> > U =C2=A0 =C2=A0 vendor/extensions/forms
> > U =C2=A0 =C2=A0 vendor/extensions/forms_mail
> > U =C2=A0 =C2=A0 vendor/extensions/mailer
> > U =C2=A0 =C2=A0 vendor/extensions/multi_site
> > U =C2=A0 =C2=A0 vendor/extensions/paperclipped
> > U =C2=A0 =C2=A0 vendor/extensions/paperclipped_uploader
> > U =C2=A0 =C2=A0 vendor/extensions/ray
> > U =C2=A0 =C2=A0 vendor/extensions/rbac_base
> > U =C2=A0 =C2=A0 vendor/extensions/rbac_page_edit
> > U =C2=A0 =C2=A0 vendor/extensions/settings
> > U =C2=A0 =C2=A0 vendor/plugins/attachment_fu
> > fatal: 'commit' is not possible because you have unmerged files.
> >
> > I'm lost, I tried a variety of commands but nothing seems to work o=
n these
> > extensions. I had several RB files on this list before so I hit git=
 add
> > <file> and now they don't show up. Can't really do that extension d=
irs
> > though.
> >
> > Anyways, I don't care if I start from scratch and do it properly or=
 if I'm
> > just one step away from having the page that I want up and running.=
 I'd just
> > like it up. It's a very simple page and it's taken many more hours =
to deploy
> > than to create because the documentation tends to be mmm...technica=
l. Any
> > help would be greatly appreciated, I am trying to make a site for c=
ommunity
> > good!
> >
> This is just a complete guess but you probably have previous merge
> conflict that needs resolving.
>
> The output of 'git status' should tell you something about files bein=
g
> 'unmerged' or having conflicts (sorry I can't remember the exact
> wording). If you do have any conflicts open the files in a text edito=
r
> and search for the conflict markers '>>>>>>>' fix-up the files and
> double check that everything looks OK. After that you need to tell gi=
t
> that the conflicts have been handled with 'git add <filename>' you
> should then be able to commit.

Hey thanks for the reply, it wasn't showing up on the old nabble
because I was not subscribed. I am now, but I believe I'd have to
repost.

No problem. Just keep the list on the Cc someone who knows=C2=A0 more m=
ight
decide to help. You don't need to subscribe the git mailing list
allows non-subscriber posts and the convention is to Cc all
participants (as well as the list) so you won't miss out.

I forgot to mention git status results

$ git status
> (my wording) 3 changes need to be commited (environment.rb, environme=
nt.bak, and boot.rb)
> the extensions mentioned in my first post need to be merged
> roughly 500-1,000 lines of "deleted" xyz

I found the conflict markers in 3 files - environment.rb,
environment.bak, and boot.rb and then I git added them. However now I
am left with all the extension files/folders.

Hmm. Did you mean to delete those files? If so you can tell git that
you meant to with 'git rm <files>' or you can get them back with 'git
checkout <files>'.

=46or your extensions it looks like they are "updated but unmerged" I'm
not entirely sure what that means but once again 'git add'ing them
should hopefully sort them out. Alternatively 'git checkout
vendor/extensions/*' will get them back from the stored versions but
if you have any uncommitted changes in them they will be lost.

You might want to let us know how you got to where you are from the
start. It sounds like you may be tripping over some of the DVCS
concepts that people who have used traditional VCSes run into.

e.g. i did the following
=C2=A0 git clone blah
=C2=A0 <hack hack hack>
=C2=A0 git pull
=C2=A0 <more hacking>
=C2=A0 git add
=C2=A0 git commit
=C2=A0 git push

I ordered a Git book but it'll be a couple days before it gets here.

Lost of free resources are available on the web. I'd recommend the git
community book [1], git tutorial [2] and the full manual [3]

[1] http://book.git-scm.com/
[2] http://www.kernel.org/pub/software/scm/git/docs/gittutorial.html
[3] http://www.kernel.org/pub/software/scm/git/docs/

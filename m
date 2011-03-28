From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: GSoC questions
Date: Sun, 27 Mar 2011 19:11:53 -0500
Message-ID: <20110328001152.GA11294@elie>
References: <AANLkTinTM8hQpcahGgDyB4UJvGbdN0xyp65wL5PDQGKa@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, libgit2@librelist.org,
	Jeff King <peff@peff.net>
To: Alexandru Sutii <sutii.alex@gmail.com>
X-From: git-owner@vger.kernel.org Mon Mar 28 02:12:09 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q4040-0007cL-Nz
	for gcvg-git-2@lo.gmane.org; Mon, 28 Mar 2011 02:12:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751956Ab1C1AMA convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 27 Mar 2011 20:12:00 -0400
Received: from mail-yi0-f46.google.com ([209.85.218.46]:41265 "EHLO
	mail-yi0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751262Ab1C1AL7 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 27 Mar 2011 20:11:59 -0400
Received: by yia27 with SMTP id 27so996112yia.19
        for <git@vger.kernel.org>; Sun, 27 Mar 2011 17:11:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=6+O+QfYRwIIx+5mD0zo+w3Qk6ISaZIipGO00pfpE+EQ=;
        b=XybE9eK4RVeubtTICNcHosgSHiox1SpTb9pVNw9xJFnKMgjryoqmxQ6ZQgmI+8azBU
         NpfVPLOLbVObSKMiWXMntgZwqecd6Ph8ZpkhijJP0HI46zPg0e1njr3IGdMAjEWAlEWD
         m7gEO9XnbDbF6nsGl8U7jxGWwgE3vviYd5De8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=hvsp0+R73KqkHVt4GDqt2rrn/ufy7Pzb5kO61RGtF+k8g2WK0aH7VfvqdxuDBBRwX1
         +3q1WncEsLSMmB4gR+FAYEVKXddVP+Tzm1ZBDWgnx0bNIWzFzoQ2clEUK70tebc1Zg4b
         gNhB/Um+Wap8mLqs3oQ6+E1258ptnfJ8pJAfc=
Received: by 10.147.158.16 with SMTP id k16mr3231148yao.22.1301271118797;
        Sun, 27 Mar 2011 17:11:58 -0700 (PDT)
Received: from elie (adsl-68-255-101-206.dsl.chcgil.sbcglobal.net [68.255.101.206])
        by mx.google.com with ESMTPS id x69sm1649211yhn.41.2011.03.27.17.11.56
        (version=SSLv3 cipher=OTHER);
        Sun, 27 Mar 2011 17:11:57 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <AANLkTinTM8hQpcahGgDyB4UJvGbdN0xyp65wL5PDQGKa@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/170094>

Hi,

Alexandru Sutii wrote:

> I am interested in two projects from your list:
> - Build a minimal Git client based on libgit2
> - Port Git to Android
> My questions are:
> - How important are these projects for the community?
> - Should I provide a patch in order to prove that I am suited for one=
 of these
> projects?
> =C2=A0 If so, what specifically should I implement?

Thanks for writing.  The "minimal Git client" task seems like a
popular one.  Luckily that is not a fatal problem --- git has many
subcommands, so even if every proposal is about that, it could be
possible to subdivide the work and produce something interesting.

Some reading matter:

 http://thread.gmane.org/gmane.comp.version-control.git/99608/focus=3D9=
9682
 http://thread.gmane.org/gmane.comp.version-control.git/169498/focus=3D=
169517
 http://thread.gmane.org/gmane.comp.version-control.git/169498/focus=3D=
169762
 http://thread.gmane.org/gmane.comp.version-control.git/170032/focus=3D=
170076

Is there some particular part of git functionality you would like to
focus on (history creation, history mining, object store maintenance,
configuration, transport)?  The list of low-level commands (plumbing)
in the git manual might be a good place to get an idea of the scope.

The ideas page mentions areas in which libgit2 functionality is
incomplete --- depending on your interest, you might want to focus on
one of these (so the project would be to add functionality to libgit2
as well as using it) or to steer clear of them (to focus on
functionality libgit2 already has).

So, to make a long story short: there is something sneaky about us
presenting this idea, since there is so much room for choice.  As your
project becomes more precise it should be possible for people on the
list to give more detailed advice.

Cc-ing the libgit2 list and Jeff King for more hints.

As for porting git to Android: that idea is less concrete to me.  A
native Android app would presumably be in Java, so most likely your
best bet is to talk to someone involved in the JGit project[1].

Another note.  Please feel free to venture beyond projects listed on
the ideas page.  For example the 2010 ideas page contains some gems:

 https://git.wiki.kernel.org/index.php/SoC2010Ideas#Several_small_proje=
cts_improving_msysGit

as does the 2008 page if you can get Nicolas Pitre on board :)

 https://git.wiki.kernel.org/index.php/SoC2008Ideas#Implement_pack_v4.2=
=46v5_for_higher_compression

Really, if you name any git-related topic you're interested in,
chances are we can come up together with something valuable and
interesting to work on in that area.

Lastly, as far as patches go: yes, it would be excellent (and it would
show initiative) to offer an experience of what it is like to work
with you (if you end up finding time for this).

Git may misbehave; or while getting up to speed on some aspect of its
behavior you may find some documentation confusing; or you may wonder,
"why is this code doing such a slow/unreliable/otherwise insane
thing?"  When the moment comes, look straight to
Documentation/SubmittingPatches and it will tell what to do. :)

Good luck with whatever project you decide,
Jonathan

[1] http://wiki.eclipse.org/Google_Summer_of_Code_2011_Ideas#Ideas_subm=
ission
http://eclipse.org/jgit/developers/

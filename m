From: "Scott Chacon" <schacon@gmail.com>
Subject: Re: git-scm.com (was Re: Git graph on GitHub)
Date: Wed, 15 Oct 2008 09:21:50 -0700
Message-ID: <d411cc4a0810150921j198fda93j60dae04c4cc9b9d1@mail.gmail.com>
References: <bab6a2ab0810150315l273d4ef3k95cda8f43a4745ca@mail.gmail.com>
	 <bab6a2ab0810150318pb616a6dj867efa36623ac12e@mail.gmail.com>
	 <20C9ABEC-52E5-405E-A755-C58A6359D7A9@wincent.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: "Wincent Colaiuta" <win@wincent.com>
X-From: git-owner@vger.kernel.org Wed Oct 15 18:23:07 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kq99N-0006Lz-18
	for gcvg-git-2@gmane.org; Wed, 15 Oct 2008 18:23:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751798AbYJOQVw convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 15 Oct 2008 12:21:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752480AbYJOQVw
	(ORCPT <rfc822;git-outgoing>); Wed, 15 Oct 2008 12:21:52 -0400
Received: from wa-out-1112.google.com ([209.85.146.177]:16033 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751054AbYJOQVv convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 15 Oct 2008 12:21:51 -0400
Received: by wa-out-1112.google.com with SMTP id v27so1539210wah.21
        for <git@vger.kernel.org>; Wed, 15 Oct 2008 09:21:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=qHxIGuV6d007AXv6q+xuWrNzZ4lyHMTr3Hw9nS9JKQ0=;
        b=e0ty8McKBFiRsPBtCD8vIjnhZnRRI2Us+IBAvDCd0qi9Sw7r6M43Czr2VNaJm8tCXg
         o39Kv8Yn0rn14IWoiTre8yBZrq4vz1FfTd1i9Hlol1HLb+BOZtXjyJ9JC3knGFaFw4Z/
         XqklX1DzGH9f+K//8SIjy4Zmxn4SibgSMBlj4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=txAuAQA1wJXdGW1sTnIk+U3Ioq3Yu/88shd35WKo32x+EzM73ItrnI2qiR1uOzR1/+
         JidZa0EpGiv2XYN4I00IVXpVZCPpi0I9uxM5Ll3N17xQrnFDurMI9krlZ+6fExeIepxv
         02H4CEX50VYtq+h9lSQlVcA0CYtYoaQT7k6UI=
Received: by 10.114.77.19 with SMTP id z19mr1042278waa.138.1224087710657;
        Wed, 15 Oct 2008 09:21:50 -0700 (PDT)
Received: by 10.114.135.18 with HTTP; Wed, 15 Oct 2008 09:21:50 -0700 (PDT)
In-Reply-To: <20C9ABEC-52E5-405E-A755-C58A6359D7A9@wincent.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/98284>

Hi,

On Wed, Oct 15, 2008 at 3:34 AM, Wincent Colaiuta <win@wincent.com> wro=
te:
> El 15/10/2008, a las 12:18, PJ Hyett escribi=F3:
>
>>> One nitpick regarding your git.git mirror: I doubt that people here
>>> ("the community") consider git-scm.com to be "the git homepage". I =
don't
>>> want to go into the reasons and start a pointless thread, but since
>>> git-scm.com is a fork of git.or.cz pointing to the latter (the root=
)
>>> should make everyone happy.

There is a slight misperception here.  I setup the git mirror at
GitHub as part of my git-scm.com work, they did not do it as some sort
of semi-official mirror.  The reason the git.git repo points to
git-scm is because I had plans to use github apis to do some fun stuff
on git-scm, and the mirror is being kept up to date by scripts on the
git-scm server.  Also, I figured it was likely that people looking at
the git repo on GitHub rather than on kernel.org would probably be
more interested in the more user-friendly version, yes?  That's all,
it's nothing sinister. Petr and I have previously discussed trying to
unify the sites somehow and will likely discuss this in more detail at
the GitTogether in a few weeks.

Also, trust me - none of us want Junio's job.  I've talked way too
much with Shawn over the last few weeks to ever covet that position :)

I do wish that there wasn't this 'us vs them' mentality on this list,
though. I think GitHub is doing some good things for the community,
and I also think that 'the community' is bigger than this list.  I
propose that we spend our cycles on git stuff, rather than mocking or
trying to exclude each other.

Also, I think we can all agree that Junio is strikingly handsome.

Scott

>>
>> Hi Michael,
>> I'll go ahead and start a pointless thread along with the reasons
>> provided via answers to the 2008 Git Survey[1]:
>
> Coming up in news at 6...
>
> GitHub announces new maintainer for Git
>
> GitHub is proud to announce the replacement of the old Git maintainer=
 with
> the "Git Core Team", comprising PJ Hyett, Scott Chacon, Tom Preston a=
nd some
> select personalities from the Ruby on Rails world. You'll be able to =
track
> all the latest updates to "Git Edge" over at GitHub. The former maint=
ainer,
> Junio C Hamano, is being retired from service because the Git communi=
ty (see
> git-scm.com) decided he wasn't as good-looking as David Heinemeier Ha=
nson.
> For more information, see the official Git book (book.git-scm.com).
>
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>

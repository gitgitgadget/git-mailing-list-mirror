From: Konstantin Khomoutov <kostix+git@007spb.ru>
Subject: Re: git lock files (Was: GIT for Microsoft Access projects)
Date: Tue, 9 Jun 2015 21:50:59 +0300
Message-ID: <20150609215059.dcbacca5d9fa3f7eb1683cb9@domain007.com>
References: <1433870383-7631-1-git-send-email-sbeller@google.com>
	<20150609132144.ANWJW.73271.root@txifep04>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Stefan Beller <sbeller@google.com>,
	kostix+git@007spb.ru, sitaramc@gmail.com
To: <hackerp@suddenlink.net>
X-From: git-owner@vger.kernel.org Tue Jun 09 20:51:15 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z2OcE-0001pB-Rr
	for gcvg-git-2@plane.gmane.org; Tue, 09 Jun 2015 20:51:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752335AbbFISvK convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 9 Jun 2015 14:51:10 -0400
Received: from mailhub.007spb.ru ([84.204.203.130]:45039 "EHLO
	mailhub.007spb.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753896AbbFISvJ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Jun 2015 14:51:09 -0400
Received: from tigra.domain007.com (tigra.domain007.com [192.168.2.102])
	by mailhub.007spb.ru (8.14.3/8.14.3/Debian-5+lenny1) with SMTP id t59IoxkN012972;
	Tue, 9 Jun 2015 21:51:00 +0300
In-Reply-To: <20150609132144.ANWJW.73271.root@txifep04>
X-Mailer: Sylpheed 3.2.0 (GTK+ 2.24.10; x86_64-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/271227>

On Tue, 9 Jun 2015 13:21:44 -0500
<hackerp@suddenlink.net> wrote:

> Thanks folks, I am digesting all you have said.
>=20
> Now the command line I can do (I'm a programmer) but the secretary
> here I doubt.
>=20
> So is there at GUI interface for this? Does it work on Windows
> systems?

That's why I asked whether the thing you do really want is a document
management system, not a version control system.

Yes, Git works on Windows thanks to folks behind the Git for Windows
project (often and errorneously called "msysGit" in the internets)
and yes there do exist mature Windows GUI front-ends to it, with
TortoiseGit and Git Extensions being supposedly the most visible picks.

But there's such thing as an irreducible complexity: while these tools
strive to be user-friendly, and TortoiseGit even tries to make you
think you're using Subversion rather than Git, they won't hide all the
underlying complexity of a DVCS tool, which Git is, from the user.

So... I bet for your random user, it would be much easier to switch to
the browser window and upload another version of their document there,
with a short note describing what they do and why.  This is how a
typical DMS works.  You won't get all that awesomness Git gives you to
fiddle with your source code files but in return you'll get a system
which requires next to zero training for any layman to use it.

Please rememeber about [1].  Many of the statements that post does are
outdated but its essense remains to be true when it comes to handing
off Git to users not possessing ninja-level computer skills.
I especially recommend to think through this particular passage:

| They often struggle to use version control at all; are you now going
| to teach them the difference between =E2=80=9Cpull=E2=80=9D and =E2=80=
=9Cupdate=E2=80=9D, between
| =E2=80=9Ccommit=E2=80=9D and =E2=80=9Cpush=E2=80=9D? Look me in the e=
yes and say that with a straight
| face.

I also wonder how do you intend to explain them why they can't push
because someone else had just did that, and what to do about this, and
why.  (And whose version should win, in the end, as the files you
intend to work with are not subject for merging in the usual sense of
this word -- when it comes to plain text files.)

1. http://blog.red-bean.com/sussman/?p=3D79

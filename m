From: Aaron Bentley <aaron.bentley@utoronto.ca>
Subject: Re: VCS comparison table
Date: Mon, 23 Oct 2006 13:18:30 -0400
Message-ID: <453CF966.7000308@utoronto.ca>
References: <45357CC3.4040507@utoronto.ca>	<200610222206.13973.jnareb@gmail.com>	<1161604564.22276.173.camel@zepto.home.zettazebra.com>	<200610231454.06355.jnareb@gmail.com> <a7e835d40610230801m4ac92409gbddcf66dcd1bb429@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Jakub Narebski <jnareb@gmail.com>, bazaar-ng@lists.canonical.com,
	"Matthew D. Fuller" <fullermd@over-yonder.net>,
	Linus Torvalds <torvalds@osdl.org>,
	Andreas Ericsson <ae@op5.se>, Carl Worth <cworth@cworth.org>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Oct 23 19:19:51 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Gc3S8-0002Dh-6I
	for gcvg-git@gmane.org; Mon, 23 Oct 2006 19:19:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932190AbWJWRSv (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 23 Oct 2006 13:18:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932192AbWJWRSv
	(ORCPT <rfc822;git-outgoing>); Mon, 23 Oct 2006 13:18:51 -0400
Received: from server4.panoramicfeedback.com ([66.216.124.41]:8663 "EHLO
	server4.panoramicfeedback.com") by vger.kernel.org with ESMTP
	id S932190AbWJWRSu (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Oct 2006 13:18:50 -0400
Received: from server4.panoramicfeedback.com ([66.216.124.41] helo=[192.168.2.19])
	by server4.panoramicfeedback.com with esmtp (Exim 3.36 #1 (Debian))
	id 1Gc3Rk-0007Kw-00; Mon, 23 Oct 2006 13:18:44 -0400
User-Agent: Debian Thunderbird 1.0.2 (X11/20060830)
X-Accept-Language: en-us, en
To: James Henstridge <james@jamesh.id.au>
In-Reply-To: <a7e835d40610230801m4ac92409gbddcf66dcd1bb429@mail.gmail.com>
X-Enigmail-Version: 0.91.0.0
X-Panometrics-MailScanner: Found to be clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/29848>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

James Henstridge wrote:
> Why do you continue to repeat this argument?  No one is claiming that
> a revision number by itself, as Bazaar uses them, is a global
> identifier.  In fact, we keep on saying that they only have meaning in
> the context of a branch.

And, unlike git, Bazaar branches are all independent entities[1], and
they each have a URL.

So:

http://code.aaronbentley.com/bzrrepo/bzr.ab 1695

is a name for

abentley@panoramicfeedback.com-20060927202832-9795d0528e311e31

And it does not depend on any other branch, especially not bzr.dev

Since:
1. anyone with write access to the urls can create them
2. anyone with read access to the urls can read them
3. the maintainers of the mainline have no control over them
   (except as provided by 1)

these identifiers are not centralized.

Aaron

[1] The fact that they may share storage is not important to the model.
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFFPPlm0F+nu1YWqI0RAlmLAJ9cpw5X7UXQ82EmoIeUrKzEaFbhdACfZPsS
CRJ69XWi7XAWJRi7Fgt9ICU=
=WrV9
-----END PGP SIGNATURE-----

From: luc.linux@mailoo.org
Subject: Re: What is missing from Git v2.0
Date: Thu, 24 Apr 2014 21:55:59 +0200
Message-ID: <20140424195559.GA1336@luc-arch>
References: <20140422213039.GB21043@thunk.org>
 <alpine.DEB.2.02.1404221523060.14881@nftneq.ynat.uz>
 <53588713347b7_59ed83d308cf@nysa.notmuch>
 <CAHYYfeHeJYZ67chSTQk2grsFGr07KXcVNR-T6kOPo0bVYDm59g@mail.gmail.com>
 <53588f448d817_59ed83d3084e@nysa.notmuch>
 <CAHYYfeFKW93GH+6-ssR5L_uoo3OL2-LFAsj-4+8uEmL0BhT3ow@mail.gmail.com>
 <5358bae8ab550_1f7b143d31037@nysa.notmuch>
 <877g6fb2h6.fsf@fencepost.gnu.org>
 <5358ca1a55a69_1f7b143d3101c@nysa.notmuch>
 <20140424134106.GA27035@thunk.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="EeQfGwPcQSOJBaQU"
Cc: Git Mailing List <git@vger.kernel.org>
To: Theodore Ts'o <tytso@mit.edu>
X-From: git-owner@vger.kernel.org Thu Apr 24 22:18:53 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WdQ6d-000265-54
	for gcvg-git-2@plane.gmane.org; Thu, 24 Apr 2014 22:18:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752037AbaDXUSr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 Apr 2014 16:18:47 -0400
Received: from arnold.mailoo.org ([212.83.147.198]:33090 "EHLO mailoo.org"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751177AbaDXUSq (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Apr 2014 16:18:46 -0400
X-Greylist: delayed 527 seconds by postgrey-1.27 at vger.kernel.org; Thu, 24 Apr 2014 16:18:46 EDT
Received: from localhost (localhost.localdomain [127.0.0.1])
	by arnold.mailoo.org (Postfix) with ESMTP id A35FB140;
	Thu, 24 Apr 2014 22:09:57 +0200 (CEST)
Received: from localhost (174.158.92.79.rev.sfr.net [79.92.158.174])
	by arnold.mailoo.org (Postfix) with ESMTPSA id 4DCF6102;
	Thu, 24 Apr 2014 22:09:57 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20140424134106.GA27035@thunk.org>
X-Info: Keep It Simple, Stupid.
User-Agent: Mutt/1.5.22.1-rc1 (2013-10-16)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/247006>


--EeQfGwPcQSOJBaQU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Apr 24, 2014 at 09:41:06AM -0400, Theodore Ts'o wrote:
> On Thu, Apr 24, 2014 at 03:23:54AM -0500, Felipe Contreras wrote:
> Creating a ~/.gitconfig file if one doesn't already is one I agree
> with, and at least on Unix systems, telling them that the config file
> lives in ~/.gitconfig, or where ever it might happen to be on other
> platforms, is a good one.  If it's in some really weird place on
> Windows, then sure, we can tell them about "git config -e".  But the
> point is to let the user look at the default .gitconfig file, where we
> can put in comments to help explain what is going on, and perhaps have
> links to web pages for more information.

I think the idea of a commented gitconfig is a good solution. We could
include default aliases commented, so that a new user would just have to
uncomment them. That way, he will understand they are aliases and not
commands, learn how to tune them to its own needs and it won't annoy
anyone because they will be commented by default, ideally with explicit
commentaries around them.

Furthermore, this could be a good way to show a new user all the
possibilities of git, or at least its configuration. Documentation is a
good thing when you know what you are looking for, but when you are
beginning, you don't know what can be done, and reading a complete and
commented example configuration could be a good way to discover it.


--EeQfGwPcQSOJBaQU
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQEcBAEBAgAGBQJTWWxPAAoJEIcYFL//CHl9v+oIAJYQ3T/eYzGvB34ZA3OYYD+5
Rf0OhW0HI6ZZP/kKImRj41hRj+pYtBlISflZmjNuReHVN8+k+HZoxcCjCHdMh9Pt
V19S5PVzNyjLhehxe8ilOMdDdx92HOWJ4ptQycq2TbKYf+2sE9UN9rCWU5+b7a7L
Ed8K8HrnR0BwPSFOSpbMNfEWfJCy8VUfgGyHMA8LsjZjqHTvPzdDLx1/+ETocfP8
1VdxOQ3LSUDEedqdLr6F/ABDiqCjldO1SwU7X6P6eAvNM5I3Cpoh/BqU2ybB1dEq
E9tfLMyyN4zRra8z7PCLox8NXHQkwO9HwHTuOumTAecYemX8YzSsYjm8w6KM0Hg=
=JZq8
-----END PGP SIGNATURE-----

--EeQfGwPcQSOJBaQU--

From: Karl =?iso-8859-1?Q?Hasselstr=F6m?= <kha@treskal.com>
Subject: Re: stg clean removes conflicting patch
Date: Fri, 25 Jan 2008 09:04:34 +0100
Message-ID: <20080125080434.GA5599@diana.vm.bytemark.co.uk>
References: <1201233317.2811.17.camel@dv>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Catalin Marinas <catalin.marinas@gmail.com>, git@vger.kernel.org
To: Pavel Roskin <proski@gnu.org>
X-From: git-owner@vger.kernel.org Fri Jan 25 09:07:14 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JIJac-0002JQ-8C
	for gcvg-git-2@gmane.org; Fri, 25 Jan 2008 09:07:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758866AbYAYIFO convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 25 Jan 2008 03:05:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760663AbYAYIFM
	(ORCPT <rfc822;git-outgoing>); Fri, 25 Jan 2008 03:05:12 -0500
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:3347 "EHLO
	diana.vm.bytemark.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1764447AbYAYIFI (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 Jan 2008 03:05:08 -0500
Received: from kha by diana.vm.bytemark.co.uk with local (Exim 3.36 #1 (Debian))
	id 1JIJYA-0001Sm-00; Fri, 25 Jan 2008 08:04:34 +0000
Content-Disposition: inline
In-Reply-To: <1201233317.2811.17.camel@dv>
X-Manual-Spam-Check: kha@treskal.com, clean
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/71685>

On 2008-01-24 22:55:17 -0500, Pavel Roskin wrote:

> If "stg push" fails, the subsequent "stg clean" will remove the
> patch that could not been applied. I think it's wrong.

I agree. It's consistent -- a conflicting patch is empty -- but
clearly the wrong thing to do from a usability perspective.

> I've made a patch for the testsuite that should pass once the bug is
> fixed. Try removing "stg clean" from the test. and it will pass. But
> "stg clean" should make no difference here.

Good!

=46or known-to-be-failing tests, you can use test_expect_failure. I'll
amend your patch to do that when I pick it up (if Catalin doesn't beat
me to it).

--=20
Karl Hasselstr=F6m, kha@treskal.com
      www.treskal.com/kalle

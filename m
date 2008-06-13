From: Karl =?iso-8859-1?Q?Hasselstr=F6m?= <kha@treskal.com>
Subject: Re: [StGit PATCH] compressed import v3
Date: Fri, 13 Jun 2008 07:11:27 +0200
Message-ID: <20080613051127.GA24245@diana.vm.bytemark.co.uk>
References: <48519602.2090103@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Catalin Marinas <catalin.marinas@gmail.com>, git@vger.kernel.org
To: Clark Williams <clark.williams@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jun 13 07:12:52 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K71al-0005ig-G2
	for gcvg-git-2@gmane.org; Fri, 13 Jun 2008 07:12:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752833AbYFMFLm convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 13 Jun 2008 01:11:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752683AbYFMFLm
	(ORCPT <rfc822;git-outgoing>); Fri, 13 Jun 2008 01:11:42 -0400
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:3101 "EHLO
	diana.vm.bytemark.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750798AbYFMFLl (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 Jun 2008 01:11:41 -0400
Received: from kha by diana.vm.bytemark.co.uk with local (Exim 3.36 #1 (Debian))
	id 1K71ZP-0006Km-00; Fri, 13 Jun 2008 06:11:27 +0100
Content-Disposition: inline
In-Reply-To: <48519602.2090103@gmail.com>
X-Manual-Spam-Check: kha@treskal.com, clean
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/84832>

On 2008-06-12 16:32:50 -0500, Clark Williams wrote:

> Attached is my latest stab at StGit importing patches from
> compressed files. This version doesn't try to differentiate by the
> file extension; it just tries to open gzip or bz2 files and if those
> fail it reverts to text.

Very good!

> I'm not completely happy with it, but I've spent about as much time
> on it as I can afford to (for this week anyway).

Heh. I see an opportunity for condensing the code a bit in
__gethandleandname(), and you intented the "pass"es funny, but I'll
take care of it (or not, seeing as they're kind of minor nits -- in
any case, I'll just take the patch off your hands and stop tormenting
you about it).

> Yeah, yeah, Karl, there are four new tests in t1800-import. Let me
> know if you think there should be more (more for compressed input
> that is; I'm not crazy enough to sign up to write more tests for
> *everything*). :)

No, this is exactly what I was aiming for.

Bleed 'em dry, but _no more_! ;-)

--=20
Karl Hasselstr=F6m, kha@treskal.com
      www.treskal.com/kalle

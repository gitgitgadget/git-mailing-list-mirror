From: Andreas Krey <a.krey@gmx.de>
Subject: Re: git's directory is _prepended_ to PATH when called with an absolute path
Date: Wed, 22 Apr 2015 07:47:37 +0200
Message-ID: <20150422054737.GA11889@inner.h.apk.li>
References: <5536C319.4000402@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: David =?iso-8859-1?Q?Rodr=EDguez?= <deivid.rodriguez@gmail.com>
X-From: git-owner@vger.kernel.org Wed Apr 22 08:15:15 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YknwG-0001uR-Ls
	for gcvg-git-2@plane.gmane.org; Wed, 22 Apr 2015 08:15:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756359AbbDVGPI convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 22 Apr 2015 02:15:08 -0400
Received: from continuum.iocl.org ([217.140.74.2]:57419 "EHLO
	continuum.iocl.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756031AbbDVGPH (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 Apr 2015 02:15:07 -0400
X-Greylist: delayed 1644 seconds by postgrey-1.27 at vger.kernel.org; Wed, 22 Apr 2015 02:15:06 EDT
Received: (from krey@localhost)
	by continuum.iocl.org (8.11.3/8.9.3) id t3M5lcM13536;
	Wed, 22 Apr 2015 07:47:38 +0200
Content-Disposition: inline
In-Reply-To: <5536C319.4000402@gmail.com>
User-Agent: Mutt/1.4.2.1i
X-message-flag: What did you expect to see here?
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/267579>

On Tue, 21 Apr 2015 18:37:29 +0000, David Rodr=EDguez wrote:
=2E..
> This causes issues with Ruby git hooks, because Ruby version managers=
=20
> rely on custom settings in PATH to select the Ruby executable,

Even if git wouldn't modify PATH this is still a broken way to do that.
What ruby to execute a hook with is a property of the hook, not of the
user context invoking it.

Andreas

--=20
"Totally trivial. Famous last words."
=46rom: Linus Torvalds <torvalds@*.org>
Date: Fri, 22 Jan 2010 07:29:21 -0800

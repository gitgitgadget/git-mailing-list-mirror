From: Andreas Krey <a.krey@gmx.de>
Subject: Re: git's directory is _prepended_ to PATH when called with an absolute path
Date: Wed, 22 Apr 2015 17:31:09 +0200
Message-ID: <20150422153109.GO23476@inner.h.apk.li>
References: <5536C319.4000402@gmail.com> <20150422054737.GA11889@inner.h.apk.li> <553787A0.40707@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: David =?iso-8859-1?Q?Rodr=EDguez?= <deivid.rodriguez@gmail.com>
X-From: git-owner@vger.kernel.org Wed Apr 22 17:31:19 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YkwcR-0000Zf-AS
	for gcvg-git-2@plane.gmane.org; Wed, 22 Apr 2015 17:31:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965695AbbDVPbO convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 22 Apr 2015 11:31:14 -0400
Received: from continuum.iocl.org ([217.140.74.2]:57851 "EHLO
	continuum.iocl.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965612AbbDVPbO (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 Apr 2015 11:31:14 -0400
Received: (from krey@localhost)
	by continuum.iocl.org (8.11.3/8.9.3) id t3MFVA632214;
	Wed, 22 Apr 2015 17:31:10 +0200
Content-Disposition: inline
In-Reply-To: <553787A0.40707@gmail.com>
User-Agent: Mutt/1.4.2.1i
X-message-flag: What did you expect to see here?
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/267595>

On Wed, 22 Apr 2015 08:36:00 +0000, David Rodr=EDguez wrote:
=2E..
> * User is relying on a custom path to select their Ruby version. For=20
> example, let's say the first folder in path is "~/.rubies/2.2.2/bin".
> * User runs "/usr/bin/git commit" and a pre-commit hook is triggered.
> * The pre-commit hook starts with "#!/us/bin/env ruby" to select the=20
> Ruby to be used in the hook,

Yes...but shouldn't the hook itself know which ruby version it needs?

After all, if I go into that directory with another ruby setup in my
PATH, the hook should still work, and presumably that requires that
the hook itself selects its version, and not the user's context.

Andreas

--=20
"Totally trivial. Famous last words."
=46rom: Linus Torvalds <torvalds@*.org>
Date: Fri, 22 Jan 2010 07:29:21 -0800

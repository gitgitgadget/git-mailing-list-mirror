From: Pavel Roskin <proski@gnu.org>
Subject: Re: Importing Mozilla CVS into git
Date: Wed, 07 Jun 2006 11:21:28 -0400
Message-ID: <1149693688.3415.6.camel@dv>
References: <9e4733910606011521n106f8f24s6c7053ce51e3791e@mail.gmail.com>
	 <1149214075.5521.31.camel@neko.keithp.com>
	 <9e4733910606011936i725e8eb2h8c2357f3688da43e@mail.gmail.com>
	 <1149219593.5521.34.camel@neko.keithp.com>
	 <9e4733910606012047h727a25f1vb367c880f8933c4e@mail.gmail.com>
	 <1149220518.5521.43.camel@neko.keithp.com>
	 <9e4733910606012100s7ace4721le6fbfbcaadfb6c43@mail.gmail.com>
	 <20060602041107.GA5429@spearce.org> <1149223164.2443.33.camel@dv>
	 <9e4733910606012144p5f4fda26sdc2de2cc77b71fe7@mail.gmail.com>
	 <df0b33100606070202w581ff581i435056f0fbc197f8@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: Jon Smirl <jonsmirl@gmail.com>, Shawn Pearce <spearce@spearce.org>,
	Keith Packard <keithp@keithp.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jun 07 17:22:00 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fnzqq-0000og-8d
	for gcvg-git@gmane.org; Wed, 07 Jun 2006 17:21:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932257AbWFGPVl (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 7 Jun 2006 11:21:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932259AbWFGPVl
	(ORCPT <rfc822;git-outgoing>); Wed, 7 Jun 2006 11:21:41 -0400
Received: from fencepost.gnu.org ([199.232.76.164]:48607 "EHLO
	fencepost.gnu.org") by vger.kernel.org with ESMTP id S932257AbWFGPVk
	(ORCPT <rfc822;git@vger.kernel.org>); Wed, 7 Jun 2006 11:21:40 -0400
Received: from proski by fencepost.gnu.org with local (Exim 4.34)
	id 1Fnzql-00019s-68
	for git@vger.kernel.org; Wed, 07 Jun 2006 11:21:39 -0400
Received: from proski by dv.roinet.com with local (Exim 4.62)
	(envelope-from <proski@dv.roinet.com>)
	id 1Fnzqa-0002Bg-LE; Wed, 07 Jun 2006 11:21:28 -0400
To: Igor Bukanov <igor.bukanov@gmail.com>
In-Reply-To: <df0b33100606070202w581ff581i435056f0fbc197f8@mail.gmail.com>
X-Mailer: Evolution 2.7.2.1 (2.7.2.1-4) 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/21437>

On Wed, 2006-06-07 at 11:02 +0200, Igor Bukanov wrote:
> On 6/2/06, Jon Smirl <jonsmirl@gmail.com> wrote:
> > On 6/2/06, Pavel Roskin <proski@gnu.org> wrote:
> > > Dependency on Cygwin, Perl and Python is too much.  Windows is becoming
> > > a legacy system in some circles, and it may run on legacy hardware.  Yet
> > > it's irreplaceable as a testing platform for many projects.
> >
> > 80% of Mozilla commiters are running Windows. Some are OS bilingual
> > but many are not.
> 
> Mozilla build system on Windows requires Cygwin and there are 198 Perl
> files in Firefox tree. So it is only Python that can be problematic.

Then maybe the existing 3 python files in git (I'm not counting
compat/subprocess.py) could be converted to Perl?  Perl would be great
as the "common denominator" for interpreted languages.

Search for "python to perl" translator lead me to Perthon:
http://perthon.sourceforge.net/

But Perthon needs work.  My attempt to run it on git-p4import.py failed:

$ perl -I `pwd`/lib perthon.pl git-p4import.py 
Can't coerce array into hash at lib/Perthon/PerthonImpl.pm line 15420.

It may be a fun project for somebody who wants to learn Perl and Python.

-- 
Regards,
Pavel Roskin

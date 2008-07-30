From: "H.Merijn Brand" <h.m.brand@xs4all.nl>
Subject: Re: Feature suggestion: git-hist
Date: Wed, 30 Jul 2008 17:03:26 +0200
Message-ID: <20080730170326.6f4f1772@pc09.procura.nl>
References: <20080730133859.368bbd92@pc09.procura.nl>
	<20080730133334.GB31192@lars.home.noschinski.de>
	<20080730155835.71289eee@pc09.procura.nl>
	<20080730145534.GD32057@genesis.frugalware.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: Lars Noschinski <lars-2008-1@usenet.noschinski.de>,
	git@vger.kernel.org
To: Miklos Vajna <vmiklos@frugalware.org>
X-From: git-owner@vger.kernel.org Wed Jul 30 17:05:52 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KODEL-0002VR-EN
	for gcvg-git-2@gmane.org; Wed, 30 Jul 2008 17:04:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753535AbYG3PDp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Jul 2008 11:03:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753308AbYG3PDo
	(ORCPT <rfc822;git-outgoing>); Wed, 30 Jul 2008 11:03:44 -0400
Received: from smtp-vbr4.xs4all.nl ([194.109.24.24]:2374 "EHLO
	smtp-vbr4.xs4all.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752754AbYG3PDo (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Jul 2008 11:03:44 -0400
Received: from pc09.procura.nl (procura.xs4all.nl [82.95.216.29])
	(authenticated bits=0)
	by smtp-vbr4.xs4all.nl (8.13.8/8.13.8) with ESMTP id m6UF3QH0045072
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Wed, 30 Jul 2008 17:03:31 +0200 (CEST)
	(envelope-from h.m.brand@xs4all.nl)
In-Reply-To: <20080730145534.GD32057@genesis.frugalware.org>
X-Mailer: Claws Mail 3.5.0cvs35 (GTK+ 2.12.0; x86_64-unknown-linux-gnu)
Face: iVBORw0KGgoAAAANSUhEUgAAADAAAAAwEAIAAACI8LKTAAAACXBIWXMAAABIAAAASABGyWs+AAAC
 JElEQVRo3u2aMY4CMQxFczZ6RItEzRm4DBINDbRUSPRInIRbsNK6+dJfezN4kokn48IaCSjysL8d
 e9Knoj2fr9f9/gllqQ6U9/vxWK3EdwdIEGjRIVCu18NhuxUfK46SH81+fzrdbuKPx/P5ctHQdAdI
 TKAgpvV6s9ntBEfXEYSGgMQzIHnuFBBjkshCNJ2KtJZ04hHNAugP8bZr3NIHhbcF0AKoK0CoaHXU
 LUWBIs1n+jV+Fl8CVqOApEXAwyMO/DSR4XVntoAYDR7eBjQupuYAYTMph8Rj21D4m7MChN02tpqs
 NSnb/KqU2oHCXu5xDCgflj/RAgBiKBIXnICzAsSjWBsTz5K4/HeXYvb8yK5lY3VGEwPi2aONKT+5
 AlcxrTPOwcTiraGRChgMEKJh0bVVifGVTq6qgBiNVl8QE29EsK6VE+YJAOG2wz5AvsqUS6uqgHCA
 n4NGvBYpnJ64Jgg27sCtxtBk1CJIA4S/GhdWKh07QxUB48jWGhZ4jKamRRr/T8/M0AaEyctry6YB
 4dTGj9iWZNs3DahES5kPCJOu0RQbF/fQOBprsB9gaO9JtPDzII9U5ySXX7AnuIt91y54AAW7rPpT
 LCe5gt3F+CLqr2UarGB3MXvMylWGq4+9RCx3TW1oJq1t3HPQlFs6N1fFNEB4s8dn7Ne7ACSm7TPQ
 I5quAWmw6qBpulHM33B0Csge4Nd8JTTYG2b1XyRe3lH8x34ABJ6aePuQ2N4AAAAASUVORK5CYII=
X-Virus-Scanned: by XS4ALL Virus Scanner
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/90801>

On Wed, 30 Jul 2008 16:55:34 +0200, Miklos Vajna
<vmiklos@frugalware.org> wrote:

> On Wed, Jul 30, 2008 at 03:58:35PM +0200, "H.Merijn Brand" <h.m.brand@xs4all.nl> wrote:
> > We are not used to working with $SHA's, and IMHO from the end-user pov,
> > a $SHA is less user friendly than a release number or a file version. I
> > can remember a version, but I cannot remember a SHA.
> 
> But a version is never unique in a distributed environment. So a version
> is useless without at least an abbreviated hash.

Which is exactly what my git-hist does:

# git-hist *pm | perl -ne'63..83 and print'
09d4472 2007-12-06 13:25:58                         63:     allow_loose_quotes  => 0,
09d4472 2007-12-06 13:25:58                         64:     allow_loose_escapes => 0,
09d4472 2007-12-06 13:25:58                         65:     allow_whitespace    => 0,
caf4798 2008-02-19 17:56:36 0.34          + 004     66:     blank_is_undef      => 0,
09d4472 2007-12-06 13:25:58                         67:     verbatim            => 0,
09d4472 2007-12-06 13:25:58                         68:     types               => undef,
09d4472 2007-12-06 13:25:58                         69:
8648db0 2008-03-27 18:37:54 0.37          + 002     70:
09d4472 2007-12-06 13:25:58                         71:     _EOF                => 0,
09d4472 2007-12-06 13:25:58                         72:     _STATUS             => undef,
09d4472 2007-12-06 13:25:58                         73:     _FIELDS             => undef,
09d4472 2007-12-06 13:25:58                         74:     _FFLAGS             => undef,
09d4472 2007-12-06 13:25:58                         75:     _STRING             => undef,
09d4472 2007-12-06 13:25:58                         76:     _ERROR_INPUT        => undef,
2b95026 2008-04-04 11:10:09 0.37          + 006     77:     _COLUMN_NAMES       => undef,
ce53d02 2008-04-06 00:40:26 0.37          + 016     78:     _BOUND_COLUMNS      => undef,
09d4472 2007-12-06 13:25:58                         79:     );
caf4798 2008-02-19 17:56:36 0.34          + 004     80: my $last_new_err = "";
09d4472 2007-12-06 13:25:58                         81:
09d4472 2007-12-06 13:25:58                         82: sub new
09d4472 2007-12-06 13:25:58                         83: {

> If pure hashes are not friendly enough, you can use something like:
> 
> git describe $(git rev-list -1 HEAD -- <file>)

What do I miss here?

> git describe $(git rev-list -1 HEAD -- *pm)
fatal: cannot describe 'c2220c8a544af5cd5419e238eb5f43b1f079ad85'

> to get the _hash_ of the _commit_ (ie. not the version of a file) that
> touched the file last time.

My git-hist is just a perl script that collects the combined
information of

	git-log --pretty=format:'%h %ct %s'
	git-show-ref --tags
and	git-blame file

I could also make it a reformatting wrapper over several calls to

	git blame -l file | git name-rev --stdin --tags

Which is probably faster for a single file, but slower on multiple files

-- 
H.Merijn Brand          Amsterdam Perl Mongers  http://amsterdam.pm.org/
using & porting perl 5.6.2, 5.8.x, 5.10.x, 5.11.x on HP-UX 10.20, 11.00,
11.11, 11.23, and 11.31, SuSE 10.1, 10.2, and 10.3, AIX 5.2, and Cygwin.
http://mirrors.develooper.com/hpux/           http://www.test-smoke.org/
http://qa.perl.org      http://www.goldmark.org/jeff/stupid-disclaimers/

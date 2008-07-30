From: "H.Merijn Brand" <h.m.brand@xs4all.nl>
Subject: Feature suggestion: git-hist
Date: Wed, 30 Jul 2008 13:38:59 +0200
Message-ID: <20080730133859.368bbd92@pc09.procura.nl>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="MP_/IX+N_67o_1RJnC7qG92e6F0"
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jul 30 13:53:02 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KOAES-0006GL-UI
	for gcvg-git-2@gmane.org; Wed, 30 Jul 2008 13:52:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752756AbYG3Lvk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Jul 2008 07:51:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752775AbYG3Lvk
	(ORCPT <rfc822;git-outgoing>); Wed, 30 Jul 2008 07:51:40 -0400
Received: from smtp-vbr4.xs4all.nl ([194.109.24.24]:4527 "EHLO
	smtp-vbr4.xs4all.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752756AbYG3Lvj (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Jul 2008 07:51:39 -0400
X-Greylist: delayed 758 seconds by postgrey-1.27 at vger.kernel.org; Wed, 30 Jul 2008 07:51:38 EDT
Received: from pc09.procura.nl (procura.xs4all.nl [82.95.216.29])
	(authenticated bits=0)
	by smtp-vbr4.xs4all.nl (8.13.8/8.13.8) with ESMTP id m6UBcx8r032980
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <git@vger.kernel.org>; Wed, 30 Jul 2008 13:38:59 +0200 (CEST)
	(envelope-from h.m.brand@xs4all.nl)
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/90766>

--MP_/IX+N_67o_1RJnC7qG92e6F0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

I've talked about this with Arjen, and he suggested to put it here.
Please Cc me too, as I have little time to follow this quite busy list.

Suggestion

	Add a new command: 'git-hist' that will show a blame log of a
	single file with each line `tagged' with the most recent tag
	plus the number of changes since that tag.

Relationale.

	Coming from SCCS, each file `keeps' a version in a keyword like
	%R%.%L% which is included in the file when a release is made.
	The unix command 'what' will show all SCCS id's when used on a
	object, like

	% what probev | head -10
	probev:
		$Revision: 92453-07 linker linker crt0.o B.11.60 070209$
		probev.ic       5.27    [07/11/14]
		Make info: HP-UX B.11.00 9000/800; 14 Jul 2008, 14:52; v04.3.6.04:v82BC anrs.ic 5.5     [07/04/10]
		arsmon.ic       5.19    [08/07/09]
		controle.ic     5.40    [2008-03-18]
		goedmut.ic      5.19    [07/05/16]
		gvh.ic  5.8     [06/06/13]
		inw.ic  5.8     [06/06/12]

	All software has bugs, so has ours, and we ship updates, just as
	git makes updates available to the world. I just updated to the
	most recent 1.5.6.4.

	We make our updates available to our customers, but they
	sometimes wait weeks or months to install the updates, but still
	complain about bugs that already have been fixed and for which
	they already received an update.

	I can ask them what version they have, and I can then check if
	the complaint was already addressed in an update that was
	already released. In SCCS this was easy: they tell me the output
	of the what command, I check if the bug was fixed in a newer
	version and the answer is present. No such luck in git, as the
	stamps are (non-sequitive) SHA id's. As we moved to git, we now
	have to update those id's by hand, as the customers are used to
	it. (At least we can now use readable date formats)

Implementation

	Attached is my perl script git-hist, which is how I currently
	use it, which will show the blame log of a file, with each line
	prefixed with the tag plus changes since. So I can tell that if
	the customer runs release version 0.34, the line in question has
	been added before or after.

	* Tag all releases with a version number like 5.10.0 or
5.10.1-RC2
          (give or take the annoying quircks that git refuses some characters
           in tag names, which changed without warning in the 1.5.x track so
           I had to manually rename all my 'v 0.53' tags to loose the space)
        * Count changes since last tag

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

	Or for a perl file

# git-hist xsutils.c | perl -ne'30..50 and print'
02ca0a6 2005-04-21 17:38:30 perl-5.9.2    + 104     30: PERL_XS_EXPORT_C void XS_attributes_bootstrap(pTHX_ CV *cv);
d66c5aa 1999-09-07 19:25:07 perl-5.005    + 1988    31:
d66c5aa 1999-09-07 19:25:07 perl-5.005    + 1988    32:
d66c5aa 1999-09-07 19:25:07 perl-5.005    + 1988    33: /*
d66c5aa 1999-09-07 19:25:07 perl-5.005    + 1988    34:  * Note that only ${pkg}::bootstrap definitions should go here.
d66c5aa 1999-09-07 19:25:07 perl-5.005    + 1988    35:  * This helps keep down the start-up time, which is especially
d66c5aa 1999-09-07 19:25:07 perl-5.005    + 1988    36:  * relevant for users who don't invoke any features which are
d66c5aa 1999-09-07 19:25:07 perl-5.005    + 1988    37:  * (partially) implemented here.
d66c5aa 1999-09-07 19:25:07 perl-5.005    + 1988    38:  *
d66c5aa 1999-09-07 19:25:07 perl-5.005    + 1988    39:  * The various bootstrap definitions can take care of doing
d66c5aa 1999-09-07 19:25:07 perl-5.005    + 1988    40:  * package-specific newXS() calls.  Since the layout of the
2136f35 2000-02-04 05:58:57 perl-5.005    + 2832    41:  * bundled *.pm files is in a version-specific directory,
d66c5aa 1999-09-07 19:25:07 perl-5.005    + 1988    42:  * version checks in these bootstrap calls are optional.
d66c5aa 1999-09-07 19:25:07 perl-5.005    + 1988    43:  */
d66c5aa 1999-09-07 19:25:07 perl-5.005    + 1988    44:
02d011f 2006-05-02 19:46:38 perl-5.9.3    + 950     45: static const char file[] = __FILE__;
02d011f 2006-05-02 19:46:38 perl-5.9.3    + 950     46:
d66c5aa 1999-09-07 19:25:07 perl-5.005    + 1988    47: void
d66c5aa 1999-09-07 19:25:07 perl-5.005    + 1988    48: Perl_boot_core_xsutils(pTHX)
d66c5aa 1999-09-07 19:25:07 perl-5.005    + 1988    49: {
d66c5aa 1999-09-07 19:25:07 perl-5.005    + 1988    50:     newXS("attributes::bootstrap",      XS_attributes_bootstrap,        file);


-- 
H.Merijn Brand          Amsterdam Perl Mongers  http://amsterdam.pm.org/
using & porting perl 5.6.2, 5.8.x, 5.10.x, 5.11.x on HP-UX 10.20, 11.00,
11.11, 11.23, and 11.31, SuSE 10.1, 10.2, and 10.3, AIX 5.2, and Cygwin.
http://mirrors.develooper.com/hpux/           http://www.test-smoke.org/
http://qa.perl.org      http://www.goldmark.org/jeff/stupid-disclaimers/

--MP_/IX+N_67o_1RJnC7qG92e6F0
Content-Type: application/octet-stream; name=git-hist
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename=git-hist

IyEvcHJvL2Jpbi9wZXJsCgojIGdpdC1oaXN0IGZpbGUgLi4uCiMgKGMpIDIwMDggSC5NZXJpam4g
QnJhbmQgZm9yIFBST0NVUkEgQi5WLgoKdXNlIHN0cmljdDsKdXNlIHdhcm5pbmdzOwoKc3ViIHBy
X3RpbWUKewogICAgbXkgQGQgPSBAXzsKICAgIHNwcmludGYgIiU0ZC0lMDJkLSUwMmQgJTAyZDol
MDJkOiUwMmQiLCAxOTAwICsgJGRbNV0sICsrJGRbNF0sIEBkWzMsMiwxLDBdOwogICAgfSAjIHBy
X3RpbWUKCm15IEBoc2g7Cm15ICVsb2c7CnsgICBsb2NhbCBAQVJHViA9ICgiZ2l0LWxvZyAtLXBy
ZXR0eT1mb3JtYXQ6JyVoICVjdCAlcycgfCIpOwogICAgd2hpbGUgKDw+KSB7CglteSAoJGhzaCwg
JHRpbWUsICR0ZXh0KSA9IChtL14oXFMrKVxzKyhbMC05XSspXHMrKC4qKS8pOwoJcHVzaCBAaHNo
LCAkaHNoOwoJJGxvZ3skaHNofSA9IFsgIiIsICR0ZXh0LCBwcl90aW1lIGxvY2FsdGltZSAkdGlt
ZSBdOwoJfQogICAgfQoKeyAgIGxvY2FsIEBBUkdWID0gKCJnaXQtc2hvdy1yZWYgLS10YWdzIHwi
KTsKICAgIHdoaWxlICg8PikgewoJbXsoXFN7N30pLiovKC4qKX0gb3IgbmV4dDsKCSRsb2d7JDF9
WzBdID0gJDI7Cgl9CiAgICB9Cgp7ICAgbXkgJHRhZyA9ICIiOwogICAgbXkgJGluYzsKICAgIGZv
cmVhY2ggbXkgJGhzaCAocmV2ZXJzZSBAaHNoKSB7CglpZiAoJGxvZ3skaHNofVswXSkgewoJICAg
ICR0YWcgPSAkbG9neyRoc2h9WzBdOwoJICAgICRpbmMgPSAiMDAxIjsKCSAgICB9CgllbHNpZiAo
JHRhZykgewoJICAgICRsb2d7JGhzaH1bMF0gPSBzcHJpbnRmICIlLTEzcyArICVzIiwgJHRhZywg
JGluYysrOwoJICAgIH0KCX0KICAgIH0KCmZvcmVhY2ggbXkgJGZpbGUgKEBBUkdWKSB7CiAgICBv
cGVuIG15ICRibGFtZSwgIi18IiwgImdpdC1ibGFtZSAkZmlsZSIgb3IgbmV4dDsKICAgIHdoaWxl
ICg8JGJsYW1lPikgewoJbXkgKCRoc2gsICRsbnIsICR0eHQpID0KCSAgICBtL15cXj8oWzAtOWEt
Zl17N30pLio/XHMrKFswLTldKylcKSguKikvIG9yIG5leHQ7CglwcmludGYgIiUuN3MgJXMgJS0y
MHMgJTVkOiVzXG4iLAoJICAgICRoc2gsICRsb2d7JGhzaH1bMl0sICRsb2d7JGhzaH1bMF0sICRs
bnIsICR0eHQ7Cgl9CiAgICB9Cg==

--MP_/IX+N_67o_1RJnC7qG92e6F0--

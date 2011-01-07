From: "Robin H. Johnson" <robbat2@gentoo.org>
Subject: Re: [PATCH] git-cvs*: Make building (and testing) of CVS interface
 scripts optionally selectable
Date: Fri, 7 Jan 2011 22:53:53 +0000
Message-ID: <robbat2-20110107T225218-562776173Z@orbis-terrarum.net>
References: <1294433290-9262-1-git-send-email-robbat2@gentoo.org>
 <7v39p45pyw.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Robin H. Johnson" <robbat2@gentoo.org>, git@vger.kernel.org,
	=?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jan 07 23:54:04 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PbLC5-0000Sf-Ig
	for gcvg-git-2@lo.gmane.org; Fri, 07 Jan 2011 23:54:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754017Ab1AGWx4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 7 Jan 2011 17:53:56 -0500
Received: from mail.isohunt.com ([208.95.172.20]:49802 "EHLO mail.as30085.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753137Ab1AGWx4 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Jan 2011 17:53:56 -0500
Received: (qmail 21056 invoked from network); 7 Jan 2011 22:53:54 -0000
Received: from tsi-static.orbis-terrarum.net (HELO grubbs.orbis-terrarum.net) (76.10.188.108)
    by mail.as30085.net (qpsmtpd/0.33-dev on beta01) with (AES256-SHA encrypted) ESMTPS; Fri, 07 Jan 2011 22:53:54 +0000
Received: (qmail 11158 invoked by uid 10000); 7 Jan 2011 22:53:53 -0000
Content-Disposition: inline
In-Reply-To: <7v39p45pyw.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/164780>

On Fri, Jan 07, 2011 at 02:05:59PM -0800, Junio C Hamano wrote:
> > Presently, the CVS interface scripts are always built, and their
> > test-suites run based on a binary named 'cvs' happening to return zero.
> > If there something other than the real CVS there, bad things happened
> > during the test-suite run.
> It makes sense to let people whose system happens to have a working cvs to
> omit cvs interoperability bits when they know the do not want them, and
> that alone would be a good enough motivation.
Ok, i'll respin to a different explanation.

> While the patch looks good, some people seem to prefer skipping individual
> tests without shortcut; see 900eab4 (t/t9600-cvsimport.sh: change from
> skip_all=* to prereq skip, 2010-08-13) for example.  I am slightly in
> favor of the short-cut as I haven't heard convincing argument against it
> other than "skipped statistics" which I don't think is interesting nor
> accurate anyway.
I did it this was because of your prior comment on my perl prereq patch
for the send-email tests.

> I wonder if "check PERL and CVS prerequisite and say test_done" should be
> made into a helper in lib-cvs.sh or somewhere instead of repeating them in
> individual tests, but that is a minor point.
I'll see if I can respin to do this.

-- 
Robin Hugh Johnson
Gentoo Linux: Developer, Trustee & Infrastructure Lead
E-Mail     : robbat2@gentoo.org
GnuPG FP   : 11AC BA4F 4778 E3F6 E4ED  F38E B27B 944E 3488 4E85

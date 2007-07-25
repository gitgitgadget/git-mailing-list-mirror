From: "Medve Emilian-EMMEDVE1" <Emilian.Medve@freescale.com>
Subject: RE:  Re: Windows support
Date: Wed, 25 Jul 2007 12:04:56 -0700
Message-ID: <598D5675D34BE349929AF5EDE9B03E27012EDD12@az33exm24.fsl.freescale.net>
References: <a1bbc6950707250335m3d37d4farceffc50945e31f6c@mail.gmail.com>  <693D0FFF-B271-4781-BCE2-3BF00C8BF426@zib.de> <316a20a40707250958w1fe9f6fdn41d75ca704aeb9cd@mail.gmail.com> A<loom.20070725T195200-46@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 8BIT
To: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Jul 25 21:05:54 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IDmAY-0001Us-1i
	for gcvg-git@gmane.org; Wed, 25 Jul 2007 21:05:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753763AbXGYTFE (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 25 Jul 2007 15:05:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753453AbXGYTFE
	(ORCPT <rfc822;git-outgoing>); Wed, 25 Jul 2007 15:05:04 -0400
Received: from de01egw02.freescale.net ([192.88.165.103]:54861 "EHLO
	de01egw02.freescale.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753117AbXGYTFB convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 25 Jul 2007 15:05:01 -0400
Received: from de01smr02.am.mot.com (de01smr02.freescale.net [10.208.0.151])
	by de01egw02.freescale.net (8.12.11/de01egw02) with ESMTP id l6PJ4wCm021004
	for <git@vger.kernel.org>; Wed, 25 Jul 2007 12:04:58 -0700 (MST)
Received: from az33exm24.fsl.freescale.net (az33exm24.am.freescale.net [10.64.32.14])
	by de01smr02.am.mot.com (8.13.1/8.13.0) with ESMTP id l6PJ4vbn027797
	for <git@vger.kernel.org>; Wed, 25 Jul 2007 14:04:57 -0500 (CDT)
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
In-Reply-To: A<loom.20070725T195200-46@post.gmane.org>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Re: Windows support
Thread-Index: AcfO5fOPYX2EsgVcRkOQaheO+8hY4QACGGQA
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/53706>

Hi Russ,


Try playing with the core.autocrlf config option.


Cheers,
Emil.


This e-mail, and any associated attachments have been classified as:
--------------------------------------------------------------------
[x] Public
[ ] Freescale Semiconductor Internal Use Only
[ ] Freescale Semiconductor Confidential Proprietary


-----Original Message-----
From: git-owner@vger.kernel.org [mailto:git-owner@vger.kernel.org] On
Behalf Of Russ Dill
Sent: Wednesday, July 25, 2007 12:56 PM
To: git@vger.kernel.org
Subject: Re: Windows support

Stephen Cuppett <cuppett <at> gmail.com> writes:

> I actually have no problems with cygwin and find it works pretty well
> with git repositories.  Starting the xserver to run git-gui is pretty
> annoying though.  Windows-based development teams are going to expect
> easy access to those kinds of tooling.  Otherwise, the champion will
> be pushing a type of workflow change that would hinder adoption anyway
> and leave a sour taste for a long time.

I have the version of git that came with cygwin, and I never have to run
an X
server to run git-gui or gitk.

Personally, I can't imagine running git without cygwin. Course, I want
my
desktop to feel as much like unix as possible. My experience with git
under
cygwin has been excellent. My only gripe has to do with CRLF. The
repository has
everything checked in with dos line endings, I'd like to check
everything out
with unix line endings, and then check it back in with dos line endings.
I hate
seeing the ^M's everywhere.

> In addition, performance is atrocious.  In my particular case I have
> an older P4 running F7 and a newer machine running Windows and cygwin.
>  On a pserver based cvsimport of a large, enterprise project, Linux
> was able to generate the full history in 4 hours, cygwin took 3 and a
> half days.  When I sync up every now and then, typical times for
> windows are 25 minutes and Linux is around 4.  That should give you an
> idea of what kind of multiplier we are talking about.

Granted, the performance isn't equal to git running on a real unix, but
compared
to working with SVN under win32, I would say it performs quite well.




From: Julian Phillips <julian@quantumfyre.co.uk>
Subject: Re: typo in http://www.kernel.org/pub/software/scm/git/docs/git-checkout.html
Date: Mon, 6 Aug 2007 15:26:00 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0708061520490.29052@reaper.quantumfyre.co.uk>
References: <46B72A8E.3040602@gmx.de>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="-1463811584-608730407-1186410360=:29052"
Cc: git@vger.kernel.org
To: =?ISO-8859-1?Q?Toralf_F=F6rster?= <toralf.foerster@gmx.de>
X-From: git-owner@vger.kernel.org Mon Aug 06 16:26:12 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1II3X8-0005Kb-Kh
	for gcvg-git@gmane.org; Mon, 06 Aug 2007 16:26:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762531AbXHFO0G (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 6 Aug 2007 10:26:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755393AbXHFO0E
	(ORCPT <rfc822;git-outgoing>); Mon, 6 Aug 2007 10:26:04 -0400
Received: from electron.quantumfyre.co.uk ([87.106.55.16]:53238 "EHLO
	electron.quantumfyre.co.uk" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755519AbXHFO0D (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 6 Aug 2007 10:26:03 -0400
Received: from neutron.quantumfyre.co.uk (neutron.datavampyre.co.uk [212.159.54.235])
	by electron.quantumfyre.co.uk (Postfix) with ESMTP id C809EB8D88
	for <git@vger.kernel.org>; Mon,  6 Aug 2007 15:26:00 +0100 (BST)
Received: (qmail 29753 invoked by uid 103); 6 Aug 2007 15:26:00 +0100
Received: from 192.168.0.2 by neutron.quantumfyre.co.uk (envelope-from <julian@quantumfyre.co.uk>, uid 201) with qmail-scanner-1.25st 
 (clamdscan: 0.91/3869. spamassassin: 3.2.1. perlscan: 1.25st.  
 Clear:RC:1(192.168.0.2):. 
 Processed in 0.034397 secs); 06 Aug 2007 14:26:00 -0000
Received: from reaper.quantumfyre.co.uk (192.168.0.2)
  by neutron.datavampyre.co.uk with SMTP; 6 Aug 2007 15:26:00 +0100
X-X-Sender: jp3@reaper.quantumfyre.co.uk
In-Reply-To: <46B72A8E.3040602@gmx.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/55151>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

---1463811584-608730407-1186410360=:29052
Content-Type: TEXT/PLAIN; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Mon, 6 Aug 2007, Toralf F=F6rster wrote:

> Hello,
>
> shouldn't " at the tip of one of your branches" better written as " at th=
e=20
> top of one of your branches".
>
> BTW one question: I run a simple test unit (only build tests) against the=
=20
> latest git tree, which is updated with "git pull" once a day.
>
> If I want to make some tests with a previous kernel version - say v2.6.20=
 and=20
> switch then back to HEAD to continue with my common test suite, would the=
=20
> following be ok : ?
>
> $> git checkout v2.6.20

This will change HEAD to be a detached checkout of v2.6.20

> $> <do something useful with it>
> $> git reset

This will not change HEAD back.

something like this perhaps?

$> MY_HEAD=3D$(git symbolic-ref HEAD)
$> git checkout v2.6.20
$> <...>
$> git reset --hard $MY_HEAD

no doubt there is a more cunning method ...

--=20
Julian

  ---
<SpanKY> hmm, blade iii comes out the 8th
<SpanKY> we could catch a flick and have anal sex in the back
<jforman> holy jesus, /me cancels his plans
---1463811584-608730407-1186410360=:29052--

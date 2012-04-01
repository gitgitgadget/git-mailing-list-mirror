From: chaitanya nalla <nallachaitu@gmail.com>
Subject: Re: GSoC idea: adding JavaScript library / framework in gitweb
Date: Sun, 1 Apr 2012 15:17:54 +0530
Message-ID: <CACeyoge0ynCdTJtLWr2DES7r5C8L_QZy=C8EJNnd2HXwft=jtw@mail.gmail.com>
References: <CACeyogcFJoUyAiTReDJK_nCMGBp+23OjcS407A1X=fqFR+aGag@mail.gmail.com>
	<201203291114.15284.jnareb@gmail.com>
	<CACeyogcCGhqcQp98JFJVntP9=BvX0TkMWA5JPj7At0bxPwvmfQ@mail.gmail.com>
	<201203301529.20942.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Sun Apr 01 11:48:01 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SEHOD-0000pP-56
	for gcvg-git-2@plane.gmane.org; Sun, 01 Apr 2012 11:48:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751257Ab2DAJr5 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 1 Apr 2012 05:47:57 -0400
Received: from mail-ob0-f174.google.com ([209.85.214.174]:36820 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751212Ab2DAJrz convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 1 Apr 2012 05:47:55 -0400
Received: by obbtb18 with SMTP id tb18so872727obb.19
        for <git@vger.kernel.org>; Sun, 01 Apr 2012 02:47:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=AOK8jJEsDp6ZXY6n3cmXDeZ1Qa1ttie175XbVCwKDWs=;
        b=BclUG41I4iAWmcnkxG0tO7Wo3lbBrL/7CQQoZaSCIsELjP8K4KCv8vzk1ioC3eFN/R
         JMwals8DFzaKeE3Fu7aAlMW6dssVH0pmWmhY+2U7PheKcnP+ERKkaLSbhib/a0GKamID
         VPvTrIOegcuorytHw2J9qsKHG7Akb35dIXYLn65jzbM02ffZqf0xJ1gFiC7RFrJd+7XD
         +yOFBh73RgSQ4eALsCg8mIGixkrkegrO5ZyW9OImwG816u6wXc/AdwL+W6FvqfuvE1XE
         llFmfJY1LFdHWpW9G0LS4NSGx5ZX7Snli6SAJXfhxLvxmoGfTnbDUHzrsejhOGMelorS
         mjFQ==
Received: by 10.60.19.106 with SMTP id d10mr6625879oee.40.1333273674512; Sun,
 01 Apr 2012 02:47:54 -0700 (PDT)
Received: by 10.182.39.234 with HTTP; Sun, 1 Apr 2012 02:47:54 -0700 (PDT)
In-Reply-To: <201203301529.20942.jnareb@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/194477>

Dear jakub,

I have changed schedule based on the good suggetions given by you.
please look at it.

Before May 21st =EF=83=A0 interacting with the beloved community member=
s and
get familiarize  with the code base.
Week 1 =EF=83=A0 Gaining a proper understanding regarding how various a=
re
implemented , their design philosophy , coding standards ,
documentation standards to maintain the best  coding practices
=2EDetailed discussions on which  JavaScript library / framework to use
for client-side scripting in gitweb (jQuery, MooTools, Dojo, YUI)
based on several criteria.(as you mentioned , a short paragraph
describing which framework to use is also added)
Week 2  =EF=83=A0 Transform existing code of JavaScript detection, adju=
sting
timezones and from hand written JavaScript to using JavaScript
library,improving their features wherever possible, incrementally  and
removing the  mini-library in `gitweb/static/js/lib/` by  proper
design and analysis.

Week 3 =EF=83=A0transform the existing code of incremental blame and im=
proving
its features wherever possible by proper design and analysis
Week 4 & 5=EF=83=A0 design and implementation of client side sorting of=
 tables
and client side syntax highlighting of the blob view by handling how
git web splits the output into lines and providing line numbers.
There is also a question of integrating it with server-side source
highlighting (turning off JS-based if server side already does syntax
highlighting, and using
the same CSS).
Week 6 =EF=83=A0 testing the code robustly on as many browsers as possi=
ble
(with their versions) and documenting the code neatly .If possible
automated testing will also be done using selenium web driver.
MidTerm Delivarables : Transform existing code of JavaScript
detection, adjusting timezones and from hand written JavaScript to
using JavaScript library,improving their features wherever possible,
incrementally  and removing the  mini-library in
`gitweb/static/js/lib/` by  proper design and analysis. Adding client
side sorting of tables and client side syntax highlighting of blob
view .
Week 7 & 8=EF=83=A0 Using deferrands or queues in the interactive blame=
 to
avoid the editing of DOM which happens asynchronously to avoid
locking and automatic extending of clickable area for places where the
link is constrained to a single cell or of that type.
Week 9 & 10 & 11 adding user interface  to compare arbitrary commits
in the page using commitdiff view similar to MediaWiki page history
view . Creating a side by side diff from unified diff in javascript so
that switching between unified diff and side by side diff could be
handled on client side.
Week 12 =EF=83=A0 documentation , writing a detail report , testing
exhaustively and checking whether the written code follows the best
coding practises and good design.
Note: considerable amount of time will be spent each week
concentrating on design for adding a new feature since its design
greatly affects many things.

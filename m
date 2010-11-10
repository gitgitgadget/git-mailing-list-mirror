From: lists@haller-berlin.de (Stefan Haller)
Subject: Re: [PATCH] gitk: Add "First parent" checkbox
Date: Wed, 10 Nov 2010 08:17:19 +0100
Message-ID: <1jrqe9r.1i2zca71746ggiM%lists@haller-berlin.de>
References: <20101108211101.GA13114@burratino>
Cc: paulus@samba.org (Paul Mackerras), git@vger.kernel.org,
	patthoyts@users.sourceforge.net (Pat Thoyts),
	trast@student.ethz.ch (Thomas Rast)
To: jrnieder@gmail.com (Jonathan Nieder)
X-From: git-owner@vger.kernel.org Wed Nov 10 08:18:35 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PG4x0-0000H2-Ps
	for gcvg-git-2@lo.gmane.org; Wed, 10 Nov 2010 08:18:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753406Ab0KJHR0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Nov 2010 02:17:26 -0500
Received: from mail.ableton.net ([62.96.12.115]:34403 "EHLO mail.ableton.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752823Ab0KJHRZ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Nov 2010 02:17:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=haller-berlin.de; s=mail_2009081900;
	h=Message-ID:Date:From:Subject:In-Reply-To:Cc:To; bh=tdRwSj1qHAoooMvWGD33JfOCPtTycSW1PkUpszqJP00=;
	b=t65aHbNWV8mqaYqtf8sQ39E82HmyctgjUUkmtx2VfNu4BObyMQvA5ghMnHf6bKGJieYOxdDlZo2RLYFcYY7+daH3Qhs1E4jW7vqLh6/q3ayfMdhZx+dwuNXzW9Nxav08NbCCtvNiU0yEWTW6pH9gBKiyXA3bzywSqIXYr2Kcekc=;
Received: from [10.1.15.237]
	by mail.ableton.net with esmtpsa (SSLv3:AES128-SHA:128)
	(Exim 4.72)
	(envelope-from <lists@haller-berlin.de>)
	id 1PG4vo-0002T3-59; Wed, 10 Nov 2010 08:17:20 +0100
In-Reply-To: <20101108211101.GA13114@burratino>
User-Agent: MacSOUP/2.8.3 (Mac OS X version 10.6.4 (x86))
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/161132>

Jonathan Nieder <jrnieder@gmail.com> wrote:

> Stefan Haller wrote:
> 
> >                                   Most of the diff related options are
> > ones that I want to toggle with one click.  That's certainly true for
> > "Ignore space change", "First parent", and the "Diff/Old Version/New
> > Version" radio buttons.  I would hate to see any of them be removed from
> > the diff pane.
> 
> Thanks, that's useful information.  Could you give example workflows
> to illustrate this?

When browsing history, I usually have "First parent" off, so that I see
empty diffs for most merges, except the ones that had conflicts.
Occasionally though, when looking at a merge of a larger branch, I want
to see what changes were introduced by the merge; turning on "First
parent" allows me to quickly see that, or in general gives me an idea of
just how "big" the merge was.  I usually turn it back off right
afterwards.

Similar for "Ignore space change": I usually have it off most of the
time, so that I see faithful diffs.  Occasionally, when just the
indentation of a block of C code has changed, I turn it on just for that
one diff to make it easier to read; then I turn it back off right
afterwards.

Also similar for "Lines of context": this is usually set to a medium
value, like 3 or 4; sometimes I'll increase it to 12 or more for a
single diff to see more of the surrounding code, and sometimes I'll set
it to 1 for a merge diff with hunks so close to each other that they
otherwise show as conflicts.

Your proposal of having presets for diff options has the drawback that I
would need a preset for each combination of these options.

-Stefan


-- 
Stefan Haller
Berlin, Germany
http://www.haller-berlin.de/

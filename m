From: Hannu Koivisto <azure@iki.fi>
Subject: Re: after first git clone of linux kernel repository there are changed files in working dir
Date: Mon, 19 Jan 2009 15:36:04 +0200
Message-ID: <83ocy3fmez.fsf@kalahari.s2.org>
References: <d304880b0812101019ufe85095h46ff0fe00d32bbd0@mail.gmail.com>
	<d304880b0812101022u2abe5d68ub3bda68ed39f830b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: rdkrsr <rdkrsr@googlemail.com>
X-From: git-owner@vger.kernel.org Mon Jan 19 14:37:30 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LOuJl-0001rX-Pi
	for gcvg-git-2@gmane.org; Mon, 19 Jan 2009 14:37:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752248AbZASNgI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 19 Jan 2009 08:36:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751413AbZASNgH
	(ORCPT <rfc822;git-outgoing>); Mon, 19 Jan 2009 08:36:07 -0500
Received: from s2.org ([195.197.64.39]:38476 "EHLO kalahari.s2.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751169AbZASNgG (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 Jan 2009 08:36:06 -0500
Received: from azure by kalahari.s2.org with local (Exim 4.69)
	(envelope-from <azure@iki.fi>)
	id 1LOuIO-0003cA-Et; Mon, 19 Jan 2009 15:36:04 +0200
In-Reply-To: <d304880b0812101022u2abe5d68ub3bda68ed39f830b@mail.gmail.com>
	(rdkrsr@googlemail.com's message of "Wed, 10 Dec 2008 19:22:46 +0100")
User-Agent: Gnus/5.110011 (No Gnus v0.11) Emacs/22.2 (gnu/linux)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: azure@iki.fi
X-SA-Exim-Scanned: No (on kalahari.s2.org); SAEximRunCond expanded to false
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/106356>

rdkrsr <rdkrsr@googlemail.com> writes:

> I just fetched the sources without changing anything, but git diff
> shows, that there are changes that are not yet updated (changed but not
> updated: use git add to ...). Why is it like that?
>
> I use msysgit on windows, maybe that is one reason?

Kernel source contains pairs of files whose names differ only by
case.  Windows cannot store such pairs (at least by default) and
apparently there is no support for such a situation in git so
you'll only get one file from each pair to your workspace and the
other file is shown as modified.

-- 
Hannu

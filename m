From: Jonas Fonseca <fonseca@diku.dk>
Subject: Re: [ANNOUNCE] tig-0.14.1
Date: Tue, 17 Feb 2009 23:45:45 +0100
Message-ID: <20090217224545.GB19085@diku.dk>
References: <20090215231101.GA7032@diku.dk> <20090216103400.GB7458@b2j>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 17 23:47:39 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LZYii-0007eT-3D
	for gcvg-git-2@gmane.org; Tue, 17 Feb 2009 23:47:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752318AbZBQWps (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Feb 2009 17:45:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752186AbZBQWps
	(ORCPT <rfc822;git-outgoing>); Tue, 17 Feb 2009 17:45:48 -0500
Received: from mgw1.diku.dk ([130.225.96.91]:58891 "EHLO mgw1.diku.dk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751008AbZBQWps (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Feb 2009 17:45:48 -0500
Received: from localhost (localhost [127.0.0.1])
	by mgw1.diku.dk (Postfix) with ESMTP id A99CB52C352
	for <git@vger.kernel.org>; Tue, 17 Feb 2009 23:45:46 +0100 (CET)
X-Virus-Scanned: amavisd-new at diku.dk
Received: from mgw1.diku.dk ([127.0.0.1])
	by localhost (mgw1.diku.dk [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id z5ToHFJYVZbA for <git@vger.kernel.org>;
	Tue, 17 Feb 2009 23:45:45 +0100 (CET)
Received: from nhugin.diku.dk (nhugin.diku.dk [130.225.96.140])
	by mgw1.diku.dk (Postfix) with ESMTP id 87BF052C328
	for <git@vger.kernel.org>; Tue, 17 Feb 2009 23:45:45 +0100 (CET)
Received: from tyr.diku.dk (tyr.diku.dk [130.225.96.226])
	by nhugin.diku.dk (Postfix) with ESMTP id 941056DF845
	for <git@vger.kernel.org>; Tue, 17 Feb 2009 23:43:44 +0100 (CET)
Received: by tyr.diku.dk (Postfix, from userid 3873)
	id 71FD239AA06; Tue, 17 Feb 2009 23:45:45 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <20090216103400.GB7458@b2j>
User-Agent: Mutt/1.5.16 (2007-06-09)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/110460>

bill lam <cbill.lam@gmail.com> wrote Mon, Feb 16, 2009:
> I was ignorant that readline did not work well with ncurses.

Apparently, it can be done if you look at gdb, so if you want to try ...

> Anyway will it be easier to make backspace act as ^H and uparrow to
> recall the last input line?

Probably. It may be rather hard to make backspace work reliably across
different terminals. At least in my gnome-terminal backspace does not
come out as '\b' (or KEY_BACKSPACE), but as 332 (KEY_DC) due to keypad()
translation being enabled. This is one reason why I would like to
introduce an "edit" keymap so it can be made configurable.

-- 
Jonas Fonseca

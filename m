From: Eygene Ryabinkin <rea-git@codelabs.ru>
Subject: Re: [PATCH 2/4] Fix drop-down menus in the git-gui dialogs.
Date: Fri, 6 Apr 2007 11:42:42 +0400
Message-ID: <20070406074242.GC1458@twilight.grid.kiae.ru>
References: <20070327103005.GP14837@codelabs.ru> <20070404163709.GA5167@spearce.org> <20070405124920.GV26348@codelabs.ru> <20070405153226.GH5436@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Cc: git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Fri Apr 06 09:44:57 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HZj6T-0004I4-H3
	for gcvg-git@gmane.org; Fri, 06 Apr 2007 09:43:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1767544AbXDFHnV (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 6 Apr 2007 03:43:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1767546AbXDFHnV
	(ORCPT <rfc822;git-outgoing>); Fri, 6 Apr 2007 03:43:21 -0400
Received: from pobox.codelabs.ru ([144.206.177.45]:65222 "EHLO
	pobox.codelabs.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1767545AbXDFHnT (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Apr 2007 03:43:19 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=simple; s=one; d=codelabs.ru;
	h=Received:Date:From:To:Cc:Message-ID:References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To:Sender:X-Spam-Status:Subject;
	b=Lvl+v0NcWh9W7HeNYsQwE5wCbJDdwvM1bU+thEjCN+cfdlWTTOQEZtbQUZlNl19vmEVSZi2bX881I8zn0tTeVvUHPvjReRS7xRmDkAgENWV8DlPgjtyft9s7k/jyS/h2dfuFL3rOe4lMWTd0dTRAEkEHCeG6jrZ1gPk/ifXT2I4=;
Received: from twilight (daemon.grid.kiae.ru [144.206.66.47])
	by pobox.codelabs.ru with esmtpsa (TLSv1:AES256-SHA:256)
	id 1HZj5q-000OTS-P7; Fri, 06 Apr 2007 11:43:10 +0400
Content-Disposition: inline
In-Reply-To: <20070405153226.GH5436@spearce.org>
X-Spam-Status: No, score=-3.3 required=4.0 tests=ALL_TRUSTED,AWL,BAYES_00
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/43905>

Shawn, good day.

Thu, Apr 05, 2007 at 11:32:26AM -0400, Shawn O. Pearce wrote:
> > OK, I will try to find the other workaround, but I have no Mac OS
> > X at hand (they are a bit expensive to me), so I hope you will find
> > some time to test the new approaches, if I will come up with any.
> 
> That's fine.  I'd be happy to retest something.  If I understood your
> problem description right, this bug doesn't appear on either Cygwin's
> Tcl/Tk implementation or my Mac OS X implementation.  Maybe this
> is one of those things that we just have to do conditionally per OS.

I was not tested this under Cygwin. But the wrong list behaviour I
got is appearing only in dialogs. I am not getting this in the gitk:
there are many drop-down menus in the main window. All of them are
disappearing once I depress the mouse button no matter where the
cursor is. So this issue can be dialog-specific, but I believe that
the main window and dialog windows are handled by Tcl/Tk on the
same footing. Thought, I do not 100% sure.

> If that's the case, maybe we should also consider making our own
> local variant of tk_optionMenu (a wrapper of sorts) that sets our
> font_ui, and does this grab fix on your platform.

I think this would be the last hope. I will try to understand the
problem a bit deeper first.

Thank you!
-- 
Eygene

From: lists@haller-berlin.de (Stefan Haller)
Subject: Re: [PATCH] gitk: Add "First parent" checkbox
Date: Mon, 8 Nov 2010 21:23:44 +0100
Message-ID: <1jrnp0m.116vp4ycag4blM%lists@haller-berlin.de>
References: <20101108194817.GC6348@burratino>
Cc: paulus@samba.org (Paul Mackerras), git@vger.kernel.org,
	patthoyts@users.sourceforge.net (Pat Thoyts),
	trast@student.ethz.ch (Thomas Rast)
To: jrnieder@gmail.com (Jonathan Nieder)
X-From: git-owner@vger.kernel.org Mon Nov 08 21:23:54 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PFYFt-0000FU-Gm
	for gcvg-git-2@lo.gmane.org; Mon, 08 Nov 2010 21:23:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754571Ab0KHUXr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Nov 2010 15:23:47 -0500
Received: from mail.ableton.net ([62.96.12.115]:51720 "EHLO mail.ableton.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754537Ab0KHUXq (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Nov 2010 15:23:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=haller-berlin.de; s=mail_2009081900;
	h=Message-ID:Date:From:Subject:In-Reply-To:Cc:To; bh=nvjwLkBBJlpKa5ll1PaU27cnk7D4VtEvQj1VUBCHxk4=;
	b=Fjg0sKnhKD0Kr+XOlj0XEMOl0+MG31DoEv3IA5eOdMoWA3iKK1RVzWNwJCwh/wY558j3aV5m+ozLiGzEzJUFfpHndXqnUNpj+EQEPT5DmewmZ5t8aeL/3a22OooWYlyEUNc+jzRexP54nbx9Mnso3lKq+tRzfxpGxD7rp+q7QrY=;
Received: from [10.1.15.238]
	by mail.ableton.net with esmtpsa (SSLv3:AES128-SHA:128)
	(Exim 4.72)
	(envelope-from <lists@haller-berlin.de>)
	id 1PFYFk-0007EB-Ps; Mon, 08 Nov 2010 21:23:44 +0100
In-Reply-To: <20101108194817.GC6348@burratino>
User-Agent: MacSOUP/2.8.3 (Mac OS X version 10.6.4 (x86))
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/160983>

Jonathan Nieder <jrnieder@gmail.com> wrote:

> Stefan Haller wrote:
>
> > Matthieu made the suggestion of "line-wrapping" the widgets in the diff
> > pane header if it becomes too narrow.
>
> Hmm.  I don't like where this method tends in the limit.
>
> Maybe we need a notion of a "diff view", for setting up various
> diff-tree options (word diff, whitespace options, context lines,
> patience, diffstat, first-parent)?  The diff pane could then provide a
> drop-down box for diff views already set up.

I don't think I would like this.  Most of the diff related options are
ones that I want to toggle with one click.  That's certainly true for
"Ignore space change", "First parent", and the "Diff/Old Version/New
Version" radio buttons.  I would hate to see any of them be removed from
the diff pane.


-- 
Stefan Haller
Berlin, Germany
http://www.haller-berlin.de/

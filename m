From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: Switching from CVS to GIT
Date: Tue, 16 Oct 2007 02:21:44 -0400
Message-ID: <20071016062144.GD13801@spearce.org>
References: <1192293466.17584.95.camel@homebase.localnet> <uy7e6keyv.fsf@gnu.org> <1192381040.4908.57.camel@homebase.localnet> <1773C6F0-87BE-4F3C-B68A-171E1F32E242@lrde.epita.fr> <47130B25.4010304@viscovery.net> <20071015231242.GR27899@spearce.org> <471455ED.8070408@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git list <git@vger.kernel.org>
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Tue Oct 16 08:22:07 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IhfoW-0002j7-8f
	for gcvg-git-2@gmane.org; Tue, 16 Oct 2007 08:22:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755177AbXJPGVu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Oct 2007 02:21:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752294AbXJPGVu
	(ORCPT <rfc822;git-outgoing>); Tue, 16 Oct 2007 02:21:50 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:59992 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751983AbXJPGVt (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Oct 2007 02:21:49 -0400
Received: from [74.70.48.173] (helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.68)
	(envelope-from <spearce@spearce.org>)
	id 1IhfoH-0001l9-D5; Tue, 16 Oct 2007 02:21:45 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id D177F20FBAE; Tue, 16 Oct 2007 02:21:44 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <471455ED.8070408@viscovery.net>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/61091>

Johannes Sixt <j.sixt@viscovery.net> wrote:
> >Johannes Sixt <j.sixt@viscovery.net> wrote:
> >>Unfortunately, "Fetch" does not yet work[*] from within git-gui, so you 
> >>have to fall back to git-fetch on the command line.
> 
> It's the scripted fetch that does not work. The symptom is that the output 
> of at least one of the commands (upload-pack, I think, because what I see 
> is wire protocol) goes to a newly spawned console instead of wherever it 
> was redirected to.
> 
> I didn't bother reporting since builtin-fetch is on the way (which will 
> hopefully make this a moot point) and our team here is comfortable with 
> calling git fetch on the command line.

Hmm.  The way the builtin-fetch works this shouldn't happen, but
I'd appreciate it if you could test and report back before that
topic merges into master.

-- 
Shawn.

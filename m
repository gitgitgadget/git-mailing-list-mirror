From: Mike Hommey <mh@glandium.org>
Subject: Re: [PATCH] git-rebase.sh: Update USAGE string (No. 1)
Date: Mon, 4 Feb 2008 12:57:42 +0100
Organization: glandium.org
Message-ID: <20080204115741.GA23834@glandium.org>
References: <prvd3i9e.fsf@blue.sea.net> <zluh1sxv.fsf@blue.sea.net> <7vfxw9pnbp.fsf@gitster.siamese.dyndns.org> <200802041115.22409.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	Jari Aalto <jari.aalto@cante.net>, git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Mon Feb 04 12:58:24 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JLzxv-0007pY-Hn
	for gcvg-git-2@gmane.org; Mon, 04 Feb 2008 12:58:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751729AbYBDL5u (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 4 Feb 2008 06:57:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751832AbYBDL5u
	(ORCPT <rfc822;git-outgoing>); Mon, 4 Feb 2008 06:57:50 -0500
Received: from smtp23.orange.fr ([193.252.22.30]:32551 "EHLO smtp23.orange.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751729AbYBDL5t (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Feb 2008 06:57:49 -0500
Received: from me-wanadoo.net (localhost [127.0.0.1])
	by mwinf2333.orange.fr (SMTP Server) with ESMTP id 1BF011C000A1
	for <git@vger.kernel.org>; Mon,  4 Feb 2008 12:57:43 +0100 (CET)
Received: from vaio.glandium.org (APuteaux-153-1-42-109.w82-124.abo.wanadoo.fr [82.124.6.109])
	by mwinf2333.orange.fr (SMTP Server) with ESMTP id DCC441C0009C;
	Mon,  4 Feb 2008 12:57:42 +0100 (CET)
X-ME-UUID: 20080204115742904.DCC441C0009C@mwinf2333.orange.fr
Received: from mh by vaio.glandium.org with local (Exim 4.63)
	(envelope-from <mh@glandium.org>)
	id 1JLzxG-0006Ey-9n; Mon, 04 Feb 2008 12:57:42 +0100
Content-Disposition: inline
In-Reply-To: <200802041115.22409.jnareb@gmail.com>
X-GPG-Fingerprint: A479 A824 265C B2A5 FC54  8D1E DE4B DA2C 54FD 2A58
User-Agent: Mutt/1.5.13 (2006-08-11)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: mh@glandium.org
X-SA-Exim-Scanned: No (on vaio.glandium.org); SAEximRunCond expanded to false
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/72492>

On Mon, Feb 04, 2008 at 11:15:20AM +0100, Jakub Narebski <jnareb@gmail.com> wrote:
> Actually we are not entirely consistent here.  git-init(1) has 
>   --shared[={false|true|umask|group|all|world|everybody}]
> in the option description, git-rev-list(1) has
>   [ --date={local|relative|default|iso|rfc|short} ]

What is inconsistent here ? The first tells you you can use --shared without
an argument. And it's [--shared[=<permissions>]] in the synopsis, so you
may omit --shared, or use in alone, or specify permissions. The second tells
you can't use --date without an additional argument.

Mike

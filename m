From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: [PATCH 3/3] commit: Show the committer ident when is different
	from the parent
Date: Wed, 30 Apr 2008 19:52:24 +0200
Message-ID: <20080430175224.GA4131@steel.home>
References: <1209545236-4266-1-git-send-email-sbejar@gmail.com> <1209545236-4266-4-git-send-email-sbejar@gmail.com>
Reply-To: Alex Riesen <raa.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Santi =?iso-8859-15?Q?B=E9jar?= <sbejar@gmail.com>
X-From: git-owner@vger.kernel.org Wed Apr 30 19:53:20 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JrGUY-0007MP-IC
	for gcvg-git-2@gmane.org; Wed, 30 Apr 2008 19:53:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760803AbYD3Rw2 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 30 Apr 2008 13:52:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760760AbYD3Rw2
	(ORCPT <rfc822;git-outgoing>); Wed, 30 Apr 2008 13:52:28 -0400
Received: from mo-p07-ob.rzone.de ([81.169.146.189]:38943 "EHLO
	mo-p07-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760304AbYD3Rw0 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Apr 2008 13:52:26 -0400
X-RZG-CLASS-ID: mo07
X-RZG-AUTH: z4gYkBuibEUndJ36PWMnarZw4cjU0g==
Received: from tigra.home (Faed6.f.strato-dslnet.de [195.4.174.214])
	by post.webmailer.de (mrclete mo28) (RZmta 16.27)
	with ESMTP id 3008fck3UG4jv8 ; Wed, 30 Apr 2008 19:52:24 +0200 (MEST)
	(envelope-from: <raa.lkml@gmail.com>)
Received: from steel.home (steel.home [192.168.1.2])
	by tigra.home (Postfix) with ESMTP id B1F7A277BD;
	Wed, 30 Apr 2008 19:52:24 +0200 (CEST)
Received: by steel.home (Postfix, from userid 1000)
	id 7810656D28; Wed, 30 Apr 2008 19:52:24 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1209545236-4266-4-git-send-email-sbejar@gmail.com>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/80860>

Santi B=E9jar, Wed, Apr 30, 2008 10:47:16 +0200:
> To remind the committer ident in case it is not what you want
> (taken from the gecos field, want to use different ident in
> different repositories).

Like: show committer id always if the repo is any kind of a public
project. Which maybe ok, I'd better always see what id I use to work
on, for example, Git.

I like the idea in general, but the implementation could be refined.
Maybe consider looking at user.name (whether the repo has an ident
set)? This is usually done conciously, and the user wont need this
reminder.

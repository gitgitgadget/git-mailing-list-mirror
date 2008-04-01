From: Teemu Likonen <tlikonen@iki.fi>
Subject: Re: [PATCH] Add new git-graph command
Date: Tue, 1 Apr 2008 07:29:51 +0300
Message-ID: <200804010729.51202.tlikonen@iki.fi>
References: <20080330195840.GA8695@adamsimpkins.net> <200803312017.28354.tlikonen@iki.fi> <9b3e2dc20803312105i1f890784v29928321e3e51374@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, "Adam Simpkins" <adam@adamsimpkins.net>
To: "Stephen Sinclair" <radarsat1@gmail.com>
X-From: git-owner@vger.kernel.org Tue Apr 01 06:30:57 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JgY99-0000Ef-Df
	for gcvg-git-2@gmane.org; Tue, 01 Apr 2008 06:30:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750897AbYDAE3z (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 Apr 2008 00:29:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750927AbYDAE3y
	(ORCPT <rfc822;git-outgoing>); Tue, 1 Apr 2008 00:29:54 -0400
Received: from pne-smtpout3-sn1.fre.skanova.net ([81.228.11.120]:43872 "EHLO
	pne-smtpout3-sn1.fre.skanova.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750868AbYDAE3y (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 1 Apr 2008 00:29:54 -0400
Received: from [192.168.0.2] (80.220.180.181) by pne-smtpout3-sn1.fre.skanova.net (7.3.129)
        id 47A78857003156E6; Tue, 1 Apr 2008 06:29:52 +0200
User-Agent: KMail/1.9.5
In-Reply-To: <9b3e2dc20803312105i1f890784v29928321e3e51374@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/78625>

Stephen Sinclair kirjoitti:

> On Mon, Mar 31, 2008 at 1:17 PM, Teemu Likonen <tlikonen@iki.fi> 
wrote:
> >  I just want to say that I really like your 'git graph'. I would
> > like to see it integrated to 'git log', perhaps as 'git log
> > --pretty=graph' or 'git log --graph'.
>
> Any reason?
>
> I don't see why it's necessary to bundle all useful commands into one
> big super-command.  I like the idea of typing "git-graph".
> Then again, I happen to like the git-command syntax which seems to
> have fallen out of favour, so don't pay attention to me.

Adam's 'git graph' is a way of viewing log (in terminal environment), it 
looks very similar to 'git log --pretty=oneline' and it accepts very 
much the same command line options. That's why I see 'git log' being 
logical place for such functionality.

Actually, to me it would be more logical if 'git whatchanged' was 'git 
log --changed' or '--verbose / -v' something.

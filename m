From: Teemu Likonen <tlikonen@iki.fi>
Subject: Re: [PATCH] Add new git-graph command
Date: Tue, 1 Apr 2008 08:07:52 +0300
Message-ID: <200804010807.52914.tlikonen@iki.fi>
References: <20080330195840.GA8695@adamsimpkins.net> <9b3e2dc20803312105i1f890784v29928321e3e51374@mail.gmail.com> <200804010729.51202.tlikonen@iki.fi>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: "Stephen Sinclair" <radarsat1@gmail.com>,
	"Adam Simpkins" <adam@adamsimpkins.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Apr 01 07:08:40 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JgYje-0000Ry-0E
	for gcvg-git-2@gmane.org; Tue, 01 Apr 2008 07:08:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750927AbYDAFHz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 Apr 2008 01:07:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751446AbYDAFHz
	(ORCPT <rfc822;git-outgoing>); Tue, 1 Apr 2008 01:07:55 -0400
Received: from pne-smtpout3-sn2.hy.skanova.net ([81.228.8.111]:54951 "EHLO
	pne-smtpout3-sn2.hy.skanova.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750868AbYDAFHz (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 1 Apr 2008 01:07:55 -0400
Received: from [192.168.0.2] (80.220.180.181) by pne-smtpout3-sn2.hy.skanova.net (7.3.129)
        id 478BDB960043673F; Tue, 1 Apr 2008 07:07:54 +0200
User-Agent: KMail/1.9.5
In-Reply-To: <200804010729.51202.tlikonen@iki.fi>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/78632>

Teemu Likonen kirjoitti:

> Adam's 'git graph' is a way of viewing log (in terminal environment),
> it looks very similar to 'git log --pretty=oneline' and it accepts
> very much the same command line options. That's why I see 'git log'
> being logical place for such functionality.
>
> Actually, to me it would be more logical if 'git whatchanged' was
> 'git log --changed' or '--verbose / -v' something.

May I add that I'm the kind of user who only understands the porcelain 
Git. In my mindset it's best when commands are in logical units by 
their functionality (from user's point of view).

I see 'git log' as a command for studying history log and to me 'git 
whatchanged' sounds like some user's personal _alias_ to 'git 
log --raw --full-history --always' or something (thanks Jeff). 
Similarly 'git graph' sounds like an alias to 'git log --pretty=graph' 
for someone who uses this a lot.

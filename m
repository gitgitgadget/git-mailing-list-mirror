From: Johan Herland <johan@herland.net>
Subject: Re: [RFH] rpm packaging failure
Date: Sun, 31 Jan 2010 01:06:52 +0100
Message-ID: <201001310106.52303.johan@herland.net>
References: <7v8wbgueqz.fsf@alter.siamese.dyndns.org>
 <20100130151921.GM29188@inocybe.localdomain>
 <7vsk9nsemh.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-8859-1
Content-Transfer-Encoding: 7BIT
Cc: Todd Zullinger <tmz@pobox.com>, git@vger.kernel.org,
	Sverre Rabbelier <srabbelier@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Jan 31 01:07:02 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NbNLB-0003Rq-LG
	for gcvg-git-2@lo.gmane.org; Sun, 31 Jan 2010 01:07:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752988Ab0AaAG4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 30 Jan 2010 19:06:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752797Ab0AaAG4
	(ORCPT <rfc822;git-outgoing>); Sat, 30 Jan 2010 19:06:56 -0500
Received: from smtp.getmail.no ([84.208.15.66]:52534 "EHLO
	get-mta-out02.get.basefarm.net" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751509Ab0AaAG4 (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 30 Jan 2010 19:06:56 -0500
Received: from smtp.getmail.no ([10.5.16.4]) by get-mta-out02.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0KX3001HS4BH5S20@get-mta-out02.get.basefarm.net> for
 git@vger.kernel.org; Sun, 31 Jan 2010 01:06:53 +0100 (MET)
Received: from alpha.localnet ([84.215.68.234])
 by get-mta-in01.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0KX300HFH4BG0C20@get-mta-in01.get.basefarm.net> for
 git@vger.kernel.org; Sun, 31 Jan 2010 01:06:53 +0100 (MET)
X-PMX-Version: 5.5.3.366731, Antispam-Engine: 2.7.0.366912,
 Antispam-Data: 2010.1.30.235725
User-Agent: KMail/1.12.4 (Linux/2.6.32-ARCH; KDE/4.3.4; x86_64; ; )
In-reply-to: <7vsk9nsemh.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/138521>

On Saturday 30 January 2010, Junio C Hamano wrote:
> The files that are problematic are only infrastructure bits to support
> "remote helpers written in Python" (which we don't ship at all yet).
> 
> Once we start shipping real remote helpers, separating Python bits out
> into its own package would make a lot of sense.  People who want to use
> foreign scm helpers that happen to be written in Python would need it,
>  and all others don't.
> 
> But I suspect that a safer alternative at least for 1.7.0 would be to
> leave these files out altogether.  As I understand the current state, it
> is an unused but required package dependency on Python, a downside
>  without an upside.  Is it Ok with "remote helpers in Python" folks (I
>  think Sverre and Johan are principal parties), or did I miss some reason
>  that these need to be installed/installable, perhaps to support third
>  party packages that already exist?

AFAICS, there's no reason why these should be installed without anything 
actually using them. Although I defer to Sverre, who did the last work in 
this area.


...Johan

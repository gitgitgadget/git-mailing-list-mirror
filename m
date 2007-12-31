From: Graham Barr <gbarr@pobox.com>
Subject: Re: git over webdav: what can I do for improving http-push ?
Date: Mon, 31 Dec 2007 10:57:52 -0600
Message-ID: <47791F90.8030302@pobox.com>
References: <477822C3.9060002@gbarbier.org> <alpine.LNX.1.00.0712302145500.13593@iabervon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?ISO-8859-15?Q?Gr=E9goire_Barbier?= <gb@gbarbier.org>,
	git@vger.kernel.org
To: Daniel Barkalow <barkalow@iabervon.org>
X-From: git-owner@vger.kernel.org Mon Dec 31 18:25:10 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J9ONu-0002gq-LA
	for gcvg-git-2@gmane.org; Mon, 31 Dec 2007 18:25:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750939AbXLaRYh convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 31 Dec 2007 12:24:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750853AbXLaRYh
	(ORCPT <rfc822;git-outgoing>); Mon, 31 Dec 2007 12:24:37 -0500
Received: from aa.67.1343.static.theplanet.com ([67.19.103.170]:47418 "EHLO
	mail.goingon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750790AbXLaRYg (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 31 Dec 2007 12:24:36 -0500
X-Greylist: delayed 1586 seconds by postgrey-1.27 at vger.kernel.org; Mon, 31 Dec 2007 12:24:36 EST
Received: from zipper.x.goingon.net (client-63.249.42.207.dfw.buz.net [63.249.42.207])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.goingon.net (Postfix) with ESMTP id E625749196;
	Mon, 31 Dec 2007 10:58:09 -0600 (CST)
User-Agent: Thunderbird 2.0.0.9 (Macintosh/20071031)
In-Reply-To: <alpine.LNX.1.00.0712302145500.13593@iabervon.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/69407>

Daniel Barkalow wrote:
> On Sun, 30 Dec 2007, Gr=E9goire Barbier wrote:

>> I'm using Git for a rather short time but enough to fall in love wit=
h it. For
>> a few days I'm trying to use it over webdav, that is over http/https=
 with
>> write (push) access. As for me, the main rationale to use http(s) ra=
ther than
>> git or ssh is to get through corporate firewalls, otherwise I would =
probably
>> not bother with webdav.

> In general, we've been able to either get through firewalls with ssh =
or=20
> it's all in the same VPN. So it's kind of unloved at this point. Peop=
le=20
> poke at it occasionally, but mostly in the context of other fixes, I=20
> think.

If you have a http proxy that you can use, the you can use ssh via that=
 with
something like corkscrew. http://wiki.kartbuilding.net/index.php/Corksc=
rew_-_ssh_over_https

A simple shell script wrapper around ssh to detect when you are behind =
a firewall
can inject the ProxyCommand into the command line arguments with -o

Graham.

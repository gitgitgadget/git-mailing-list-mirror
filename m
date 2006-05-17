From: Sean <seanlkml@sympatico.ca>
Subject: Re: "git add $ignored_file" fail
Date: Wed, 17 May 2006 15:39:03 -0400
Message-ID: <BAYC1-PASMTP12920BE00C27B0CF31CB9FAEA10@CEZ.ICE>
References: <8aa486160605161507w3a27152dq@mail.gmail.com>
	<Pine.LNX.4.64.0605161526210.16475@g5.osdl.org>
	<8aa486160605161542u704ccf03w@mail.gmail.com>
	<Pine.LNX.4.63.0605171306400.19012@wbgn013.biozentrum.uni-wuerzburg.de>
	<81b0412b0605170604i689a8f7axa5aeb7752dc72072@mail.gmail.com>
	<8aa486160605170641p2ab8704o@mail.gmail.com>
	<e4f9eo$b60$1@sea.gmane.org>
	<1147893786.16654.5.camel@dv>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: jnareb@gmail.com, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 17 21:45:27 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FgRxT-0007wy-V6
	for gcvg-git@gmane.org; Wed, 17 May 2006 21:45:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751055AbWEQTpP (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 17 May 2006 15:45:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751060AbWEQTpP
	(ORCPT <rfc822;git-outgoing>); Wed, 17 May 2006 15:45:15 -0400
Received: from bayc1-pasmtp12.bayc1.hotmail.com ([65.54.191.172]:49753 "EHLO
	BAYC1-PASMTP12.BAYC1.HOTMAIL.COM") by vger.kernel.org with ESMTP
	id S1751055AbWEQTpN (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 May 2006 15:45:13 -0400
X-Originating-IP: [69.156.138.66]
X-Originating-Email: [seanlkml@sympatico.ca]
Received: from linux1.attic.local ([69.156.138.66]) by BAYC1-PASMTP12.BAYC1.HOTMAIL.COM over TLS secured channel with Microsoft SMTPSVC(6.0.3790.1830);
	 Wed, 17 May 2006 12:52:07 -0700
Received: from guru.attic.local (guru.attic.local [10.10.10.28])
	by linux1.attic.local (Postfix) with ESMTP id 108E6644C28;
	Wed, 17 May 2006 15:44:40 -0400 (EDT)
To: Pavel Roskin <proski@gnu.org>
Message-Id: <20060517153903.6b896fdd.seanlkml@sympatico.ca>
In-Reply-To: <1147893786.16654.5.camel@dv>
X-Mailer: Sylpheed version 2.0.4 (GTK+ 2.8.15; i386-redhat-linux-gnu)
X-OriginalArrivalTime: 17 May 2006 19:52:07.0890 (UTC) FILETIME=[61091B20:01C679EB]
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Wed, 17 May 2006 15:23:06 -0400
Pavel Roskin <proski@gnu.org> wrote:

> Can we apply the ignore rules to the directories but not the files?
> 
> This way, "git-add *" would add all files (rarely a good idea), whereas 
> "git-add ." would respect the ignore rules.
> 
> Kludgy as it is, this approach would generally produce more expected
> results than others.  If you let the shell expand the pattern, expect
> all junk to be added.  If you let git expand the pattern, expect it to
> adhere to the ignore rules. 

Shouldn't git just always respect the ignore rules?  Forcing someone to
remove a file from the .gitignore or employ the other work around
mentioned earlier doesn't seem too bad.  How often are people adding
files that are explicitly ignored?

Sean

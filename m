From: "Sean" <seanlkml@sympatico.ca>
Subject: Re: Strange dependency problem installing GIT 0.99.7
Date: Mon, 19 Sep 2005 02:14:04 -0400 (EDT)
Message-ID: <BAYC1-PASMTP030A084E1D3B3D9B324DAEAE920@cez.ice>
References: <432E1F28.9060909@bigpond.net.au>
    <7v8xxtzmtl.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Sep 19 08:14:55 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EHEup-0004xa-0G
	for gcvg-git@gmane.org; Mon, 19 Sep 2005 08:14:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932328AbVISGOH (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 19 Sep 2005 02:14:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932331AbVISGOH
	(ORCPT <rfc822;git-outgoing>); Mon, 19 Sep 2005 02:14:07 -0400
Received: from bayc1-pasmtp03.bayc1.hotmail.com ([65.54.191.163]:60201 "EHLO
	BAYC1-PASMTP03.bayc1.hotmail.com") by vger.kernel.org with ESMTP
	id S932329AbVISGOG (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 Sep 2005 02:14:06 -0400
X-Originating-IP: [67.71.125.52]
X-Originating-Email: [seanlkml@sympatico.ca]
Received: from linux1.attic.local ([67.71.125.52]) by BAYC1-PASMTP03.bayc1.hotmail.com over TLS secured channel with Microsoft SMTPSVC(6.0.3790.211);
	 Sun, 18 Sep 2005 23:13:41 -0700
Received: by linux1.attic.local (Postfix, from userid 48)
	id 20C70644BED; Mon, 19 Sep 2005 02:14:04 -0400 (EDT)
Received: from 10.10.10.28
        (SquirrelMail authenticated user sean)
        by linux1 with HTTP;
        Mon, 19 Sep 2005 02:14:04 -0400 (EDT)
Message-ID: <57460.10.10.10.28.1127110444.squirrel@linux1>
In-Reply-To: <7v8xxtzmtl.fsf@assigned-by-dhcp.cox.net>
To: "Peter Williams" <pwil3058@bigpond.net.au>
User-Agent: SquirrelMail/1.4.4-2
X-Priority: 3 (Normal)
Importance: Normal
X-OriginalArrivalTime: 19 Sep 2005 06:13:41.0448 (UTC) FILETIME=[482CB480:01C5BCE1]
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Mon, September 19, 2005 12:46 am, Junio C Hamano said:
> Peter Williams <pwil3058@bigpond.net.au> writes:
>
>> So I installed String::ShellQuote from CPAN and tried again with the
>> same result.  So I then rebuilt the rpm on my system and still got the
>> same error message.  So I've installed the rpm using the --nodeps option
>> but would like to test whether it is successfully finding
>> String::ShellQuote.  Which command(s) would exercise this perl package?
>
> $ git grep ShellQuote
> git-archimport.perl:42:use String::ShellQuote;

Peter,

You need to install ShellQuote with rpm rather than installing it directly
from CPAN.  You can pick up a rpm version of ShellQuote from several
places, here's one:  http://tinyurl.com/7p7ey

Cheers,
Sean

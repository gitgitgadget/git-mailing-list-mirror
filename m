From: John Norris <john@norricorp.f9.co.uk>
Subject: Re: Building git 2.4.5 on AIX 6.1 problems
Date: Fri, 10 Jul 2015 04:32:37 +0000
Message-ID: <a4eee6a136cafece6be5dbd5ee934f7a@imap.force9.net>
References: <516b832bd9db48e4bdb486d63b2a3977@imap.force9.net>
 <xmqqwpy9uqth.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 7bit
Cc: <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jul 10 06:40:25 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZDQ6n-0000DB-PW
	for gcvg-git-2@plane.gmane.org; Fri, 10 Jul 2015 06:40:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751183AbbGJEkR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 10 Jul 2015 00:40:17 -0400
Received: from avasout04.plus.net ([212.159.14.19]:40249 "EHLO
	avasout04.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750874AbbGJEkP (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 10 Jul 2015 00:40:15 -0400
X-Greylist: delayed 455 seconds by postgrey-1.27 at vger.kernel.org; Fri, 10 Jul 2015 00:40:15 EDT
Received: from webmail.plus.net ([84.93.237.98])
	by avasout04 with smtp
	id qUYd1q003283uBY01UYe4L; Fri, 10 Jul 2015 05:32:39 +0100
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.1 cv=JOrGyJ+b c=1 sm=1 tr=0
 a=BJaFPv9AyABFDM2hXLRoEA==:117 a=6JrruMomGWIwZufWOQ3PvA==:17 a=0Bzu9jTXAAAA:8
 a=GCZBuicCAAAA:8 a=mrHjP8x4AAAA:8 a=6_JOMXYOAAAA:8 a=cyCaf7Y57g0A:10
 a=M-Fncn8uHW8A:10 a=IkcTkHD0fZMA:10 a=zOBTXjUuO1YA:10
 a=mX3l9Cmfqjxn3QCTKtYA:9 a=QEXdDO2ut3YA:10 a=dINvrct3qHcA:10
X-AUTH: norricorp@:2501
Received: from 5-148-128-42.cust-5.exponential-e.net ([5.148.128.42])
 by webmail.plus.net
 with HTTP (HTTP/1.1 POST); Fri, 10 Jul 2015 05:32:37 +0100
In-Reply-To: <xmqqwpy9uqth.fsf@gitster.dls.corp.google.com>
X-Sender: john@norricorp.f9.co.uk
User-Agent: Roundcube Webmail/0.7.4
X-Originating-IP: [5.148.128.42]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/273801>

Hi Junio,
thank you for this - I will run make with V=1 as you suggested and try 
and talk to some IBM AIX people.
But there are a few archive commands before I get to linking 
credentials-store. Is there something special about credentials store?
And is the collect2 an AIX library or general library used by git?
Regards,
John

From: Jan Engelhardt <jengelh@medozas.de>
Subject: Re: gitweb forgets to send utf8 header for raw blob views
Date: Sun, 1 Jun 2008 04:08:30 +0200 (CEST)
Message-ID: <alpine.LNX.1.10.0806010407460.4055@fbirervta.pbzchgretzou.qr>
References: <alpine.LNX.1.10.0805282002510.19264@fbirervta.pbzchgretzou.qr> <m3tzgg1a06.fsf@localhost.localdomain> <alpine.LNX.1.10.0805311703420.4055@fbirervta.pbzchgretzou.qr> <200806010039.14663.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jun 01 04:09:52 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K2d0z-00007v-BC
	for gcvg-git-2@gmane.org; Sun, 01 Jun 2008 04:09:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755289AbYFACIc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 31 May 2008 22:08:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755288AbYFACIc
	(ORCPT <rfc822;git-outgoing>); Sat, 31 May 2008 22:08:32 -0400
Received: from sovereign.computergmbh.de ([85.214.69.204]:51997 "EHLO
	sovereign.computergmbh.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751803AbYFACIb (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 31 May 2008 22:08:31 -0400
Received: by sovereign.computergmbh.de (Postfix, from userid 25121)
	id 8FD0D1810B924; Sun,  1 Jun 2008 04:08:30 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by sovereign.computergmbh.de (Postfix) with ESMTP id 873011CFCF5BF;
	Sun,  1 Jun 2008 04:08:30 +0200 (CEST)
In-Reply-To: <200806010039.14663.jnareb@gmail.com>
User-Agent: Alpine 1.10 (LNX 962 2008-03-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/83422>


On Sunday 2008-06-01 00:39, Jakub Narebski wrote:

>On Sat, 31 May 2008, Jan Engelhardt wrote:
>> On Friday 2008-05-30 10:18, Jakub Narebski wrote:
>>>Jan Engelhardt <jengelh@medozas.de> writes:
>>>
>>>> I have configured gitweb to use utf8, and that works for text blob views 
>>>> like on
>>>> http://dev.medozas.de/gitweb.cgi?p=hxtools;a=blob;f=bin/git-forest;hb=HEAD
>>>> but it does not for raw blob views like
>>>> http://dev.medozas.de/gitweb.cgi?p=hxtools;a=blob_plain;f=bin/git-forest;hb=HEAD
>>>
>>> This can depend on configuration, both on gitweb configuration (you
>>> can for example define $default_blob_plain_mimetype to 'text/plain;
>>> charset=utf-8', and define $default_text_plain_charset to 'utf-8'),
>>> and on your /etc/mime.types; gitweb does not add charset info if
>>> mimetype is acquired from mime.types, which I guess is a mistake.
>> 
>> Thanks for the hint. Setting 
>> 	our $default_text_plain_charset  = "utf-8";
>> was all that was needed.
>
>By the way, do you think that this should be the default for gitweb?

Definitely. I also made tbz2 the default for me over tgz, because that's
just how it is.

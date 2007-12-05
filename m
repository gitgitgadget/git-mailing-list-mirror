From: Brian Gernhardt <benji@silverinsanity.com>
Subject: Re: [PATCH/RFC] autoconf: Add test for OLD_ICONV
Date: Wed, 5 Dec 2007 16:38:10 -0500
Message-ID: <9B4498E3-295F-4D0B-896C-34E54A869B5E@silverinsanity.com>
References: <7vd4u5l29v.fsf@gitster.siamese.dyndns.org> <200712051752.28667.jnareb@gmail.com> <52A4CC8B-EB11-4E3F-A3B6-06826F860E5D@wincent.com> <200712052219.00930.jnareb@gmail.com>
Mime-Version: 1.0 (Apple Message framework v915)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Cc: Wincent Colaiuta <win@wincent.com>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>,
	Ramsay Jones <ramsay@ramsay1.demon.co.uk>,
	Arjen Laarhoven <arjen@yaph.org>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Wed Dec 05 22:38:45 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J01x1-0007ZZ-Ev
	for gcvg-git-2@gmane.org; Wed, 05 Dec 2007 22:38:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752335AbXLEViR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 5 Dec 2007 16:38:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752253AbXLEViR
	(ORCPT <rfc822;git-outgoing>); Wed, 5 Dec 2007 16:38:17 -0500
Received: from vs072.rosehosting.com ([216.114.78.72]:38091 "EHLO
	silverinsanity.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751761AbXLEViQ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Dec 2007 16:38:16 -0500
Received: from [192.168.1.3] (cpe-69-205-115-17.rochester.res.rr.com [69.205.115.17])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by silverinsanity.com (Postfix) with ESMTP id 1E02A1FFC229;
	Wed,  5 Dec 2007 21:38:13 +0000 (UTC)
In-Reply-To: <200712052219.00930.jnareb@gmail.com>
X-Mailer: Apple Mail (2.915)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/67198>


On Dec 5, 2007, at 4:19 PM, Jakub Narebski wrote:

> Ahhh... now I understand. You have installed new iconv() on your
> computer, and generic 'uname -s' (OS name) based guessing in Makefile
> guesses wrongly that you need OLD_ICONV, while ./configure script
> actually tests it and correctly decides to unset OLD_ICONV !

As far as the "installed new iconv()" goes, you may be wrong there.   
The latest major release of OS X includes a version of iconv that does  
not need OLD_ICONV as part of the base system.  I've had to unset it  
in my config.mak in order to avoid the warning.

~~ Brian Gernhardt

From: Sean <seanlkml@sympatico.ca>
Subject: Re: ~ and ^
Date: Sun, 13 May 2007 15:49:05 -0400
Message-ID: <20070513154905.36da94e1.seanlkml@sympatico.ca>
References: <20070513144442.b3cba792.seanlkml@sympatico.ca>
	<7v8xbssfti.fsf@assigned-by-dhcp.cox.net>
	<20070513191350.GB14657@diana.vm.bytemark.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
To: Karl =?ISO-8859-1?B?SGFzc2Vsc3Ry9m0=?= <kha@treskal.com>
X-From: git-owner@vger.kernel.org Sun May 13 21:49:16 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HnK4B-0003sV-Gv
	for gcvg-git@gmane.org; Sun, 13 May 2007 21:49:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754655AbXEMTtJ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Sun, 13 May 2007 15:49:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755059AbXEMTtJ
	(ORCPT <rfc822;git-outgoing>); Sun, 13 May 2007 15:49:09 -0400
Received: from bay0-omc1-s7.bay0.hotmail.com ([65.54.246.79]:54088 "EHLO
	bay0-omc1-s7.bay0.hotmail.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754655AbXEMTtI convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 13 May 2007 15:49:08 -0400
Received: from bayc1-pasmtp04.bayc1.hotmail.com ([65.54.191.164]) by bay0-omc1-s7.bay0.hotmail.com with Microsoft SMTPSVC(6.0.3790.2668);
	 Sun, 13 May 2007 12:49:07 -0700
X-Originating-IP: [65.95.67.118]
X-Originating-Email: [seanlkml@sympatico.ca]
Received: from linux1.attic.local ([65.95.67.118]) by bayc1-pasmtp04.bayc1.hotmail.com over TLS secured channel with Microsoft SMTPSVC(6.0.3790.2668);
	 Sun, 13 May 2007 12:49:07 -0700
Received: from guru.attic.local ([10.10.10.28])
	by linux1.attic.local with esmtp (Exim 4.43)
	id 1HnK2k-0002hu-Ba; Sun, 13 May 2007 15:47:46 -0400
In-Reply-To: <20070513191350.GB14657@diana.vm.bytemark.co.uk>
X-Mailer: Sylpheed 2.3.1 (GTK+ 2.10.8; i386-redhat-linux-gnu)
X-OriginalArrivalTime: 13 May 2007 19:49:07.0402 (UTC) FILETIME=[C49492A0:01C79597]
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/47176>

On Sun, 13 May 2007 21:13:50 +0200
Karl Hasselstr=F6m <kha@treskal.com> wrote:

> It seems that ~foo is only expanded to foo's home if there is such a
> user. Since all-numeric users probably aren't common, we can probably
> get away with it.

Someone just mentioned to me that ~# is expanded by Bash if you use the
pushd command to keep a directory stack.   So ~1 will stop working
if you use "pushd".   Maybe it'd be more confusing than helpful.  On th=
e
other hand, there's probably no reason for Git to just give an error
message if it receives a properly escaped lone "~", "~#", or "^".

Sean

From: Brian Gernhardt <benji@silverinsanity.com>
Subject: Re: t3902-quoted.sh broken on cygwin
Date: Mon, 2 Jul 2007 12:36:36 -0400
Message-ID: <5CD91C2E-2994-4791-959B-EC94DA03D78C@silverinsanity.com>
References: <81b0412b0707020146x74f1a707na27cc3e5e16f75ad@mail.gmail.com>
Mime-Version: 1.0 (Apple Message framework v752.3)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Git Mailing List" <git@vger.kernel.org>
To: Alex Riesen <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jul 02 18:36:48 2007
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I5OtJ-000307-LK
	for gcvg-git@gmane.org; Mon, 02 Jul 2007 18:36:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756300AbXGBQgm (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 2 Jul 2007 12:36:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756219AbXGBQgl
	(ORCPT <rfc822;git-outgoing>); Mon, 2 Jul 2007 12:36:41 -0400
Received: from vs072.rosehosting.com ([216.114.78.72]:51136 "EHLO
	silverinsanity.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756106AbXGBQgk (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 Jul 2007 12:36:40 -0400
Received: from [192.168.1.4] (cpe-69-205-115-17.rochester.res.rr.com [69.205.115.17])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by silverinsanity.com (Postfix) with ESMTP id D43D41FFC036;
	Mon,  2 Jul 2007 16:36:39 +0000 (UTC)
In-Reply-To: <81b0412b0707020146x74f1a707na27cc3e5e16f75ad@mail.gmail.com>
X-Mailer: Apple Mail (2.752.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/51380>


On Jul 2, 2007, at 4:46 AM, Alex Riesen wrote:

> ... and I suspect it is broken on MacOSX as well.
> I suggest we disable the test completely on Cygwin/MinGW,
> and after a test of course, on MacOSX.

The only test that is broken for me (on OS X) is t9400 (9, 11,13).   
t3902 goes by without a problem.

The filenames in there must use the same normalized form as OS X does  
internally.

~~ Brian

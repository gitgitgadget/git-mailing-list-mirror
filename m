From: Geert Bosch <bosch@adacore.com>
Subject: Re: man pages are littered with .ft C and others
Date: Sat, 2 Feb 2008 12:46:20 -0500
Message-ID: <79B19ABE-C310-472D-84C9-7D95670F25DD@adacore.com>
References: <alpine.DEB.1.00.0802021055180.21831@an.sumeria>
Mime-Version: 1.0 (iPhone Mail 4A93)
Content-Type: text/plain;
	charset=US-ASCII;
	format=flowed;
	delsp=yes
Content-Transfer-Encoding: 7bit
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Adam Flott <adam@npjh.com>
X-From: git-owner@vger.kernel.org Sat Feb 02 18:48:06 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JLMTF-0000TV-77
	for gcvg-git-2@gmane.org; Sat, 02 Feb 2008 18:48:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752020AbYBBRrc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 2 Feb 2008 12:47:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752017AbYBBRrc
	(ORCPT <rfc822;git-outgoing>); Sat, 2 Feb 2008 12:47:32 -0500
Received: from rock.gnat.com ([205.232.38.15]:42001 "EHLO rock.gnat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751924AbYBBRrc (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 2 Feb 2008 12:47:32 -0500
Received: from localhost (localhost.localdomain [127.0.0.1])
	by filtered-rock.gnat.com (Postfix) with ESMTP id 65C372AA072;
	Sat,  2 Feb 2008 12:47:31 -0500 (EST)
Received: from rock.gnat.com ([127.0.0.1])
	by localhost (rock.gnat.com [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id ZSPvsoteB2g4; Sat,  2 Feb 2008 12:47:31 -0500 (EST)
Received: from [172.16.1.96] (sdsl-216-220-103-157.dsl.bway.net [216.220.103.157])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by rock.gnat.com (Postfix) with ESMTP id 0A0B62AA071;
	Sat,  2 Feb 2008 12:47:31 -0500 (EST)
In-Reply-To: <alpine.DEB.1.00.0802021055180.21831@an.sumeria>
X-Mailer: iPhone Mail (4A93)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/72291>

On Feb 2, 2008, at 12:25, Adam Flott <adam@npjh.com> wrote:
> I do remember at one point the man pages looking correctly (just  
> tested
> v1.5.3.8 and it shows the same problem). Therefore it is probably
> some package I'm missing on my system.
>
> And now, I see this scattered all over:
>
> For example:
>
>     .ft C
>     $ git checkout master             \fB(1)\fR
>     $ git checkout master~2 Makefile  \fB(2)\fR
>     $ rm -f hello.c
>     $ git checkout hello.c            \fB(3)\fR
>     .ft
>
> Seems that "------------" and <n>, and a few others aren't being
> translated.
(...)
> Anyone else seeing this?
Yes, I'm seeing this on mac as well.

-geert

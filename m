From: Eygene Ryabinkin <rea-git@codelabs.ru>
Subject: Re: Memory overrun in http-push.c
Date: Thu, 1 Mar 2007 14:26:11 +0300
Message-ID: <20070301112611.GC63606@codelabs.ru>
References: <20070228151516.GC57456@codelabs.ru> <200702281541.41164.andyparkins@gmail.com> <20070301051323.GG57456@codelabs.ru> <81b0412b0703010015l5c91c68pd4748ae379db98bb@mail.gmail.com> <20070301091058.GA63606@codelabs.ru> <81b0412b0703010121s59884556ha36e5ff72010f96c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Cc: Andy Parkins <andyparkins@gmail.com>, git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Alex Riesen <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Thu Mar 01 12:27:22 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HMjQS-0000wt-Sc
	for gcvg-git@gmane.org; Thu, 01 Mar 2007 12:26:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933239AbXCAL0U (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 1 Mar 2007 06:26:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933244AbXCAL0U
	(ORCPT <rfc822;git-outgoing>); Thu, 1 Mar 2007 06:26:20 -0500
Received: from pobox.codelabs.ru ([144.206.177.45]:62160 "EHLO
	pobox.codelabs.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933239AbXCAL0T (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 Mar 2007 06:26:19 -0500
Received: from codelabs.ru (pobox.codelabs.ru [144.206.177.45])
	by pobox.codelabs.ru with esmtpsa (TLSv1:AES256-SHA:256)
	id 1HMjQO-000GqH-8o; Thu, 01 Mar 2007 14:26:16 +0300
Content-Disposition: inline
In-Reply-To: <81b0412b0703010121s59884556ha36e5ff72010f96c@mail.gmail.com>
X-Spam-Status: No, score=-1.9 required=4.0 tests=ALL_TRUSTED,AWL,BAYES_50
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/41084>

Thu, Mar 01, 2007 at 10:21:47AM +0100, Alex Riesen wrote:
> On 3/1/07, Eygene Ryabinkin <rea-git@codelabs.ru> wrote:
> >OK, I've forgot to ask in my previous letter: will the issue with
> >'+11' instead of '+1' be fixed (or its already fixed)? Or 11 is 10 + 1,
> >where 10 it strlen("git") trice plus one just to be sure? ;)))
> 
> Your patch is already commited.

Thank you!
-- 
Eygene

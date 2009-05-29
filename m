From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git-svn: refuse to dcommit non-UTF-8 messages
Date: Fri, 29 May 2009 00:56:28 -0700
Message-ID: <7v3aaoe40j.fsf@alter.siamese.dyndns.org>
References: <op.uuljhmmg1e62zd@balu.cs.uni-paderborn.de>
	<20090528080706.GA9239@dcvr.yhbt.net>
	<20090528081804.GB9239@dcvr.yhbt.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Brandon Casey <drafnel@gmail.com>
To: Eric Wong <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Fri May 29 09:56:39 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M9wxC-0000fE-1r
	for gcvg-git-2@gmane.org; Fri, 29 May 2009 09:56:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753979AbZE2H43 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 29 May 2009 03:56:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753749AbZE2H42
	(ORCPT <rfc822;git-outgoing>); Fri, 29 May 2009 03:56:28 -0400
Received: from fed1rmmtao105.cox.net ([68.230.241.41]:52033 "EHLO
	fed1rmmtao105.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752225AbZE2H41 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 May 2009 03:56:27 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao105.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20090529075628.UHBV20430.fed1rmmtao105.cox.net@fed1rmimpo01.cox.net>;
          Fri, 29 May 2009 03:56:28 -0400
Received: from localhost ([68.225.240.211])
	by fed1rmimpo01.cox.net with bizsmtp
	id xKwV1b0014aMwMQ03KwVBG; Fri, 29 May 2009 03:56:29 -0400
X-Authority-Analysis: v=1.0 c=1 a=X5p2AuBCShgA:10 a=iP3C-SWiKv8A:10
 a=Hbzmh3xeAAAA:8 a=uMf4GC2R7Isx0c16deMA:9 a=rAqBFE3S7BK-af86vTGgPd4udEIA:4
 a=BEwxGj72lFYA:10
X-CM-Score: 0.00
In-Reply-To: <20090528081804.GB9239@dcvr.yhbt.net> (Eric Wong's message of "Thu\, 28 May 2009 01\:18\:04 -0700")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/120256>

Eric Wong <normalperson@yhbt.net> writes:

>  t/t9139-git-svn-non-utf8-commitencoding.sh |   47 ++++++++++++++++++++++++++++

Hmm.

> +# Copyright (c) 2009 Eric Wong
> +
> +test_description='git svn refuses to dcommit non-UTF8 messages'
> +
> +. ./lib-git-svn.sh

This passes when merged to 'master', but together with bc/old-iconv branch
cooking in 'next' it breaks.

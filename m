From: Eygene Ryabinkin <rea-git@codelabs.ru>
Subject: Re: [PATCH] Teach Makefile to respect external variables: CFLAGS and others.
Date: Wed, 13 Jun 2007 11:15:14 +0400
Message-ID: <20070613071514.GP86872@void.codelabs.ru>
References: <20070613054229.GM86872@void.codelabs.ru> <7v4plcgzer.fsf@assigned-by-dhcp.pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>, sam@ravnborg.org
X-From: git-owner@vger.kernel.org Wed Jun 13 09:15:26 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HyN4e-00076G-B1
	for gcvg-git@gmane.org; Wed, 13 Jun 2007 09:15:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755395AbXFMHPX (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 13 Jun 2007 03:15:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755450AbXFMHPX
	(ORCPT <rfc822;git-outgoing>); Wed, 13 Jun 2007 03:15:23 -0400
Received: from pobox.codelabs.ru ([144.206.177.45]:51470 "EHLO
	pobox.codelabs.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754306AbXFMHPW (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Jun 2007 03:15:22 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=simple; s=one; d=codelabs.ru;
	h=Received:Date:From:To:Cc:Message-ID:References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To:Sender:X-Spam-Status:Subject;
	b=gZQ7DWf6Opv7r2YzdIuZQS7L6M9Hi6g0NhzB/nCkbHJ4Ntvd9NbwNyzF9Ood2J2EsZ6bgE8l3EXirjisN9ATDIAwUcryi/5PnoCDGyWMy4aGSYY5v4iB8uxZAB5lPz4tZtd2mhrE6YRjFYwAfXUrQM5x2rurEs6pHoed+R+azd0=;
Received: from void.codelabs.ru (void.codelabs.ru [144.206.177.25])
	by pobox.codelabs.ru with esmtpsa (TLSv1:AES256-SHA:256)
	id 1HyN4Z-000ChJ-9w; Wed, 13 Jun 2007 11:15:19 +0400
Content-Disposition: inline
In-Reply-To: <7v4plcgzer.fsf@assigned-by-dhcp.pobox.com>
X-Spam-Status: No, score=-1.5 required=4.0 tests=ALL_TRUSTED,AWL,BAYES_50
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/50024>

Junio, Sam, good day.

Tue, Jun 12, 2007 at 11:07:56PM -0700, Junio C Hamano wrote:
> I run "make CFLAGS=-O0 -g" all the time.  Also "make CC=echo"
> seems to "work" as expected ;-).
> 
> Care to elaborate what problem you are trying to solve?

As Sam Ravnborg kindly pointed out, you're using make variables
and I am trying to give the respect to the environment variables.

And the real problem is that one (for example, me) can try to
build Git with the different compiler than CC (gccX or icc, for
example).  And it is much better for lazy people to do 'export
CC=whatever' once and then fire make any number of times ;))

Answering Sam: yes, with my patch it is easier to inherit the
variables from the environment.  But it is not clear if it is
good or bad ;))

But anyway, this patch is only my suggestion, and it can be
thrown away :)
-- 
Eygene

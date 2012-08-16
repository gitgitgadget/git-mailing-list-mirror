From: Heiko Voigt <hvoigt@hvoigt.net>
Subject: Re: [PATCH] help: correct behavior for is_executable on Windows
Date: Thu, 16 Aug 2012 18:35:43 +0200
Message-ID: <20120816163543.GA45275@book.hvoigt.net>
References: <20120811070030.GA83665@book.hvoigt.net> <7vd32whgvl.fsf@alter.siamese.dyndns.org> <20120813170221.GB6418@book.hvoigt.net> <7vmx1yel9d.fsf@alter.siamese.dyndns.org> <20120815165054.GA43523@book.hvoigt.net> <7v7gt06nyk.fsf@alter.siamese.dyndns.org> <20120815222911.GA44080@book.hvoigt.net> <7va9xv4uir.fsf@alter.siamese.dyndns.org> <7vwr0z387c.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Aug 16 18:35:53 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T2333-0004xD-3Q
	for gcvg-git-2@plane.gmane.org; Thu, 16 Aug 2012 18:35:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933082Ab2HPQfr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 16 Aug 2012 12:35:47 -0400
Received: from smtprelay06.ispgateway.de ([80.67.31.101]:41485 "EHLO
	smtprelay06.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932996Ab2HPQfq (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 Aug 2012 12:35:46 -0400
Received: from [77.21.76.22] (helo=localhost)
	by smtprelay06.ispgateway.de with esmtpsa (TLSv1:AES256-SHA:256)
	(Exim 4.68)
	(envelope-from <hvoigt@hvoigt.net>)
	id 1T232u-0003qH-5s; Thu, 16 Aug 2012 18:35:44 +0200
Content-Disposition: inline
In-Reply-To: <7vwr0z387c.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.19 (2009-01-05)
X-Df-Sender: aHZvaWd0QGh2b2lndC5uZXQ=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Wed, Aug 15, 2012 at 07:02:31PM -0700, Junio C Hamano wrote:
> Junio C Hamano <gitster@pobox.com> writes:
> 
> > My preference is to remove "static int is_executable()" function
> > from help.c, have an...
> > ... I wouldn't mind seeing the implementation of posix_is_executable()
> > in help.c, which will be dead-code on Windows and Cygwin, if that
> > makes linking and Makefile easier.
> 
> An outline of such a change might look like this.

Thanks for the outline and the clarification, I will use it to cook up
something.

Cheers Heiko

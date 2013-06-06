From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Dependencies and packaging (Re: [Administrivia] On ruby and contrib/)
Date: Thu, 6 Jun 2013 14:31:24 -0700
Message-ID: <20130606213124.GB12924@google.com>
References: <7vtxld30f2.fsf@alter.siamese.dyndns.org>
 <7va9n52zjc.fsf@alter.siamese.dyndns.org>
 <rmivc5rp9w2.fsf@fnord.ir.bbn.com>
 <CAMP44s07p0vpS_2cjAjB=QWoZjjPSuAm09xwk4BjAAD+hsJrSw@mail.gmail.com>
 <rmisj0vnorm.fsf@fnord.ir.bbn.com>
 <CALkWK0kQSuvv9owUYxatKTKW+GEpR0kL6XsyrOJD66yfodycUQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Greg Troxel <gdt@ir.bbn.com>,
	Felipe Contreras <felipe.contreras@gmail.com>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Jeff King <peff@peff.net>, Thomas Rast <trast@inf.ethz.ch>,
	=?iso-8859-1?Q?Ren=E9?= Scharfe <rene.scharfe@lsrfire.ath.cx>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	=?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= <pclouds@gmail.com>,
	Ramsay Jones <ramsay@ramsay1.demon.co.uk>,
	Erik Faye-Lund <kusmabite@gmail.com>,
	Johannes Sixt <j6t@kdbg.org>,
	Johannes Schindelin <johannes.schindelin@gmx.de>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jun 06 23:32:11 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ukhn0-0005rO-Mo
	for gcvg-git-2@plane.gmane.org; Thu, 06 Jun 2013 23:32:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753403Ab3FFVcG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 6 Jun 2013 17:32:06 -0400
Received: from mail-ob0-f174.google.com ([209.85.214.174]:42288 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752908Ab3FFVcC (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Jun 2013 17:32:02 -0400
Received: by mail-ob0-f174.google.com with SMTP id wd20so5522385obb.33
        for <git@vger.kernel.org>; Thu, 06 Jun 2013 14:32:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=V/NibahbGvBsZ5FvctvqlyMB/c7irL4nSLh0TMEz8gY=;
        b=nMxgtFJsbcGuPaURGVTOQYtUd3RbbCRnwOgqE1y2FC1vJj4dnXg8JdeYVjG9Fq6gdK
         4piIX9xZ+twi5G87BguWg7X/YoVO5SvxcJ0cm6I/tjIL3zPzMybvxBLQQKcC8QFw0PvG
         +iSsAHuCCY5rUiMSoi1tAaGTgL+CBPZxFvY8lIL917dfvQPkjK3s71UTy9EHtOpE6Pa6
         w1KCdd7XFucZVE7NXzr8gD45V7NmCtWInLxYx7pZaThOsw4sfr3od05L8/XSvsv2rN56
         7+cZtnIoDNps6JggNAv/uUbCDikL6wg45hmUvkb76JfFP48lhdxjoghwztyWRGOm+lsx
         IQZw==
X-Received: by 10.182.171.9 with SMTP id aq9mr19615031obc.16.1370554322248;
        Thu, 06 Jun 2013 14:32:02 -0700 (PDT)
Received: from google.com ([2620:0:1000:5b00:b6b5:2fff:fec3:b50d])
        by mx.google.com with ESMTPSA id oe10sm15961887oeb.6.2013.06.06.14.31.59
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Thu, 06 Jun 2013 14:32:01 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CALkWK0kQSuvv9owUYxatKTKW+GEpR0kL6XsyrOJD66yfodycUQ@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/226564>

Ramkumar Ramachandra wrote:

>                                      Git is probably the _last_ thing
> to be complaining about when it comes to packaging.

It would be nice if contrib/ files supported the usual "make; make
install; make clean" targets.  That's missing functionality that does
matter to at least one packager.

It would be nice if the dependencies associated to each piece of
functionality or makefile flag were documented more clearly.
Currently when e.g. features of gitweb gain dependencies I don't
notice until the testsuite fails.

Jonathan

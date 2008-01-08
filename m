Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: **
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=2.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,LIST_MIRROR_BCC,RP_MATCHES_RCVD shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.0
Received: (qmail 19443 invoked by uid 111); 8 Jan 2008 18:12:14 -0000
Received: from vger.kernel.org (HELO vger.kernel.org) (209.132.176.167)
    by peff.net (qpsmtpd/0.32) with ESMTP; Tue, 08 Jan 2008 13:12:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753919AbYAHSMG (ORCPT <rfc822;peff@peff.net>);
	Tue, 8 Jan 2008 13:12:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755832AbYAHSMF
	(ORCPT <rfc822;git-outgoing>); Tue, 8 Jan 2008 13:12:05 -0500
Received: from blaine.gmane.org ([80.91.229.8]:48939 "EHLO hugh.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755660AbYAHSMD (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Jan 2008 13:12:03 -0500
Received: from public by hugh.gmane.org with local (Exim 4.63)
	(envelope-from <public@hugh.gmane.org>)
	id 1JCIu5-0007Rb-71
	for git@vger.kernel.org; Tue, 08 Jan 2008 19:10:21 +0100
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25] helo=sasl.smtp.pobox.com)
	by hugh.gmane.org with esmtp (Exim 4.63)
	(envelope-from <gitster@pobox.com>)
	id 1JCIrN-0005Tm-Fd; Tue, 08 Jan 2008 19:07:33 +0100
Received: from a-sasl-quonix (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 7C94FCB3B;
	Tue,  8 Jan 2008 13:07:30 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 14C89CB34;
	Tue,  8 Jan 2008 13:07:20 -0500 (EST)
From:	Junio C Hamano <gitster@pobox.com>
To:	public-prohaska-wjoc1KHpMeg@hugh.gmane.org
Cc:	"J. Bruce Fields" 
	<public-bfields-uC3wQj2KruNg9hUCZPvPmw@hugh.gmane.org>,
	Johannes Schindelin 
	<public-Johannes.Schindelin-Mmb7MZpHnFY@hugh.gmane.org>,
	Robin Rosenberg 
	<public-robin.rosenberg.lists-RgPrefM1rjDQT0dZR+AlfA@hugh.gmane.org>,
	Jeff King <public-peff-AdEPDUrAXsQ@hugh.gmane.org>,
	Peter Karlsson 
	<public-peter-wzhfs8O2nkI+/KzbbBz5qQ@hugh.gmane.org>,
	Git Mailing List 
	<public-git-u79uwXL29TY76Z2rM5mHXA@hugh.gmane.org>,
	public-msysgit-/JYPxA39Uh5TLH3MbocFFw@hugh.gmane.org
Subject: Re: CRLF problems with Git on Win32
References: <Pine.LNX.4.64.0801071010340.1864@ds9.cixit.se>
	<200801071947.28586.robin.rosenberg.lists@dewire.com>
	<alpine.LSU.1.00.0801071915470.10101@racer.site>
	<200801072203.23938.robin.rosenberg.lists@dewire.com>
	<alpine.LSU.1.00.0801072115120.10101@racer.site>
	<3B08AC4C-A807-4155-8AD7-DC6A6D0FE134@zib.de>
	<20080108172957.GG22155@fieldses.org>
	<CE10C08D-AAF1-44B5-89B5-9A16A4AB70EA@zib.de>
Date:	Tue, 08 Jan 2008 10:07:19 -0800
In-Reply-To: <CE10C08D-AAF1-44B5-89B5-9A16A4AB70EA@zib.de> (Steffen Prohaska's
	message of "Tue, 8 Jan 2008 18:56:28 +0100")
Message-ID: <7vmyrgry20.fsf@gitster.siamese.dyndns.org>
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org



Steffen Prohaska <prohaska-wjoc1KHpMeg@public.gmane.org> writes:

> msysgit installs plain git.  core.autocrlf is unset.  Whatever plain
> git's default is, this is msysgit's default, too.

That sounds like a mistake if you are installing a port to a
platform whose native line ending convention is different from
where plain git natively runs on (i.e. UNIX).


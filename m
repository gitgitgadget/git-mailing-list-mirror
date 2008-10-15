From: "Lars Hoss" <lars@woeye.net>
Subject: Re: [BUG] git status doesn't handle submodules properly on OSX
Date: Wed, 15 Oct 2008 17:14:21 +0200 (CEST)
Message-ID: <cb12ad6f061a80750569e3f8b9d9b9d0.squirrel@webmail.highteq.net>
References: <c60a85c1297be6446ad92a3e7723ddc8.squirrel@webmail.highteq.net>
    <5D0481A4-D173-4CF8-B855-5E58978210F8@ai.rug.nl>
    <6ca24750ca8d7bd9e995d023e78e0d71.squirrel@webmail.highteq.net>
    <A0A3837E-7F85-4172-A8BA-969BFD46CF48@ai.rug.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: "Lars Hoss" <lars@woeye.net>, "Jeff King" <peff@peff.net>,
	"Git Mailinglist" <git@vger.kernel.org>
To: "Pieter de Bie" <pdebie@ai.rug.nl>
X-From: git-owner@vger.kernel.org Wed Oct 15 17:12:37 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kq838-00025z-2J
	for gcvg-git-2@gmane.org; Wed, 15 Oct 2008 17:12:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753163AbYJOPLW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 15 Oct 2008 11:11:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753231AbYJOPLW
	(ORCPT <rfc822;git-outgoing>); Wed, 15 Oct 2008 11:11:22 -0400
Received: from mail.codewut.de ([78.47.135.140]:50143 "EHLO mail.codewut.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753073AbYJOPLV (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 15 Oct 2008 11:11:21 -0400
Received: by mail.codewut.de (Postfix, from userid 65534)
	id 7C8167BEF1; Wed, 15 Oct 2008 17:14:24 +0200 (CEST)
X-Spam-Checker-Version: SpamAssassin 3.1.7-deb (2006-10-05) on mail.codewut.de
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=5.0 tests=AWL,BAYES_00 autolearn=ham 
	version=3.1.7-deb
Received: from webmail.highteq.net (web.highteq.net [78.47.135.138])
	by mail.codewut.de (Postfix) with ESMTP id CA7F97BE67;
	Wed, 15 Oct 2008 17:14:21 +0200 (CEST)
Received: from 194.127.8.18
        (SquirrelMail authenticated user lars)
        by webmail.highteq.net with HTTP;
        Wed, 15 Oct 2008 17:14:21 +0200 (CEST)
In-Reply-To: <A0A3837E-7F85-4172-A8BA-969BFD46CF48@ai.rug.nl>
User-Agent: SquirrelMail/1.4.15
X-Priority: 3 (Normal)
Importance: Normal
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/98280>

> I just tested 1.6.0.2, and had no problems. Perhaps macports is doing
> something odd?

Actually this was my idea first. Thus I build git from the sources the
portfile links to myself. The bug, however, remains.

The link is: http://www.kernel.org/pub/software/scm/git/git-1.6.0.2.tar.bz2.

I've tested this on two machines, both using latest version of Leopard.
And there was another poster on this forum who had the very same issue.

Now the interesting question is what is different between Pieter's system
and mine? And why does 1.5.6 work fine?

As soon as I am at home I will try bisect. I am currently at work behind a
big bad firewall ;)

Yours,
Lars

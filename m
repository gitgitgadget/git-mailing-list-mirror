From: Jeff King <peff@peff.net>
Subject: Re: white spaces in a patch
Date: Wed, 17 Dec 2008 07:22:41 -0500
Message-ID: <20081217122240.GA14342@coredump.intra.peff.net>
References: <dac45060812162331k19272488r4e95e0555e7a6db9@mail.gmail.com> <bd6139dc0812170413j5ed2d9eak89df8517bc91c5fd@mail.gmail.com> <dac45060812170413w7c8cffaifa1a0f3b649474e4@mail.gmail.com> <200812171316.21531.thomas.jarosch@intra2net.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Mark Ryden <markryde@gmail.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Thomas Jarosch <thomas.jarosch@intra2net.com>
X-From: git-owner@vger.kernel.org Wed Dec 17 13:24:04 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LCvRZ-0000Zd-Ug
	for gcvg-git-2@gmane.org; Wed, 17 Dec 2008 13:24:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751391AbYLQMWo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 17 Dec 2008 07:22:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751379AbYLQMWo
	(ORCPT <rfc822;git-outgoing>); Wed, 17 Dec 2008 07:22:44 -0500
Received: from peff.net ([208.65.91.99]:3547 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751334AbYLQMWn (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Dec 2008 07:22:43 -0500
Received: (qmail 26265 invoked by uid 111); 17 Dec 2008 12:22:42 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Wed, 17 Dec 2008 07:22:42 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Wed, 17 Dec 2008 07:22:41 -0500
Content-Disposition: inline
In-Reply-To: <200812171316.21531.thomas.jarosch@intra2net.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/103344>

On Wed, Dec 17, 2008 at 01:15:56PM +0100, Thomas Jarosch wrote:

> This should do the trick:
> 
> git config --global color.diff auto
> git config --global color.status auto
> git config --global color.branch auto

These days we have

  git config --global color.ui auto

-Peff

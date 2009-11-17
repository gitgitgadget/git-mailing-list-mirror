From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] RFC Allow case insensitive search flag with git-grep
 for fixed-strings
Date: Tue, 17 Nov 2009 02:38:45 -0500
Message-ID: <20091117073845.GC4007@coredump.intra.peff.net>
References: <B7C4E16C-B15D-4A7B-873A-B6BD0FDAD8C8@gmail.com>
 <20091116195050.6117@nanako3.lavabit.com>
 <7vocn2m48d.fsf@alter.siamese.dyndns.org>
 <7v639am2uq.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Brian Collins <bricollins@gmail.com>,
	Nanako Shiraishi <nanako3@lavabit.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Nov 17 08:38:53 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NAIeI-0004ZD-NZ
	for gcvg-git-2@lo.gmane.org; Tue, 17 Nov 2009 08:38:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755851AbZKQHij (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Nov 2009 02:38:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755842AbZKQHij
	(ORCPT <rfc822;git-outgoing>); Tue, 17 Nov 2009 02:38:39 -0500
Received: from peff.net ([208.65.91.99]:32823 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755839AbZKQHij (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Nov 2009 02:38:39 -0500
Received: (qmail 21817 invoked by uid 107); 17 Nov 2009 07:42:33 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Tue, 17 Nov 2009 02:42:33 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Tue, 17 Nov 2009 02:38:45 -0500
Content-Disposition: inline
In-Reply-To: <7v639am2uq.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/133071>

On Mon, Nov 16, 2009 at 04:06:37PM -0800, Junio C Hamano wrote:

> By the way, I would suggest updating the test like the attached.
> 
> By looking for rEtUrN, you will catch a bug that breaks "-i"-ness
> of the grep, but your test does not catch breakages in "-F"-ness.

Your change looks good to me.

-Peff

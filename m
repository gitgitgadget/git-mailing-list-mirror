From: John Keeping <john@keeping.me.uk>
Subject: Re: [PATCH 5/7] enforce `xfuncname` precedence over `funcname`
Date: Thu, 24 Jul 2014 20:04:03 +0100
Message-ID: <20140724190403.GF26927@serenity.lan>
References: <1406140978-9472-1-git-send-email-tanayabh@gmail.com>
 <1406140978-9472-6-git-send-email-tanayabh@gmail.com>
 <xmqqtx67bt78.fsf@gitster.dls.corp.google.com>
 <vpqlhrjqmyw.fsf@anie.imag.fr>
 <xmqqiommadl0.fsf@gitster.dls.corp.google.com>
 <53D15188.2010209@gmail.com>
 <vpqegxa386m.fsf@anie.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Tanay Abhra <tanayabh@gmail.com>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Ramkumar Ramachandra <artagnon@gmail.com>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Thu Jul 24 21:11:37 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XAOQR-0000EW-23
	for gcvg-git-2@plane.gmane.org; Thu, 24 Jul 2014 21:11:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759505AbaGXTLb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 Jul 2014 15:11:31 -0400
Received: from coyote.aluminati.org ([72.9.247.114]:43306 "EHLO
	coyote.aluminati.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759440AbaGXTLa (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Jul 2014 15:11:30 -0400
X-Greylist: delayed 436 seconds by postgrey-1.27 at vger.kernel.org; Thu, 24 Jul 2014 15:11:30 EDT
Received: from localhost (localhost [127.0.0.1])
	by coyote.aluminati.org (Postfix) with ESMTP id E234D6064CF;
	Thu, 24 Jul 2014 20:04:13 +0100 (BST)
X-Quarantine-ID: <OhxVEueq12jI>
X-Virus-Scanned: Debian amavisd-new at caracal.aluminati.org
X-Spam-Flag: NO
X-Spam-Score: -0.2
X-Spam-Level: 
X-Spam-Status: No, score=-0.2 tagged_above=-9999 required=6.31
	tests=[ALL_TRUSTED=-1, BAYES_50=0.8] autolearn=no
Received: from coyote.aluminati.org ([127.0.0.1])
	by localhost (coyote.aluminati.org [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id OhxVEueq12jI; Thu, 24 Jul 2014 20:04:12 +0100 (BST)
Received: from serenity.lan (chimera.aluminati.org [10.0.16.60])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by coyote.aluminati.org (Postfix) with ESMTPSA id 924756064D4;
	Thu, 24 Jul 2014 20:04:05 +0100 (BST)
Content-Disposition: inline
In-Reply-To: <vpqegxa386m.fsf@anie.imag.fr>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/254180>

On Thu, Jul 24, 2014 at 08:47:45PM +0200, Matthieu Moy wrote:
> Tanay Abhra <tanayabh@gmail.com> writes:
> > Also can you name any third party apps that use the git_config()
> > system on which I can test the patches.
> 
> There are probably tons of. I can think of git-multimail.

CGit [1] is probably the only one that links with libgit.a and uses the
internal C API.

[1] http://git.zx2c4.com/cgit/

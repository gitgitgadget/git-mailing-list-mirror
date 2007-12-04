From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Allow HTTP proxy to be overridden in config
Date: Tue, 04 Dec 2007 00:49:39 -0800
Message-ID: <7vodd66dzw.fsf@gitster.siamese.dyndns.org>
References: <1195776420-22075-1-git-send-email-sam.vilain@catalyst.net.nz>
	<7voddl24b7.fsf@gitster.siamese.dyndns.org>
	<47464A90.4030509@catalyst.net.nz>
	<7vhcj387jh.fsf@gitster.siamese.dyndns.org>
	<475479C6.3050506@catalyst.net.nz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, francois@debian.org
To: Sam Vilain <sam.vilain@catalyst.net.nz>
X-From: git-owner@vger.kernel.org Tue Dec 04 09:50:18 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IzTTu-0007H1-4o
	for gcvg-git-2@gmane.org; Tue, 04 Dec 2007 09:50:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751479AbXLDIt6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 4 Dec 2007 03:49:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751442AbXLDIt6
	(ORCPT <rfc822;git-outgoing>); Tue, 4 Dec 2007 03:49:58 -0500
Received: from sceptre.pobox.com ([207.106.133.20]:33369 "EHLO
	sceptre.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751360AbXLDIt6 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Dec 2007 03:49:58 -0500
Received: from sceptre (localhost.localdomain [127.0.0.1])
	by sceptre.pobox.com (Postfix) with ESMTP id 412CE2EF;
	Tue,  4 Dec 2007 03:50:10 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by sceptre.sasl.smtp.pobox.com (Postfix) with ESMTP id C1DFB9BB55;
	Tue,  4 Dec 2007 03:50:06 -0500 (EST)
In-Reply-To: <475479C6.3050506@catalyst.net.nz> (Sam Vilain's message of "Tue,
	04 Dec 2007 10:48:54 +1300")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/67027>

Sam Vilain <sam.vilain@catalyst.net.nz> writes:

> Subject: [PATCH] Add remote.<name>.proxy
>
> As well as allowing a default proxy option, allow it to be set
> per-remote.

Thanks.

I was very tempted to rename them to remote.*.httpproxy, but ended up
keeping the name of the variable.  We might want to allow tunnelling the
git native transport over the named proxy when remote.*.url is native
transport.

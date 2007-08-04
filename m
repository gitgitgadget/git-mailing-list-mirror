From: Alexandre Julliard <julliard@winehq.org>
Subject: Re: [RFC/PATCH] update-index: Add a --refresh-only option to refresh specified files.
Date: Sat, 04 Aug 2007 23:31:02 +0200
Message-ID: <87hcnfj8bt.fsf@wine.dyndns.org>
References: <87odhnk4cb.fsf@wine.dyndns.org>
	<7vlkcrgnd1.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Aug 04 23:31:17 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IHRDQ-0000Wm-8Z
	for gcvg-git@gmane.org; Sat, 04 Aug 2007 23:31:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762391AbXHDVbN (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 4 Aug 2007 17:31:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1762141AbXHDVbN
	(ORCPT <rfc822;git-outgoing>); Sat, 4 Aug 2007 17:31:13 -0400
Received: from mail.codeweavers.com ([216.251.189.131]:34566 "EHLO
	mail.codeweavers.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761944AbXHDVbN (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 4 Aug 2007 17:31:13 -0400
Received: from adsl-84-226-58-170.adslplus.ch ([84.226.58.170] helo=wine.dyndns.org)
	by mail.codeweavers.com with esmtpsa (TLS-1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.63)
	(envelope-from <julliard@winehq.org>)
	id 1IHRDE-0000aL-Ej; Sat, 04 Aug 2007 16:31:04 -0500
Received: by wine.dyndns.org (Postfix, from userid 1000)
	id 19B20429EA1; Sat,  4 Aug 2007 23:31:02 +0200 (CEST)
In-Reply-To: <7vlkcrgnd1.fsf@assigned-by-dhcp.cox.net> (Junio C. Hamano's message of "Sat\, 04 Aug 2007 11\:34\:34 -0700")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.1.50 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/54908>

Junio C Hamano <gitster@pobox.com> writes:

> Makes me wonder why it is not like:
>
> 	$ git update-index --refresh Documentation/
>
> That is:
>
>  - why a new option?

It was to avoid breaking backwards compatibility, since passing files
with --refresh currently has a different meaning. But if you think we
can change that, then sure, it would be much nicer.

>  - why not a pathspec or glob, similar to what ls-files gets?

I'm not sure, would this really belong in update-index since it
currently always requires explicit pathnames?  Or should it be in a
higher-level command like git-add --refresh?

-- 
Alexandre Julliard
julliard@winehq.org

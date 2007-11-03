From: Mike Hommey <mh@glandium.org>
Subject: Re: [PATCH] Reuse previous annotation when overwriting a tag
Date: Sat, 3 Nov 2007 13:27:07 +0100
Organization: glandium.org
Message-ID: <20071103122707.GA7227@glandium.org>
References: <1194082273-19486-1-git-send-email-mh@glandium.org> <Pine.LNX.4.64.0711031148460.4362@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sat Nov 03 13:28:37 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IoI7A-00083I-Pg
	for gcvg-git-2@gmane.org; Sat, 03 Nov 2007 13:28:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753519AbXKCM2V (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 3 Nov 2007 08:28:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753514AbXKCM2V
	(ORCPT <rfc822;git-outgoing>); Sat, 3 Nov 2007 08:28:21 -0400
Received: from vawad.err.no ([85.19.200.177]:49594 "EHLO vawad.err.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753474AbXKCM2V (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 3 Nov 2007 08:28:21 -0400
Received: from aputeaux-153-1-33-156.w82-124.abo.wanadoo.fr ([82.124.3.156] helo=namakemono.glandium.org)
	by vawad.err.no with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.62)
	(envelope-from <mh@glandium.org>)
	id 1IoI6n-0002JX-Qy; Sat, 03 Nov 2007 13:28:16 +0100
Received: from mh by namakemono.glandium.org with local (Exim 4.68)
	(envelope-from <mh@glandium.org>)
	id 1IoI5j-0001uc-F4; Sat, 03 Nov 2007 13:27:07 +0100
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0711031148460.4362@racer.site>
X-GPG-Fingerprint: A479 A824 265C B2A5 FC54  8D1E DE4B DA2C 54FD 2A58
User-Agent: Mutt/1.5.16 (2007-06-11)
X-Spam-Status: (score 2.0): Status=No hits=2.0 required=5.0 tests=RCVD_IN_SORBS_DUL version=3.1.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/63256>

On Sat, Nov 03, 2007 at 11:54:38AM +0000, Johannes Schindelin wrote:
> Why not teach write_annotations() (or write_tag_body() like I would prefer 
> it to be called) to grok a null_sha1?  It's not like we care for 
> performance here, but rather for readability and ease of use.

By the way, I think it would be much better if this function was made
more generic and would not write, but return an strbuf containing the
object body. It could also be used by e.g. git-commit --amend.

What would be the best suited place for such a function ?

Mike

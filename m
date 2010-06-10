From: Brian Downing <bdowning@lavos.net>
Subject: Re: Serious performance regression in diff between 1.6.6 and 1.7.0
Date: Thu, 10 Jun 2010 13:42:46 -0500
Message-ID: <20100610184246.GD2635@glaurung.lavos.net>
References: <20100610001005.GA2635@glaurung.lavos.net> <20100610170804.GB2635@glaurung.lavos.net> <20100610181421.GC2635@glaurung.lavos.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jun 10 20:42:56 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OMmiM-0006UR-MT
	for gcvg-git-2@lo.gmane.org; Thu, 10 Jun 2010 20:42:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759472Ab0FJSms (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 Jun 2010 14:42:48 -0400
Received: from glaurung.lavos.net ([69.162.133.92]:35662 "EHLO
	glaurung.lavos.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757138Ab0FJSmr (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Jun 2010 14:42:47 -0400
Received: by glaurung.lavos.net (Postfix, from userid 1000)
	id 754327417D; Thu, 10 Jun 2010 13:42:46 -0500 (CDT)
Content-Disposition: inline
In-Reply-To: <20100610181421.GC2635@glaurung.lavos.net>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/148907>

On Thu, Jun 10, 2010 at 01:14:21PM -0500, Brian Downing wrote:
> That makes it look sort of exponential (perhaps around files^1.5),
> though from what I can understand of the find_cache_pos code in
> unpack-trees it would depend on the exact shape of the repository.  It
> does seem to linear-search over whole directory trees of the index
> repeatedly, though, which would support the exponential theory.

(I meant polynomial with an exponent > 1 here, not exponential [in the
2^n sense]; sorry!)

-bcd

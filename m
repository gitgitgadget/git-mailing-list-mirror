From: Clemens Buchacher <drizzd@aon.at>
Subject: Re: Auto-refresh git-gui
Date: Wed, 4 Jan 2012 17:33:40 +0100
Message-ID: <20120104163338.GA27567@ecki.lan>
References: <20120104091547.GC3484@victor>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Victor Engmark <victor.engmark@terreactive.ch>
X-From: git-owner@vger.kernel.org Wed Jan 04 17:42:01 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RiTub-0004HG-B9
	for gcvg-git-2@lo.gmane.org; Wed, 04 Jan 2012 17:42:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755857Ab2ADQl5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 Jan 2012 11:41:57 -0500
Received: from bsmtp4.bon.at ([195.3.86.186]:32928 "EHLO bsmtp.bon.at"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752625Ab2ADQl4 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Jan 2012 11:41:56 -0500
Received: from localhost (unknown [80.123.242.182])
	by bsmtp.bon.at (Postfix) with ESMTP id B303F130060;
	Wed,  4 Jan 2012 17:41:54 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <20120104091547.GC3484@victor>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/187933>

Hi Victor,

On Wed, Jan 04, 2012 at 10:15:47AM +0100, Victor Engmark wrote:
>
> Is there some way to make `git-gui` rescan automatically when anything
> in the repository changes?

How about doing it each time git gui gets focus? Or if that's to
much do it only if it gets focus _and_ the index has changed?

Clemens

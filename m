From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [RFC/PATCH] Add a new commit-raw command.
Date: Tue, 24 Feb 2009 15:07:01 -0800
Message-ID: <20090224230701.GW22848@spearce.org>
References: <1235510914-23319-1-git-send-email-felipe.contreras@gmail.com> <20090224221406.GA6299@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org,
	Rene Stadler <renestadler84@gmail.com>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Wed Feb 25 00:09:07 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lc6O8-0005Z4-FW
	for gcvg-git-2@gmane.org; Wed, 25 Feb 2009 00:08:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752910AbZBXXHF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Feb 2009 18:07:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752041AbZBXXHF
	(ORCPT <rfc822;git-outgoing>); Tue, 24 Feb 2009 18:07:05 -0500
Received: from george.spearce.org ([209.20.77.23]:38269 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751471AbZBXXHE (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Feb 2009 18:07:04 -0500
Received: by george.spearce.org (Postfix, from userid 1001)
	id 54AA538210; Tue, 24 Feb 2009 23:07:01 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <20090224221406.GA6299@coredump.intra.peff.net>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/111360>

Jeff King <peff@peff.net> wrote:
> On Tue, Feb 24, 2009 at 11:28:34PM +0200, Felipe Contreras wrote:
> 
> > This command receives as input a raw commit object, and outputs the
> > generated sha1. This is very useful when doing some serious repo
> > reconstructions.
> > 
> > For example: git cat-file -p 343ee25 | git write-raw
> > 343ee2589d1b94772f513cc699765622351acb19
> 
> How about:
> 
>   git cat-file -p 343ee25 | git hash-object -t commit --stdin

And if you are really writing a lot of new objects, use fast-import.

-- 
Shawn.

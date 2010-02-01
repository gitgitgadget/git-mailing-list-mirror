From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: pack.packSizeLimit, safety checks
Date: Mon, 1 Feb 2010 08:28:16 -0800
Message-ID: <20100201162816.GA9394@spearce.org>
References: <loom.20100201T101056-232@post.gmane.org> <alpine.LFD.2.00.1002011100550.1681@xanadu.home> <4B6700CF.1090106@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Nicolas Pitre <nico@fluxnic.net>,
	Sergio <sergio.callegari@gmail.com>, git@vger.kernel.org
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Mon Feb 01 17:28:26 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nbz8T-0004vE-V3
	for gcvg-git-2@lo.gmane.org; Mon, 01 Feb 2010 17:28:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755511Ab0BAQ2V (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 1 Feb 2010 11:28:21 -0500
Received: from qw-out-2122.google.com ([74.125.92.24]:18713 "EHLO
	qw-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754733Ab0BAQ2U (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Feb 2010 11:28:20 -0500
Received: by qw-out-2122.google.com with SMTP id 8so809534qwh.37
        for <git@vger.kernel.org>; Mon, 01 Feb 2010 08:28:19 -0800 (PST)
Received: by 10.224.7.82 with SMTP id c18mr2087647qac.317.1265041699673;
        Mon, 01 Feb 2010 08:28:19 -0800 (PST)
Received: from localhost (george.spearce.org [209.20.77.23])
        by mx.google.com with ESMTPS id 22sm3893996qyk.10.2010.02.01.08.28.17
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 01 Feb 2010 08:28:18 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <4B6700CF.1090106@viscovery.net>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/138622>

Johannes Sixt <j.sixt@viscovery.net> wrote:
> Nicolas Pitre schrieb:
> > Grrrrr.  This is a terrible discrepency given that all the other 
> > arguments in Git are always byte based, with the optional k/m/g suffix, 
> > by using git_parse_ulong().  So IMHO I'd just change --max-pack-size to 
> > be in line with all the rest and have it accept bytes instead of MB.  
> > And of course I'd push such a change to be included in v1.7.0 along with 
> > the other incompatible fixes.
> 
> While at it, also change --big-file-threshold that fast-import learnt the
> other day...

Yup.  WTF was I thinking when I did megabytes as the default unit
on the command line...

-- 
Shawn.

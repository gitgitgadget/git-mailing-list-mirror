From: Michael Dressel <MichaelTiloDressel@t-online.de>
Subject: Re: chronologically listed tags?
Date: Tue, 24 Apr 2007 21:59:00 +0200 (CEST)
Message-ID: <Pine.LNX.4.64.0704242158090.4291@castor.milkiway.cos>
References: <Pine.LNX.4.64.0704241924070.4438@castor.milkiway.cos>
 <20070424174217.GB5942@spearce.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Tue Apr 24 21:59:18 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HgRAT-0005Uf-I3
	for gcvg-git@gmane.org; Tue, 24 Apr 2007 21:59:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423075AbXDXT7O (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 24 Apr 2007 15:59:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423076AbXDXT7N
	(ORCPT <rfc822;git-outgoing>); Tue, 24 Apr 2007 15:59:13 -0400
Received: from mailout10.sul.t-online.com ([194.25.134.21]:36549 "EHLO
	mailout10.sul.t-online.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1423075AbXDXT7M (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 24 Apr 2007 15:59:12 -0400
Received: from fwd26.aul.t-online.de 
	by mailout10.sul.t-online.com with smtp 
	id 1HgRAL-0001KK-00; Tue, 24 Apr 2007 21:59:09 +0200
Received: from [192.168.2.100] (ZktGGEZvweDR5AAcUrV77fmFHuq5PSIDXVAW9F0yMe8-3s5ygX-H8a@[84.163.228.53]) by fwd26.sul.t-online.de
	with esmtp id 1HgRAD-1FA8tE0; Tue, 24 Apr 2007 21:59:01 +0200
X-X-Sender: michael@castor.milkiway.cos
In-Reply-To: <20070424174217.GB5942@spearce.org>
X-ID: ZktGGEZvweDR5AAcUrV77fmFHuq5PSIDXVAW9F0yMe8-3s5ygX-H8a
X-TOI-MSGID: 80ef5e83-dfbc-4afd-8293-a01e3aff0be4
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/45487>



On Tue, 24 Apr 2007, Shawn O. Pearce wrote:

> Michael Dressel <MichaelTiloDressel@t-online.de> wrote:
> > I would like to list tags chronologically. I failed to find out how to do 
> > this using git or cogito directly. So I wrote the simplistic bash script 
> > below. Is there a way more direct way?
> 
> for-each-ref is your friend:
> 
> 	git for-each-ref --sort='taggerdate' refs/tags
> 
> -- 
> Shawn.
> 

Hi Shawn,

great thanx.

Michael

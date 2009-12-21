From: Bertram Scharpf <lists@bertram-scharpf.de>
Subject: Re: Delete a commit
Date: Mon, 21 Dec 2009 22:01:37 +0100
Message-ID: <20091221210137.GA17695@marge.bs.l>
References: <20091219233957.GC29111@marge.bs.l> <hgjpqu$dos$1@ger.gmane.org> <20091220004340.GA30440@marge.bs.l> <hgocfi$pge$1@ger.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Dec 21 22:01:58 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NMpNz-0001as-9T
	for gcvg-git-2@lo.gmane.org; Mon, 21 Dec 2009 22:01:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757060AbZLUVBm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Dec 2009 16:01:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756998AbZLUVBl
	(ORCPT <rfc822;git-outgoing>); Mon, 21 Dec 2009 16:01:41 -0500
Received: from moutng.kundenserver.de ([212.227.126.171]:52478 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756023AbZLUVBk (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Dec 2009 16:01:40 -0500
Received: from bs.l (e180004199.adsl.alicedsl.de [85.180.4.199])
	by mrelayeu.kundenserver.de (node=mreu2) with ESMTP (Nemesis)
	id 0MFwkk-1NGlMd45gM-00EtDg; Mon, 21 Dec 2009 22:01:39 +0100
Received: from bsch by bs.l with local (Exim 4.69)
	(envelope-from <lists@bertram-scharpf.de>)
	id 1NMpNp-0004cb-H6
	for git@vger.kernel.org; Mon, 21 Dec 2009 22:01:37 +0100
Mail-Followup-To: git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <hgocfi$pge$1@ger.gmane.org>
User-Agent: Mutt/1.5.16 (2007-06-09)
X-Provags-ID: V01U2FsdGVkX18CsnEBZrCeQ8pvmPPB7Y+LPHZHK73DAwg4jQk
 05eKVkmL4GDL6iyB+JcDKWVbNmoDf/A0NvG3n/SRmDiGwumafq
 XtxE1TBTLaGEXT1eXtNmKJfLBOhymv6
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/135565>

Hi,

Am Montag, 21. Dez 2009, 18:49:36 +0100 schrieb Johan 't Hart:
> Bertram Scharpf schreef:
>
>>   % git fsck --lost-found
>>   dangling commit 6abc221327e896c850c56dafae92277bcfe68e2b
>> It is still there. This is the one I want to delete.
>
> It is not in the history of any head anymore, so you could consider it 
> deleted. ('git log' does not show this commit)
>
> If you want to prune unreferenced objects, try:
> git prune
>
> ('git help prune' for options)

In the meantime I detected the gc.pruneExpire config variable. I
didn't get that to work on all versions that I have installed on
different machines, but I just wanted to understand what has to
happen with the commit.

Thank you!

Bertram


-- 
Bertram Scharpf
Stuttgart, Deutschland/Germany
http://www.bertram-scharpf.de

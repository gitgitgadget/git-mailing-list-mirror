From: Bertram Scharpf <lists@bertram-scharpf.de>
Subject: Re: Delete a commit
Date: Sun, 20 Dec 2009 01:43:40 +0100
Message-ID: <20091220004340.GA30440@marge.bs.l>
References: <20091219233957.GC29111@marge.bs.l> <hgjpqu$dos$1@ger.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Dec 20 01:43:47 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NM9ti-0001fv-8G
	for gcvg-git-2@lo.gmane.org; Sun, 20 Dec 2009 01:43:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754713AbZLTAnm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 19 Dec 2009 19:43:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754649AbZLTAnm
	(ORCPT <rfc822;git-outgoing>); Sat, 19 Dec 2009 19:43:42 -0500
Received: from moutng.kundenserver.de ([212.227.17.8]:59875 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754643AbZLTAnl (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 19 Dec 2009 19:43:41 -0500
Received: from bs.l (e180000188.adsl.alicedsl.de [85.180.0.188])
	by mrelayeu.kundenserver.de (node=mrbap0) with ESMTP (Nemesis)
	id 0MQM5U-1NRZHk2ELk-00UJQC; Sun, 20 Dec 2009 01:43:40 +0100
Received: from bsch by bs.l with local (Exim 4.69)
	(envelope-from <lists@bertram-scharpf.de>)
	id 1NM9tc-0007yt-3z
	for git@vger.kernel.org; Sun, 20 Dec 2009 01:43:40 +0100
Mail-Followup-To: git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <hgjpqu$dos$1@ger.gmane.org>
User-Agent: Mutt/1.5.16 (2007-06-09)
X-Provags-ID: V01U2FsdGVkX1+bVIS4prlhnlSSryl9TXIuuQAUuuKcs1vIG/L
 9MZbWHQJVjIUV7xnVagt5779phKmLCaEPWoMvVYGEESXu/fLVR
 uyx8fRkqtxZSniYNGh3F73SWkKdjwvW4RYLA2mdt7E=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/135514>

Hi,

Am Sonntag, 20. Dez 2009, 01:06:46 +0100 schrieb Johan 't Hart:
> Bertram Scharpf schreef:
>> I fetched a line from the shell's history and accidentally hit
>> enter before editing it. Then I had commited some work that was
>> not completed. Is there a way to get rid of that commit as if it
>> never were there?
>
> Try:
> git reset --soft HEAD~1
>
> You could also:
> git commit --amend ...

  % git fsck --lost-found
  dangling commit 6abc221327e896c850c56dafae92277bcfe68e2b

It is still there. This is the one I want to delete.

Bertram


-- 
Bertram Scharpf
Stuttgart, Deutschland/Germany
http://www.bertram-scharpf.de

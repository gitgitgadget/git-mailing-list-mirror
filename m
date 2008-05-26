From: "Kenneth P. Turvey" <kt-usenet@squeakydolphin.com>
Subject: Re: sync() slowdown
Date: Mon, 26 May 2008 16:06:41 +0000 (UTC)
Message-ID: <g1en6g$vuc$1@ger.gmane.org>
References: <20080526142607.GA3082@kali.thurne.chezwam.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon May 26 18:07:48 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K0fEh-0007BM-7G
	for gcvg-git-2@gmane.org; Mon, 26 May 2008 18:07:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752996AbYEZQGz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 26 May 2008 12:06:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753047AbYEZQGz
	(ORCPT <rfc822;git-outgoing>); Mon, 26 May 2008 12:06:55 -0400
Received: from main.gmane.org ([80.91.229.2]:37492 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752968AbYEZQGz (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 May 2008 12:06:55 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1K0fDo-0003xb-5c
	for git@vger.kernel.org; Mon, 26 May 2008 16:06:52 +0000
Received: from pool-71-161-46-181.clppva.east.verizon.net ([71.161.46.181])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 26 May 2008 16:06:52 +0000
Received: from kt-usenet by pool-71-161-46-181.clppva.east.verizon.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 26 May 2008 16:06:52 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: pool-71-161-46-181.clppva.east.verizon.net
User-Agent: Pan/0.129 (Benson & Hedges Moscow Gold)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/82939>

On Mon, 26 May 2008 16:26:07 +0200, Sebastien Gross wrote:

> I do understand that syncing filesystem is usefull and needed.
> 
> But is there a good idea to add a --no-sync option to prevent that
> behaviour ?

Just a user here, but I would prefer it if it didn't sync at all.  If I 
want to sync it, I will, or the operating system will handle it like it 
does with all other file accesses.  

Just my 2 cents. 

I was just editing my backup script the other day and part of the problem 
with it was that I was syncing too often.  What I needed was a single 
sync when everything was done.  

This was possible because I was just doing copies and tars.  It should be 
possible with git too.  

-- 
Kenneth P. Turvey <kt-usenet@squeakydolphin.com>
http://www.electricsenator.net

  There are two major products that come out of Berkeley: LSD and UNIX.
  We don't believe this to be a coincidence.
        -- Jeremy S. Anderson

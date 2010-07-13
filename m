From: Enrico Weigelt <weigelt@metux.de>
Subject: Re: Massive repository corruptions
Date: Tue, 13 Jul 2010 08:46:48 +0200
Message-ID: <20100713064648.GD29392@nibiru.local>
References: <20100713015600.GA29392@nibiru.local> <AANLkTilXQ3VgPjihf0pjt4QPN-nCjwAWyHwoosLMeRpH@mail.gmail.com> <20100713050350.GB29392@nibiru.local> <20100713053154.GC29392@nibiru.local>
Reply-To: weigelt@metux.de
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jul 13 08:53:16 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OYZMh-0002BW-Re
	for gcvg-git-2@lo.gmane.org; Tue, 13 Jul 2010 08:53:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751319Ab0GMGxK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 Jul 2010 02:53:10 -0400
Received: from forum.psychotherapie.org ([217.160.22.205]:34286 "EHLO
	s15216962.onlinehome-server.info" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751003Ab0GMGxJ (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 13 Jul 2010 02:53:09 -0400
Received: (from uucp@localhost)
	by s15216962.onlinehome-server.info (8.13.3/8.13.3) with UUCP id o6D6r73m005737
	for git@vger.kernel.org; Tue, 13 Jul 2010 08:53:07 +0200
Received: (from weigelt@localhost)
	by nibiru.metux.de (8.12.10/8.12.10) id o6D6kmM7012582
	for git@vger.kernel.org; Tue, 13 Jul 2010 08:46:48 +0200
Content-Disposition: inline
In-Reply-To: <20100713053154.GC29392@nibiru.local>
User-Agent: Mutt/1.4.1i
X-Terror: bin laden, kill bush, Briefbombe, Massenvernichtung, KZ, 
X-Nazi: Weisse Rasse, Hitlers Wiederauferstehung, 42, 
X-Antichrist: weg mit schaeuble, ausrotten, heiliger krieg, al quaida, 
X-Killer: 23, endloesung, Weltuntergang, 
X-Doof: wer das liest ist doof
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/150882>

* Enrico Weigelt <weigelt@metux.de> wrote:
> * Enrico Weigelt <weigelt@metux.de> wrote:
> 
> <snip>
> 
> What's strange: 
> 
> when copying pack files from another machine to this box and
> run git index-pack there, it fails with the same error. 
> 
> also: pushing into a new (bare) repo sometimes fails with 
> inflate errors, sometimes succeeds but leaves an broken packfile.

Interesting: if I limit the pack size on the local repository,
and manually copy them over via scp, git index-pack runs fine
on them.

Subsequent push doesnt seem to recognize the already transferred
packs and still sends the big one which gets broken, but running
git-gc multiple times seems to clean up the mess.

Is there any way for limiting the pack size on push ?
(pack.packSizeLimit only affects git-repack, not remote transfers).


cu
-- 
----------------------------------------------------------------------
 Enrico Weigelt, metux IT service -- http://www.metux.de/

 phone:  +49 36207 519931  email: weigelt@metux.de
 mobile: +49 151 27565287  icq:   210169427         skype: nekrad666
----------------------------------------------------------------------
 Embedded-Linux / Portierung / Opensource-QM / Verteilte Systeme
----------------------------------------------------------------------

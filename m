From: Enrico Weigelt <weigelt@metux.de>
Subject: Re: inotify daemon speedup for git [POC/HACK]
Date: Fri, 13 Aug 2010 19:53:33 +0200
Message-ID: <20100813175333.GC27540@nibiru.local>
References: <20100727122018.GA26780@pvv.org> <AANLkTinuU6b1vmRFuBrA4Tc5H6gmC5cMP3Pa8EYz-8JE@mail.gmail.com> <9E67A084-4EDB-4CCB-A771-11B97107F4EF@gmail.com> <AANLkTi=oA33M4DmS5FyDx7Wn1DFrUGcmhSYkvcSYMc2r@mail.gmail.com> <20100728000009.GE25268@spearce.org> <AANLkTimkLrTwavErFkyaUTSVU-2s3me5f+cyqNFp7n+D@mail.gmail.com> <52EDBD9A-2961-4F66-88B3-07BF873FA994@gmail.com> <AANLkTi=TQnyATgJ0LSdR3qeeCVAgu+wOFcHmHUBguPiV@mail.gmail.com> <AANLkTinabaO3csi3TBRJKPTZ1zVGgK8-ijs6h1YUkT-n@mail.gmail.com> <AANLkTimqBSTRzcU++jW6izMgeA=HB00wBXQVHuSsn1oR@mail.gmail.com>
Reply-To: weigelt@metux.de
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Aug 13 20:01:37 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OjyZO-0006I8-Nb
	for gcvg-git-2@lo.gmane.org; Fri, 13 Aug 2010 20:01:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934700Ab0HMSBX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 13 Aug 2010 14:01:23 -0400
Received: from caprica.metux.de ([82.165.128.25]:34788 "EHLO
	mailgate.caprica.metux.de" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S934675Ab0HMSBW (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 13 Aug 2010 14:01:22 -0400
Received: from mailgate.caprica.metux.de (localhost.localdomain [127.0.0.1])
	by mailgate.caprica.metux.de (8.14.4/8.14.4) with ESMTP id o7DI11lH022796
	for <git@vger.kernel.org>; Fri, 13 Aug 2010 20:01:01 +0200
Received: (from uucp@localhost)
	by mailgate.caprica.metux.de (8.14.4/8.14.4/Submit) with UUCP id o7DI10sD022786
	for git@vger.kernel.org; Fri, 13 Aug 2010 20:01:00 +0200
Received: (from weigelt@localhost)
	by nibiru.metux.de (8.12.10/8.12.10) id o7DHrXUQ027248
	for git@vger.kernel.org; Fri, 13 Aug 2010 19:53:33 +0200
Mail-Followup-To: git <git@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <AANLkTimqBSTRzcU++jW6izMgeA=HB00wBXQVHuSsn1oR@mail.gmail.com>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/153484>

* Nguyen Thai Ngoc Duy <pclouds@gmail.com> wrote:

> But then we could as well drop git object store in favor of Fossil (OK
> I'm going to far).

You mean venti ?

Actually: that's an idea I'm thinking about for quite a while :)

But venti is yet lacking delete operations and differential
compression. The first is unproblematic (even it would require
rewriting the log areas in some ways to reclaim space), but
for differential compression, the venti store would have to
know a lot about the object's internal structure.

I'm doing some bit reasearch in the area of distributed 
content-addressed objects stores , designing an superstore 
called "Nebulon" [1] with things like strong encryption and
on-demand fetching/syncing. But getting git into it seems
to be a bit tricky, at least the hashes would change ...


cu

[1] http://www.metux.de/index.php/de/nebulon-storage-cloud.html
-- 
----------------------------------------------------------------------
 Enrico Weigelt, metux IT service -- http://www.metux.de/

 phone:  +49 36207 519931  email: weigelt@metux.de
 mobile: +49 151 27565287  icq:   210169427         skype: nekrad666
----------------------------------------------------------------------
 Embedded-Linux / Portierung / Opensource-QM / Verteilte Systeme
----------------------------------------------------------------------

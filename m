From: Enrico Weigelt <weigelt@metux.de>
Subject: Re: large files and low memory
Date: Tue, 5 Oct 2010 02:57:15 +0200
Message-ID: <20101005005715.GB2768@nibiru.local>
References: <20101004092046.GA4382@nibiru.local> <AANLkTimbdrAqoWMxiteT5zNYmwHp8M698BEv1FLuiAxx@mail.gmail.com> <20101004185854.GA6466@burratino>
Reply-To: weigelt@metux.de
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Oct 05 03:04:12 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P2vwx-0004yB-JE
	for gcvg-git-2@lo.gmane.org; Tue, 05 Oct 2010 03:04:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755632Ab0JEBEA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 4 Oct 2010 21:04:00 -0400
Received: from caprica.metux.de ([82.165.128.25]:46200 "EHLO
	mailgate.caprica.metux.de" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1752811Ab0JEBD7 (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 4 Oct 2010 21:03:59 -0400
Received: from mailgate.caprica.metux.de (localhost.localdomain [127.0.0.1])
	by mailgate.caprica.metux.de (8.14.4/8.14.4) with ESMTP id o95151x9013159
	for <git@vger.kernel.org>; Tue, 5 Oct 2010 03:05:02 +0200
Received: (from uucp@localhost)
	by mailgate.caprica.metux.de (8.14.4/8.14.4/Submit) with UUCP id o9514UN4013144
	for git@vger.kernel.org; Tue, 5 Oct 2010 03:04:30 +0200
Received: (from weigelt@localhost)
	by nibiru.metux.de (8.12.10/8.12.10) id o950vFXP028708
	for git@vger.kernel.org; Tue, 5 Oct 2010 02:57:15 +0200
Mail-Followup-To: git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <20101004185854.GA6466@burratino>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/158149>

* Jonathan Nieder <jrnieder@gmail.com> wrote:
> Shawn Pearce wrote:
> 
> > The mmap() isn't the problem.  Its the allocation of a buffer that is
> > larger than the file in order to hold the result of deflating the file
> > before it gets written to disk.
> 
> Wasn't this already fixed, at least in some cases?
> 
> commit 9892bebafe0865d8f4f3f18d60a1cfa2d1447cd7 (tags/v1.7.0.2~11^2~1)
> Author: Nicolas Pitre <nico@fluxnic.net>
> Date:   Sat Feb 20 23:27:31 2010 -0500

I guess I'll have to do a update.

But: latest tag (1.7.3.1) doesnt build:


    CC read-cache.o
    read-cache.c: In function `fill_stat_cache_info':
    read-cache.c:73: structure has no member named `st_ctim'
    read-cache.c:74: structure has no member named `st_mtim'
    read-cache.c: In function `read_index_from':
    read-cache.c:1334: structure has no member named `st_mtim'
    read-cache.c: In function `write_index':
    read-cache.c:1614: structure has no member named `st_mtim'
    make: *** [read-cache.o] Fehler 1
    
Is my libc too old ?


cu
-- 
----------------------------------------------------------------------
 Enrico Weigelt, metux IT service -- http://www.metux.de/

 phone:  +49 36207 519931  email: weigelt@metux.de
 mobile: +49 151 27565287  icq:   210169427         skype: nekrad666
----------------------------------------------------------------------
 Embedded-Linux / Portierung / Opensource-QM / Verteilte Systeme
----------------------------------------------------------------------

From: Enrico Weigelt <weigelt@metux.de>
Subject: Re: git repository in production release
Date: Thu, 21 Oct 2010 21:07:58 +0200
Message-ID: <20101021190755.GD28700@nibiru.local>
References: <loom.20101021T140249-924@post.gmane.org> <1287664757.24161.17.camel@drew-northup.unet.maine.edu> <loom.20101021T160058-462@post.gmane.org>
Reply-To: weigelt@metux.de
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Oct 21 21:19:35 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P90fh-0006Qw-3n
	for gcvg-git-2@lo.gmane.org; Thu, 21 Oct 2010 21:19:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757945Ab0JUTS5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 21 Oct 2010 15:18:57 -0400
Received: from caprica.metux.de ([82.165.128.25]:34155 "EHLO
	mailgate.caprica.metux.de" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1752416Ab0JUTSa (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 21 Oct 2010 15:18:30 -0400
Received: from mailgate.caprica.metux.de (localhost.localdomain [127.0.0.1])
	by mailgate.caprica.metux.de (8.14.4/8.14.4) with ESMTP id o9LJJuEq015151
	for <git@vger.kernel.org>; Thu, 21 Oct 2010 21:19:58 +0200
Received: (from uucp@localhost)
	by mailgate.caprica.metux.de (8.14.4/8.14.4/Submit) with UUCP id o9LJJuOu015144
	for git@vger.kernel.org; Thu, 21 Oct 2010 21:19:56 +0200
Received: (from weigelt@localhost)
	by nibiru.metux.de (8.12.10/8.12.10) id o9LJ7wKI021044
	for git@vger.kernel.org; Thu, 21 Oct 2010 21:07:58 +0200
Mail-Followup-To: git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <loom.20101021T160058-462@post.gmane.org>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/159545>

* Jonas <jonas@ibiz.se> wrote:
> Because I suspect that the local .git directory in my rails application 
> folder should not be added to the 
> remote repository at all. But I might be wrong.

Your repository (aka: the committed trees inside it) contain a .git
directory ? That's very strange, should not happen in normal git
operations (would cause some infinite recursion ;-o).

Seems that something's wrong w/ Capistrano - most likely not a
problem of git itself.


cu
-- 
----------------------------------------------------------------------
 Enrico Weigelt, metux IT service -- http://www.metux.de/

 phone:  +49 36207 519931  email: weigelt@metux.de
 mobile: +49 151 27565287  icq:   210169427         skype: nekrad666
----------------------------------------------------------------------
 Embedded-Linux / Portierung / Opensource-QM / Verteilte Systeme
----------------------------------------------------------------------

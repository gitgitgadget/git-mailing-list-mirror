From: Enrico Weigelt <weigelt@metux.de>
Subject: Re: large files and low memory
Date: Tue, 5 Oct 2010 09:41:45 +0200
Message-ID: <20101005074144.GA22564@nibiru.local>
References: <20101004092046.GA4382@nibiru.local> <AANLkTimbdrAqoWMxiteT5zNYmwHp8M698BEv1FLuiAxx@mail.gmail.com> <4CAA1BEB.3050908@workspacewhiz.com> <AANLkTi=nzyRgiBL07f2oeyjdUc8XnaKbJEJ+k8_g9rQ1@mail.gmail.com> <20101005005902.GC2768@nibiru.local>
Reply-To: weigelt@metux.de
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Oct 05 09:47:34 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P32FF-00030S-N8
	for gcvg-git-2@lo.gmane.org; Tue, 05 Oct 2010 09:47:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756144Ab0JEHrY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 5 Oct 2010 03:47:24 -0400
Received: from caprica.metux.de ([82.165.128.25]:56998 "EHLO
	mailgate.caprica.metux.de" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1752200Ab0JEHrX (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 5 Oct 2010 03:47:23 -0400
Received: from mailgate.caprica.metux.de (localhost.localdomain [127.0.0.1])
	by mailgate.caprica.metux.de (8.14.4/8.14.4) with ESMTP id o957mPct013193
	for <git@vger.kernel.org>; Tue, 5 Oct 2010 09:48:26 +0200
Received: (from uucp@localhost)
	by mailgate.caprica.metux.de (8.14.4/8.14.4/Submit) with UUCP id o957mECx013150
	for git@vger.kernel.org; Tue, 5 Oct 2010 09:48:14 +0200
Received: (from weigelt@localhost)
	by nibiru.metux.de (8.12.10/8.12.10) id o957fjxr023280
	for git@vger.kernel.org; Tue, 5 Oct 2010 09:41:45 +0200
Mail-Followup-To: git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <20101005005902.GC2768@nibiru.local>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/158173>

* Enrico Weigelt <weigelt@metux.de> wrote:

<snip>

Found another possible bottleneck: git-commit seems to scan through
a lot of files. Shouldnt it just create a commit object from the
current index and update the head ?


cu
-- 
----------------------------------------------------------------------
 Enrico Weigelt, metux IT service -- http://www.metux.de/

 phone:  +49 36207 519931  email: weigelt@metux.de
 mobile: +49 151 27565287  icq:   210169427         skype: nekrad666
----------------------------------------------------------------------
 Embedded-Linux / Portierung / Opensource-QM / Verteilte Systeme
----------------------------------------------------------------------

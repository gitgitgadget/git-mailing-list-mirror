From: Enrico Weigelt <weigelt@metux.de>
Subject: Re: How to create tags outside of refs/tags?
Date: Wed, 23 Feb 2011 17:36:35 +0100
Message-ID: <20110223163634.GA16569@nibiru.local>
References: <AANLkTimxAhMfPsqEJVyteuTzXLr+QnhcxpJLgaE=y12_@mail.gmail.com> <AANLkTi=7yUh9J9S5LdpNY0SwCv008ih2LEd3KNvy46sL@mail.gmail.com> <20110222080305.GA11177@sigill.intra.peff.net> <7vvd0cebi6.fsf@alter.siamese.dyndns.org> <20110222081458.GA11825@sigill.intra.peff.net> <m3wrks756a.fsf@localhost.localdomain> <20110222152723.GA23353@sigill.intra.peff.net> <AANLkTinTj7BehKYc15jbQzMq+q=2CfLvzTkGSJ-Ps-FH@mail.gmail.com> <7v7hcrewyz.fsf@alter.siamese.dyndns.org>
Reply-To: weigelt@metux.de
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Feb 23 17:48:14 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PsHss-0008Uk-12
	for gcvg-git-2@lo.gmane.org; Wed, 23 Feb 2011 17:48:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932133Ab1BWQsI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Feb 2011 11:48:08 -0500
Received: from caprica.metux.de ([82.165.128.25]:39912 "EHLO
	mailgate.caprica.metux.de" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S932065Ab1BWQsH (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 23 Feb 2011 11:48:07 -0500
Received: from mailgate.caprica.metux.de (localhost.localdomain [127.0.0.1])
	by mailgate.caprica.metux.de (8.14.4/8.14.4) with ESMTP id p1NGj1v1002225
	for <git@vger.kernel.org>; Wed, 23 Feb 2011 17:45:06 +0100
Received: (from uucp@localhost)
	by mailgate.caprica.metux.de (8.14.4/8.14.4/Submit) with UUCP id p1NGiWAw002190
	for git@vger.kernel.org; Wed, 23 Feb 2011 17:44:32 +0100
Received: (from weigelt@localhost)
	by nibiru.metux.de (8.12.10/8.12.10) id p1NGaZ3x023551
	for git@vger.kernel.org; Wed, 23 Feb 2011 17:36:35 +0100
Mail-Followup-To: git <git@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <7v7hcrewyz.fsf@alter.siamese.dyndns.org>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/167702>

* Junio C Hamano <gitster@pobox.com> wrote:

Hi folks,


> I would think that using a private namespace other than tags for your own
> use (e.g. "git update-ref refs/anchor/release-20110222 $that_commit") may
> be the best option that is easiest to understand, though.

I'm doing similar things with source crawlers in the OSS-QM
project: each time a new upstream version arrives, it gets
tag into a queue namespace, so I can pick them up an do my
usual qm works on them one by one.

git ls-remote git://pubgit.metux.de/oss-qm/glib2.git | grep queue


cu
-- 
----------------------------------------------------------------------
 Enrico Weigelt, metux IT service -- http://www.metux.de/

 phone:  +49 36207 519931  email: weigelt@metux.de
 mobile: +49 151 27565287  icq:   210169427         skype: nekrad666
----------------------------------------------------------------------
 Embedded-Linux / Portierung / Opensource-QM / Verteilte Systeme
----------------------------------------------------------------------

From: Nicolas Pitre <nico@fluxnic.net>
Subject: Re: [PULL REQUEST] initial pack v4 support
Date: Tue, 10 Sep 2013 17:32:50 -0400 (EDT)
Message-ID: <alpine.LFD.2.03.1309101729310.20709@syhkavp.arg>
References: <alpine.LFD.2.03.1309091526430.20709@syhkavp.arg>
 <xmqqtxhswexg.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; CHARSET=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: =?ISO-8859-15?Q?Nguyn_Th=E1i_Ngc_Duy?= <pclouds@gmail.com>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Sep 10 23:33:11 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VJVYb-0002cd-LV
	for gcvg-git-2@plane.gmane.org; Tue, 10 Sep 2013 23:33:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751806Ab3IJVdH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Sep 2013 17:33:07 -0400
Received: from relais.videotron.ca ([24.201.245.36]:41424 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751276Ab3IJVdE (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Sep 2013 17:33:04 -0400
Received: from yoda.home ([70.83.209.44]) by VL-VM-MR005.ip.videotron.ca
 (Oracle Communications Messaging Exchange Server 7u4-22.01 64bit (built Apr 21
 2011)) with ESMTP id <0MSX009ESIIQ6KD0@VL-VM-MR005.ip.videotron.ca> for
 git@vger.kernel.org; Tue, 10 Sep 2013 17:32:51 -0400 (EDT)
Received: from xanadu.home (xanadu.home [192.168.2.2])	by yoda.home (Postfix)
 with ESMTPSA id C6A012DA0625; Tue, 10 Sep 2013 17:32:50 -0400 (EDT)
In-reply-to: <xmqqtxhswexg.fsf@gitster.dls.corp.google.com>
User-Agent: Alpine 2.03 (LFD 1266 2009-07-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/234485>

On Tue, 10 Sep 2013, Junio C Hamano wrote:

> Nicolas Pitre <nico@fluxnic.net> writes:
> 
> > Junio, would you please pull the following into pu:
> >
> > 	git://git.linaro.org/people/nico/git
> >
> > This is the pack v4 work to date which is somewhat getting usable.  It 
> > is time it gets more exposure, and possibly some more people's attention 
> > who would like to work on the missing parts as I need to scale down my 
> > own involvement.
> 
> Thanks.  Parked on 'pu'.

Good.

> >       packv4-parse.c: allow tree entry copying from a canonical tree object
> 
> This one needed a small fix-up to make it compile.
> 
> I do not particularly like reusing that "size" variable, but it
> seemed to be dead at that point, so...

Feel free to fold this in the original commit.

I'm curious... what compiler are you using?  My gcc version is just 
happy to do arithmetic on void pointers.


Nicolas

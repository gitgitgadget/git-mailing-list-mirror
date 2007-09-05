From: Nix <nix@esperi.org.uk>
Subject: Re: People unaware of the importance of "git gc"?
Date: Wed, 05 Sep 2007 22:14:19 +0100
Message-ID: <87ps0wzufo.fsf@hades.wkstn.nix>
References: <alpine.LFD.0.999.0709042355030.19879@evo.linux-foundation.org>
	<20070905074206.GA31750@artemis.corp> <87odgh0zn6.fsf@hades.wkstn.nix>
	<46DEF1FA.4050500@midwinter.com> <877in50y7p.fsf@hades.wkstn.nix>
	<alpine.LFD.0.9999.0709051438460.21186@xanadu.home>
	<7vr6lcj2zi.fsf@gitster.siamese.dyndns.org>
	<alpine.LFD.0.9999.0709051634190.21186@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	Steven Grimm <koreth@midwinter.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Git Mailing List <git@vger.kernel.org>
To: Nicolas Pitre <nico@cam.org>
X-From: git-owner@vger.kernel.org Wed Sep 05 23:15:14 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IT2DQ-0002dG-3e
	for gcvg-git@gmane.org; Wed, 05 Sep 2007 23:15:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756024AbXIEVPF (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 5 Sep 2007 17:15:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754949AbXIEVPF
	(ORCPT <rfc822;git-outgoing>); Wed, 5 Sep 2007 17:15:05 -0400
Received: from 41-052.adsl.zetnet.co.uk ([194.247.41.52]:40929 "EHLO
	mail.esperi.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753492AbXIEVPB (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Sep 2007 17:15:01 -0400
Received: from esperi.org.uk (nix@hades.wkstn.nix [192.168.14.18])
	by mail.esperi.org.uk (8.12.11.20060614/8.12.11) with ESMTP id l85LEJh4010590;
	Wed, 5 Sep 2007 22:14:20 +0100
Received: (from nix@localhost)
	by esperi.org.uk (8.12.11.20060614/8.12.11/Submit) id l85LEJvB022525;
	Wed, 5 Sep 2007 22:14:19 +0100
Emacs: freely redistributable; void where prohibited by law.
In-Reply-To: <alpine.LFD.0.9999.0709051634190.21186@xanadu.home> (Nicolas Pitre's message of "Wed, 05 Sep 2007 16:35:19 -0400 (EDT)")
User-Agent: Gnus/5.1008 (Gnus v5.10.8) XEmacs/21.5-b28 (linux)
X-DCC-INFN-TO-Metrics: hades 1233; Body=5 Fuz1=5 Fuz2=5
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/57764>

On 5 Sep 2007, Nicolas Pitre stated:

> On Wed, 5 Sep 2007, Junio C Hamano wrote:
>> 	git fetch
>
> I think that would be a much better idea to simply decrease the 
> fetch.unpackLimit default value.

I think `git fetch' works reasonably well as is: unless you're fetching
every five minutes you often find you get packs anyway. There's no point
packing incrementally *too* often, or you replace a lots-of-objects
problem with a lots-of-packs problem, after which you're worse off than
when you started.

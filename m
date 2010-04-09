From: Nicolas Pitre <nico@fluxnic.net>
Subject: Re: git clone: very long "resolving deltas" phase
Date: Fri, 09 Apr 2010 15:30:19 -0400 (EDT)
Message-ID: <alpine.LFD.2.00.1004091525480.7232@xanadu.home>
References: <loom.20100406T161552-321@post.gmane.org>
 <vpqljd062xb.fsf@bauges.imag.fr> <4BBB5346.6070607@gmail.com>
 <4BBB53F5.9010106@op5.se>
 <q2mec874dac1004060850r5eaa41fak2ba9889d07794651@mail.gmail.com>
 <v2qecffb261004060856qcb769a06vf40ad2a75a3aa4fd@mail.gmail.com>
 <alpine.LFD.2.00.1004061705390.7232@xanadu.home> <4BBC1E15.9040403@gmail.com>
 <20100407080049.GA14041@LK-Perkele-V2.elisa-laajakaista.fi>
 <4BBC3EEC.6010702@gmail.com> <alpine.LFD.2.00.1004071009180.7232@xanadu.home>
 <4BBC981F.1000802@gmail.com> <alpine.LFD.2.00.1004071048340.7232@xanadu.home>
 <4BBECD31.9080307@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org, Ilari Liusvaara <ilari.liusvaara@elisanet.fi>,
	Shawn Pearce <spearce@spearce.org>,
	Andreas Ericsson <ae@op5.se>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
To: Vitaly Berov <vitaly.berov@gmail.com>
X-From: git-owner@vger.kernel.org Fri Apr 09 21:30:40 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O0JuO-0001WF-Ji
	for gcvg-git-2@lo.gmane.org; Fri, 09 Apr 2010 21:30:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755541Ab0DITaX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 Apr 2010 15:30:23 -0400
Received: from relais.videotron.ca ([24.201.245.36]:27373 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751486Ab0DITaW (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Apr 2010 15:30:22 -0400
Received: from xanadu.home ([66.130.28.92]) by VL-MO-MR001.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-4.01 (built Aug  3 2007; 32bit))
 with ESMTP id <0L0M000OKJIJJV00@VL-MO-MR001.ip.videotron.ca> for
 git@vger.kernel.org; Fri, 09 Apr 2010 15:30:22 -0400 (EDT)
X-X-Sender: nico@xanadu.home
In-reply-to: <4BBECD31.9080307@gmail.com>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/144462>

On Fri, 9 Apr 2010, Vitaly Berov wrote:

> Hi,
> 
> On 04/07/2010 06:55 PM, Nicolas Pitre wrote:
> > 
> > Then playing with core.deltaBaseCacheLimit instead would be quite
> > interesting.
> It's difficult to play with parameters because only receiving objects phase
> takes 1.5-2 hours.

Huh...  I guess that's over 100Mbps ethernet?

57GB / 1.5h -> approx 10MB/s


Nicolas

From: Nicolas Pitre <nico@fluxnic.net>
Subject: Re: Out of memory error during git push
Date: Fri, 20 Aug 2010 13:26:02 -0400 (EDT)
Message-ID: <alpine.LFD.2.00.1008201324440.622@xanadu.home>
References: <20100820125119.GA9762@burratino>
 <23639398.583.1282314377177.JavaMail.root@hermes>
 <20100820145011.GF16190@burratino>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Thomas Jampen <jampen@kinet.ch>, git@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Fri Aug 20 19:26:12 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OmVM3-0002Tx-BY
	for gcvg-git-2@lo.gmane.org; Fri, 20 Aug 2010 19:26:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751828Ab0HTR0F (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 Aug 2010 13:26:05 -0400
Received: from relais.videotron.ca ([24.201.245.36]:13630 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751018Ab0HTR0E (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Aug 2010 13:26:04 -0400
Received: from xanadu.home ([66.130.28.92]) by VL-MR-MR001.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-8.01 (built Dec 16 2008; 32bit))
 with ESMTP id <0L7G00B98OFE6G60@VL-MR-MR001.ip.videotron.ca> for
 git@vger.kernel.org; Fri, 20 Aug 2010 13:26:02 -0400 (EDT)
X-X-Sender: nico@xanadu.home
In-reply-to: <20100820145011.GF16190@burratino>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/154058>

On Fri, 20 Aug 2010, Jonathan Nieder wrote:

> Thomas Jampen wrote:
> 
> > vm.overcommit_memory = 0
> > 
> > Do you propose to set this to '2' in order to disable overcommitting?
> 
> It might be interesting to try
> 
>  echo 1 >/proc/sys/vm/overcommit_memory
> 
> but 0 is generally the only sane setting.

Don't know the meaning for specific values, but you definitively don't 
want to turn off memory overcommit.


Nicolas

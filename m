From: Nicolas Pitre <nico@fluxnic.net>
Subject: Re: [PATCH v2] Document pack v4 format
Date: Thu, 05 Sep 2013 00:40:43 -0400 (EDT)
Message-ID: <alpine.LFD.2.03.1309050024090.14472@syhkavp.arg>
References: <1377602225-30439-1-git-send-email-pclouds@gmail.com>
 <1377917393-28460-1-git-send-email-pclouds@gmail.com>
 <alpine.LFD.2.03.1309030156410.14472@syhkavp.arg>
 <alpine.LFD.2.03.1309030231350.14472@syhkavp.arg>
 <CACsJy8CZP+55nhfEbgRGa9=y0PyExyHt_seiSc23kB31-_c1Hg@mail.gmail.com>
 <CACsJy8CzpW_xsoxU=+OE6ssbnPu9tyAqRten0=Q5cxPUZ4aeMw@mail.gmail.com>
 <alpine.LFD.2.03.1309042350560.14472@syhkavp.arg>
 <CACsJy8BeU_01c0f5RJExcYo7xGETnduKOw-_shszHd0ZFgZDXw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; CHARSET=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Thu Sep 05 06:40:51 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VHRNB-0001Um-9l
	for gcvg-git-2@plane.gmane.org; Thu, 05 Sep 2013 06:40:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754522Ab3IEEko (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 Sep 2013 00:40:44 -0400
Received: from relais.videotron.ca ([24.201.245.36]:23534 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753234Ab3IEEko (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Sep 2013 00:40:44 -0400
Received: from xanadu.home ([70.83.209.44]) by VL-VM-MR006.ip.videotron.ca
 (Oracle Communications Messaging Exchange Server 7u4-22.01 64bit (built Apr 21
 2011)) with ESMTP id <0MSM00GYIYBVD300@VL-VM-MR006.ip.videotron.ca> for
 git@vger.kernel.org; Thu, 05 Sep 2013 00:40:43 -0400 (EDT)
In-reply-to: <CACsJy8BeU_01c0f5RJExcYo7xGETnduKOw-_shszHd0ZFgZDXw@mail.gmail.com>
User-Agent: Alpine 2.03 (LFD 1266 2009-07-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/233891>

On Thu, 5 Sep 2013, Duy Nguyen wrote:

> On Thu, Sep 5, 2013 at 11:12 AM, Nicolas Pitre <nico@fluxnic.net> wrote:
> > Many other bugs have now been fixed.  A git.git repository with packs
> > version 4 appears to be functional and passes git-fsck --full --strict.
> 
> Yeah I was looking at the diff some minutes ago, saw changes in
> pack-check.c and wondering if fsck was working. I'll add v4 support to
> index-pack.

Beware that the tree delta encoding has changed a little.  This saved up 
to 2% on some repos.

I'll probably change the encoding to incorporate the escape hatch 
for path and name references as discussed previously.

> Waiting to see the new, v4-aware tree walker interface
> with good "rev-list --all --objects" numbers from you.

Well, unfortunately I've put more time than I really had available into 
this project lately.  I'm about to call for other people to take over it 
and pursue this work further.

I really wanted to set the pack format direction since I've been toying 
with this for so many years.  Now the tool to convert a pack is there, 
and the read side is also there, proving that the format does work and 
the encoding and decoding code is functional and may serve as reference.  
So that's about the extent of what I can contribute at this point.

I'll be happy to provide design assistance and code review comments of 
course.  But I won't be able to put the time to do the actual coding 
myself much longer.


Nicolas

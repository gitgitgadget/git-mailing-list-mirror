From: Nicolas Pitre <nico@fluxnic.net>
Subject: Re: [PATCH] pack-objects: no crc check when the cached version is used
Date: Fri, 13 Sep 2013 23:18:45 -0400 (EDT)
Message-ID: <alpine.LFD.2.03.1309132302350.20709@syhkavp.arg>
References: <1379070180-15947-1-git-send-email-pclouds@gmail.com>
 <xmqq7gekk24q.fsf@gitster.dls.corp.google.com> <87k3ikct1e.fsf@inf.ethz.ch>
 <CACsJy8BctT3C+oW9a5azzFUru89j-NZ-kGK_wgxhsjRZEKnq_g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; CHARSET=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Thomas Rast <trast@inf.ethz.ch>,
	Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Sat Sep 14 05:19:09 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VKgO4-0007Yk-LP
	for gcvg-git-2@plane.gmane.org; Sat, 14 Sep 2013 05:19:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756254Ab3INDSv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 13 Sep 2013 23:18:51 -0400
Received: from relais.videotron.ca ([24.201.245.36]:62633 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751587Ab3INDSu (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 Sep 2013 23:18:50 -0400
Received: from xanadu.home ([70.83.209.44]) by VL-VM-MR003.ip.videotron.ca
 (Oracle Communications Messaging Exchange Server 7u4-22.01 64bit (built Apr 21
 2011)) with ESMTP id <0MT300KAPIJ9YU10@VL-VM-MR003.ip.videotron.ca> for
 git@vger.kernel.org; Fri, 13 Sep 2013 23:18:45 -0400 (EDT)
In-reply-to: <CACsJy8BctT3C+oW9a5azzFUru89j-NZ-kGK_wgxhsjRZEKnq_g@mail.gmail.com>
User-Agent: Alpine 2.03 (LFD 1266 2009-07-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/234787>

On Sat, 14 Sep 2013, Duy Nguyen wrote:

> On Sat, Sep 14, 2013 at 4:26 AM, Thomas Rast <trast@inf.ethz.ch> wrote:
> > I tried the perf script below, but at least for the git repo the only
> > thing I can see is noise.
> 
> --stdout does not set do_check_packed_object_crc, you need to run
> pack-objects without --stdout (i.e. the real use case is repack)

And for those who might wonder why, you can have a look at the 
description for commit 0e8189e2708b.  This was probably one of my best 
commit logs ever.  ;-)

This commit also provides a hint about the cost of over-checking the 
CRC.


Nicolas

From: Nicolas Pitre <nico@fluxnic.net>
Subject: Re: [PATCH v2] Document pack v4 format
Date: Tue, 03 Sep 2013 02:46:44 -0400 (EDT)
Message-ID: <alpine.LFD.2.03.1309030231350.14472@syhkavp.arg>
References: <1377602225-30439-1-git-send-email-pclouds@gmail.com>
 <1377917393-28460-1-git-send-email-pclouds@gmail.com>
 <alpine.LFD.2.03.1309030156410.14472@syhkavp.arg>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="Boundary_(ID_YkvNF17N9Yienn8+v9riiw)"
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: =?VISCII?Q?Nguy=ADn_Th=E1i_Ng=F7c_Duy?= <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Tue Sep 03 08:46:50 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VGkO2-0001JO-9B
	for gcvg-git-2@plane.gmane.org; Tue, 03 Sep 2013 08:46:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759490Ab3ICGqq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Sep 2013 02:46:46 -0400
Received: from relais.videotron.ca ([24.201.245.36]:46686 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753749Ab3ICGqp (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Sep 2013 02:46:45 -0400
Received: from yoda.home ([70.83.209.44]) by VL-VM-MR001.ip.videotron.ca
 (Oracle Communications Messaging Exchange Server 7u4-22.01 64bit (built Apr 21
 2011)) with ESMTP id <0MSJ003J6ETXRZ00@VL-VM-MR001.ip.videotron.ca> for
 git@vger.kernel.org; Tue, 03 Sep 2013 02:46:45 -0400 (EDT)
Received: from xanadu.home (xanadu.home [192.168.2.2])	by yoda.home (Postfix)
 with ESMTPSA id F003F2DA0547; Tue, 03 Sep 2013 02:46:44 -0400 (EDT)
In-reply-to: <alpine.LFD.2.03.1309030156410.14472@syhkavp.arg>
User-Agent: Alpine 2.03 (LFD 1266 2009-07-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/233684>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--Boundary_(ID_YkvNF17N9Yienn8+v9riiw)
Content-type: TEXT/PLAIN; charset=UTF-8
Content-transfer-encoding: 8BIT

On Tue, 3 Sep 2013, Nicolas Pitre wrote:

> On Sat, 31 Aug 2013, Nguyễn Thái Ngọc Duy wrote:
> 
> > 
> > Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
> > ---
> >  Incorporated suggestions by Nico and Junio. I went ahead and added
> >  escape hatches for converting thin packs to full ones so the document
> >  does not really match the code (I've been watching Nico's repository,
> >  commit reading is added, good stuff!)
> 
> Now tree reading is added.  multiple encoding bug fixes trickled down to 
> their originating commits as well.
> 
> Something is still wrong with deltas though.

Deltas fixed now.

So... looks like pack v4 is now "functional".

However something is still wrong as it operates about 6 times slower 
than pack v3.

Anyone wishes to investigate?


Nicolas

--Boundary_(ID_YkvNF17N9Yienn8+v9riiw)--

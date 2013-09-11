From: Nicolas Pitre <nico@fluxnic.net>
Subject: Re: [PATCH 20/21] show-index: acknowledge that it does not read .idx v3
Date: Wed, 11 Sep 2013 12:19:22 -0400 (EDT)
Message-ID: <alpine.LFD.2.03.1309111214510.20709@syhkavp.arg>
References: <xmqqtxhswexg.fsf@gitster.dls.corp.google.com>
 <1378879582-15372-1-git-send-email-pclouds@gmail.com>
 <1378879582-15372-21-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="Boundary_(ID_k0XBh35A2seWBYzNZ+JNKw)"
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: =?VISCII?Q?Nguy=ADn_Th=E1i_Ng=F7c_Duy?= <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Wed Sep 11 18:19:32 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VJn8a-0000Qn-Hg
	for gcvg-git-2@plane.gmane.org; Wed, 11 Sep 2013 18:19:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755474Ab3IKQTY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 Sep 2013 12:19:24 -0400
Received: from relais.videotron.ca ([24.201.245.36]:47468 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755064Ab3IKQTX (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Sep 2013 12:19:23 -0400
Received: from yoda.home ([70.83.209.44]) by VL-VM-MR002.ip.videotron.ca
 (Oracle Communications Messaging Exchange Server 7u4-22.01 64bit (built Apr 21
 2011)) with ESMTP id <0MSY00DREYOAOWC0@VL-VM-MR002.ip.videotron.ca> for
 git@vger.kernel.org; Wed, 11 Sep 2013 12:19:22 -0400 (EDT)
Received: from xanadu.home (xanadu.home [192.168.2.2])	by yoda.home (Postfix)
 with ESMTPSA id 675872DA0625; Wed, 11 Sep 2013 12:19:22 -0400 (EDT)
In-reply-to: <1378879582-15372-21-git-send-email-pclouds@gmail.com>
User-Agent: Alpine 2.03 (LFD 1266 2009-07-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/234577>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--Boundary_(ID_k0XBh35A2seWBYzNZ+JNKw)
Content-type: TEXT/PLAIN; charset=UTF-8
Content-transfer-encoding: 8BIT

On Wed, 11 Sep 2013, Nguyễn Thái Ngọc Duy wrote:

> show-index takes .idx from stdin while v3 requires the .pack. It's
> used for testing purposes only. Let those test scripts force .idx v2
> with index-pack.

Since I have a patch adding (partial) index v3 support to show-index in 
my tree, I've dropped this patch.

Many tests use show-index only to manually count the number of objects 
and the added support in show-index is good enough for that.  I've 
therefore reduced your next patch only to those tests where the actual 
list of object names is expected.

Whether or not we'd wish to get rid of show-index completely at some 
point is a separate matter.


Nicolas

--Boundary_(ID_k0XBh35A2seWBYzNZ+JNKw)--

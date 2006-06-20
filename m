From: Nicolas Pitre <nico@cam.org>
Subject: Re: wrong check condition in patch-delta.c?
Date: Tue, 20 Jun 2006 08:28:01 -0400 (EDT)
Message-ID: <Pine.LNX.4.64.0606200827120.3377@localhost.localdomain>
References: <fcaeb9bf0606192332j5b2ee4b9ycf2c63c7b1820204@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="Boundary_(ID_EagvMC3JCm/BL5oKHAjOkA)"
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jun 20 14:28:12 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FsfKy-0000VV-OL
	for gcvg-git@gmane.org; Tue, 20 Jun 2006 14:28:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030238AbWFTM2E (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 20 Jun 2006 08:28:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965121AbWFTM2E
	(ORCPT <rfc822;git-outgoing>); Tue, 20 Jun 2006 08:28:04 -0400
Received: from relais.videotron.ca ([24.201.245.36]:9709 "EHLO
	relais.videotron.ca") by vger.kernel.org with ESMTP
	id S1030238AbWFTM2C (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 Jun 2006 08:28:02 -0400
Received: from xanadu.home ([74.56.108.184]) by VL-MO-MR002.ip.videotron.ca
 (Sun Java System Messaging Server 6.2-2.05 (built Apr 28 2005))
 with ESMTP id <0J1500N3ZRYP2LI0@VL-MO-MR002.ip.videotron.ca> for
 git@vger.kernel.org; Tue, 20 Jun 2006 08:28:02 -0400 (EDT)
In-reply-to: <fcaeb9bf0606192332j5b2ee4b9ycf2c63c7b1820204@mail.gmail.com>
X-X-Sender: nico@localhost.localdomain
To: =?UTF-8?Q?Nguy=E1=BB=85n_Th=C3=A1i_Ng=E1=BB=8Dc_Duy?= 
	<pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/22198>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--Boundary_(ID_EagvMC3JCm/BL5oKHAjOkA)
Content-type: TEXT/PLAIN; charset=ISO-8859-1
Content-transfer-encoding: 8BIT

On Tue, 20 Jun 2006, Nguyn Thái Ngc Duy wrote:

> Hi,
> While inspecting patch-delta.c, I encounter this:
>                       if (cp_off + cp_size < cp_size ||
>                           cp_off + cp_size > src_size ||
>                           cp_size > size)
>                               goto bad;
> "cp_off + cp_size < cp_size" doesn't make sense to me. Is it on purpose?

Yes, it absolutely is.


Nicolas

--Boundary_(ID_EagvMC3JCm/BL5oKHAjOkA)--

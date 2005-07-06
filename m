From: Wolfgang Denk <wd@denx.de>
Subject: Re: cvsimport: rewritten in Perl
Date: Wed, 06 Jul 2005 12:24:27 +0200
Message-ID: <20050706102427.A6B12353A6A@atlas.denx.de>
References: <20050705230226.0F9F4353A69@atlas.denx.de> <Pine.LNX.4.58.0507051936350.3570@g5.osdl.org>
Mime-Version: 1.0
Content-Type: multipart/mixed ;
	boundary="==_Exmh_1120645459_21020"
X-From: git-owner@vger.kernel.org Wed Jul 06 12:39:19 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Dq7IN-00079F-I4
	for gcvg-git@gmane.org; Wed, 06 Jul 2005 12:38:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262273AbVGFKem (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 6 Jul 2005 06:34:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262364AbVGFKel
	(ORCPT <rfc822;git-outgoing>); Wed, 6 Jul 2005 06:34:41 -0400
Received: from mailout07.sul.t-online.com ([194.25.134.83]:21643 "EHLO
	mailout07.sul.t-online.com") by vger.kernel.org with ESMTP
	id S262324AbVGFK1J (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Jul 2005 06:27:09 -0400
Received: from fwd25.aul.t-online.de 
	by mailout07.sul.t-online.com with smtp 
	id 1Dq77U-0000Ot-00; Wed, 06 Jul 2005 12:27:08 +0200
Received: from denx.de (EfLmXMZvYeOM0g3mJEUuyom+GiSRPbuyNl+TDuN-bQsatmiGo2F4Qc@[84.150.70.229]) by fwd25.sul.t-online.de
	with esmtp id 1Dq77B-1K3isq0; Wed, 6 Jul 2005 12:26:49 +0200
Received: from atlas.denx.de (atlas.denx.de [10.0.0.14])
	by denx.de (Postfix) with ESMTP id 1B9BA42950
	for <git@vger.kernel.org>; Wed,  6 Jul 2005 12:26:48 +0200 (MEST)
Received: from atlas.denx.de (localhost.localdomain [127.0.0.1])
	by atlas.denx.de (Postfix) with ESMTP id A6B12353A6A
	for <git@vger.kernel.org>; Wed,  6 Jul 2005 12:24:27 +0200 (MEST)
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.1
To: git@vger.kernel.org
In-reply-to: <Pine.LNX.4.58.0507051936350.3570@g5.osdl.org> 
Comments: In-reply-to Linus Torvalds <torvalds@osdl.org>
   message dated "Tue, 05 Jul 2005 19:41:30 -0700."
X-ID: EfLmXMZvYeOM0g3mJEUuyom+GiSRPbuyNl+TDuN-bQsatmiGo2F4Qc@t-dialin.net
X-TOI-MSGID: 64ce39a2-0469-4eea-b010-dbe9dbc210cc
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

This is a multipart MIME message.

--==_Exmh_1120645459_21020
Content-Type: text/plain; charset=us-ascii

In message <Pine.LNX.4.58.0507051936350.3570@g5.osdl.org> Linus Torvalds wrote:
> 
> If you make it print out its <pid> and then pause, you can use 
> 
> 	ls -l /proc/<pid>/fd/
> 
> to get an idea of what the files may be. Looks like the new perl version 
> is leaking file descriptors..

It does. In case it's still of interest:  log file attached.

Best regards,

Wolfgang Denk


Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de
It seems intuitively obvious to me, which  means  that  it  might  be
wrong.                                                 -- Chris Torek


--==_Exmh_1120645459_21020
Content-Type: application/x-gzip ; name="git-cvsimport-script.log.gz"
Content-Description: git-cvsimport-script.log.gz
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="git-cvsimport-script.log.gz"

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
--==_Exmh_1120645459_21020--

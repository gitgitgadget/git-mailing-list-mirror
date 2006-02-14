From: Fredrik Kuivinen <freku045@student.liu.se>
Subject: Re: [PATCH] Add git-annotate - a tool for annotating files with the revision and person that created each line in the file.
Date: Tue, 14 Feb 2006 11:51:32 +0100
Message-ID: <20060214105132.GA7006@c165.ib.student.liu.se>
References: <11394103753694-git-send-email-ryan@michonline.com> <cda58cb80602080835s38713193t@mail.gmail.com> <Pine.LNX.4.63.0602081843220.20568@wbgn013.biozentrum.uni-wuerzburg.de> <7v3bitr73q.fsf@assigned-by-dhcp.cox.net> <20060210112541.GA3513@linux-mips.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <junkio@cox.net>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Franck Bui-Huu <vagabon.xyz@gmail.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 14 11:52:01 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F8xme-00036f-C9
	for gcvg-git@gmane.org; Tue, 14 Feb 2006 11:51:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030563AbWBNKvp (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 14 Feb 2006 05:51:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030565AbWBNKvo
	(ORCPT <rfc822;git-outgoing>); Tue, 14 Feb 2006 05:51:44 -0500
Received: from [85.8.31.11] ([85.8.31.11]:22975 "EHLO mail6.wasadata.com")
	by vger.kernel.org with ESMTP id S1030563AbWBNKvo (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 14 Feb 2006 05:51:44 -0500
Received: from c165 (unknown [85.8.2.189])
	by mail6.wasadata.com (Postfix) with ESMTP
	id 069964143; Tue, 14 Feb 2006 12:05:45 +0100 (CET)
Received: from ksorim by c165 with local (Exim 3.36 #1 (Debian))
	id 1F8xmO-0001pi-00; Tue, 14 Feb 2006 11:51:32 +0100
To: Ralf Baechle <ralf@linux-mips.org>
Content-Disposition: inline
In-Reply-To: <20060210112541.GA3513@linux-mips.org>
User-Agent: Mutt/1.5.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/16134>

On Fri, Feb 10, 2006 at 11:25:41AM +0000, Ralf Baechle wrote:
> The dependency on Python 2.4 already is a problem for installation on some
> systems ... 

I understand that in the environments where the Python dependency is a
problem it is probably not due to the specific version. However, if
WITH_OWN_SUBPROCESS is defined in the Makefile then Python 2.3 should
work fine too (this is actually automatically detected now, so you
shouldn't have to do anything special to use Python 2.3).

- Fredrik

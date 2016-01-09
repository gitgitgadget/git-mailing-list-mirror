From: Johannes Schindelin <schindelin@wisc.edu>
Subject: Re: [PATCH v2 2/4] compat/basename: make basename() conform to POSIX
Date: Sat, 09 Jan 2016 15:53:54 +0100 (CET)
Message-ID: <alpine.DEB.2.20.1601091553310.2964@virtualbox>
References: <25a2598e756959f55f06ae6b4dc6f448e3b6b127.1443624188.git.johannes.schindelin@gmx.de>
 <cover.1452270051.git.johannes.schindelin@gmx.de>
 <abd20a9fb53d702cb878b8fa767881e7c1ef2148.1452270051.git.johannes.schindelin@gmx.de>
 <xmqqy4bz29mp.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; CHARSET=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org, Ramsay Jones <ramsay@ramsayjones.plus.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Jan 09 16:54:07 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aHvqA-0001NB-3K
	for gcvg-git-2@plane.gmane.org; Sat, 09 Jan 2016 16:54:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754891AbcAIPyA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 9 Jan 2016 10:54:00 -0500
Received: from wmauth1.doit.wisc.edu ([144.92.197.141]:62728 "EHLO
	smtpauth1.wiscmail.wisc.edu" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1754033AbcAIPx7 (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 9 Jan 2016 10:53:59 -0500
X-Greylist: delayed 3601 seconds by postgrey-1.27 at vger.kernel.org; Sat, 09 Jan 2016 10:53:59 EST
Received: from avs-daemon.smtpauth1.wiscmail.wisc.edu by
 smtpauth1.wiscmail.wisc.edu
 (Oracle Communications Messaging Server 7.0.5.33.0 64bit (built Aug 27 2014))
 id <0O0O00000W1RYT00@smtpauth1.wiscmail.wisc.edu> for git@vger.kernel.org;
 Sat, 09 Jan 2016 08:53:58 -0600 (CST)
X-Spam-PmxInfo: Server=avs-1, Version=6.2.1.2493963,
 Antispam-Engine: 2.7.2.2107409, Antispam-Data: 2016.1.9.144215,
 SenderIP=0.0.0.0
X-Spam-Report: AuthenticatedSender=yes, SenderIP=0.0.0.0
Received: from virtualbox (aftr-37-24-143-74.unit-ymedia.net [37.24.143.74])
 by smtpauth1.wiscmail.wisc.edu
 (Oracle Communications Messaging Server 7.0.5.33.0 64bit (built Aug 27 2014))
 with ESMTPSA id <0O0O00CPTXDVRP10@smtpauth1.wiscmail.wisc.edu>; Sat,
 09 Jan 2016 08:53:57 -0600 (CST)
X-X-Sender: virtualbox@virtualbox
In-reply-to: <xmqqy4bz29mp.fsf@gitster.mtv.corp.google.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/283602>

Hi Junio,

On Fri, 8 Jan 2016, Junio C Hamano wrote:

> Johannes Schindelin <johannes.schindelin@gmx.de> writes:
> 
> > According to POSIX, basename("/path/") should return "path", not
> > "path/". Likewise, basename(NULL) and basename("abc") should both
> > return ".".
> 
> Did you mean basename("abc"), not basename(""), here?  

I don't understand: I wrote basename("abc")... ;-)

Ciao,
Dscho

From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: First cut at git port to Cygwin
Date: Wed, 05 Oct 2005 09:23:36 -0700
Message-ID: <4343FE08.2080607@zytor.com>
References: <433B3B10.5050407@zytor.com> <81b0412b0510040531m441ca759k6d1f3fbf0cd248ce@mail.gmail.com> <434299DB.7020805@zytor.com> <81b0412b0510050424h21fc06bav7677911f52b38426@mail.gmail.com> <81b0412b0510050846l2258775co117bada2d2b5a1ad@mail.gmail.com> <20051005155457.GA30303@trixie.casa.cgf.cx> <Pine.LNX.4.63.0510050902430.28854@localhost.localdomain> <20051005161546.GB30303@trixie.casa.cgf.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Davide Libenzi <davidel@xmailserver.org>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Oct 05 18:24:02 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1ENC3U-0003cs-QK
	for gcvg-git@gmane.org; Wed, 05 Oct 2005 18:23:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030213AbVJEQXm (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 5 Oct 2005 12:23:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030215AbVJEQXm
	(ORCPT <rfc822;git-outgoing>); Wed, 5 Oct 2005 12:23:42 -0400
Received: from paleosilicon.orionmulti.com ([209.128.68.66]:62624 "EHLO
	paleosilicon.orionmulti.com") by vger.kernel.org with ESMTP
	id S1030213AbVJEQXl (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Oct 2005 12:23:41 -0400
X-Envelope-From: hpa@zytor.com
Received: from [172.27.0.18] (c-67-180-238-27.hsd1.ca.comcast.net [67.180.238.27])
	(authenticated bits=0)
	by paleosilicon.orionmulti.com (8.12.10/8.12.10) with ESMTP id j95GNaJv008674
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Wed, 5 Oct 2005 09:23:37 -0700
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
To: Christopher Faylor <me@cgf.cx>
In-Reply-To: <20051005161546.GB30303@trixie.casa.cgf.cx>
X-Spam-Status: No, hits=0.0 required=5.0 tests=AWL autolearn=ham version=2.63
X-Spam-Checker-Version: SpamAssassin 2.63 (2004-01-11) on 
	paleosilicon.orionmulti.com
X-Virus-Scanned: ClamAV version 0.87, clamav-milter version 0.87 on paleosilicon.orionmulti.com
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/9718>

Christopher Faylor wrote:
> Cygwin's rename is much more than just a simple wrapper around MoveFile
> or MoveFileEx.  It tries hard to guarantee POSIX semantics within the
> strictures imposed by Windows.

Certainly, but presumably different versions of Win32 have different 
limitations, no?

	-hpa

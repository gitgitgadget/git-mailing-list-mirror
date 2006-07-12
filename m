From: Daniel Drake <dsd@gentoo.org>
Subject: Re: git-read-tree: fatal: Entry 'Kbuild' not uptodate. Cannot merge.
Date: Wed, 12 Jul 2006 23:49:27 +0100
Message-ID: <44B57C77.1070000@gentoo.org>
References: <44B57932.4090708@gentoo.org> <Pine.LNX.4.64.0607121538300.5623@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jul 13 00:43:41 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G0nQi-0007Mq-Rw
	for gcvg-git@gmane.org; Thu, 13 Jul 2006 00:43:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932359AbWGLWni (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 12 Jul 2006 18:43:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932360AbWGLWni
	(ORCPT <rfc822;git-outgoing>); Wed, 12 Jul 2006 18:43:38 -0400
Received: from mta08-winn.ispmail.ntl.com ([81.103.221.48]:7569 "EHLO
	mtaout02-winn.ispmail.ntl.com") by vger.kernel.org with ESMTP
	id S932359AbWGLWnh (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Jul 2006 18:43:37 -0400
Received: from aamtaout01-winn.ispmail.ntl.com ([81.103.221.35])
          by mtaout02-winn.ispmail.ntl.com with ESMTP
          id <20060712224335.NMNL27023.mtaout02-winn.ispmail.ntl.com@aamtaout01-winn.ispmail.ntl.com>;
          Wed, 12 Jul 2006 23:43:35 +0100
Received: from [192.168.0.2] (really [86.14.216.162])
          by aamtaout01-winn.ispmail.ntl.com with ESMTP
          id <20060712224335.KNHP29849.aamtaout01-winn.ispmail.ntl.com@[192.168.0.2]>;
          Wed, 12 Jul 2006 23:43:35 +0100
User-Agent: Thunderbird 1.5.0.4 (X11/20060603)
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0607121538300.5623@g5.osdl.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/23802>

Linus Torvalds wrote:
> 
> On Wed, 12 Jul 2006, Daniel Drake wrote:
>> git-read-tree: fatal: Entry 'Kbuild' not uptodate. Cannot merge.
>>
>> $ git diff
>> diff --git a/Kbuild b/Kbuild
>> diff --git a/zd_chip.c b/zd_chip.c
>> diff --git a/zd_chip.h b/zd_chip.h
>> ...
> 
> Do "git update-index --refresh", does it go away?

Yep, thanks.

Daniel

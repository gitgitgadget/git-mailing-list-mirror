From: =?iso-8859-1?Q?Henrik_Grubbstr=F6m?= <grubba@roxen.com>
Subject: Re: [PATCH 1/4] convert: Safer handling of $Id$ contraction.
Date: Mon, 15 Mar 2010 19:21:55 +0100 (CET)
Organization: Roxen Internet Software AB
Message-ID: <Pine.GSO.4.63.1003151915470.1164@shipon.roxen.com>
References: <cover.1268664693.git.grubba@grubba.org> 
 <be7e603837d8f55461c4d654fb07bd61c97b70e6.1268664693.git.grubba@grubba.org>
 <36ca99e91003150839r3b159befr9086fa47eec61a8d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="-559023410-1902445306-1268677315=:1164"
Cc: git@vger.kernel.org,
	=?iso-8859-1?Q?Henrik_Grubbstr=F6m?= <grubba@grubba.org>
To: Bert Wesarg <bert.wesarg@googlemail.com>
X-From: git-owner@vger.kernel.org Mon Mar 15 19:22:04 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NrEvT-00063i-CX
	for gcvg-git-2@lo.gmane.org; Mon, 15 Mar 2010 19:22:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965637Ab0COSV6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Mar 2010 14:21:58 -0400
Received: from mail.roxen.com ([212.247.29.220]:59951 "EHLO mail.roxen.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965596Ab0COSV5 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Mar 2010 14:21:57 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.roxen.com (Postfix) with ESMTP id 5266A6281A4;
	Mon, 15 Mar 2010 19:21:56 +0100 (CET)
X-Virus-Scanned: amavisd-new at roxen.com
Received: from mail.roxen.com ([212.247.29.220])
	by localhost (marge.roxen.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id WuxwwEJWMAxr; Mon, 15 Mar 2010 19:21:55 +0100 (CET)
Received: from shipon.roxen.com (shipon.roxen.com [212.247.28.156])
	by mail.roxen.com (Postfix) with ESMTP id 7827762819B;
	Mon, 15 Mar 2010 19:21:55 +0100 (CET)
In-Reply-To: <36ca99e91003150839r3b159befr9086fa47eec61a8d@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/142239>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

---559023410-1902445306-1268677315=:1164
Content-Type: TEXT/PLAIN; charset=iso-8859-1; format=flowed
Content-Transfer-Encoding: 8BIT

On Mon, 15 Mar 2010, Bert Wesarg wrote:

> 2010/3/15 Henrik Grubbström (Grubba) <grubba@grubba.org>:
>> diff --git a/t/t0021-conversion.sh b/t/t0021-conversion.sh
[...]
>> +               echo "\$Id: Foreign Commit With Spaces $"
>
> Missing \ for second $.
[...]
>> +               echo "\$Id: fd0478f5f1486f3d5177d4c3f6eb2765e8fc56b9 $"
>
> Ditto.

Thanks. It seems like bash and /bin/sh on Solaris don't care, but it's 
probably not a portable behaviour.

--
Henrik Grubbström					grubba@grubba.org
Roxen Internet Software AB				grubba@roxen.com
---559023410-1902445306-1268677315=:1164--

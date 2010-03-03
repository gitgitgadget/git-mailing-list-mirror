From: =?iso-8859-1?Q?Henrik_Grubbstr=F6m?= <grubba@roxen.com>
Subject: Re: [PATCH 1/4] convert: Safer handling of $Id$ contraction.
Date: Wed, 3 Mar 2010 11:40:00 +0100 (CET)
Organization: Roxen Internet Software AB
Message-ID: <Pine.GSO.4.63.1003031129340.1164@shipon.roxen.com>
References: <1267460218-1172-1-git-send-email-grubba@grubba.org>
 <7vljeamcpq.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="-559023410-33463914-1267612800=:1164"
Cc: git@vger.kernel.org,
	=?iso-8859-1?Q?Henrik_Grubbstr=F6m?= <grubba@grubba.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Mar 03 12:03:21 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NmmML-0006fI-B5
	for gcvg-git-2@lo.gmane.org; Wed, 03 Mar 2010 12:03:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753510Ab0CCLDP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Mar 2010 06:03:15 -0500
Received: from mail.roxen.com ([212.247.29.220]:51441 "EHLO mail.roxen.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752809Ab0CCLDO (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Mar 2010 06:03:14 -0500
X-Greylist: delayed 1391 seconds by postgrey-1.27 at vger.kernel.org; Wed, 03 Mar 2010 06:03:14 EST
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.roxen.com (Postfix) with ESMTP id D8DBF62811E;
	Wed,  3 Mar 2010 11:40:01 +0100 (CET)
X-Virus-Scanned: amavisd-new at roxen.com
Received: from mail.roxen.com ([212.247.29.220])
	by localhost (marge.roxen.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id mnI4EcY9GjSr; Wed,  3 Mar 2010 11:40:01 +0100 (CET)
Received: from shipon.roxen.com (shipon.roxen.com [212.247.28.156])
	by mail.roxen.com (Postfix) with ESMTP id 0989562811D;
	Wed,  3 Mar 2010 11:40:01 +0100 (CET)
In-Reply-To: <7vljeamcpq.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/141442>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

---559023410-33463914-1267612800=:1164
Content-Type: TEXT/PLAIN; charset=iso-8859-1; format=flowed
Content-Transfer-Encoding: 8BIT

On Tue, 2 Mar 2010, Junio C Hamano wrote:

> Henrik Grubbström <grubba@grubba.org> writes:
>
>> From: Henrik Grubbström (Grubba) <grubba@grubba.org>
>
> You can omit this line, as it is the same as your From: header.

I blame git-send-email(1).

>> The code to contract $Id:xxxxx$ strings could eat an arbitrary amount
>> of source text if the terminating $ was lost. It now refuses to
>> contract $Id:xxxxx$ strings spanning multiple lines.
>
> Hmm, at least when going from working tree to the index, shouldn't the
> code refuse _and_ die(), instead of silently pass the garbage through?

It depends; it could be part of some code that scans for the $Id: tag.
A warning might be appropriate though.

--
Henrik Grubbström					grubba@grubba.org
Roxen Internet Software AB				grubba@roxen.com
---559023410-33463914-1267612800=:1164--

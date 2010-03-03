From: =?iso-8859-1?Q?Henrik_Grubbstr=F6m?= <grubba@grubba.org>
Subject: Re: [PATCH 2/4] convert: Keep foreign $Id$ on checkout.
Date: Wed, 3 Mar 2010 12:36:26 +0100 (CET)
Organization: Roxen Internet Software AB
Message-ID: <Pine.GSO.4.63.1003031140110.1164@shipon.roxen.com>
References: <1267460218-1172-1-git-send-email-grubba@grubba.org>
 <1267460218-1172-2-git-send-email-grubba@grubba.org> <7vfx4imcpl.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="-559023410-342241519-1267613498=:1164"
Cc: git@vger.kernel.org, grubba@grubba.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Mar 03 13:10:35 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NmnOx-0002F5-BT
	for gcvg-git-2@lo.gmane.org; Wed, 03 Mar 2010 13:10:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753944Ab0CCMJz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Mar 2010 07:09:55 -0500
Received: from mail.roxen.com ([212.247.29.220]:49111 "EHLO mail.roxen.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753876Ab0CCMJy (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Mar 2010 07:09:54 -0500
X-Greylist: delayed 2001 seconds by postgrey-1.27 at vger.kernel.org; Wed, 03 Mar 2010 07:09:54 EST
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.roxen.com (Postfix) with ESMTP id A002662811B;
	Wed,  3 Mar 2010 12:36:28 +0100 (CET)
X-Virus-Scanned: amavisd-new at roxen.com
Received: from mail.roxen.com ([212.247.29.220])
	by localhost (marge.roxen.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id lJL9D5xDg-ew; Wed,  3 Mar 2010 12:36:27 +0100 (CET)
Received: from shipon.roxen.com (shipon.roxen.com [212.247.28.156])
	by mail.roxen.com (Postfix) with ESMTP id 12506628121;
	Wed,  3 Mar 2010 12:36:26 +0100 (CET)
X-X-Sender: grubba@shipon.roxen.com
In-Reply-To: <7vfx4imcpl.fsf@alter.siamese.dyndns.org>
Content-ID: <Pine.GSO.4.63.1003031151430.1164@shipon.roxen.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/141447>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

---559023410-342241519-1267613498=:1164
Content-Type: TEXT/PLAIN; CHARSET=iso-8859-1; FORMAT=flowed
Content-Transfer-Encoding: 8BIT
Content-ID: <Pine.GSO.4.63.1003031151431.1164@shipon.roxen.com>

On Tue, 2 Mar 2010, Junio C Hamano wrote:

> Henrik Grubbström <grubba@grubba.org> writes:
>
>> If there are foreign $Id$ keywords in the repository, they are most
>> likely there for a reason.
>
> If so what is the user doing by using "ident" attribute?

Example:

   The user has recently converted from a different versioning system,
   and kept the $Id$ tags from that system verbatim since they have been
   refered to by external systems (eg bug reports, etc).

   Having the ident property active (with my patches) will cause the $Id$
   tag to be zapped as soon as (but not before) the file is altered.

--
Henrik Grubbström					grubba@grubba.org
Roxen Internet Software AB				grubba@roxen.com
---559023410-342241519-1267613498=:1164--

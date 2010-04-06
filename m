From: =?iso-8859-1?Q?Henrik_Grubbstr=F6m?= <grubba@roxen.com>
Subject: Re: [PATCH 4/5] convert: Inhibit contraction of foreign $Id$ during
 stats.
Date: Tue, 6 Apr 2010 13:53:16 +0200 (CEST)
Organization: Roxen Internet Software AB
Message-ID: <Pine.GSO.4.63.1004061324530.1164@shipon.roxen.com>
References: <cover.1269860022.git.grubba@grubba.org>
 <a75a46b1b6fdb9d52f608643676512e87474e16d.1269860022.git.grubba@grubba.org>
 <6d9d8b0eaa022f441c507b141ff0efa3f21d1988.1269860022.git.grubba@grubba.org>
 <74ce7980eb1fe629a651433ca9f1662f26495ce9.1269860022.git.grubba@grubba.org>
 <81e71814080d0eca72809a751e4e90026f8fe0ea.1269860022.git.grubba@grubba.org>
 <7v634bosjg.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="-559023410-1847939343-1270554796=:1164"
Cc: git@vger.kernel.org,
	=?iso-8859-1?Q?Henrik_Grubbstr=F6m?= <grubba@grubba.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Apr 06 13:53:32 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nz7LS-0003Yc-5M
	for gcvg-git-2@lo.gmane.org; Tue, 06 Apr 2010 13:53:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754779Ab0DFLxV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 6 Apr 2010 07:53:21 -0400
Received: from mail.roxen.com ([212.247.29.220]:45961 "EHLO mail.roxen.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754686Ab0DFLxT (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Apr 2010 07:53:19 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.roxen.com (Postfix) with ESMTP id 74F25628180;
	Tue,  6 Apr 2010 13:53:17 +0200 (CEST)
X-Virus-Scanned: amavisd-new at roxen.com
Received: from mail.roxen.com ([212.247.29.220])
	by localhost (marge.roxen.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id tjS90lz03pkS; Tue,  6 Apr 2010 13:53:16 +0200 (CEST)
Received: from shipon.roxen.com (shipon.roxen.com [212.247.28.156])
	by mail.roxen.com (Postfix) with ESMTP id ACADA628173;
	Tue,  6 Apr 2010 13:53:16 +0200 (CEST)
In-Reply-To: <7v634bosjg.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/144131>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

---559023410-1847939343-1270554796=:1164
Content-Type: TEXT/PLAIN; charset=iso-8859-1; format=flowed
Content-Transfer-Encoding: 8BIT

On Thu, 1 Apr 2010, Junio C Hamano wrote:

> "Henrik Grubbström (Grubba)"  <grubba@grubba.org> writes:
>
>> @@ -462,6 +463,20 @@ static int ident_to_git(const char *path, const char *src, size_t len,
[...]
>
> Somehow this feels to me that it is applying a band-aid to solve a problem
> that does not exist, only because the second patch in this series to keep
> the foreign one left expanded were not such a good change after all...

True, this was the patch that I was least satisfied with, since it only 
solved a special case (albeit the special case that I was interested in).

The general case is when the canonic (ie *_to_git) conversion filter for a
file has changed after the file was committed.

--
Henrik Grubbström					grubba@grubba.org
Roxen Internet Software AB				grubba@roxen.com
---559023410-1847939343-1270554796=:1164--

From: =?iso-8859-1?Q?Henrik_Grubbstr=F6m?= <grubba@roxen.com>
Subject: Re: [PATCH 2/2] Attr: Allow macros to override earlier attributes.
Date: Fri, 2 Apr 2010 21:23:21 +0200 (CEST)
Organization: Roxen Internet Software AB
Message-ID: <Pine.GSO.4.63.1004022118300.26349@shipon.roxen.com>
References: <ca1f7f974d72a036dd8369309d487bbd047a8e2d.1270216006.git.grubba@grubba.org>
 <f02815e3761a8050aa76f46cd19288e72da14206.1270216006.git.grubba@grubba.org>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="-559023410-1804928587-1270236201=:26349"
Cc: =?iso-8859-1?Q?Henrik_Grubbstr=F6m?= <grubba@roxen.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Apr 02 21:23:43 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NxmT1-0006hU-73
	for gcvg-git-2@lo.gmane.org; Fri, 02 Apr 2010 21:23:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753765Ab0DBTX1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 2 Apr 2010 15:23:27 -0400
Received: from mail.roxen.com ([212.247.29.220]:44565 "EHLO mail.roxen.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753128Ab0DBTX0 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 Apr 2010 15:23:26 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.roxen.com (Postfix) with ESMTP id E7C2B628137
	for <git@vger.kernel.org>; Fri,  2 Apr 2010 21:23:22 +0200 (CEST)
X-Virus-Scanned: amavisd-new at roxen.com
Received: from mail.roxen.com ([212.247.29.220])
	by localhost (marge.roxen.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 1XfpAs2cr3vy; Fri,  2 Apr 2010 21:23:21 +0200 (CEST)
Received: from shipon.roxen.com (shipon.roxen.com [212.247.28.156])
	by mail.roxen.com (Postfix) with ESMTP id A05926280A7;
	Fri,  2 Apr 2010 21:23:21 +0200 (CEST)
In-Reply-To: <f02815e3761a8050aa76f46cd19288e72da14206.1270216006.git.grubba@grubba.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/143839>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

---559023410-1804928587-1270236201=:26349
Content-Type: TEXT/PLAIN; charset=iso-8859-1; format=flowed
Content-Transfer-Encoding: 8BIT

On Fri, 2 Apr 2010, Henrik Grubbström (Grubba) wrote:

> Macros need to be able to override earlier attribute values.
> Consider a .gitattributes file with the following content:
>
> [attr]mybinary	binary -ident
> *		ident
> foo.bin		mybinary
>
> Without this patch foo.bin will still have the ident attribute set.

On closer thought, the approach taken by this patch wasn't a good idea,
since it doesn't handle the case:

bar.bin		mybinary ident

--
Henrik Grubbström					grubba@roxen.com
Roxen Internet Software AB
---559023410-1804928587-1270236201=:26349--

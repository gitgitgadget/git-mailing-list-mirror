From: =?utf-8?q?=E3=81=97=E3=82=89=E3=81=84=E3=81=97=E3=81=AA=E3=81=AA=E3=81=93?= 
	<nanako3@bluebottle.com>
Subject: Re: how to use two bare repositories?
Date: Sat, 12 Apr 2008 09:42:05 +0900
Message-ID: <200804120042.m3C0gmWR004445@mi0.bluebottle.com>
References: <7vabk0nd6x.fsf@gitster.siamese.dyndns.org> <20080411234430.GQ29940@cs-wsok.swansea.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: git@vger.kernel.org, Oliver Kullmann <O.Kullmann@swansea.ac.uk>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Apr 12 02:43:51 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JkTqR-0004L8-4W
	for gcvg-git-2@gmane.org; Sat, 12 Apr 2008 02:43:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757567AbYDLAmv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 11 Apr 2008 20:42:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756957AbYDLAmv
	(ORCPT <rfc822;git-outgoing>); Fri, 11 Apr 2008 20:42:51 -0400
Received: from mi0.bluebottle.com ([206.188.25.15]:45027 "EHLO
	mi0.bluebottle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756782AbYDLAmv (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Apr 2008 20:42:51 -0400
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by mi0.bluebottle.com (8.13.1/8.13.1) with ESMTP id m3C0gmWR004445
	for <git@vger.kernel.org>; Fri, 11 Apr 2008 17:42:48 -0700
DomainKey-Signature: a=rsa-sha1; s=mail; d=bluebottle.com; c=nofws; q=dns;
	h=received:from:to:cc:subject:date:in-reply-to:references:
	mime-version:content-type:content-transfer-encoding:x-trusted-delivery;
	b=i5oVnxGhD8EsJYWW+klSRj/+yVIAunuOchk9ky91/Rd+XBLToAo31j6qOAf6ZVqtp
	r19kDkEVwnzqZJMsu5vjrA+OZ2sm5rmnyJtv9ljSIq1cKtLbYCjFdWjV8E+F9iw
Received: from nanako3.mail.bluebottle.com ([212.62.97.21])
	(authenticated bits=0)
	by fe0.bluebottle.com (8.13.1/8.13.1) with ESMTP id m3C0gaF5031459
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Fri, 11 Apr 2008 17:42:41 -0700
In-reply-to: <7vabk0nd6x.fsf@gitster.siamese.dyndns.org>
X-Trusted-Delivery: <0ecf94412d60934226b868d65baa5472>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/79319>

Junio C Hamano <gitster@pobox.com> writes:

> Typically, you would update a bare repository used for publishing by
> pushing into it, and trigger update-server-info from the post-update hook.
>
> But it is perfectly fine if you initiate a mirror-fetch from that
> publishing repository (in your case, "B"), and the caller to "git fetch"
> can run update-server-info after fetching.
>
> And no, there is not a "post-fetch" hook, nor is there a need for one.

Can you please explain why?

-- 
Nanako Shiraishi
http://ivory.ap.teacup.com/nanako3/

----------------------------------------------------------------------
Finally - A spam blocker that actually works.
http://www.bluebottle.com/tag/4

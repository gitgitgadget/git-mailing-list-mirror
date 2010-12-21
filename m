From: Ken Brownfield <krb@irridia.com>
Subject: Re: Performance issue exposed by git-filter-branch
Date: Mon, 20 Dec 2010 20:59:27 -0800
Message-ID: <5ED25D1E-3028-43B7-9EA7-8E94773EA3E1@irridia.com>
References: <41C1B4AC-8427-4D62-BEB6-689A4BE4EE5B@irridia.com> <AANLkTi=eWaaGKGpUptdkVg5iEMiZK5FQ9URjUTgd+LxB@mail.gmail.com>
Mime-Version: 1.0 (Apple Message framework v1081)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Dec 21 05:59:37 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PUuK0-0006nr-Us
	for gcvg-git-2@lo.gmane.org; Tue, 21 Dec 2010 05:59:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933580Ab0LUE72 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 20 Dec 2010 23:59:28 -0500
Received: from endymion.irridia.com ([184.105.192.220]:44962 "EHLO
	endymion.irridia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933593Ab0LUE72 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 20 Dec 2010 23:59:28 -0500
Received: from shrike2.sfo.corp.google.com (unknown [72.14.229.84])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by endymion.irridia.com (Postfix) with ESMTPSA id 0D1F714566E
	for <git@vger.kernel.org>; Mon, 20 Dec 2010 20:59:28 -0800 (PST)
In-Reply-To: <AANLkTi=eWaaGKGpUptdkVg5iEMiZK5FQ9URjUTgd+LxB@mail.gmail.com>
X-Mailer: Apple Mail (2.1081)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/164026>

Filename lengths: min 4 avg 50 median 51 max 178
Directory depths: min 1 avg 5 median 6 max 13

Pretty standard Python naming/hierarchy, really.

Thanks!
Ken

On Dec 17, 2010, at 5:01 AM, Nguyen Thai Ngoc Duy wrote:

> On Fri, Dec 17, 2010 at 8:07 AM, Ken Brownfield <krb@irridia.com> wrote:
>> cache_name_compare (and the presumed follow-ons of memcpy/sha/malloc/etc) is the major consumer.
> 
> Other people have given you alternative approaches. I'm just wondering
> if we can improve something here. cache_name_compare() is essentially
> memcmp() on two full paths. A tree-based index might help. How long
> are your file names on average? Are your trees deep?
> -- 
> Duy
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

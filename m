From: =?iso-8859-1?Q?Henrik_Grubbstr=F6m?= <grubba@roxen.com>
Subject: Re: [PATCH v4 3/8] status: Added missing calls to diff_unmodified_pair()
 in format_callbacks.
Date: Mon, 12 Apr 2010 15:00:03 +0200 (CEST)
Organization: Roxen Internet Software AB
Message-ID: <Pine.GSO.4.63.1004121453310.1164@shipon.roxen.com>
References: <cover.1270554878.git.grubba@grubba.org>
 <5962221bef558d15183c9937863b38bc7ca41339.1270554878.git.grubba@grubba.org>
 <7vaatbueg5.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="-559023410-96173209-1271077203=:1164"
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Apr 12 15:00:16 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O1JFP-0002cg-GU
	for gcvg-git-2@lo.gmane.org; Mon, 12 Apr 2010 15:00:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751910Ab0DLNAI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Apr 2010 09:00:08 -0400
Received: from mail.roxen.com ([212.247.29.220]:43954 "EHLO mail.roxen.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751180Ab0DLNAH (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Apr 2010 09:00:07 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.roxen.com (Postfix) with ESMTP id BD717628145;
	Mon, 12 Apr 2010 15:00:04 +0200 (CEST)
X-Virus-Scanned: amavisd-new at roxen.com
Received: from mail.roxen.com ([212.247.29.220])
	by localhost (marge.roxen.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id beN2j3eIdrgP; Mon, 12 Apr 2010 15:00:03 +0200 (CEST)
Received: from shipon.roxen.com (shipon.roxen.com [212.247.28.156])
	by mail.roxen.com (Postfix) with ESMTP id C61646280A7;
	Mon, 12 Apr 2010 15:00:03 +0200 (CEST)
In-Reply-To: <7vaatbueg5.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/144722>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

---559023410-96173209-1271077203=:1164
Content-Type: TEXT/PLAIN; charset=iso-8859-1; format=flowed
Content-Transfer-Encoding: 8BIT

On Sat, 10 Apr 2010, Junio C Hamano wrote:

> "Henrik Grubbström (Grubba)"  <grubba@grubba.org> writes:
>
>> The diff_queue_struct provided by diff_flush() is raw, and needs to be
>> filtered through diff_unmodified_pair() before being used.
>> This is already done by most of the other functions operating on
>> diff_queue_struct called by diff_flush().
>
> That is true but only if you are letting the diff front-end to feed
> unmodified pairs to begin with, e.g. --find-copies-harder.  I don't think
> the internal caller in wt-status does that.
>
> I don't think the patch is wrong nor it would hurt, but I am puzzled why
> you needed this patch.

Well, it's a prerequisite for the diff: Filter files that have changed...
patch, albeit apparently not sufficient (yet).

--
Henrik Grubbström					grubba@grubba.org
Roxen Internet Software AB				grubba@roxen.com
---559023410-96173209-1271077203=:1164--

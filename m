From: "Catalin Marinas" <catalin.marinas@gmail.com>
Subject: Re: [PATCH 2/3] Rebase to parent branch after git-fetch in "stg pull".
Date: Fri, 2 Feb 2007 09:58:06 +0000
Message-ID: <b0943d9e0702020158o1a07b8efu9302794c57d050e1@mail.gmail.com>
References: <20070201234534.3313.10426.stgit@gandelf.nowhere.earth>
	 <20070201234805.3313.20525.stgit@gandelf.nowhere.earth>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Yann Dirson" <ydirson@altern.org>
X-From: git-owner@vger.kernel.org Fri Feb 02 10:58:13 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HCvBN-0000a9-9L
	for gcvg-git@gmane.org; Fri, 02 Feb 2007 10:58:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932967AbXBBJ6J (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 2 Feb 2007 04:58:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932998AbXBBJ6J
	(ORCPT <rfc822;git-outgoing>); Fri, 2 Feb 2007 04:58:09 -0500
Received: from wr-out-0506.google.com ([64.233.184.227]:37303 "EHLO
	wr-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932967AbXBBJ6I (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 Feb 2007 04:58:08 -0500
Received: by wr-out-0506.google.com with SMTP id i22so684629wra
        for <git@vger.kernel.org>; Fri, 02 Feb 2007 01:58:07 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=M2vRw/IsmWa5hD96C8DcfNNI8gICIIucpLzjseci5FFbwmvd3DDLtrMaECqm+C1v9JJKBMwbzyemxIdHvXkfSDseuipwOAv9pOIQtu26oY5n0C9Be54en2nnjLgpmowyHQ2jxwKE/EhquEu7maOPPo33X4Gd2g5+NCyeYMbFhbg=
Received: by 10.114.12.9 with SMTP id 9mr277644wal.1170410287008;
        Fri, 02 Feb 2007 01:58:07 -0800 (PST)
Received: by 10.115.110.12 with HTTP; Fri, 2 Feb 2007 01:58:06 -0800 (PST)
In-Reply-To: <20070201234805.3313.20525.stgit@gandelf.nowhere.earth>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/38484>

On 01/02/07, Yann Dirson <ydirson@altern.org> wrote:
> Previously we were just assuming that the remote from which we
> just failed defined a local branch whose name was the same as the
> remote def, and that this branch was the parent.  While this is true
> for the most common case (branch "origin" from remote "origin"), it is
> quite an unflexible assumption.

The t1200-push-modified.sh test fails after applying this patch. It
looks like the 3rd test fails to pull the changes from 'foo' into
'bar'.

Thanks.

-- 
Catalin

From: Andy Parkins <andyparkins@gmail.com>
Subject: Re: git-fetch and unannotated tags
Date: Wed, 25 Apr 2007 21:42:32 +0100
Message-ID: <200704252142.33756.andyparkins@gmail.com>
References: <200704252004.45112.andyparkins@gmail.com> <Pine.LNX.4.64.0704252056210.1005@reaper.quantumfyre.co.uk>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Julian Phillips <julian@quantumfyre.co.uk>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 25 22:43:24 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HgoKa-0001PP-Q1
	for gcvg-git@gmane.org; Wed, 25 Apr 2007 22:43:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S2993174AbXDYUmu (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 25 Apr 2007 16:42:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S2993175AbXDYUmu
	(ORCPT <rfc822;git-outgoing>); Wed, 25 Apr 2007 16:42:50 -0400
Received: from wr-out-0506.google.com ([64.233.184.236]:14690 "EHLO
	wr-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S2993173AbXDYUmt (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Apr 2007 16:42:49 -0400
Received: by wr-out-0506.google.com with SMTP id 76so383006wra
        for <git@vger.kernel.org>; Wed, 25 Apr 2007 13:42:48 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=C5cPINWUmkT6foTdZdhyOTvdko505sIcBLvi2Q90p8PLr25n6+NTAgY+Hqx/CLlLmo0wY237oLdZ1R042lxtrrYBAFzgFHvQsGEdE8K45mbhZMIfUjZT0L9ci4f3CS4v0sRA2d1+w2+HWGL5wrvjDLZxP+W38WCjOoLYNlFHqP4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=r+TBpRrhJWLn0AsiYYkyf2ki5vfVRY00b0fj3XWvBGRkany9MTSr2bCQBc5+CZ+WnjN6jtyZ+Lot9tvTUppiqihabL7UMf2mvzFOYJAVPGCkAIfHWvHRYsHkojR4039matdnisiaEBkYDV9eKK/L+wuM0rcJEXShC+HeDEEiQqU=
Received: by 10.78.204.7 with SMTP id b7mr308565hug.1177533768000;
        Wed, 25 Apr 2007 13:42:48 -0700 (PDT)
Received: from grissom.local ( [84.201.153.164])
        by mx.google.com with ESMTP id y7sm3146928ugc.2007.04.25.13.42.46;
        Wed, 25 Apr 2007 13:42:47 -0700 (PDT)
User-Agent: KMail/1.9.6
In-Reply-To: <Pine.LNX.4.64.0704252056210.1005@reaper.quantumfyre.co.uk>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/45571>

On Wednesday 2007, April 25, Julian Phillips wrote:

> Why not create a directory .git/refs/bm and put things you don't want
> to make public in there?  You can then use bm/foo etc ...

I could, but then they don't get treated as tags properly in qgit.  I 
still want to list them in git-tag -l

> You could even modify git-tag to create them for you with some
> appropriate switch ...

Well yes, but that's the answer to everything isn't it?


Andy

-- 
Dr Andy Parkins, M Eng (hons), MIET
andyparkins@gmail.com

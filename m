From: "Rafael Garcia-Suarez" <rgarciasuarez@gmail.com>
Subject: Re: [PATCH] git-cherry-pick -x works with conflicting commits
Date: Mon, 24 Mar 2008 15:52:57 +0100
Message-ID: <b77c1dce0803240752s29e611aay55c4021741de598a@mail.gmail.com>
References: <1206355274-6052-1-git-send-email-rgarciasuarez@gmail.com>
	 <ae63f8b50803240655k5d6413e5s8d6ceebca462370f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Jean-Baptiste Quenot" <jbq@caraldi.com>
X-From: git-owner@vger.kernel.org Mon Mar 24 15:53:49 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jdo3Y-0006xz-Sp
	for gcvg-git-2@gmane.org; Mon, 24 Mar 2008 15:53:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761170AbYCXOw7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 24 Mar 2008 10:52:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1761127AbYCXOw7
	(ORCPT <rfc822;git-outgoing>); Mon, 24 Mar 2008 10:52:59 -0400
Received: from rv-out-0910.google.com ([209.85.198.190]:16225 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760771AbYCXOw6 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 24 Mar 2008 10:52:58 -0400
Received: by rv-out-0910.google.com with SMTP id k20so1483669rvb.1
        for <git@vger.kernel.org>; Mon, 24 Mar 2008 07:52:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=xJGQm7frhjp0eSLSlXJivvoWmw66BQdWdrvYCJz6N1Q=;
        b=QvtVRxbZH15lcph2+OBi3Q/oZHHHM2Zdi6g8VjXYScssayD248u8T43s3ON1qjY57LCQpuJJXBifDu/1Q7ACEnTAltU/x1VOE9rj9+kZG6IZMEFqnVVJKLRqN1Jtcnrl+ke66wzYiT1l8Rb4BRggg0zofaw43keBFp9RMVC3rbo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=jqgQA2XDgi+rvyGUTlPlFnD8+S7BYjB8SKMq+WzKZMRnbxWectQXKABRtMZbGe6G3YaGAl/8zkdeI1R6ZCFQilXYvO+58vTGHLTaoFXBFZESaISPWBVkbQm14Rfpn8mNAGZgNCmbWYs19RWDy3/WeKVb9i/lGeEheumZWLTxRCE=
Received: by 10.141.193.1 with SMTP id v1mr2207992rvp.73.1206370377435;
        Mon, 24 Mar 2008 07:52:57 -0700 (PDT)
Received: by 10.140.131.1 with HTTP; Mon, 24 Mar 2008 07:52:57 -0700 (PDT)
In-Reply-To: <ae63f8b50803240655k5d6413e5s8d6ceebca462370f@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/78045>

On 24/03/2008, Jean-Baptiste Quenot <jbq@caraldi.com> wrote:
> When I'm using "git commit -c <id>" as suggested by git-cherry-pick
>  upon conflict, I do not get the mention "(cherry picked from commit
>  <id>)", at least with version 1.5.4.1.  How did you get it?

I use the most recent git from master, and simply do git-add and
git-commit without arguments after having resolving the conflict. The
commit message in MERGE_MSG, that I checked, does have the "cherry
picked from commit <id>" mention (before the conflict list).

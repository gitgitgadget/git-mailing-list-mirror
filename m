From: "Jean-Baptiste Quenot" <jbq@caraldi.com>
Subject: Re: [PATCH] git-cherry-pick -x works with conflicting commits
Date: Mon, 24 Mar 2008 19:32:39 +0100
Message-ID: <ae63f8b50803241132s2938ae17s79257fdb7938ba79@mail.gmail.com>
References: <1206355274-6052-1-git-send-email-rgarciasuarez@gmail.com>
	 <ae63f8b50803240655k5d6413e5s8d6ceebca462370f@mail.gmail.com>
	 <b77c1dce0803240752s29e611aay55c4021741de598a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Rafael Garcia-Suarez" <rgarciasuarez@gmail.com>
X-From: git-owner@vger.kernel.org Mon Mar 24 19:33:43 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JdrUF-0007md-SY
	for gcvg-git-2@gmane.org; Mon, 24 Mar 2008 19:33:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759252AbYCXSco (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 24 Mar 2008 14:32:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758333AbYCXSco
	(ORCPT <rfc822;git-outgoing>); Mon, 24 Mar 2008 14:32:44 -0400
Received: from mu-out-0910.google.com ([209.85.134.191]:16897 "EHLO
	mu-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757442AbYCXScn (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 24 Mar 2008 14:32:43 -0400
Received: by mu-out-0910.google.com with SMTP id i10so3456335mue.5
        for <git@vger.kernel.org>; Mon, 24 Mar 2008 11:32:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references:x-google-sender-auth;
        bh=HGyLfR4QVK5UzguciCzFXG7tgQ1sTSbbnR4FTjk9dOc=;
        b=ZKZgA6KivOthrq9/ecFg2MiFB9S5I4W2d5VEADcBoeCRmvcgwDxUcNIm9HUmoWi+Iw2eJmBHDCETDRN8+ykenDd884cGoJOlSvTgdpWxFR4DsE5ngfpemV/YtWtkNp1gflvkZrUODcvP/GzdvKU9kNh1XV4z7QFvF7dBxUwLCYY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references:x-google-sender-auth;
        b=NP+29p9pr5KcMZ/UlCpO2O2Tg5OGRD9unjd81IAmn2sLW/kCsEJSPEnZvAoBDyCM8jVWiJCPSF5RpqCQmBy/TLGO0XKQmrK2ImKvkix1yGkE12aWQ5JiOzj4LTMSPmujGKyHdJ+v26CpI6VVbwsrOOvEqVGYXZzBCWdioct39cM=
Received: by 10.78.196.10 with SMTP id t10mr16101747huf.30.1206383559755;
        Mon, 24 Mar 2008 11:32:39 -0700 (PDT)
Received: by 10.78.130.20 with HTTP; Mon, 24 Mar 2008 11:32:39 -0700 (PDT)
In-Reply-To: <b77c1dce0803240752s29e611aay55c4021741de598a@mail.gmail.com>
Content-Disposition: inline
X-Google-Sender-Auth: 96d93ee00eb720f1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/78073>

All right, I see.  The conflict error message was confusing me:

------------------------------------------------------------------------
fatal: Entry 'azerty' would be overwritten by merge. Cannot merge.
Automatic cherry-pick failed.  After resolving the conflicts,
mark the corrected paths with 'git add <paths>' or 'git rm <paths>'
and commit the result.
When commiting, use the option '-c c17532f' to retain authorship and message.
------------------------------------------------------------------------

The last sentence does not make much sense when -x is specified.

Cheers,
-- 
Jean-Baptiste Quenot
http://caraldi.com/jbq/blog/

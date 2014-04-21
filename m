From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [RTC/PATCH] Add 'update-branch' hook
Date: Mon, 21 Apr 2014 16:17:26 -0500
Message-ID: <53558ae6f1282_604be1f30cf3@nysa.notmuch>
References: <1398047016-21643-1-git-send-email-felipe.contreras@gmail.com>
 <5355793A.5020000@gmail.com>
 <53558476703cb_5c94d452ec4e@nysa.notmuch>
 <53558A54.4060801@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
To: Ilya Bobyr <ilya.bobyr@gmail.com>,
	Felipe Contreras <felipe.contreras@gmail.com>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Apr 21 23:28:03 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WcLkw-0004og-By
	for gcvg-git-2@plane.gmane.org; Mon, 21 Apr 2014 23:28:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754820AbaDUV1w (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Apr 2014 17:27:52 -0400
Received: from mail-yk0-f171.google.com ([209.85.160.171]:47756 "EHLO
	mail-yk0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754814AbaDUV1t (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Apr 2014 17:27:49 -0400
Received: by mail-yk0-f171.google.com with SMTP id q9so3891137ykb.30
        for <git@vger.kernel.org>; Mon, 21 Apr 2014 14:27:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:message-id:in-reply-to:references:subject:mime-version
         :content-type:content-transfer-encoding;
        bh=SSeLNQeLMAJ+pVyBfaeAqE+GU1CUDbBqoOY9eqDRwoA=;
        b=IMDkLQ8QNb6IrBJq7azF8crDWSIQ+uHPS4sbWwadwo6fbDRjYHo9dCy41Xh+dE6aHQ
         hnDHka1dnEQqOuYwJn1Tsgx2p3D6cSiMrH00XV+wYeqOyRX/HM19FiGzKEp0M9rXHNBK
         DN1mut4tRjzpxdML9NAz/wrxG6F+q0Af1xCBKx6bCrOvCD68LuRLlCJU62LJQL4WPrmo
         jC6j+6AUeYZeJdjAmC8UXC7c+QOMqcQmpR92NR11m39huSwtLjLtf7KPtc1MmUgeY6M0
         nugS1ocfCNZsEQ/IpYuAonv5P+fhQ5MdGXle1hCh7dMpkl5T48zr+c9PliIyNoth00gG
         3eDA==
X-Received: by 10.236.100.177 with SMTP id z37mr5079270yhf.123.1398115668853;
        Mon, 21 Apr 2014 14:27:48 -0700 (PDT)
Received: from localhost (189-211-224-40.static.axtel.net. [189.211.224.40])
        by mx.google.com with ESMTPSA id j46sm73702549yhc.14.2014.04.21.14.27.47
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 21 Apr 2014 14:27:47 -0700 (PDT)
In-Reply-To: <53558A54.4060801@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/246647>

Ilya Bobyr wrote:

> Also, most have names that start with either "pre-" or "post-".
> It seems reasonable for both "pre-update-branch" and
> "post-update-branch" to exist.

I don't see what would be the point in that.

> This one would be "pre-update-branch", I guess.
> 
> I was also wondering about "git reset".  It could also change the branch
> position, right?

That's right, maybe that command should call the hook as well.

-- 
Felipe Contreras

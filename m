From: "Dana How" <danahow@gmail.com>
Subject: Re: [PATCH 5/6] Teach "fsck" not to follow subproject links
Date: Wed, 11 Apr 2007 17:00:52 -0700
Message-ID: <56b7f5510704111700r1cb6923ehbfb742512014aebc@mail.gmail.com>
References: <Pine.LNX.4.64.0704092100110.6730@woody.linux-foundation.org>
	 <Pine.LNX.4.64.0704111545040.6730@woody.linux-foundation.org>
	 <Pine.LNX.4.64.0704111605210.6730@woody.linux-foundation.org>
	 <Pine.LNX.4.63.0704111600390.28394@qynat.qvtvafvgr.pbz>
	 <Pine.LNX.4.64.0704111646000.6730@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "David Lang" <david.lang@digitalinsight.com>,
	"Sam Vilain" <sam@vilain.net>,
	"Git Mailing List" <git@vger.kernel.org>,
	"Junio C Hamano" <junkio@cox.net>, danahow@gmail.com
To: "Linus Torvalds" <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Thu Apr 12 02:01:01 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HbmkE-0000Wk-AJ
	for gcvg-git@gmane.org; Thu, 12 Apr 2007 02:00:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161383AbXDLAAz (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 11 Apr 2007 20:00:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161412AbXDLAAy
	(ORCPT <rfc822;git-outgoing>); Wed, 11 Apr 2007 20:00:54 -0400
Received: from nz-out-0506.google.com ([64.233.162.239]:23084 "EHLO
	nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1161383AbXDLAAx (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Apr 2007 20:00:53 -0400
Received: by nz-out-0506.google.com with SMTP id s1so272670nze
        for <git@vger.kernel.org>; Wed, 11 Apr 2007 17:00:53 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=umFqI/b5UW1887KFtK/+I7pS+yZeJ0Mt10lOdDkmTtuG3QNIUMOPWhNsW8OA7TGZxa5Q5MrKMbBvCAqLfL5arQMGOvKKGxSqUAKv2PSiaQm/SuIhnBzdpIPOPdAtZMwhb0oM8/uNEZiRlgcVCp7ybpEzYGO1eAmslkhsoW4lxc8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=GNrB4ISqvf7m9NP6AA0pvpqlilAXgZyXa7xWL1C/a1eddAtFuQ2bKTyb6WuwO07WEhNPQLq0YyyA9lRcoGxN10YGP1ejgJ3E0PuG/rBS3iLJA8fyBpmINtIpb7WBS9JUWhSsu7a0dIaqYv4y7AfeOoHBiIUQPlPy93NVzCUuDZs=
Received: by 10.114.185.8 with SMTP id i8mr511264waf.1176336052715;
        Wed, 11 Apr 2007 17:00:52 -0700 (PDT)
Received: by 10.114.46.4 with HTTP; Wed, 11 Apr 2007 17:00:52 -0700 (PDT)
In-Reply-To: <Pine.LNX.4.64.0704111646000.6730@woody.linux-foundation.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/44285>

On 4/11/07, Linus Torvalds <torvalds@linux-foundation.org> wrote:
> It's not an insurmountable problem, or even necessarily a very large one,
> but it boils down to one very basic issue:
>
>  - nobody seems to actually *use* the shared object directory model!

Cool -- my previous email makes me either a git idiot or a git pioneer!

So I'll think through my usage model some more and
look over the fsck source.

Until then,
-- 
Dana L. How  danahow@gmail.com  +1 650 804 5991 cell

From: Stefano Lattarini <stefano.lattarini@gmail.com>
Subject: Re: [ENHANCEMENT] Allow '**' pattern in .gitignore
Date: Tue, 02 Oct 2012 09:58:30 +0200
Message-ID: <506A9EA6.9010303@gmail.com>
References: <CALkWK0nXfeAnFfdFtdDNdEwtk0mMPtpYbg8sPzfrEXUpXsGQOA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Git List <git@vger.kernel.org>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Tue Oct 02 09:59:19 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TIxNT-0004O3-BI
	for gcvg-git-2@plane.gmane.org; Tue, 02 Oct 2012 09:58:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753461Ab2JBH6l (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Oct 2012 03:58:41 -0400
Received: from mail-bk0-f46.google.com ([209.85.214.46]:42839 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753389Ab2JBH6l (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Oct 2012 03:58:41 -0400
Received: by bkcjk13 with SMTP id jk13so5299606bkc.19
        for <git@vger.kernel.org>; Tue, 02 Oct 2012 00:58:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:mime-version:to:cc:subject:references
         :in-reply-to:content-type:content-transfer-encoding;
        bh=2Yl3vohqELrZQbKMnNa/nNA3DKLrWrnJRUQOKFJdufE=;
        b=FEHDYn9pH3JHH3G6G31aZWHlZrhiLdbg98IOfL86lPVmniSZKNxoCD3qSOYCaN2phL
         TOFSzFs4nbJozbzeg1pf60Diw0UZpq6utvF1/B8LUX4wQ15sbUW04cFe96PSyDVvaYS4
         nCbO+r04OVJ2WNk9SXLEizosT/qCqDzn7+fgTBdn6iIjnBJRqTYHiDvn2giZzVrJG2KW
         RKBaHkjLqNVTHCUIqaLIio4p/aVexQmPf/BKBdQ9yLTmFsUahPsY4ljKPNrD4tcWt7ex
         5rAnA3WqKS/lMiWD5AhoRLNHCtqMCK3afkhh4j94JjLhKSSfTEhof8o1EGDS6/gT5c+E
         x1EQ==
Received: by 10.204.3.214 with SMTP id 22mr6400505bko.108.1349164719662;
        Tue, 02 Oct 2012 00:58:39 -0700 (PDT)
Received: from [192.168.178.21] (host194-94-dynamic.2-87-r.retail.telecomitalia.it. [87.2.94.194])
        by mx.google.com with ESMTPS id k21sm246023bkv.1.2012.10.02.00.58.38
        (version=SSLv3 cipher=OTHER);
        Tue, 02 Oct 2012 00:58:38 -0700 (PDT)
In-Reply-To: <CALkWK0nXfeAnFfdFtdDNdEwtk0mMPtpYbg8sPzfrEXUpXsGQOA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/206789>

On 10/02/2012 09:21 AM, Ramkumar Ramachandra wrote:
> Hi,
> 
> I've often found the '**' (extended) shell glob useful for matching
> any string crossing directory boundaries: it's especially useful if
> you only have a toplevel .gitignore, as opposed to a per-directory
> .gitignore.  Unfortunately, .gitignore currently uses fnmatch(3), and
> doesn't recognize '**'.  Would extending the .gitignore format to
> accept this be a useful feature?  Would it involve re-implementing and
> extending fnmatch, or is there some other way?
>
I think there is a topic in flight about this:

    <http://thread.gmane.org/gmane.comp.version-control.git/206406>

HTH,
  Stefano

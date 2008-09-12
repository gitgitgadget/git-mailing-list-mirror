From: "Catalin Marinas" <catalin.marinas@gmail.com>
Subject: Re: StGit question
Date: Fri, 12 Sep 2008 23:15:29 +0100
Message-ID: <b0943d9e0809121515v53c6d593o8211b3cbbb8dfba4@mail.gmail.com>
References: <48C94F86.6080707@gmail.com>
	 <20080912075116.GA26685@diana.vm.bytemark.co.uk>
	 <48CA6367.9020300@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "=?ISO-8859-1?Q?Karl_Hasselstr=F6m?=" <kha@treskal.com>,
	git@vger.kernel.org
To: "Clark Williams" <clark.williams@gmail.com>
X-From: git-owner@vger.kernel.org Sat Sep 13 00:16:46 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KeGwT-0004Vn-Fg
	for gcvg-git-2@gmane.org; Sat, 13 Sep 2008 00:16:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757791AbYILWPb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Sep 2008 18:15:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757690AbYILWPb
	(ORCPT <rfc822;git-outgoing>); Fri, 12 Sep 2008 18:15:31 -0400
Received: from rv-out-0506.google.com ([209.85.198.238]:58194 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757575AbYILWPa (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Sep 2008 18:15:30 -0400
Received: by rv-out-0506.google.com with SMTP id k40so992369rvb.1
        for <git@vger.kernel.org>; Fri, 12 Sep 2008 15:15:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=pG//y3uFrfpcvfAbuqRTPFopCOW6rIplqwoqFSO56sY=;
        b=Z6I1YjHRgva3C18jCdBlGk+GrXfByriOJoGUmUE+hgWl/7g8b2VovE+UILZSJOtiWb
         kXZsGb0inMk1rQRYZsCgT8i5Iu9JkA/NrUXceJUPFkY9ik7Qm32ENubrJng+pQ0ymuax
         heBZRfiqP7ycn0aaoQL3z+VavqDZqND5P0G7s=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=luElIEP6B/ASuq6+oc1w0GE+T3NXRQydiqt1VWJk9twbD3fF32f6RYYcgoS2NAa9xj
         o08d7oNX463XPIGVyk7gwhqG0iTRr4cq20MPI6uV3Hf6VswfaXHKDT1BR0c7kR495ZB+
         2cFyn6kInvwmfogk31q7TJUW/t3fTIm5zXKe4=
Received: by 10.141.89.13 with SMTP id r13mr2943180rvl.88.1221257729310;
        Fri, 12 Sep 2008 15:15:29 -0700 (PDT)
Received: by 10.140.136.21 with HTTP; Fri, 12 Sep 2008 15:15:29 -0700 (PDT)
In-Reply-To: <48CA6367.9020300@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/95779>

On 12/09/2008, Clark Williams <clark.williams@gmail.com> wrote:
> Most of the time it's not more than one or two patches difference, so I think that it
>  can be handled manually for now. I'll definitely keep an eye on sync and merge though...

As Karl said, we have some plans to allow collaboration between
multiple StGit repositories but we didn't have much time to look at it
recently. Karl's "merge" stuff looks promising though.

What "sync" does is that it allow the same set of patches between two
branches to be synchronised in case modifications happened on one of
these branches. In your situation, you would have to fetch the remote
branch, uncommit as in Karl's method and either import or sync the
remote patches with those on your local branch.

-- 
Catalin

From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 4/5] vcs-svn: Add outfile option to buffer_copy_bytes()
Date: Mon, 18 Oct 2010 03:59:30 -0500
Message-ID: <20101018085930.GA5425@burratino>
References: <1287147256-9457-1-git-send-email-david.barr@cordelta.com>
 <1287147256-9457-5-git-send-email-david.barr@cordelta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Sverre Rabbelier <srabbelier@gmail.com>
To: David Barr <david.barr@cordelta.com>
X-From: git-owner@vger.kernel.org Mon Oct 18 11:03:17 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P7lcj-00027c-9L
	for gcvg-git-2@lo.gmane.org; Mon, 18 Oct 2010 11:03:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754563Ab0JRJDL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 Oct 2010 05:03:11 -0400
Received: from mail-yx0-f174.google.com ([209.85.213.174]:62004 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753744Ab0JRJDK (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Oct 2010 05:03:10 -0400
Received: by yxm8 with SMTP id 8so223992yxm.19
        for <git@vger.kernel.org>; Mon, 18 Oct 2010 02:03:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=V84saq5b+dxjeKs3vd0bXMBXswBf1Nkp0WHQ3crm1XY=;
        b=G7kbmL/5Ju144n1I7VhZWvOuOYxg5xrWIAezpmjCX6TtUS0SzFVhv5DJxyM/ZwrHJw
         RI3YP9AYnruMw7SMDTMP577/Q3mHX63l5m2bKCy4YsgQgATnw6SMaEvSSxLxD7MApzmZ
         KJcm0cfahQwROJJRN4+eA+8XQ5uEbHFl/i6Uc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=nNgQNkNPkaoxFiGHIxHnsUYcr5zAkn2Z8+yQWJhMLdD0bv1YEsslAl4CsL4IC9hjlR
         F+p0gDtu3/awwgB79uJ/9Y6E+2Q8gEVq1c1xTTWf/fpNAkJHNLFJ1/rzxG+NkoOu+GW6
         XL9OUVwVpi7Cpa87FsIJ1akpZq7n1KfkhrqM0=
Received: by 10.151.146.3 with SMTP id y3mr6480226ybn.182.1287392589826;
        Mon, 18 Oct 2010 02:03:09 -0700 (PDT)
Received: from burratino (adsl-68-255-106-176.dsl.chcgil.ameritech.net [68.255.106.176])
        by mx.google.com with ESMTPS id z16sm13722206ybm.4.2010.10.18.02.03.08
        (version=SSLv3 cipher=RC4-MD5);
        Mon, 18 Oct 2010 02:03:09 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1287147256-9457-5-git-send-email-david.barr@cordelta.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/159240>

David Barr wrote:

> Explicitly declare that output is to stdout for existing use.
> Allow users of buffer_copy_bytes() to specify the output file.

Probably worth mentioning the motivation, which is presumably
that svn-fe will be streaming the preimage for files expressed as
deltas from the cat-file-fd to a temporary file.

> Signed-off-by: David Barr <david.barr@cordelta.com>

Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>

Thanks.  (It's a good API change.)

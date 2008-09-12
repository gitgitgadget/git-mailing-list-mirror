From: "Catalin Marinas" <catalin.marinas@gmail.com>
Subject: Re: StGit question
Date: Fri, 12 Sep 2008 23:18:22 +0100
Message-ID: <b0943d9e0809121518p38f60733v3857fa66ac80d152@mail.gmail.com>
References: <48C94F86.6080707@gmail.com>
	 <20080912075116.GA26685@diana.vm.bytemark.co.uk>
	 <48CA6367.9020300@gmail.com>
	 <b0943d9e0809121515v53c6d593o8211b3cbbb8dfba4@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "=?ISO-8859-1?Q?Karl_Hasselstr=F6m?=" <kha@treskal.com>,
	git@vger.kernel.org
To: "Clark Williams" <clark.williams@gmail.com>
X-From: git-owner@vger.kernel.org Sat Sep 13 00:19:32 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KeGzD-0005Ex-Re
	for gcvg-git-2@gmane.org; Sat, 13 Sep 2008 00:19:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756213AbYILWSY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Sep 2008 18:18:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753641AbYILWSX
	(ORCPT <rfc822;git-outgoing>); Fri, 12 Sep 2008 18:18:23 -0400
Received: from rv-out-0506.google.com ([209.85.198.231]:57935 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752150AbYILWSX (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Sep 2008 18:18:23 -0400
Received: by rv-out-0506.google.com with SMTP id k40so993330rvb.1
        for <git@vger.kernel.org>; Fri, 12 Sep 2008 15:18:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=9ABcR21RYg/OPDktIV6w2fu59/DWd2tzhvmrZErr6QU=;
        b=tEz8GWsfJylzcViTmfCgfwDmJZ+JNzbC7ysVmlhJIhsoejiL27N4PSz3LDZVNpSSKd
         4vXx+pJSdwWnhBMA7Hi+XDEe6HxWDS+SYjJl855Dok4WVOZr9y1/B5OPHJsaiJtew/sK
         Pf5bGxRuwNAuLH9WXwYFMulv2riDA6QXUeVJY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=fwt8ptZ9hyccLbuBaj9Vl0Jh7olrx6yjP3oOuk85ykGlHNm/I/R5vOCXww0P1lyuCh
         IBCC8fP8P7djd8HNsABvD1HHRrMLRzGSszh7oTAApu7azm2JfyIWF8jwawDzLixtJSx1
         Vg7naqUCw4Y1ZN2xObj+gFNzy99HPcQnOKsgc=
Received: by 10.141.76.21 with SMTP id d21mr2941096rvl.270.1221257902309;
        Fri, 12 Sep 2008 15:18:22 -0700 (PDT)
Received: by 10.140.136.21 with HTTP; Fri, 12 Sep 2008 15:18:22 -0700 (PDT)
In-Reply-To: <b0943d9e0809121515v53c6d593o8211b3cbbb8dfba4@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/95780>

On 12/09/2008, Catalin Marinas <catalin.marinas@gmail.com> wrote:
> On 12/09/2008, Clark Williams <clark.williams@gmail.com> wrote:
>  > Most of the time it's not more than one or two patches difference, so I think that it
>  >  can be handled manually for now. I'll definitely keep an eye on sync and merge though...
>
>
> As Karl said, we have some plans to allow collaboration between
>  multiple StGit repositories but we didn't have much time to look at it
>  recently. Karl's "merge" stuff looks promising though.
>
>  What "sync" does is that it allow the same set of patches between two
>  branches to be synchronised in case modifications happened on one of
>  these branches. In your situation, you would have to fetch the remote
>  branch, uncommit as in Karl's method and either import or sync the
>  remote patches with those on your local branch.

BTW, "sync" allows synchronisation with a series of patches stored in
a directory. So you can also share patches using exported repositories
with import and sync.

-- 
Catalin

From: "David Symonds" <dsymonds@gmail.com>
Subject: Re: A couple branch questions
Date: Wed, 13 Feb 2008 19:03:12 -0800
Message-ID: <ee77f5c20802131903i45b1629fpcb4a5c6e4f483052@mail.gmail.com>
References: <76718490802131739n22c56cadn39c1871ea1762dc3@mail.gmail.com>
	 <ee77f5c20802131745p23aa1db3j47207f1e6538b0e@mail.gmail.com>
	 <18355.42595.377377.433309@lisa.zopyra.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Jay Soffian" <jaysoffian@gmail.com>,
	"Git Mailing List" <git@vger.kernel.org>
To: "Bill Lear" <rael@zopyra.com>
X-From: git-owner@vger.kernel.org Thu Feb 14 04:03:52 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JPUO5-00015p-U0
	for gcvg-git-2@gmane.org; Thu, 14 Feb 2008 04:03:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754096AbYBNDDP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Feb 2008 22:03:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754006AbYBNDDP
	(ORCPT <rfc822;git-outgoing>); Wed, 13 Feb 2008 22:03:15 -0500
Received: from wx-out-0506.google.com ([66.249.82.229]:63800 "EHLO
	wx-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753821AbYBNDDO (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Feb 2008 22:03:14 -0500
Received: by wx-out-0506.google.com with SMTP id h31so202826wxd.4
        for <git@vger.kernel.org>; Wed, 13 Feb 2008 19:03:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=GSBDau9p0Q1tMi1Af6CL52ZfNXTZpX22y+8dvNnGViw=;
        b=ojkuCQMIWLuX3vFlnZ/uwCqLSDuVt7sV72fabMwiNYTsVPRP8TbmeOub2oAkv57lfjEDAD6IifBaUtIDnMOXUekyNnXQW4ho89AxtaRJFZ9kmova9pT7XEDY1RMOk/FaeWTzX6nfkgyXi63Hc4/I0GgPptWwzu+C54RFUxyvKuM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=rCwt/FG+P9t2/KPXXSj/eRGUBM3goRoh3AOxwc3d+rG58TkHQSRoOj8W7zehyUg69TfbkwpUt97pxDzRJCExlDrv7fIx9l9lyR3ZLxfJB/KS1rcN7iHZhBKj2Kq4xZeXMF23uG2B+t0DAPNM99RB1Xh9PWyYgQgwO1kuiqwgVsA=
Received: by 10.141.33.21 with SMTP id l21mr529583rvj.251.1202958192500;
        Wed, 13 Feb 2008 19:03:12 -0800 (PST)
Received: by 10.140.135.17 with HTTP; Wed, 13 Feb 2008 19:03:12 -0800 (PST)
In-Reply-To: <18355.42595.377377.433309@lisa.zopyra.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/73844>

On Feb 13, 2008 6:24 PM, Bill Lear <rael@zopyra.com> wrote:
>
> On Wednesday, February 13, 2008 at 17:45:16 (-0800) David Symonds writes:
> >On Feb 13, 2008 5:39 PM, Jay Soffian <jaysoffian@gmail.com> wrote:
> >> 1) git-branch -d <branchname> complains if <branchname> hasn't been
> >> merged to HEAD. Shouldn't it really only complain if <branchname>
> >> hasn't been merged into any local branch? i.e., as long as
> >> <branchname> has been merged, why care to which branch?
> >
> >It's easy to mistype branch names, and you typically only delete them
> >after you merge them into your current branch. If you're really sure,
> >just pass -D instead of -d.
>
> How does that answer the question posed?

If I have four branches, a, b1, b2 and c, and I've merged b2 into c
(but planning to keep developing on b2), and just merged b1 into a
(which I have checked out), then I probably only want to delete b1,
not b2. The "current" branch is a useful notion because it
significantly simplifies merging/rebasing operations.


Dave.

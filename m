From: "David Symonds" <dsymonds@gmail.com>
Subject: Re: on subtree checkout
Date: Mon, 25 Feb 2008 18:30:36 -0800
Message-ID: <ee77f5c20802251830p47c6de60je97a31cb34bc3105@mail.gmail.com>
References: <fcaeb9bf0802240134i46e276ajfe83071e0b18ce61@mail.gmail.com>
	 <alpine.DEB.1.00.0802260156350.3322@eeepc-johanness>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Nguyen Thai Ngoc Duy" <pclouds@gmail.com>,
	"git mailing list" <git@vger.kernel.org>
To: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue Feb 26 03:31:41 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JTpbX-0005Rt-Vp
	for gcvg-git-2@gmane.org; Tue, 26 Feb 2008 03:31:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756646AbYBZCaj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 Feb 2008 21:30:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755873AbYBZCaj
	(ORCPT <rfc822;git-outgoing>); Mon, 25 Feb 2008 21:30:39 -0500
Received: from wr-out-0506.google.com ([64.233.184.230]:11733 "EHLO
	wr-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755589AbYBZCai (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Feb 2008 21:30:38 -0500
Received: by wr-out-0506.google.com with SMTP id c48so2898630wra.23
        for <git@vger.kernel.org>; Mon, 25 Feb 2008 18:30:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=CX0myM6eFwLxkFm+HHWPJL/r/8CyUf2hxQilZJj9ldw=;
        b=km9r/4jdcc5SI2axAK3jueICxrEaanKuyvQsFYin5OQhU4QIKHvoQYD5ML3bjeQaLN10ku/a1AMa7vGmvpbUcQOjOsZY9GLSvp65NRFKVWVErgwzxgKVtsuAVnSprUQbnFLzYqC7yKy4aSayWl+25bvjOSpmJUiIpxuiHwzem+U=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=AdqS1n44jgkAW3zvE+pw7ecN4VS6wnI1T/m2dKATHuXROQ8KdryrtUWzgIQaivoml9JahdjhJuz85CSF0OuLRxKjL6Hg+jM95Wwt+hMdz+Fgcf2VjZJLwAsVbeae8edqviiwlPWtWCyTx6cxbOTAUkRtxPvTy2ewIC2RFcX+h8A=
Received: by 10.140.180.11 with SMTP id c11mr2769842rvf.248.1203993036766;
        Mon, 25 Feb 2008 18:30:36 -0800 (PST)
Received: by 10.140.252.17 with HTTP; Mon, 25 Feb 2008 18:30:36 -0800 (PST)
In-Reply-To: <alpine.DEB.1.00.0802260156350.3322@eeepc-johanness>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/75103>

On Mon, Feb 25, 2008 at 5:59 PM, Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
> Hi,
>
>
>  On Sun, 24 Feb 2008, Nguyen Thai Ngoc Duy wrote:
>
>  > I'm going to implement subtree checkout. The plan is to save "index
>  > prefix" in GIT_DIR/prefix and update git commands to use index prefix
>  > when accessing the index. If I'm heading a wrong way, stop me now.
>
>  As I wrote a long time ago already, I think the correct approach would be
>  to reuse the code for the core.ignoreStat feature.
>
>  But I agree with others that you should think about sane implementations
>  of rebase/merge with partial checkouts.

I, too, was shortly going to attempt a partial checkout/clone
implementation. The intended context of my implementation was similar
to the KDE scenario in that you might only care about /pkgA and /pkgB,
so changes to /pkgC are usually irrelevant and independent to your
work-flow, so I was planning to assume a simplistic "theirs" merge
strategy for /pkgC, etc.


Dave.

From: Dmitry Potapov <dpotapov@gmail.com>
Subject: Re: GIT BUG? GIT occasionally redownloads its entire data set
Date: Tue, 24 Mar 2009 05:53:26 +0300
Message-ID: <37fcd2780903231953pdfaa679r8a680f64ee692c8d@mail.gmail.com>
References: <28707.1237855543@redhat.com>
	 <7vskl34qc9.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: David Howells <dhowells@redhat.com>, git@vger.kernel.org,
	Daniel Barkalow <barkalow@iabervon.org>,
	"Shawn O. Pearce" <spearce@spearce.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Mar 24 03:55:01 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Llwn6-0004DM-Po
	for gcvg-git-2@gmane.org; Tue, 24 Mar 2009 03:55:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753343AbZCXCx3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 Mar 2009 22:53:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753045AbZCXCx3
	(ORCPT <rfc822;git-outgoing>); Mon, 23 Mar 2009 22:53:29 -0400
Received: from fg-out-1718.google.com ([72.14.220.155]:18838 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752748AbZCXCx2 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Mar 2009 22:53:28 -0400
Received: by fg-out-1718.google.com with SMTP id e12so608490fga.17
        for <git@vger.kernel.org>; Mon, 23 Mar 2009 19:53:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=it7VBP75t3/6sHINVrkazwuRyF/K12zQzA8MVMD+GzM=;
        b=jThXi9be7KLHlc0yMMNGmoRyJCqMDMyysaybXgu8OoEdFy3B9CmSGh3im39Uh4pUCB
         OpVkKGWgoBkKlTfZq08UyzJiUDAfM6QjoDcYY1Hn8/Iouod6O7ffhKjI0xYA9TJKfo1A
         25arvyu9HOLyI54VkVr29+Ejw8xpXwkgqCnLc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=u/aXzlkPWFEPkRb7W62FpDEZWAOJhT+8Z64mHwctEuABZa04A3O7d+Trom0q2PMuIg
         CkBBgI3xjDVAPUL8eBGdJAsILfDGJoHUDS3b5uMwPh0mk6Ma1QQmoSJdlfZ0zflk74vs
         HJNeiiqYXguT4I6vKYcM07+aG+Coc5XzL3hoo=
Received: by 10.86.54.3 with SMTP id c3mr4210862fga.63.1237863206078; Mon, 23 
	Mar 2009 19:53:26 -0700 (PDT)
In-Reply-To: <7vskl34qc9.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/114396>

On Tue, Mar 24, 2009 at 5:17 AM, Junio C Hamano <gitster@pobox.com> wrote:
>
> Rings a bell, anybody?

Maybe this:
http://article.gmane.org/gmane.comp.version-control.git/75201

It was fixed in Git 1.5.5 if I am not mistaken.


Dmitry

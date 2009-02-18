From: Jay Soffian <jaysoffian@gmail.com>
Subject: Re: [PATCH] Avoid segfault with 'git branch' when the HEAD is 
	detached
Date: Wed, 18 Feb 2009 15:36:49 -0500
Message-ID: <76718490902181236r1058ed6dr3ae881dfb820f068@mail.gmail.com>
References: <cover.1234980819u.git.johannes.schindelin@gmx.de>
	 <ad680bce413ddea084d84b3fcd7c4cc356c3cb0e.1234980819u.git.johannes.schindelin@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, gitster@pobox.com
To: Johannes Schindelin <johannes.schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed Feb 18 21:38:30 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LZtBW-00083Z-CY
	for gcvg-git-2@gmane.org; Wed, 18 Feb 2009 21:38:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753402AbZBRUgv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 Feb 2009 15:36:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753396AbZBRUgu
	(ORCPT <rfc822;git-outgoing>); Wed, 18 Feb 2009 15:36:50 -0500
Received: from rv-out-0506.google.com ([209.85.198.239]:29387 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753063AbZBRUgu (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Feb 2009 15:36:50 -0500
Received: by rv-out-0506.google.com with SMTP id g37so70894rvb.1
        for <git@vger.kernel.org>; Wed, 18 Feb 2009 12:36:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=OnSdjKozQuZOnhLDVdj93k9Xn8/cc8kmrIH2QJ4Evw8=;
        b=FMHc+c9Axw8uOSm0jB3tERnSaE7CClz0qzLuYXihTfEILL2ejrYMiayUmLgVza9Sp+
         4r8rvB4mkPPbGsNsXh09JZh6UDdTdbxOSAvzD++T5D29KPjoAtFnZNuoNLXgLN2JnPiO
         4Jsu0gdsrv3sn1fR6Rfow+K7BqFNYywKYwNCY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=K75UGuuRhbT3tRGe+Z0sEfiTA1kKvJhRbfHh/NU4R5P3y3vNYVVKOLahF7GPcw17Sq
         51dZ/efnUQvDajsAtZFC4WugQ3b31qiPF6wddcM8LqcT6EJHIDXT2uEp0U4NIHOzbZIO
         UeDBzxzVtMgR8pWNtMXOoYhNEd1lPRVDDKaD4=
Received: by 10.140.170.12 with SMTP id s12mr507499rve.53.1234989409464; Wed, 
	18 Feb 2009 12:36:49 -0800 (PST)
In-Reply-To: <ad680bce413ddea084d84b3fcd7c4cc356c3cb0e.1234980819u.git.johannes.schindelin@gmx.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/110572>

On Wed, Feb 18, 2009 at 1:14 PM, Johannes Schindelin
<johannes.schindelin@gmx.de> wrote:
> A recent addition to the ref_item struct was not taken care of, leading
> to a segmentation fault when accessing the (uninitialized) "dest" member.
>
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>

ACK.

Thanks,

j.

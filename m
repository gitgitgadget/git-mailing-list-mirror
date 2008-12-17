From: "Emily Ren" <lingyan.ren@gmail.com>
Subject: Re: Can I forbid somebody to pull some branch or tag from my repo with git protocol?
Date: Wed, 17 Dec 2008 17:15:12 +0800
Message-ID: <856bfe0e0812170115p73d72495ve81046127e68c281@mail.gmail.com>
References: <856bfe0e0812170103w1007cf4fs1e83e506c6dd909@mail.gmail.com>
	 <7v1vw7p3r8.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Dec 17 10:16:36 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LCsWC-0003jH-8W
	for gcvg-git-2@gmane.org; Wed, 17 Dec 2008 10:16:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759384AbYLQJPR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 17 Dec 2008 04:15:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758992AbYLQJPQ
	(ORCPT <rfc822;git-outgoing>); Wed, 17 Dec 2008 04:15:16 -0500
Received: from ag-out-0708.google.com ([72.14.246.251]:50254 "EHLO
	ag-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758438AbYLQJPO (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Dec 2008 04:15:14 -0500
Received: by ag-out-0708.google.com with SMTP id 31so3125099agc.10
        for <git@vger.kernel.org>; Wed, 17 Dec 2008 01:15:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=FLlgf3sUwsYn1M++grsOg83rT2pEEI7pndJdYB6VDy8=;
        b=TntuS5xDfBV7PTK8Cqc6sXdZTfC87C2AuZjVMWKfYoCNp4erzj3kEC1RzPXdtjJIjn
         hgKbNn9Ji8c6i956k1zZROTxL9V/kYwnIlcdkzNemhFe4gPX65p+z/4z7Uc6e7M8pQnP
         /6JBDTO/Y7lcWhFI3K2VFMdY5QuxrCH2BmS2I=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=poGuvQoKfHsMA1D5Xik4+qp+9vJ9VtCOGtIdjhK2tjj7gycrQ4RGZxy156D9FO/rTk
         fPJaiURyTMilh7HS9M1tM9Sp/POYMfDhna13JMkYXRfnw8Av47cRkajNVHbGljQF1t9Y
         Pj3Zm9L9rGhGsXKqzK8EcCxPPcGgRJDnNI71w=
Received: by 10.150.205.21 with SMTP id c21mr988756ybg.169.1229505312794;
        Wed, 17 Dec 2008 01:15:12 -0800 (PST)
Received: by 10.151.11.2 with HTTP; Wed, 17 Dec 2008 01:15:12 -0800 (PST)
In-Reply-To: <7v1vw7p3r8.fsf@gitster.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/103326>

I want some group can pull these branches or tags from my repo, while
other's can't, Need I maintain two repositories ?

On Wed, Dec 17, 2008 at 5:09 PM, Junio C Hamano <gitster@pobox.com> wrote:
> "Emily Ren" <lingyan.ren@gmail.com> writes:
>
>> I created a repository, and I don't want somebody to pull some branch
>> or tag from my repository with git protocol. How can I do ?
>
> By not putting that tag or branch in that repository (note that you can
> have a repository only to publish which is different from your main
> working repository).
> .
>

From: "Catalin Marinas" <catalin.marinas@gmail.com>
Subject: Re: [StGit] Debian packaging update
Date: Thu, 21 Aug 2008 23:35:43 +0100
Message-ID: <b0943d9e0808211535s7b829a13hbf28be8116e856a6@mail.gmail.com>
References: <20080818201036.7c2c00f8@whitehouse.id.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org,
	"=?ISO-8859-1?Q?Karl_Hasselstr=F6m?=" <kha@treskal.com>
To: "Daniel White" <daniel@whitehouse.id.au>
X-From: git-owner@vger.kernel.org Fri Aug 22 00:37:10 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KWIls-0003Ta-RG
	for gcvg-git-2@gmane.org; Fri, 22 Aug 2008 00:36:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756481AbYHUWfp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 21 Aug 2008 18:35:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756995AbYHUWfp
	(ORCPT <rfc822;git-outgoing>); Thu, 21 Aug 2008 18:35:45 -0400
Received: from rv-out-0506.google.com ([209.85.198.226]:35840 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756348AbYHUWfo (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Aug 2008 18:35:44 -0400
Received: by rv-out-0506.google.com with SMTP id k40so162522rvb.1
        for <git@vger.kernel.org>; Thu, 21 Aug 2008 15:35:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=xzCkJk3EGQQdUKmVwCLhvPq+azYHmiwA+F86GeHi7uE=;
        b=LAVES0y9UC+mIXq+9EiDPC93IVLlvL0O+aU1u57/PhNFa8/5ThDdhZV+XhegkzPGfT
         E0LCB71Hwpdz5kktn7vjT16QpSlyIA3WQjLyh+ruATy+J8pDV/EyMgg0cqPMQ6/Bt4ps
         msux741aNSmdqp31ZtqWGRPbT7X5r027r0GQo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=FW5kAlNcGBJCoNgct+i5DbMG8+INFiO6PlmuoSIKc6z3H8hMd6FzfEy8CjkhU09Hjf
         ohBI74YBtU9Jh0tgXU5T6NzpGHqaD9X1Kxlsx/Wmg8GvJ87Wd7z/bq+rd66ZEeDfQUxj
         uqCaTh+cGtcnlfO/jYtxUT83MSgW8vZW/nN0c=
Received: by 10.114.200.2 with SMTP id x2mr430719waf.79.1219358143768;
        Thu, 21 Aug 2008 15:35:43 -0700 (PDT)
Received: by 10.114.193.12 with HTTP; Thu, 21 Aug 2008 15:35:43 -0700 (PDT)
In-Reply-To: <20080818201036.7c2c00f8@whitehouse.id.au>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/93220>

2008/8/18 Daniel White <daniel@whitehouse.id.au>:
> I've just pushed some patches up to put the debian packaging in line
> with the other changes to the build system.
>
> Most importantly, the documentation now gets included in the package.

The patches look allright. I'll merge them tomorrow if no other objections.

I'm not that versed in building debian packages but the .changes file
generated is still reported as "i386" rather than "all". Is this
expected?

Thanks.

-- 
Catalin

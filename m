From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: Pull is Evil
Date: Thu, 01 May 2014 19:31:41 -0500
Message-ID: <5362e76d5169_429131b31093@nysa.notmuch>
References: <4ay6w9i74cygt6ii1b0db7wg.1398433713382@email.android.com>
 <xmqqoazlqot4.fsf@gitster.dls.corp.google.com>
 <536106EA.5090204@xiplink.com>
 <xmqqppjyhnom.fsf@gitster.dls.corp.google.com>
 <536152D3.5050107@xiplink.com>
 <E699B6CE8ADD46618D52F05DB8EF6F07@PhilipOakley>
 <5362d9eeb8b30_12fe14dd310e6@nysa.notmuch>
 <20140501235933.GA28634@odin.tremily.us>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: Philip Oakley <philipoakley@iee.org>, git@vger.kernel.org,
	Marat Radchenko <marat@slonopotamus.org>,
	Junio C Hamano <gitster@pobox.com>,
	Marc Branchaud <marcnarc@xiplink.com>
To: "W. Trevor King" <wking@tremily.us>,
	Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Fri May 02 02:42:29 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wg1Ya-0003cP-Bg
	for gcvg-git-2@plane.gmane.org; Fri, 02 May 2014 02:42:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751277AbaEBAmV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 1 May 2014 20:42:21 -0400
Received: from mail-ob0-f169.google.com ([209.85.214.169]:64868 "EHLO
	mail-ob0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750802AbaEBAmU (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 May 2014 20:42:20 -0400
Received: by mail-ob0-f169.google.com with SMTP id uz6so4445475obc.14
        for <git@vger.kernel.org>; Thu, 01 May 2014 17:42:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-type:content-transfer-encoding;
        bh=+9aNrJDHvsZ36cZkJAKWuK6+cOf1lfhC5FmB6rLlObc=;
        b=KwFnKpLsqC14nE/RXNiu/Km+jQZJeAuKZGgR3kSpgagzwrtkVyCl52ipyUjv2UJlv+
         D3/d0maappSAGkTi4zTBleBcccHfhQzfvT6ihVtDWiZyu9l7pEKPtPimuGXMKgXxcVB3
         WFKF/BfMRThfyVwnQJBNdph+yD2tmhwVFNDhONWu6pdxE+IhmTIPGF0hzZqRWkdDzCb+
         ygzYXS3gJ5k1kk/CRy8edtpLrzxNWD9V6y6x+yoO2NyLuC46a3n1RW/+fQxWsSelUAuP
         M/38b2G4WiXctiVuKVt9kO5XVN/1AyOH6rchOXDs8wbMjVUrkj4yoIeuwmbZljw31Yik
         B9Cw==
X-Received: by 10.182.248.131 with SMTP id ym3mr4806362obc.58.1398991340417;
        Thu, 01 May 2014 17:42:20 -0700 (PDT)
Received: from localhost (189-211-224-40.static.axtel.net. [189.211.224.40])
        by mx.google.com with ESMTPSA id c7sm123249221oek.12.2014.05.01.17.42.17
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 01 May 2014 17:42:19 -0700 (PDT)
In-Reply-To: <20140501235933.GA28634@odin.tremily.us>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/247911>

W. Trevor King wrote:
> On Thu, May 01, 2014 at 06:34:06PM -0500, Felipe Contreras wrote:
> > Nobody ever complained about somebody doing a fast-forward by mistake.
> 
> Unless they fast-forward merged a feature branch into master, but the
> project prefers explicitly-merged feature branches with a cover-letter
> explaination in the merge commit [1].  On the one hand, folks
> integrating feature branches are likely more experienced Git users.

Exactly. That's barely an issue.

> I agree that accidental ff-merges are likely to be less troublesome
> than accidental non-ff merge/rebases, but I don't think changing the
> default to ff-only is a perfect fix.

I don't see what else we could do.

-- 
Felipe Contreras

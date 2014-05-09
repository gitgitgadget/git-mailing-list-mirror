From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: What's cooking in git.git (Apr 2014, #09; Tue, 29)
Date: Thu, 08 May 2014 19:58:17 -0500
Message-ID: <536c28297875b_741a161d3109@nysa.notmuch>
References: <xmqq7g67iwxc.fsf@gitster.dls.corp.google.com>
 <20140505184546.GB23935@serenity.lan>
 <xmqqoazb944d.fsf@gitster.dls.corp.google.com>
 <536B3259.1050602@gmail.com>
 <536b38b55b7fc_4fa68b32eca@nysa.notmuch>
 <alpine.DEB.2.02.1405081739310.17457@nftneq.ynat.uz>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: Chris Packham <judge.packham@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	John Keeping <john@keeping.me.uk>, git@vger.kernel.org
To: David Lang <david@lang.hm>,
	Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Fri May 09 03:09:14 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WiZJK-0007G4-97
	for gcvg-git-2@plane.gmane.org; Fri, 09 May 2014 03:09:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754555AbaEIBJJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 May 2014 21:09:09 -0400
Received: from mail-yk0-f173.google.com ([209.85.160.173]:35776 "EHLO
	mail-yk0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753520AbaEIBJI (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 May 2014 21:09:08 -0400
Received: by mail-yk0-f173.google.com with SMTP id 142so2899110ykq.18
        for <git@vger.kernel.org>; Thu, 08 May 2014 18:09:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-type:content-transfer-encoding;
        bh=ct+E9s92IrgL2JAny2os5hoZxh5rF6erhHFgb03f8s0=;
        b=tTDu5q9WD37agc2MqQ0bW31FsXxIsXOznS1NgipS7QXnwOTV2kpCbRkn9iEUzmN64P
         BXoofUXty5RMSaoiqe27sGBytXjHjzgLJ6XxrDYb3vmfnj+0dLq7J7PnzHMGiFwx0FFb
         y0e/vHvU/l0TKJNcHbEy9bu87d/gsgbaiZ+vOi18TvvoH5NJarjqey7myfUd6yIQKtYw
         oikb5Kf7SeV0R5fRHOimNqHKNT0kPWCTBEDCXXDnFB2p6HPlnjQ5KkMRfpxINfLKEF+G
         g0qVZtxWYzQLTIobVmdyx/73A5YvIY/UNgMbxA+03U001jRyTvTt1kSLJfWKOXADWTTH
         KQEA==
X-Received: by 10.236.36.45 with SMTP id v33mr3668197yha.129.1399597747617;
        Thu, 08 May 2014 18:09:07 -0700 (PDT)
Received: from localhost (189-211-224-40.static.axtel.net. [189.211.224.40])
        by mx.google.com with ESMTPSA id s26sm3928091yhg.4.2014.05.08.18.09.03
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 08 May 2014 18:09:06 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.02.1405081739310.17457@nftneq.ynat.uz>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/248468>

David Lang wrote:
> On Thu, 8 May 2014, Felipe Contreras wrote:
> > If submodules were an integral part of Git that would be a possibility,
> > but they are more like a hack.
> 
> Well, if git.git can't use them, then how can anyone else be expected to.

That is a very good question.

> I haven't been paying close attention for a while, what would have to be done to 
> make submodules "an integral part of Git"?

This comes to mind:

http://article.gmane.org/gmane.comp.version-control.git/220047

-- 
Felipe Contreras

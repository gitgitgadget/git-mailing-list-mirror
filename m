From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: Pull is Evil
Date: Fri, 02 May 2014 03:14:23 -0500
Message-ID: <536353dfa270b_609874930cae@nysa.notmuch>
References: <536152D3.5050107@xiplink.com>
 <5361598f8eaf7_4781124b2f02b@nysa.notmuch>
 <536173F5.7010905@xiplink.com>
 <53617877b41a9_41a872f308ef@nysa.notmuch>
 <20140501094610.GB75770@vauxhall.crustytoothpaste.net>
 <5362664C.8040907@xiplink.com>
 <20140501175623.GY6227@odin.tremily.us>
 <53628CB1.8010302@xiplink.com>
 <20140501183008.GZ6227@odin.tremily.us>
 <5362ACD6.50505@xiplink.com>
 <20140502071655.GA6288@inner.h.apk.li>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: "W. Trevor King" <wking@tremily.us>,
	Felipe Contreras <felipe.contreras@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Marat Radchenko <marat@slonopotamus.org>, git@vger.kernel.org
To: Andreas Krey <a.krey@gmx.de>, Marc Branchaud <marcnarc@xiplink.com>
X-From: git-owner@vger.kernel.org Fri May 02 10:25:12 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wg8mN-0003Ny-NK
	for gcvg-git-2@plane.gmane.org; Fri, 02 May 2014 10:25:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751387AbaEBIZI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 2 May 2014 04:25:08 -0400
Received: from mail-oa0-f53.google.com ([209.85.219.53]:58166 "EHLO
	mail-oa0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750813AbaEBIZF (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 May 2014 04:25:05 -0400
Received: by mail-oa0-f53.google.com with SMTP id m1so2301990oag.12
        for <git@vger.kernel.org>; Fri, 02 May 2014 01:25:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-type:content-transfer-encoding;
        bh=oGY9WiRB6QOuSv7cKiz5cpfZOEs4SgkeIfksxYs0EYI=;
        b=wdewrfqNBx4qZqKEgnl+Jv2xhAr3rvsUVZQKohIJGqPvEK0k8T+aaZIcMct6j0g+kR
         KvlawspHaGfnP9WJn8uFPvPpgYMvBJLM3J7WcYtD8tc3367U7sy2N/FIUbVatLMZF3Xz
         MgmpDhTmRl0CFWP+8i5+vt2EdMnAjCZJxZ44rfqPeq9OAdfP00bqE6Ixa5kyaMbkG0dr
         lZwhWA1lKAi+3A3ftV34ReBkRTax1ctf0o0ubO9z52DbK0i67ZHBuy1mboS3nm8L/TF9
         y/JcANMIkj02OV5rn6wiCaRRdfW5CaKWFUZROKAQlQku1V8XimJuo0jUTwUKP91hLs1l
         TQrw==
X-Received: by 10.60.131.172 with SMTP id on12mr15783376oeb.18.1399019104783;
        Fri, 02 May 2014 01:25:04 -0700 (PDT)
Received: from localhost (189-211-224-40.static.axtel.net. [189.211.224.40])
        by mx.google.com with ESMTPSA id ut8sm65331814obc.22.2014.05.02.01.25.00
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 02 May 2014 01:25:02 -0700 (PDT)
In-Reply-To: <20140502071655.GA6288@inner.h.apk.li>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/247930>

Andreas Krey wrote:
> My personal beef with 'git pull' is still that sometimes (namely in
> the 'git pull && git push' sequence) it should reverse the order of
> the parents in the merge commit, so that *my* commits look like an
> integrated topic branch, instead of the former mainline.

I haven't really thought much about this but it does make sense. How
about changing the behavior so `git pull` by default changes the order
of the parents, but `git pull repo branch` doesn't.

-- 
Felipe Contreras

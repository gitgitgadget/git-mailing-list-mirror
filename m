From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: Pull is Evil
Date: Thu, 01 May 2014 18:34:06 -0500
Message-ID: <5362d9eeb8b30_12fe14dd310e6@nysa.notmuch>
References: <4ay6w9i74cygt6ii1b0db7wg.1398433713382@email.android.com>
 <xmqqoazlqot4.fsf@gitster.dls.corp.google.com>
 <536106EA.5090204@xiplink.com>
 <xmqqppjyhnom.fsf@gitster.dls.corp.google.com>
 <536152D3.5050107@xiplink.com>
 <E699B6CE8ADD46618D52F05DB8EF6F07@PhilipOakley>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: Marat Radchenko <marat@slonopotamus.org>,
	Felipe Contreras <felipe.contreras@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Marc Branchaud <marcnarc@xiplink.com>
To: Philip Oakley <philipoakley@iee.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 02 01:44:51 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wg0ep-0004Mm-3s
	for gcvg-git-2@plane.gmane.org; Fri, 02 May 2014 01:44:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751187AbaEAXor (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 1 May 2014 19:44:47 -0400
Received: from mail-oa0-f53.google.com ([209.85.219.53]:61463 "EHLO
	mail-oa0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750782AbaEAXoq (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 May 2014 19:44:46 -0400
Received: by mail-oa0-f53.google.com with SMTP id m1so1774584oag.26
        for <git@vger.kernel.org>; Thu, 01 May 2014 16:44:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-type:content-transfer-encoding;
        bh=M11m+A6b+qkj4+305CUsFHnqJdte/GOHNkwH/lGFbQc=;
        b=I7GX8XxHc0QVyTdVqUoMobuHz/2Vky3ESfcxVw/3m2Sye159EPxFXgY0QNdsP7FA0i
         GykDdS16rAuoUC9ZqGSK/wLW0rjsresKZaXHp57HwuqzCec9fka4iayuj89D7SuTNUOz
         Z+oNmwZuBspjLYn64920g8ZUJGpu3h2fVvSZbu9EZZyIUqf9qj/8uGbjoUwTd01GzrMv
         kiqRdj8BijBkuFBW1XHZXmj/lr3q2D84vCjZmRB8RGjt0171MD04I3NMksmvOoz8gukN
         nbZb1o5TeMowjRHNI4L3Grp+8pMHA6mW1hQicjKdI/v/jWjWUgA6i8r9xHE0XO/vEHpL
         f77Q==
X-Received: by 10.60.15.38 with SMTP id u6mr13711156oec.26.1398987886326;
        Thu, 01 May 2014 16:44:46 -0700 (PDT)
Received: from localhost (189-211-224-40.static.axtel.net. [189.211.224.40])
        by mx.google.com with ESMTPSA id dh8sm122676453oeb.10.2014.05.01.16.44.43
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 01 May 2014 16:44:45 -0700 (PDT)
In-Reply-To: <E699B6CE8ADD46618D52F05DB8EF6F07@PhilipOakley>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/247896>

Philip Oakley wrote:
> The point that there is no easy solution to an updated default pull 
> action that is right for everybody, straight out of the box, I think is 
> now fairly obvious, a summarised by Marc. I certainly avoid pull.

Yes, I avoid it too, and quite a lot of people.

> My 'solution', if it could be called that, would be that at the point of 
> switch over, after a period of release note warning and then code 
> warning, that the plain 'git pull' would not even do the no-ff, but 
> would simply refuse to do anything...

I still haven't heard a single argument why a fast-forward by default
wouldn't be desirable.

Remember that we are talking about inexperienced users here. Experienced
users can simply do `git pull --no-ff` or do the right configuration.

The problem we want to track is newcomers doing merges (real ones) by
mistake.

Nobody ever complained about somebody doing a fast-forward by mistake.

I think a non-fast-forward warning by default, and eventually rejecting
them is the most sensible approach.

-- 
Felipe Contreras

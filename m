From: Tay Ray Chuan <rctay89@gmail.com>
Subject: Re: [PATCH --no-flowed] http-push: refactor request url creation
Date: Sat, 31 Jan 2009 07:51:21 +0800
Message-ID: <be6fef0d0901301551t7b33f6c1s8a63f3c157b692eb@mail.gmail.com>
References: <49831755.60405@gmail.com>
	 <alpine.DEB.1.00.0901301816410.3586@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sat Jan 31 00:52:52 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LT3AG-0001iF-VO
	for gcvg-git-2@gmane.org; Sat, 31 Jan 2009 00:52:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753173AbZA3XvX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 30 Jan 2009 18:51:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752890AbZA3XvX
	(ORCPT <rfc822;git-outgoing>); Fri, 30 Jan 2009 18:51:23 -0500
Received: from wa-out-1112.google.com ([209.85.146.182]:11009 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752811AbZA3XvW (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 Jan 2009 18:51:22 -0500
Received: by wa-out-1112.google.com with SMTP id v33so329807wah.21
        for <git@vger.kernel.org>; Fri, 30 Jan 2009 15:51:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=i39xiTZEEqDX2jeebrEKkgjonS7Q/9dRvh3dEu8FuIc=;
        b=Vao8lIiFiVZaifw1pEqhTRM0KHQfFvhCambc4zro8UBogeYvs5Wx29BOS+c4hQskze
         r6ogvYWYYRJBJkAW19WEyJmH5vzO6AZaVUX7b0R9GOK52/UAlL9H8tmd+SYoShyjzO3u
         YN0wK4aLMGQ4UCft0yQbE/KbBAml8yVofbUOA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=CpqFadGwCZw7mt+6sKPr70YHGZQznUo1sWxjXcxklVdI5aALAnRcCOjGnYm4LMr3Tk
         Y+Wy4wyo+2nU3cHTTW33tvy3G9kOeW/HgLFeIq6+fPSxVkZF5fkpCuPXGfI94+PijOlg
         5LMhdpUiPI7cVh9ioXtDjhBkobqIwhUTpkPhc=
Received: by 10.115.106.18 with SMTP id i18mr1119911wam.213.1233359481884; 
	Fri, 30 Jan 2009 15:51:21 -0800 (PST)
In-Reply-To: <alpine.DEB.1.00.0901301816410.3586@pacific.mpi-cbg.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/107887>

Hi,

On Sat, Jan 31, 2009 at 1:17 AM, Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
>> +static void append_remote_object_url(struct strbuf *buf, const char *url, const char *hex, int only_two_digit_prefix)
>
> I seem to remember that I mentioned that this line is too long.

I thought if i fixed my line wrapping then it wouldn't be a problem anymore.

I've edited the patch anyway.

-- 
Cheers,
Ray Chuan

From: Stefano Lattarini <stefano.lattarini@gmail.com>
Subject: Re: [PATCH] zlib: fix compilation failures with Sun C Compilaer
Date: Tue, 23 Apr 2013 00:06:07 +0200
Message-ID: <5175B44F.4000303@gmail.com>
References: <97eabaedd6cd7d876812474a35fa2d3d63dfec4a.1366647415.git.stefano.lattarini@gmail.com> <CAPig+cQQiwumaswnKf1A-e5Rk4BHpRQqhqbL0p8zkmDnZ=Cbtg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Tue Apr 23 00:06:17 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UUOsK-0006zo-0e
	for gcvg-git-2@plane.gmane.org; Tue, 23 Apr 2013 00:06:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753986Ab3DVWGL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Apr 2013 18:06:11 -0400
Received: from mail-we0-f171.google.com ([74.125.82.171]:33807 "EHLO
	mail-we0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753839Ab3DVWGL (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Apr 2013 18:06:11 -0400
Received: by mail-we0-f171.google.com with SMTP id i48so6767367wef.2
        for <git@vger.kernel.org>; Mon, 22 Apr 2013 15:06:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:message-id:date:from:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=zOQ2+ZQLFYO6Da3CHSgGSwje1fPFBF6aXouycbs4E+o=;
        b=UF7uIFhEfSqRjZtVUvbiRQI906De4BbYDYsICjv95p5vx1i3Rc2Bg/uMK+XCzFgZux
         v5F+Ss/DPLlZlpPIE65bjr+xD2DClLKkeuNgXs8DTNVMsgPa6HG8vI2mSvlWq0tz5A3q
         JQQsIaMf721ybRcacSRrmmKa3BOHZW89NdUNCBq805SaLxYptWGfaeonK0z0ztNeSwHj
         ghcvIazOiisQpqXGYGV+AUST6JpXuYCdESTsZm+K8LKMqut5qaCPyKUtTQGYVtzJxcBW
         XLZktx69MX1oJ+YPqnS2YuuWezxRU+QWaz1u2e3SjpYdvNGtrIHzJ38l7LSX+hJPHK5P
         nFTg==
X-Received: by 10.180.189.205 with SMTP id gk13mr70280213wic.25.1366668369800;
        Mon, 22 Apr 2013 15:06:09 -0700 (PDT)
Received: from [192.168.178.20] (host93-95-dynamic.6-79-r.retail.telecomitalia.it. [79.6.95.93])
        by mx.google.com with ESMTPS id s2sm24948466wib.4.2013.04.22.15.06.07
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Mon, 22 Apr 2013 15:06:08 -0700 (PDT)
In-Reply-To: <CAPig+cQQiwumaswnKf1A-e5Rk4BHpRQqhqbL0p8zkmDnZ=Cbtg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222115>

On 04/22/2013 11:41 PM, Eric Sunshine wrote:
> On Mon, Apr 22, 2013 at 12:18 PM, Stefano Lattarini
> <stefano.lattarini@gmail.com> wrote:
>> zlib: fix compilation failures with Sun C Compilaer
> 
> s/Compilaer/compiler/
> 
Oops, well spotted.  Junio, can you fix this locally?

Thanks, and sorry for the stupid typo,
  Stefano

From: "Francis Moreau" <francis.moro@gmail.com>
Subject: Re: [PATCH 0/17] Sliding window mmap for packfiles.
Date: Sun, 24 Dec 2006 09:56:59 +0100
Message-ID: <38b2ab8a0612240056k152344ael891e9b0b9f8cbc47@mail.gmail.com>
References: <20061223073317.GA9837@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Junio C Hamano" <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Dec 24 09:57:15 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by dough.gmane.org with esmtp (Exim 4.50)
	id 1GyPAQ-00072y-Mv
	for gcvg-git@gmane.org; Sun, 24 Dec 2006 09:57:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754187AbWLXI5A (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 24 Dec 2006 03:57:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754209AbWLXI5A
	(ORCPT <rfc822;git-outgoing>); Sun, 24 Dec 2006 03:57:00 -0500
Received: from wx-out-0506.google.com ([66.249.82.231]:27183 "EHLO
	wx-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754187AbWLXI5A (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 Dec 2006 03:57:00 -0500
Received: by wx-out-0506.google.com with SMTP id h27so3245191wxd
        for <git@vger.kernel.org>; Sun, 24 Dec 2006 00:56:59 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=ZuSYJGFfNn4FLFetbJ1/kp5hfvcbWH8FIQ+tj+sMT3FPFE8soTu+K8So0g6aGtd536bpJdWwymQRGisaeKH/I/mSVoeOS/meYxxN3ypuqzL8drdTgoxHMSHNiNIW9pLnbiihxJEgPP+vjgtvWjuRi94IUE+e3UqUX0CZLizPw2w=
Received: by 10.90.105.20 with SMTP id d20mr10027049agc.1166950619395;
        Sun, 24 Dec 2006 00:56:59 -0800 (PST)
Received: by 10.90.106.16 with HTTP; Sun, 24 Dec 2006 00:56:59 -0800 (PST)
To: "Shawn O. Pearce" <spearce@spearce.org>
In-Reply-To: <20061223073317.GA9837@spearce.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/35348>

Hi,

On 12/23/06, Shawn O. Pearce <spearce@spearce.org> wrote:
> This 17 patch series implements my much discussed, but never produced
[snip]
>
> This series also permits accessing packfiles up to 4 GiB in size,
> even on systems which permit only 2 GiB of virtual memory within
> a single process (e.g. Windows and some older UNIXes).  Of course

Just out of curiosity, do you mean that there are some OS running on
32 bits machines which allow 4GiB size of virtual memory within a
single process ? If so, could you give an example of such OS ?

thanks
-- 
Francis

From: "Jon Smirl" <jonsmirl@gmail.com>
Subject: Re: Stgit and refresh-temp
Date: Tue, 4 Nov 2008 09:50:33 -0500
Message-ID: <9e4733910811040650k2b63856fpf20f4b654780c658@mail.gmail.com>
References: <9e4733910811040537p4e88c09an94370154eca12778@mail.gmail.com>
	 <9e4733910811040538v604d33e3jf0b312d809630af2@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: "=?ISO-8859-1?Q?Karl_Hasselstr=F6m?=" <kha@treskal.com>,
	"Catalin Marinas" <catalin.marinas@gmail.com>,
	"Git Mailing List" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Nov 04 15:51:54 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KxNG3-0000I6-Ri
	for gcvg-git-2@gmane.org; Tue, 04 Nov 2008 15:51:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752658AbYKDOuf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 4 Nov 2008 09:50:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751677AbYKDOuf
	(ORCPT <rfc822;git-outgoing>); Tue, 4 Nov 2008 09:50:35 -0500
Received: from rv-out-0506.google.com ([209.85.198.239]:63244 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754681AbYKDOud (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Nov 2008 09:50:33 -0500
Received: by rv-out-0506.google.com with SMTP id k40so3317328rvb.1
        for <git@vger.kernel.org>; Tue, 04 Nov 2008 06:50:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=5FIXuKjbh0iLxl+/2Y0gN/2RWf7RqIppKMlrQsLRxMg=;
        b=FWr4wRXzYzNO2NuDwhijycPA9LDzq/KV/0aS5HRb3bj993LwMJ0n4qCOp3TKz34YXH
         VFr3xt5gytx+rIKK8t3Y0c40v1kPCd2x6l8k2C+7p9orBK+/VJjndkkU4lfR2TgnvQkX
         51kOyHCOnv1QCB1QAkE5UoCdyR3ZjvsJqwa3M=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=FejA7mtdZMznK6CZk+wdY3U2ql7AxH72+y3jgjA+nmv0lDNZdT2uHck5Wk2Gc4NlEn
         m2Q32H7YBQ7M0UOJ33RTXjIJh2f2YrlUhQ8j/LewZUVEgJ6KJJTemeSRCj5yaWyCxJfa
         w5DYA968LW4KGTLwMNMHxxUGw6fLbfozU9wGI=
Received: by 10.141.69.1 with SMTP id w1mr906432rvk.147.1225810233090;
        Tue, 04 Nov 2008 06:50:33 -0800 (PST)
Received: by 10.140.208.10 with HTTP; Tue, 4 Nov 2008 06:50:33 -0800 (PST)
In-Reply-To: <9e4733910811040538v604d33e3jf0b312d809630af2@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/100080>

I think I fixed my tree up. After a stg repair I was able to delete
'refresh-temp' which was empty, then apply the changes to jds-lirc.

It may have been possible to make the merge smarter. The conflicts
were with things in the popped-off patches. Your typical end of file
append merge conflicts.

On Tue, Nov 4, 2008 at 8:38 AM, Jon Smirl <jonsmirl@gmail.com> wrote:
> jonsmirl@terra:~/fs$ stg version
> Stacked GIT 0.14.3.270.g0f36
> git version 1.6.0.3.523.g304d0
> Python version 2.5.2 (r252:60911, Oct  5 2008, 19:29:17)
> [GCC 4.3.2]
> jonsmirl@terra:~/fs$
>
> --
> Jon Smirl
> jonsmirl@gmail.com
>



-- 
Jon Smirl
jonsmirl@gmail.com

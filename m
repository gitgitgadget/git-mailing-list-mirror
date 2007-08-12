From: "Dmitry Kakurin" <dmitry.kakurin@gmail.com>
Subject: Re: msysgit: should core.autocrlf=true be the default on Windows?
Date: Sun, 12 Aug 2007 03:36:20 -0700
Message-ID: <a1bbc6950708120336p61c7f10fw8d2d43ee7f5a924c@mail.gmail.com>
References: <7816DAAF-53CB-468C-9597-36AA94AC6476@zib.de>
	 <84CFEBB5D7FE48FF86FEF3289C8DDAA8@ntdev.corp.microsoft.com>
	 <F5024D9F-B008-4C14-B36B-A2E8BEFD0FE4@zib.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Steffen Prohaska" <prohaska@zib.de>
X-From: git-owner@vger.kernel.org Sun Aug 12 12:36:48 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IKAoM-0007Cg-Sj
	for gcvg-git@gmane.org; Sun, 12 Aug 2007 12:36:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761999AbXHLKgY (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 12 Aug 2007 06:36:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S934450AbXHLKgX
	(ORCPT <rfc822;git-outgoing>); Sun, 12 Aug 2007 06:36:23 -0400
Received: from rv-out-0910.google.com ([209.85.198.187]:35273 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934476AbXHLKgV (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 12 Aug 2007 06:36:21 -0400
Received: by rv-out-0910.google.com with SMTP id k20so969204rvb
        for <git@vger.kernel.org>; Sun, 12 Aug 2007 03:36:21 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=CpMjWeG8fXJ5U8H4HsOkyScl87PEMrfrbBzMC3sH11scIKX1hhZtnw97JDTSFwvTX7bQwGvf3DgtiKVmVyBvNqM2kj8jVH3uXj+zQIhRgPJ5203bpIgErJYBVUum/ssIMP2nOqkHTZbeMEecrQgbIyVuW1OuEVNQimkDxnSAmvE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Lx7SJ/CeBH2mn7Lppt+EaEe7FsbJBuwDjdNIz+z0RYCbltL9YcdHGZ1MopTY0w3NpQogvqqzl/YtZEb4n5YoBgbToe+NdyDYBR9LWDZX0By6RJqnrM1UrSQ/XDKjQmbmiEbEw7afMt7rATosC+zPu0ZiBD86NSutLNsBH69iQwM=
Received: by 10.141.164.10 with SMTP id r10mr2104415rvo.1186914980948;
        Sun, 12 Aug 2007 03:36:20 -0700 (PDT)
Received: by 10.141.21.17 with HTTP; Sun, 12 Aug 2007 03:36:20 -0700 (PDT)
In-Reply-To: <F5024D9F-B008-4C14-B36B-A2E8BEFD0FE4@zib.de>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/55672>

I'll be short.

On 8/12/07, Steffen Prohaska <prohaska@zib.de> wrote:
> > Please keep in mind that msysgit is targeting developers who want
> > to contribute to MinGW port of git.
> Why that?. In my opinion msysgit is already the best git you can
> get on Windows.

End-user version could be made MUCH smaller.

> > On the other hand, setup for end-users should have it as default, I
> > agree.
>
> But our end-users are developers! We should leverage on that and make
> msysgit the 'end-user' installation. Developers tend to be interested
> in fixing problems with their working environment. We should provide
> them a _very_ easy way of submitting their fixes and improvements
> back to msysgit, e.g. via mob branch. This could speed up the Windows
> porting effort tremendously.

I agree. That's why msysgit was created.
On the other hand, for many user Git is just a tool that they use to
accomplish something important for them (completely unrelated to git).
That's why end-user installer exists as well.

-- 
- Dmitry

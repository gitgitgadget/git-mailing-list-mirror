From: "Nguyen Thai Ngoc Duy" <pclouds@gmail.com>
Subject: Re: Something is broken in repack
Date: Thu, 13 Dec 2007 20:32:02 +0700
Message-ID: <fcaeb9bf0712130532s79aa7afeve6f018f9430ab3b3@mail.gmail.com>
References: <9e4733910712071505y6834f040k37261d65a2d445c4@mail.gmail.com>
	 <9e4733910712102125w56c70c0cxb8b00a060b62077@mail.gmail.com>
	 <9e4733910712102129v140c2affqf2e73e75855b61ea@mail.gmail.com>
	 <9e4733910712102301p5e6c4165v6afb32d157478828@mail.gmail.com>
	 <alpine.LFD.0.99999.0712110832251.555@xanadu.home>
	 <alpine.LFD.0.99999.0712110951070.555@xanadu.home>
	 <alpine.LFD.0.99999.0712111117440.555@xanadu.home>
	 <9e4733910712110821o7748802ag75d9df4be8b2c123@mail.gmail.com>
	 <alpine.LFD.0.99999.0712112057390.555@xanadu.home>
	 <alpine.LFD.0.99999.0712120743040.555@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: "Jon Smirl" <jonsmirl@gmail.com>,
	"Junio C Hamano" <gitster@pobox.com>, gcc@gcc.gnu.org,
	"Git Mailing List" <git@vger.kernel.org>
To: "Nicolas Pitre" <nico@cam.org>
X-From: git-owner@vger.kernel.org Thu Dec 13 14:32:34 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J2oAz-0003Uh-TF
	for gcvg-git-2@gmane.org; Thu, 13 Dec 2007 14:32:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752044AbXLMNcJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 13 Dec 2007 08:32:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751503AbXLMNcH
	(ORCPT <rfc822;git-outgoing>); Thu, 13 Dec 2007 08:32:07 -0500
Received: from nf-out-0910.google.com ([64.233.182.191]:6704 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750983AbXLMNcE (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 Dec 2007 08:32:04 -0500
Received: by nf-out-0910.google.com with SMTP id g13so559096nfb.21
        for <git@vger.kernel.org>; Thu, 13 Dec 2007 05:32:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=UKq1n3z/BvQ30+uPcbVwewju/f4p/BsBADEUfSbklt8=;
        b=AdCnRP5u9WCSgLeIo3rAOTn9SqUrjteIIW5vM2uiMJCW42C0oWUqsd+SiHBYpYkp/MJknKcaE7ztIYesTxurlYsaBgLhUs4D5NzVN/Rb7hPAEgMYoFZkffuCda30cBmK1ww9URTw6dm9gXZTVK5gXRqlebKQzijTUxSO7hCYNA4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=vnRh4fHrTJdmVScJT2WZp7R7vfzArKr4abkIpxt8RZQGvP2oLSo9dZJ/8UuOsPmHKloy2VUZjgmnKJIsDElH5J9qlV9xNCy3705uyv9LmXHcyTXJjBUFNWIvH6sVx2dz7d56QPOZ+7JNtNCuLWzLoJMhxinzYyM9CYHUVGEBK48=
Received: by 10.86.89.4 with SMTP id m4mr1836165fgb.14.1197552722658;
        Thu, 13 Dec 2007 05:32:02 -0800 (PST)
Received: by 10.86.83.6 with HTTP; Thu, 13 Dec 2007 05:32:02 -0800 (PST)
In-Reply-To: <alpine.LFD.0.99999.0712120743040.555@xanadu.home>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/68144>

On Dec 12, 2007 10:48 PM, Nicolas Pitre <nico@cam.org> wrote:
> In the mean time you might have to use only one thread and lots of
> memory to repack the gcc repo, or find the perfect memory allocator to
> be used with Git.  After all, packing the whole gcc history to around
> 230MB is quite a stunt but it requires sufficient resources to
> achieve it. Fortunately, like Linus said, such a wholesale repack is not
> something that most users have to do anyway.

Is there an alternative to "git repack -a -d" that repacks everything
but the first pack?
-- 
Duy

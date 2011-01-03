From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [RFC/PATCH] Documentation/technical: document quoting API
Date: Mon, 3 Jan 2011 14:39:24 +0700
Message-ID: <AANLkTi=9EfDnj+koYHPejoz1bok=FaMXhM=DQirOFp1D@mail.gmail.com>
References: <20110103063534.GA3661@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org, Christian Couder <chriscool@tuxfamily.org>,
	Jeff King <peff@peff.net>, Dmitry Potapov <dpotapov@gmail.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jan 03 08:41:24 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PZf2g-0001ao-I6
	for gcvg-git-2@lo.gmane.org; Mon, 03 Jan 2011 08:41:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751767Ab1ACHk7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 Jan 2011 02:40:59 -0500
Received: from mail-ww0-f44.google.com ([74.125.82.44]:53216 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751127Ab1ACHk7 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Jan 2011 02:40:59 -0500
Received: by wwa36 with SMTP id 36so13919176wwa.1
        for <git@vger.kernel.org>; Sun, 02 Jan 2011 23:40:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:cc:content-type;
        bh=nFbWQcQyBceJr4XS6W3DG8RCh9PyLQazgiNEHE5MQkc=;
        b=NqL1kavK2X6BCJPRcxYY3eo+0wq1ldj0vZvBD6bnYc0EkckDjXiNOA2BZF7Da1o/AP
         y7TthqR74MvhpEZYuEp4CFDpGb5OyuZ4rxUTS9Nf8i8dtw6XfRei9zYp3y0jC7G3CutC
         3PVmdmGOCprMJasAHmW9VUubAam+KHS5eGaKw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=WBUOh3rbxncXuHCr/vutA/LW5mZugE0YMxYK+56D5KlL6Wo2lZrQQEJp+bKlHIF9bs
         pfsVlW+sGcVFexH46cP/4FuRuM104/e7Ia4Wmu1FUZY4kpqVvtFvtUBZTqSH8ZEcXnuh
         WlVMjmmDcS4cEx63wxSVgzUrc8AAryCCP+0QA=
Received: by 10.216.169.71 with SMTP id m49mr20717884wel.4.1294040458028; Sun,
 02 Jan 2011 23:40:58 -0800 (PST)
Received: by 10.216.63.14 with HTTP; Sun, 2 Jan 2011 23:39:24 -0800 (PST)
In-Reply-To: <20110103063534.GA3661@burratino>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/164444>

On Mon, Jan 3, 2011 at 1:35 PM, Jonathan Nieder <jrnieder@gmail.com> wrote:
> Briefly explain the zoo of quoting functions.

I rarely read these documents. One of the reasons is sometimes I don't
know such document exists. Can we put a pointer to the document in
quote.h? I assume that anyone who wants to use these will at least
look at quote.h first.
-- 
Duy

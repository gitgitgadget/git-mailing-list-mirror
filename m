From: "Ondrej Certik" <ondrej@certik.cz>
Subject: Re: [ANNOUNCE] cgit 0.8
Date: Fri, 17 Oct 2008 23:31:00 +0200
Message-ID: <85b5c3130810171431p26a6b4c7s152cc04694b50bc9@mail.gmail.com>
References: <8c5c35580810051310u60859afcvf38845244308cd23@mail.gmail.com>
	 <alpine.DEB.2.00.0810051346290.27691@alchemy.localdomain>
	 <8c5c35580810051522l3c8fcfe4md8b78b569f287246@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: "Asheesh Laroia" <git@asheesh.org>,
	"Git Mailing List" <git@vger.kernel.org>
To: "Lars Hjemli" <hjemli@gmail.com>
X-From: git-owner@vger.kernel.org Fri Oct 17 23:32:38 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kqwvp-0008Ah-3w
	for gcvg-git-2@gmane.org; Fri, 17 Oct 2008 23:32:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754446AbYJQVbG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 17 Oct 2008 17:31:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753988AbYJQVbF
	(ORCPT <rfc822;git-outgoing>); Fri, 17 Oct 2008 17:31:05 -0400
Received: from nf-out-0910.google.com ([64.233.182.190]:21455 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754399AbYJQVbE (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 17 Oct 2008 17:31:04 -0400
Received: by nf-out-0910.google.com with SMTP id d3so435049nfc.21
        for <git@vger.kernel.org>; Fri, 17 Oct 2008 14:31:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:sender
         :to:subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references
         :x-google-sender-auth;
        bh=Fb0YtlsCAZWMPq2LKd1fyf1EaSsbugIAj4EiT0942CY=;
        b=xG6lRSXzQsjL3PeKQFLOm9GZb/3XvNQPW39hC1pZxNb0IWw+7poiaG08DylgVznSFE
         GFaFtJYYJ0uFgkNhwKV36e6WCZb7dCfupqvPm109MjNIFi2p/a3bKxiy26XX1lKljeqH
         jcqx21j43vy8YAFvHoaehjiMPjI+5du7TnKzo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references:x-google-sender-auth;
        b=voJyYQLS/HQY02bjiw7gbhTmaQU49w02xIid/WzvWmUt/dl7DxgUhiHaTQjouQpKdx
         ID1nMwTa7aVa5yxng6jD/bRG6Pabt+oWXFKQUZx5djy8tx8Ze5JrhiUxq7yoNROyBgHe
         qQWoBSxHvtphDiGTRgvoqgHc1E71fPOtjrzGw=
Received: by 10.86.27.19 with SMTP id a19mr4405048fga.56.1224279060971;
        Fri, 17 Oct 2008 14:31:00 -0700 (PDT)
Received: by 10.86.33.8 with HTTP; Fri, 17 Oct 2008 14:31:00 -0700 (PDT)
In-Reply-To: <8c5c35580810051522l3c8fcfe4md8b78b569f287246@mail.gmail.com>
Content-Disposition: inline
X-Google-Sender-Auth: 4394c1f4f6621660
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/98494>

On Mon, Oct 6, 2008 at 12:22 AM, Lars Hjemli <hjemli@gmail.com> wrote:
> On Sun, Oct 5, 2008 at 22:49, Asheesh Laroia <git@asheesh.org> wrote:
>> On Sun, 5 Oct 2008, Lars Hjemli wrote:
>>
>>> cgit-0.8, another webinterface for git, is now available.
>>>
>> I'm curious - is there any interest in the cgit world in providing gitweb
>> URL compatibility?
>
> Well, it's a request that's popped up a few times, but no patches so
> far. It would probably be a nice feature if it could be done cleanly.

While we are at the urls, I prefer the urls that mercurial has, e.g.:

http://hg.sympy.org/sympy/rev/62b1589fefa7

is there any reason why cgit uses

http://hjemli.net/git/cgit/commit/?id=140012d

instead of:

http://hjemli.net/git/cgit/commit/140012d

?

If its just a matter of preparing a patch, I'll do that.

Ondrej

From: "Jun Ma" <sync.jma@gmail.com>
Subject: Re: git checkout -b -f v1.5.5.1
Date: Tue, 6 May 2008 00:09:45 +0800
Message-ID: <dcf6addc0805050909r65966e7bmd342c57443fd8c31@mail.gmail.com>
References: <dcf6addc0805050848v91589c6i6c2fca168b7644d5@mail.gmail.com>
	 <20080505155830.GC18443@leksak.fem-net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: "Jun Ma" <sync.jma@gmail.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon May 05 18:10:47 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jt3Gu-00042Y-4R
	for gcvg-git-2@gmane.org; Mon, 05 May 2008 18:10:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754602AbYEEQJs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 5 May 2008 12:09:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754546AbYEEQJs
	(ORCPT <rfc822;git-outgoing>); Mon, 5 May 2008 12:09:48 -0400
Received: from rn-out-0910.google.com ([64.233.170.186]:51842 "EHLO
	rn-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753901AbYEEQJr (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 May 2008 12:09:47 -0400
Received: by rn-out-0910.google.com with SMTP id e11so813349rng.17
        for <git@vger.kernel.org>; Mon, 05 May 2008 09:09:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=jA7SqWkNFWgnyPAUurcoou+GBbaQrFAOS9/nwJk+MgA=;
        b=fdg0Xao+9k+xkUFUTYV9uRzCgVvlmVEhLD1mOF8a+VA7nXkn2/SH91AgroE0PAjUsdSnV8Uadj3kLw+A7GjtdasVunqSR5ZJdAfba1ZzMWGbvRORE4YLB0styYczwFBiQyaVP38VwRRQunCcjuYBBp4LlKbB/gxBGy3uTCvdse8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=qRMlU7WAhbo3dqIyxQTqmal6DPqSjZ/FzmsvT+70YIa8Mr70o7Ov3O+LDeYGhDif1P1SdqNLqMK0p6Ul7avt4Yal6GPCDJk0PInw0r/Tk42Qrt1WmKt+mJVsTYrazqtmEQKzPsVLGCssooW7BfnGMRwUnJGCA/qKa5Q9kTxfz1M=
Received: by 10.142.221.19 with SMTP id t19mr2578820wfg.62.1210003785363;
        Mon, 05 May 2008 09:09:45 -0700 (PDT)
Received: by 10.142.97.21 with HTTP; Mon, 5 May 2008 09:09:45 -0700 (PDT)
In-Reply-To: <20080505155830.GC18443@leksak.fem-net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/81293>

On Mon, May 5, 2008 at 11:58 PM, Stephan Beyer <s-beyer@gmx.net> wrote:

>  >      I just mistaken 'git checkout -b 1.5.5.1 v1.5.5.1' to 'git
>  > checkout -b -f v1.5.5.1', and I don't how to delete it ,
>
>  Try
>   git branch -D -- -f
>
It works, thanks. :)


>
>  > PS: Would it be better if we do checking on branch name to avoid this case?
>
>  What do you want to check for?
>  No leading dashes?
>
I thought it would be better do this job, so we won't get a
malformed(I thought '-f' is) branch name.:)


-- 
FIXME if it is wrong.

From: "Alex Riesen" <raa.lkml@gmail.com>
Subject: Re: [PATCH/RFC] statplot: a tool for mining repository statistics.
Date: Thu, 1 Mar 2007 10:58:52 +0100
Message-ID: <81b0412b0703010158i1a3963f4wabda2f72c1fd0bc4@mail.gmail.com>
References: <20070301072953.GA8730@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Junio C Hamano" <junkio@cox.net>, git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Thu Mar 01 10:58:58 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HMi3u-0006XQ-3i
	for gcvg-git@gmane.org; Thu, 01 Mar 2007 10:58:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964789AbXCAJ6z (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 1 Mar 2007 04:58:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964791AbXCAJ6z
	(ORCPT <rfc822;git-outgoing>); Thu, 1 Mar 2007 04:58:55 -0500
Received: from ug-out-1314.google.com ([66.249.92.172]:30956 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964789AbXCAJ6y (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 Mar 2007 04:58:54 -0500
Received: by ug-out-1314.google.com with SMTP id 44so327176uga
        for <git@vger.kernel.org>; Thu, 01 Mar 2007 01:58:53 -0800 (PST)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=IupO11jVb/GusHxc9GXFxJ5Fd86oEQuXLMqgJ+hIpf8wdIs+p3YWFhXcEHAL53tt8N5O6eny7j7iY+ALeandXQ4Hf/l9wdGrgvEUZuI7dA20c7oivN4wPFMdJPtghlHgnGPoeIrUWAuVKAKqBjUWAhOn+k3iB+lL8rTj4Nqm/us=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=tigf+v18GR+jewb1yFc0hPfrS9sUzkC/fH2oS4fYdIpT1osFP2qSAhIhS5wVK51edFx5jd/8f+By3a/SIYu2E3kYHghJkzUyeRnPnaA79xpwewrJCgbLtk5bcI0s+cAvn9c36B/wRDAei/Qbvb8roSq5pP8MiCR+VbHnkWE6FVk=
Received: by 10.78.158.11 with SMTP id g11mr143301hue.1172743132670;
        Thu, 01 Mar 2007 01:58:52 -0800 (PST)
Received: by 10.78.139.9 with HTTP; Thu, 1 Mar 2007 01:58:52 -0800 (PST)
In-Reply-To: <20070301072953.GA8730@spearce.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/41071>

On 3/1/07, Shawn O. Pearce <spearce@spearce.org> wrote:
> This is a simple program to dump statistics about number of objects
> per day, and how much disk space is used per day.  It can be used
> to generate data files suitable for plotting repository growth
> over time.
>
> This program avoids displaying information about tags, but it does
> cover the commits referenced by those tags.  Since annotated tags
> are a very small portion of most projects I don't consider this to
> be a major issue at this time.
>

Tried it on my repo but the program produced some records with
all zeros. I.e.:
2005-11-10 6 222 235 463 1785888
2005-11-11 3 34 2 39 9729
2005-11-12 0 0 0 0 0
2005-11-13 0 0 0 0 0
2005-11-14 6 227 330 563 716230
2005-11-15 3 121 209 333 1162839

What could this possibly mean?

>  This is a toy, but its more than good enough for production, so uh,
>  here it is.  Should it be included in git.git?  Don't know....
>

Definitely! It's interesting, and fun.

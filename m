From: "Ping Yin" <pkufranky@gmail.com>
Subject: Re: [PATCH] git-submodule: Don't die when command fails for one submodule
Date: Wed, 5 Mar 2008 00:06:26 +0800
Message-ID: <46dff0320803040806y5ed02b86p9216ddc752f3052@mail.gmail.com>
References: <1204641314-2726-1-git-send-email-pkufranky@gmail.com>
	 <alpine.LSU.1.00.0803041500170.22527@racer.site>
	 <46dff0320803040800o499bb77bsa033134bda43becb@mail.gmail.com>
	 <alpine.LSU.1.00.0803041602150.22527@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: gitster@pobox.com, git@vger.kernel.org
To: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue Mar 04 17:07:34 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JWZfW-0006SS-OK
	for gcvg-git-2@gmane.org; Tue, 04 Mar 2008 17:07:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762619AbYCDQG2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 4 Mar 2008 11:06:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1762491AbYCDQG2
	(ORCPT <rfc822;git-outgoing>); Tue, 4 Mar 2008 11:06:28 -0500
Received: from hs-out-0708.google.com ([64.233.178.244]:1505 "EHLO
	hs-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1762455AbYCDQG1 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Mar 2008 11:06:27 -0500
Received: by hs-out-0708.google.com with SMTP id 4so1933094hsl.5
        for <git@vger.kernel.org>; Tue, 04 Mar 2008 08:06:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=Ft/ZCdO4HcfHYEBAZEJZPv89V5lVPEA+uJ4DFUhTG/U=;
        b=c4PESnZnxm10aqafhMHr08hcz/iy/XfzoPlgjhboOPdxpC1mp/XJZl8+x8IfdCJgFa4GZoo8/OHNdvvd4iv+LWeSsTtsqIa1XzOMg+VlauYVtgBAs9DjjslFliWVygD4ZQxI+WNOm6WvCU1c+Ep64+7jpy4jT93OvyaLuChp9rU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=DkLZvH56n+qtceohI0aImLfbGidtFD4nZCxNcNdOLGsIjBTh2rPt2WMpdDjLBHgiL1pHzLUTYi5fdkgTydpuTuiamHUN2x85hL6nElap79I0FxFJ2w8b0rdg7hEeJg51HzTqujx6oK3v1DbxI5/eQbtUj8/HG3cJYAyhNGhD3Sg=
Received: by 10.100.210.9 with SMTP id i9mr3358185ang.41.1204646786705;
        Tue, 04 Mar 2008 08:06:26 -0800 (PST)
Received: by 10.100.5.18 with HTTP; Tue, 4 Mar 2008 08:06:26 -0800 (PST)
In-Reply-To: <alpine.LSU.1.00.0803041602150.22527@racer.site>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/76109>

On Wed, Mar 5, 2008 at 12:03 AM, Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
> Hi,
>
>
>  On Wed, 5 Mar 2008, Ping Yin wrote:
>
>  > The error output is not lost and is in module_name
>
>  That's what I am saying: the error output is not enough.  The exit status
>  needs to indicate that there was an error, too.  Everything else is
>  unusable by scripts.

I think this can be done in a following patch which capture any error
and give the right exit status.
>



-- 
Ping Yin

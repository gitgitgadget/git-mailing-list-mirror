From: "Marco Costalba" <mcostalba@gmail.com>
Subject: Re: limiting rename detection during merge is a really bad idea
Date: Mon, 11 Feb 2008 08:42:06 +0100
Message-ID: <e5bfff550802102342r4b4d4c83mb3c9871d0206b2fa@mail.gmail.com>
References: <CF28A4AE-62F0-4E41-9794-2CF85C2C7855@zib.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: "Git Mailing List" <git@vger.kernel.org>
To: "Steffen Prohaska" <prohaska@zib.de>
X-From: git-owner@vger.kernel.org Mon Feb 11 08:43:06 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JOTJa-0007OE-6c
	for gcvg-git-2@gmane.org; Mon, 11 Feb 2008 08:42:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752311AbYBKHmK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Feb 2008 02:42:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752722AbYBKHmJ
	(ORCPT <rfc822;git-outgoing>); Mon, 11 Feb 2008 02:42:09 -0500
Received: from rv-out-0910.google.com ([209.85.198.187]:25405 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752311AbYBKHmI (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Feb 2008 02:42:08 -0500
Received: by rv-out-0910.google.com with SMTP id k20so3308585rvb.1
        for <git@vger.kernel.org>; Sun, 10 Feb 2008 23:42:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=KUC4kdb4NB6kZKMa+9qz1WpT4hhaCpRC42UELu1zolw=;
        b=i6rDicIkooZ3+cE0/fx/2GRrlYShHaCMLFMpP70CcbM89yQoqwoZBLzmGJooW4DPvpTtQeZ8SE3TTCf405cemIk8+TzgDdXfhazFb0FnMyE/W65+zx1RXzsTrTLPHkIm6WgX2OlpjK+F/giKNp/I5sfMfFLOziKRBwKitQR7Kcw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=PfGTdaJAzhXYOsZZcPcxuOdCMAxgt9HgYi167KQkxL0b8LozAPVBSSLa6iLrXTUkNzxUrviwHZw9yuSN/GtKSGVCHa/bUEbzR1poyT5mEuN2jQC9cyC5uxzNOudaeVCqrNEg4jTV71R9HuGzT86RZUqPOSYpXhyhVn6z3ftaP6A=
Received: by 10.141.175.5 with SMTP id c5mr10358145rvp.281.1202715726623;
        Sun, 10 Feb 2008 23:42:06 -0800 (PST)
Received: by 10.141.76.1 with HTTP; Sun, 10 Feb 2008 23:42:06 -0800 (PST)
In-Reply-To: <CF28A4AE-62F0-4E41-9794-2CF85C2C7855@zib.de>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/73476>

On Feb 11, 2008 7:19 AM, Steffen Prohaska <prohaska@zib.de> wrote:
>
>
> It doesn't make sense not to detect
> renames during a merge.
>
> Opinions?
>

I agree 100%, merge is a very important and sensible task and git
should push as much as possible to avoid fails.

A failed merge is always an hassle for the developer also in simple
cases and when a successful merge is possible git should really try to
achieve that also if it takes a little time more.

So I second overriding diff.renamelimit in this case.

Marco

From: "Catalin Marinas" <catalin.marinas@gmail.com>
Subject: Re: Minor bug in 'stg edit' ?
Date: Thu, 28 Feb 2008 21:43:53 +0000
Message-ID: <b0943d9e0802281343l7c3190a1va564a87afce1ea06@mail.gmail.com>
References: <20080227224756.GK2222@TopQuark.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Paul Donohue" <stgit-bug@topquark.net>
X-From: git-owner@vger.kernel.org Thu Feb 28 22:44:31 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JUqYI-0007ml-RJ
	for gcvg-git-2@gmane.org; Thu, 28 Feb 2008 22:44:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755309AbYB1Vnz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Feb 2008 16:43:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754323AbYB1Vny
	(ORCPT <rfc822;git-outgoing>); Thu, 28 Feb 2008 16:43:54 -0500
Received: from rv-out-0910.google.com ([209.85.198.184]:21908 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752734AbYB1Vny (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Feb 2008 16:43:54 -0500
Received: by rv-out-0910.google.com with SMTP id k20so2304910rvb.1
        for <git@vger.kernel.org>; Thu, 28 Feb 2008 13:43:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=OgiwY1x0GAQeTQ4dpBgeP7kBjvSg0OYAW7x50ZYjiEM=;
        b=SpdhHUZ9hMffvevjVzmVzz8QUpFvij9kGG4KbkzhccogPPhdrIhtFGoeM5kSHEHlvogbJkWUbewfN2IORw5kn7ZZf7q7Q9PsMrE+qYCdxaESKEPWVPpn3jegwWSth+PfE1z4KdxxajhqavfBFQ95wA1vcZ5oVL3duSnUM2aMpLw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=X1yjRWlkp7Tc0CyXV3kUmbsidum4Bd+886qPM/lHBaMuf2O/LTv9EZnA1A4zpaGBr3e0uCKAHGDfLmyhXtyZQQUAEIvwXYlyNcJDbYRZNAx+xgZjldnQjslEzgw2hE6UbJc6r3Qj8S2krAKJb1HR6Tc55G5IvhEmBesfrHMkytA=
Received: by 10.140.180.11 with SMTP id c11mr5946401rvf.137.1204235033413;
        Thu, 28 Feb 2008 13:43:53 -0800 (PST)
Received: by 10.141.206.19 with HTTP; Thu, 28 Feb 2008 13:43:53 -0800 (PST)
In-Reply-To: <20080227224756.GK2222@TopQuark.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/75463>

On 27/02/2008, Paul Donohue <stgit-bug@topquark.net> wrote:
> I'm running StGIT 0.14.1
>
>  After running 'stg edit', the file '.stgit-edit.txt' is always left behind.
>
>  Is this supposed to happen?  I would have assumed the file would be automatically removed after the changes were committed.

I wouldn't say it's a bug as I never thought it would cause any
problems if left. Anyway, we could remove it if the operation was
successful.

-- 
Catalin

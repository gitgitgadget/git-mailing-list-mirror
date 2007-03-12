From: "Catalin Marinas" <catalin.marinas@gmail.com>
Subject: Re: [PATCH 0/3] "stg cp", and StGIT doc updates
Date: Mon, 12 Mar 2007 16:20:37 +0000
Message-ID: <b0943d9e0703120920v28b76773h9e78b15f9d5f5f92@mail.gmail.com>
References: <20070309231444.30705.72292.stgit@gandelf.nowhere.earth>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Yann Dirson" <ydirson@altern.org>
X-From: git-owner@vger.kernel.org Mon Mar 12 17:20:46 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HQnGP-0004tv-1A
	for gcvg-git@gmane.org; Mon, 12 Mar 2007 17:20:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030576AbXCLQUj (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 12 Mar 2007 12:20:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030580AbXCLQUj
	(ORCPT <rfc822;git-outgoing>); Mon, 12 Mar 2007 12:20:39 -0400
Received: from an-out-0708.google.com ([209.85.132.248]:11518 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030576AbXCLQUi (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Mar 2007 12:20:38 -0400
Received: by an-out-0708.google.com with SMTP id b33so1498479ana
        for <git@vger.kernel.org>; Mon, 12 Mar 2007 09:20:38 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=cHoQUjnyLw7NlaYLUcoXrZYAd+JKUHTd+OZr/K+79SsLQnLyCKj6q3dQUAEy1B3jMbQ1k4YDRzecgXVPN2TE/4ycy8uNrcyL0cf6ohv5ifbbOqIzajbTfkWeuU40C0cfagX+CcTSTAnlKzWa2mrGmp0H2ZrmW0Y0fJMS6s6dENQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=kUwNN1eXXNhD7DVxhp9B+83yZuarHqfWCYkbzAVjUxZRcmDj+QWZypSRxMu/b1sDgB75l6GopWKXxHw0Wqx+okHSMTej0aUrBeHuun+uDB6wLoh4GHvdlIpJOjxaQmVgb0uyt3FSL3tC8PipnW/KmESa7FqoMUrRf00+p3kms4Y=
Received: by 10.114.170.1 with SMTP id s1mr1787685wae.1173716437403;
        Mon, 12 Mar 2007 09:20:37 -0700 (PDT)
Received: by 10.65.96.9 with HTTP; Mon, 12 Mar 2007 09:20:37 -0700 (PDT)
In-Reply-To: <20070309231444.30705.72292.stgit@gandelf.nowhere.earth>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/42036>

On 09/03/07, Yann Dirson <ydirson@altern.org> wrote:
> "stg cp" comes to complement "add" and "rm".  I originally thought to
> complement the whole with "stg mv", but I wonder whether the all 4 of
> them eally have a place in StGIT.  Shouldn't we just use git/cogito
> for such operations ?  In this case, this patch should indeed be
> retargetted to be a git-cp command (it has anyway no real dependency
> on StGIT, and the feature would be more generally useful).

I think we should have these commands in StGIT, even if they would
just call the corresponding git commands. The reason is that we may
later decide to implement some other behaviour (i.e. use a separate
index when working on a patch).

-- 
Catalin

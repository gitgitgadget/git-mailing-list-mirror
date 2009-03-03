From: Tay Ray Chuan <rctay89@gmail.com>
Subject: Re: http: a non-curl_multi interface?
Date: Tue, 3 Mar 2009 19:19:33 +0800
Message-ID: <be6fef0d0903030319k46bd5f9bx69148a920213038d@mail.gmail.com>
References: <be6fef0d0903020514h28995ec2v2acd9f65131c1515@mail.gmail.com>
	 <alpine.DEB.1.10.0903021412120.15587@yvahk2.pbagnpgbe.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Daniel Stenberg <daniel@haxx.se>
X-From: git-owner@vger.kernel.org Tue Mar 03 12:21:06 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LeSgL-0008A9-Lp
	for gcvg-git-2@gmane.org; Tue, 03 Mar 2009 12:21:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754217AbZCCLTi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Mar 2009 06:19:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753919AbZCCLTh
	(ORCPT <rfc822;git-outgoing>); Tue, 3 Mar 2009 06:19:37 -0500
Received: from wa-out-1112.google.com ([209.85.146.180]:37317 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751335AbZCCLTg (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Mar 2009 06:19:36 -0500
Received: by wa-out-1112.google.com with SMTP id v33so1468712wah.21
        for <git@vger.kernel.org>; Tue, 03 Mar 2009 03:19:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=4Wnuc25ljKXogMTiwLVbUmHqcBbAK4JBhqVcf7/BSB8=;
        b=EQ0d25CUiOfIeJVGJpeWwNNUgDpeqpIlFGySP3HZsiVz3dePqbdMRB96gLtnLEFVxX
         DTxo0IYfTvAuDXbFW2NkL1EH5TAXxL+mHAZc+vSFPOsyWbE6niXQYdFcSjQrtyw4ldKp
         v85zmNdZSr7pkowlHfVNsRbtfqNqNMRPm3hfI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=mFschEnCUWYFZCY3nBP66qCkzHUXf3Yh3yRrz67gOzEaOPwp6izAhlteA11BOwehZ+
         dLSm9j+h3wn4gUCdrPzZE++jlcfJ23LhPjPoWy9ACsYJp92yO+i/RlpbzWEfb0xupS1F
         EQHqk2asB1gWElKlMJRNx01CTYNASJ/1N9OTg=
Received: by 10.114.106.13 with SMTP id e13mr3288931wac.52.1236079173230; Tue, 
	03 Mar 2009 03:19:33 -0800 (PST)
In-Reply-To: <alpine.DEB.1.10.0903021412120.15587@yvahk2.pbagnpgbe.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/112053>

Hi,

On Mon, Mar 2, 2009 at 9:26 PM, Daniel Stenberg <daniel@haxx.se> wrote:
> What I don't quite grasp (and I must admit I have not followed the critique
> on this matter) is why using the multi interface of libcurl is a problem to
> anyone as all libcurl versions in modern times features it. And if you have
> a libcurl with it working badly, you have a too old libcurl anyway and
> should rather upgrade...
>
> ...
>
> I don't see how that is true. In fact, properly used I would claim that an
> application using the multi interface would in general use less connections
> and do more connection re-use than otherwise. But of course it depends on a
> lot of factors.

Hmm, there aren't any very obvious benefits are there?

In that case, I guess, an re-organization of the http api/curl usage
would be more useful to git.

-- 
Cheers,
Ray Chuan

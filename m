From: Andy Parkins <andyparkins@gmail.com>
Subject: Re: Correction for post-receive-email
Date: Fri, 5 Oct 2007 09:13:57 +0100
Message-ID: <200710050913.58835.andyparkins@gmail.com>
References: <449c8cfc0710050014j9bbf057ka108ee27dea49a89@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Cc: "Eric Mertens" <emertens@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Oct 05 10:14:32 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IdiKG-0005NW-OD
	for gcvg-git-2@gmane.org; Fri, 05 Oct 2007 10:14:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752609AbXJEIOI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 5 Oct 2007 04:14:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752143AbXJEIOH
	(ORCPT <rfc822;git-outgoing>); Fri, 5 Oct 2007 04:14:07 -0400
Received: from ug-out-1314.google.com ([66.249.92.173]:35951 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752804AbXJEIOF (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Oct 2007 04:14:05 -0400
Received: by ug-out-1314.google.com with SMTP id z38so462993ugc
        for <git@vger.kernel.org>; Fri, 05 Oct 2007 01:14:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        bh=/pQJGSFlbd0Bn5xScOyFIG/FoBzwBrJ5F0vEbCQHSrA=;
        b=WjvbRawysblGQKnBiVasH50kEhmL9hCZszSYFQGhzQqLPsEdB6C+degXGQaJDWZ17EOV2DaU9QcLtp6vaMWqqlRhOmWJupedboA5MOUjkVeFLU0kXi2Or2zyWsu4zI/Rn9oWlhwUzmzO9CE9d33OzktCaXELp5sWSIm9g76afuI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=LaTy2nEt9bcyKiQPoF/eU0iBy/4xDlhDG/1dUd1i8SsZuHG4Fvnk9fNFno32UZYGvvr1U3I2z0FoDBJL3YnCs2xia+ZmrrjRYvdN8iX+bDKC9OMejurLfp1CTrNMvU3fa/bPz8qWW/uBlIMRxweL2X/HW74Tw4nCRNdzyifnokk=
Received: by 10.67.30.6 with SMTP id h6mr3051481ugj.1191572043338;
        Fri, 05 Oct 2007 01:14:03 -0700 (PDT)
Received: from dvr.360vision.com ( [194.70.53.227])
        by mx.google.com with ESMTPS id b30sm2945859ika.2007.10.05.01.14.01
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 05 Oct 2007 01:14:01 -0700 (PDT)
User-Agent: KMail/1.9.7
In-Reply-To: <449c8cfc0710050014j9bbf057ka108ee27dea49a89@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/60045>

On Friday 2007 October 05, Eric Mertens wrote:

> I noticed that my mutt wasn't correctly detecting the signature block
> on the end of the automated emails I was receiving from the script in
> contrib. I've made this trivial change in my local copy of the script,
> but I figured that if I was going to be modifying the source code I
> should share my changes.

That change has been in my pending queue for a while.  It's technically 
correct, but I've never submitted it.  The reason I haven't is that it adds 
trailing whitespace.

Perhaps one of the shell gurus can offer a nicer way of having a trailing 
space be output in a heredoc that doesn't add a trailing space in the source 
script?


Andy

-- 
Dr Andy Parkins, M Eng (hons), MIET
andyparkins@gmail.com

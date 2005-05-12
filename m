From: Jon Seymour <jon.seymour@gmail.com>
Subject: Re: [PATCH] improved delta support for git
Date: Fri, 13 May 2005 00:47:34 +1000
Message-ID: <2cfc403205051207471f6957e0@mail.gmail.com>
References: <Pine.LNX.4.62.0505112309480.5426@localhost.localdomain>
	 <7voebhkql5.fsf@assigned-by-dhcp.cox.net>
	 <200505121027.01964.mason@suse.com>
	 <2cfc403205051207467755cdf@mail.gmail.com>
Reply-To: jon@blackcubes.dyndns.org
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-From: git-owner@vger.kernel.org Thu May 12 16:41:29 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DWEqz-0006CE-RY
	for gcvg-git@gmane.org; Thu, 12 May 2005 16:39:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261978AbVELOrh (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 12 May 2005 10:47:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261981AbVELOrh
	(ORCPT <rfc822;git-outgoing>); Thu, 12 May 2005 10:47:37 -0400
Received: from rproxy.gmail.com ([64.233.170.197]:26968 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261978AbVELOre convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 May 2005 10:47:34 -0400
Received: by rproxy.gmail.com with SMTP id i8so66092rne
        for <git@vger.kernel.org>; Thu, 12 May 2005 07:47:34 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=FuJBKHRBPOsOzDz/YlIGGvH3y1YgjIc95nNw0m7E8556F5hQOCsJPJuvK0gK7BpqRePGGXRD6oQzfxsWte5VLeR+Ntq0zHOzzGUvsMnLSXitQIhbopy/iuU9GJJ3ac9ZWsXlKUloOd2DeWD6j9mZi2pgnu39+WjVre9dXpcj+3w=
Received: by 10.38.208.18 with SMTP id f18mr238113rng;
        Thu, 12 May 2005 07:47:34 -0700 (PDT)
Received: by 10.38.104.37 with HTTP; Thu, 12 May 2005 07:47:34 -0700 (PDT)
To: Git Mailing List <git@vger.kernel.org>
In-Reply-To: <2cfc403205051207467755cdf@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On 5/13/05, Chris Mason <mason@suse.com> wrote:
> On Thursday 12 May 2005 00:36, Junio C Hamano wrote:
> > It appears to me that changes to the make_sure_we_have_it() ...
>
> If we fetch the named object and it is a delta, the delta will either depend
> on an object we already have or an object that we don't have.  If we don't
> have it, the pull should find it while pulling other commits we don't have.
>

Chris,

Doesn't that assume that the object referenced by the delta is
reachable from the commit being pulled. While that may be true in
practice, I don't think it is a logical certainty.

jon.

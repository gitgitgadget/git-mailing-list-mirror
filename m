From: "Nguyen Thai Ngoc Duy" <pclouds@gmail.com>
Subject: Re: [PATCH 08/12] git-clone: support --path to do sparse clone
Date: Fri, 25 Jul 2008 01:47:54 +0700
Message-ID: <fcaeb9bf0807241147k1175c8a3mffc12e3b3cc1aa3f@mail.gmail.com>
References: <20080723145718.GA29134@laptop>
	 <20080724171952.GB21043@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Jeff King" <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Jul 24 20:49:02 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KM5rz-0004f3-RW
	for gcvg-git-2@gmane.org; Thu, 24 Jul 2008 20:48:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752379AbYGXSr4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 Jul 2008 14:47:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752487AbYGXSr4
	(ORCPT <rfc822;git-outgoing>); Thu, 24 Jul 2008 14:47:56 -0400
Received: from fg-out-1718.google.com ([72.14.220.157]:48185 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752193AbYGXSrz (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Jul 2008 14:47:55 -0400
Received: by fg-out-1718.google.com with SMTP id 19so1471998fgg.17
        for <git@vger.kernel.org>; Thu, 24 Jul 2008 11:47:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=C0hJL6Br1bj1VKZ9zpwER26Km7bqvhY1UonP4iDjjCA=;
        b=D/mykRtOPWvVjCuqhNWv97kOytkhij+ZAnkw4C8Nz+1XKmeJEko0BjxiWhAGJspX0U
         Vhjy02My+BKTALxPRLezroh5fMs5z0q2VlaQIZvPceOWKfrsPdk5+l1Pc843uwGLl3+3
         Vp2Zs+KhYqEbDTP+i+3jOf9rzOKV0bPUn+4nE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=OLbKQepnaKU5Bi41JkGN7bkx7OTlyN8k7EhvFAw3fHE1jKpXpRi0mxvzOd8jmtuARn
         yUU3jPw70bWl5Ls4UMe0XqSoeFdF9+7qjiVLEwxzxZpBaYoinPcFQO5hndMX15hpec0T
         ns/TF+lF5oyX2tWwvNfo0X0WluGtb/xq4tIPY=
Received: by 10.86.90.13 with SMTP id n13mr1161441fgb.3.1216925274293;
        Thu, 24 Jul 2008 11:47:54 -0700 (PDT)
Received: by 10.86.91.2 with HTTP; Thu, 24 Jul 2008 11:47:54 -0700 (PDT)
In-Reply-To: <20080724171952.GB21043@sigill.intra.peff.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/89936>

On 7/25/08, Jeff King <peff@peff.net> wrote:
> On Wed, Jul 23, 2008 at 09:57:18PM +0700, Nguyen Thai Ngoc Duy wrote:
>
>  > +             if (option_sparse_prefix) {
>  > +                     git_config_set("core.sparsecheckout", option_sparse_prefix);
>  > +                     set_sparse_prefix(option_sparse_prefix);
>  > +             }
>  > +
>
>
> As a user, I would expect "sparse clone" to also be sparse on the
>  fetching. That is, to not even bother fetching tree objects that we are
>  not going to check out. But that is a whole other can of worms from
>  local sparseness, so I think it is worth saving for a different series.
>
>  So instead I would suggest that this be mentioned in the documentation
>  for --path, but there doesn't seem to be any.

Thanks. Will mention it when I write documentation for this.
-- 
Duy

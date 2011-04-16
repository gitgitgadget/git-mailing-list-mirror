From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: git status -s -v: no override
Date: Fri, 15 Apr 2011 19:45:45 -0500
Message-ID: <20110416004544.GA5628@elie>
References: <BANLkTimKO7ihPpJ80Ad1kbYaMv1ycu0y9A@mail.gmail.com>
 <20110416000918.GB9334@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jacek Masiulaniec <jacekm@dobremiasto.net>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sat Apr 16 02:45:58 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QAte9-0006mP-Vu
	for gcvg-git-2@lo.gmane.org; Sat, 16 Apr 2011 02:45:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756098Ab1DPApw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 15 Apr 2011 20:45:52 -0400
Received: from mail-iy0-f174.google.com ([209.85.210.174]:65377 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755515Ab1DPApv (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 Apr 2011 20:45:51 -0400
Received: by iyb14 with SMTP id 14so2541991iyb.19
        for <git@vger.kernel.org>; Fri, 15 Apr 2011 17:45:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=4ZjWSHjOAebJS0zuHy5UMjLIx1lK5s+6L2F3TwebAas=;
        b=dedgOuNOmoYgTx9CVZwyTNYlpyOFuZnQyTLlO3K7AlgUkGGHC/GlTAt08Fz5hD9bVB
         X3UScN+lqaMPJFlOQtSqpCyRrZhW0exn0F5zYTvBs3VyZ9aagbJ+zXHFlq9NPTGglaZx
         lx+IUyOO6NehxXYRo8/R1AvIwjiBpeXYojvrM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=fmbhXTJtPYBXqtTiD5YQdCB6bMNR/f8GOfF9WuGQhwcJDwZABexuK2iv1402j8yY5/
         HCNHluMlbwgwkSwIX0Guf3RwU1OSq8ZVr/1/dpH+2uEgL0kr7SFLFhnw0un5tLvBrZA4
         8biWu/ziDi/JeXPpHZbH9U6stzT0lZV9cor5A=
Received: by 10.42.151.72 with SMTP id d8mr3543487icw.26.1302914751282;
        Fri, 15 Apr 2011 17:45:51 -0700 (PDT)
Received: from elie ([69.209.51.5])
        by mx.google.com with ESMTPS id t1sm1873993ibm.4.2011.04.15.17.45.49
        (version=SSLv3 cipher=OTHER);
        Fri, 15 Apr 2011 17:45:50 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20110416000918.GB9334@sigill.intra.peff.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/171651>

Jeff King wrote:

> There is no option that means "counteract -s or --porcelain seen earlier
> on the command line and use the default long format", which I think is
> what you want.

Doesn't "git status $opts --no-short --no-porcelain" work?

From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Prevalence of $prevent_xss
Date: Sat, 4 Jun 2011 23:53:08 +0200
Message-ID: <201106042353.08942.jnareb@gmail.com>
References: <1307177015-880-1-git-send-email-jnareb@gmail.com> <1307222101.5994.13.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Matt McCutchen <matt@mattmccutchen.net>
X-From: git-owner@vger.kernel.org Sat Jun 04 23:55:16 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QSyoM-0006eh-Tb
	for gcvg-git-2@lo.gmane.org; Sat, 04 Jun 2011 23:55:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754131Ab1FDVxR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 4 Jun 2011 17:53:17 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:35849 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753783Ab1FDVxR (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 4 Jun 2011 17:53:17 -0400
Received: by bwz15 with SMTP id 15so2524123bwz.19
        for <git@vger.kernel.org>; Sat, 04 Jun 2011 14:53:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:subject:date:user-agent:cc:references
         :in-reply-to:mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        bh=M70MjuCxznknG6FB+DfBAsKS5eZDbxdEvVcGfedE3NA=;
        b=EicVpjTxQPwOGUn6Vwqnx12NFi+iEdZXKuFVnOSeX4r/Rk4bZeBENKjkqZ5nX47l1/
         dlLKxGyz/a5iLfTXfQy6t0ulybZy9bvcsa5yfkRSXh2VBcir0H9ZkwfEJZ88KKWtA2tF
         sad7jXFKu0alyQn2i/gLP0T89U9kciPiCXZFk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=uJTxvmxdkEt7U96Q5KryWhr0+vllG2tsrDRm8XvhEJLy5klU8qx4sp/o4sJCtY4TDW
         Oo+Sk69JqDMYJJl4ObEcYUXu68AtyWZ8GojMadI+saCt+BnT35NbpAFn6POttDKt0bF8
         wk3U7QqvhaqdiOis9dnFz2S39vNVj32NQk+/k=
Received: by 10.204.126.29 with SMTP id a29mr3069296bks.167.1307224394904;
        Sat, 04 Jun 2011 14:53:14 -0700 (PDT)
Received: from [192.168.1.13] (abva119.neoplus.adsl.tpnet.pl [83.8.198.119])
        by mx.google.com with ESMTPS id g2sm2209465bkz.11.2011.06.04.14.53.13
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sat, 04 Jun 2011 14:53:13 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <1307222101.5994.13.camel@localhost>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/175065>

On Sat, 4 Jul 2011, Matt McCutchen wrote:
> On Sat, 2011-06-04 at 10:43 +0200, Jakub Narebski wrote:

> > The fact that it this buglet was present for so long, since its
> > introduction by Matt McCutchen in 7e1100e (gitweb: add $prevent_xss
> > option to prevent XSS by repository content, 2009-02-07) without
> > complaint shows that not many people are using this feature...

Well, and the fact that it is just minor issue (and might not be visible
at all if there is mime.types file, and text files do use mime.types
extensions).

> Yes.  Well, I'm still using it, and I found a few mentions on the web:
> 
> https://android.git.kernel.org/?p=tools/gerrit.git;a=blob;f=gerrit-httpd/src/main/java/com/google/gerrit/httpd/gitweb/GitWebServlet.java;h=947fbb423f1f8cf46db9876f4b80c600cdf9ee41;hb=HEAD#l193
> http://ao2.it/wiki/How_to_setup_a_GIT_server_with_gitosis_and_gitweb
> http://www.digitalfoo.net/posts/2009/11/git,_gitosis,_gitweb_on_FreeBSD/

Thanks for research.  Nice to know.
 
> And there are probably others who did their own custom things (GitHub?)
> before the feature was added upstream.

GitHub does not use gitweb, but its own [integrated] custom web interface.

-- 
Jakub Narebski
Poland

From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [RFC] Git User's Survey 2008
Date: Wed, 23 Jul 2008 23:59:54 +0200
Message-ID: <200807232359.55916.jnareb@gmail.com>
References: <200807230325.04184.jnareb@gmail.com> <20080723214433.GO32184@machine.or.cz>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Petr Baudis <pasky@suse.cz>
X-From: git-owner@vger.kernel.org Thu Jul 24 00:01:06 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KLmOP-0002Ql-Na
	for gcvg-git-2@gmane.org; Thu, 24 Jul 2008 00:01:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753475AbYGWWAF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Jul 2008 18:00:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753302AbYGWWAE
	(ORCPT <rfc822;git-outgoing>); Wed, 23 Jul 2008 18:00:04 -0400
Received: from ug-out-1314.google.com ([66.249.92.175]:55954 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752649AbYGWWAC (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Jul 2008 18:00:02 -0400
Received: by ug-out-1314.google.com with SMTP id h2so547758ugf.16
        for <git@vger.kernel.org>; Wed, 23 Jul 2008 15:00:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=Izku5vWEiHgXb/BQkklOsYE/yxdmfzop9cjnr76jwkw=;
        b=WrVBm+rzmlnXxMM2yYhjd3dbyF4UWDnf7Z4V1fAqUmpF6zFV59ifubeRMqmhVJHyjn
         vIbCt5tP0hTU+rYnTDrgrd2zijmLJXYrwZfWRveaCaIdKsGxsYb0gn3ugU1EpxSVpehh
         gOw2B7w+Oac8DRUT2uaqcqtyeDbgdDUVt0l6U=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=QcCVyAjsqyG90rjQA9Ha4QAveusgaAYD3kOPNsPyk1brpfX8n1P9stybUoA52La970
         zIUB1O1akZoWiOZzlubEmwlL95PaYW2rZDUUND5PtAhWcuTpY7qdJzhv4Kz2gK2KH+ZT
         vwbfOvDQsgToFvXnyhJtqIwzEvHC70KK0nTRY=
Received: by 10.67.22.2 with SMTP id z2mr64282ugi.34.1216850399879;
        Wed, 23 Jul 2008 14:59:59 -0700 (PDT)
Received: from ?192.168.1.11? ( [83.8.213.1])
        by mx.google.com with ESMTPS id 27sm14378081ugp.82.2008.07.23.14.59.57
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 23 Jul 2008 14:59:58 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <20080723214433.GO32184@machine.or.cz>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/89788>

On Wed, 23 Jul 2008, Petr Baudis wrote:
> On Wed, Jul 23, 2008 at 03:25:03AM +0200, Jakub Narebski wrote:
> >
> >    18. Which (main) git web interface do you use for your projects?
> >        (zero or more: multiple choice)
> >      - gitweb, cgit, wit (Ruby), git-php, viewgit (PHP), other
> >      + should there be a question about web server (Apache, IIS, ...)
> >        used to host git web interface?
> >    18b.If you selected "other web interface", what it was?
> >        (free form)
> 
> I think many people "just use GitHub", or repo.or.cz, or Gitorious; for
> GitHub or Gitorious, there's even no good answer to the question above.

For Gitorious there is a good answer: Gitorious web interface (which
is OSS, and you can deploy on your own).

> So I would either make a separate question for these or include them in
> the list above.

Fact, I have forgot to add question about which git hosting site one
uses; I have meant to add it in the second version of proposal for
Git User's Survey 2008 questions list.

   xx. Which git hosting site do you use for your projects?
       (zero or more: multiple choice)
     - repo.or.cz, GitHub, Gitorious, kernel.org, freedesktop.org,
       Savannah, Assembla, Unfuddle, Alioth, Fedora Hosted, other
     + of course "if other, which"
     + should some other web hosting sites be included as well?

> >    19. How do you publish/propagate your changes?
> >        (zero or more: multiple choice)
> >      - push, pull request, format-patch + email, bundle, other
> 
> I agree about the git-svn mention.

I'll add it, then.

-- 
Jakub Narebski
Poland

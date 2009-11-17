From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Make Gitweb behave like Apache mod_userdir
Date: Tue, 17 Nov 2009 14:58:55 +0100
Message-ID: <200911171458.56047.jnareb@gmail.com>
References: <7fce93be0911150204h259b7424md251c54186d05b7d@mail.gmail.com> <7vskcffqkn.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Petr Baudis <pasky@suse.cz>, Luben Tuikov <ltuikov@yahoo.com>,
	"J.H." <warthog9@kernel.org>, git <git@vger.kernel.org>,
	Sylvain Rabot <sylvain@abstraction.fr>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Nov 17 14:59:15 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NAOaN-00049F-Vh
	for gcvg-git-2@lo.gmane.org; Tue, 17 Nov 2009 14:59:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752617AbZKQN65 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Nov 2009 08:58:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752272AbZKQN65
	(ORCPT <rfc822;git-outgoing>); Tue, 17 Nov 2009 08:58:57 -0500
Received: from mail-fx0-f221.google.com ([209.85.220.221]:49982 "EHLO
	mail-fx0-f221.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752018AbZKQN64 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Nov 2009 08:58:56 -0500
Received: by fxm21 with SMTP id 21so3984703fxm.21
        for <git@vger.kernel.org>; Tue, 17 Nov 2009 05:59:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=txU98407kPO6XXael3c+x3oomW6j/3M3x/zkI405im4=;
        b=RcBFGj8Nur/R1Tnx8sjQI0wHnBceO4W7gsWHcD2kOXopUugJO9pjS0avIoJFzUzszo
         v5N19s3OolwLsNgVMxybdBYl3naSIb0w0mE3ewQAXHvIuFn5hecw3iIPUyhPdEhaEqxO
         oZiPu4TCN3+b7d+6UMuLgIw1ah9jFOs6GsDCk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=qG8tDrR/X87twuZTh8H/8rs++X1O7v7hfDY11rkHh+YrwWoLDR8FVYTf2/q5CiPGRR
         XrcxBQ1m58wmtmMIKmtaCf2ZHDE67jQGP4U+UAicT3QMYR7vl1mdo0DRTD3wHwRp3hpM
         k/Lsc2ihk5frtLshhktmBU87ydoIEJ2WDdqWk=
Received: by 10.204.13.207 with SMTP id d15mr3228933bka.157.1258466340877;
        Tue, 17 Nov 2009 05:59:00 -0800 (PST)
Received: from ?192.168.1.13? (abwu104.neoplus.adsl.tpnet.pl [83.8.244.104])
        by mx.google.com with ESMTPS id 14sm295329bwz.5.2009.11.17.05.58.57
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 17 Nov 2009 05:58:57 -0800 (PST)
User-Agent: KMail/1.9.3
In-Reply-To: <7vskcffqkn.fsf@alter.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/133090>

On Sun, 15 Nov 2009, Junio C Hamano wrote:
> Sylvain Rabot <sylvain@abstraction.fr> writes:
> 
> > I made gitweb behave a bit like UserDir module will in apache.
> > In fact it's only configuration but I think it could be useful to others.
> 
> Thanks.  Any comment from gitweb gangs?

I would respond earlier if it was submitted with patch inline in mail
body, and not attached.  If it needs to be attached (because of MUA/MTA
linewrapping or encoding issues), it should use 8bit and not base64
content transfer encoding, have 'text/plain' and not 
'application/octet-stream' content type, and "inline" and not "attachement"
in content disposition.

It also lacks proper commit message (although email describes it quite
well) and signoff, as per Documentation/SubmittingPatches.

I like this patch.  More examples in gitweb/README are always good idea.

> > Basicly it allows users of your server who use git to be able to use

"Basically"

> > gitweb to browse their own root project. E.G. :

"For example"

> >
> > Alice's private repos :
> >
> > /home/alice/git/product_a.git (cloned from /var/git/product_a.git)
> > /home/alice/git/product_b.git (cloned from /var/git/product_b.git)
> > /home/alice/git/product_c.git (cloned from /var/git/product_c.git)
> >
> > Alice's links to her repos which she wants to be able to browse with gitweb :

"Alice links", or "Alice creates symbolic links"

> >
> > /home/alice/gitweb/product_a -> /home/alice/git/product_a.git/.git
> > /home/alice/gitweb/product_c -> /home/alice/git/product_c.git/.git
> >
> > Bare repos :
> >
> > /var/git/product_a.git
> > /var/git/product_b.git
> > /var/git/product_c.git
> > /var/git/product_d.git

The description is a bit lacking.  Where user should put theirs git
repositories, or symbolic links to git repositories?  How it would
look like in gitweb?

-- 
Jakub Narebski
Poland

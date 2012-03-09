From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: git push default behaviour?
Date: Fri, 09 Mar 2012 06:42:12 -0800 (PST)
Message-ID: <m3mx7pzvia.fsf@localhost.localdomain>
References: <CAFsnPqp1+jX3ZY0LZ1QDmvA=2_ebApPBttwFjr36OuTX2_MHug@mail.gmail.com>
	<87k42vs8pi.fsf@thomas.inf.ethz.ch>
	<CAFsnPqopZEZeeuFzK4ZoUjGnfpiv5oMs=xV5XBSgSyGLXOwgqA@mail.gmail.com>
	<1331202483.21444.11.camel@beez.lab.cmartin.tk>
	<CAFsnPqpnH2CTki8zz6Mpz=qrdxF_aTA92cPrn1L9MQZVMoxdeg@mail.gmail.com>
	<1331203321.21444.13.camel@beez.lab.cmartin.tk>
	<CAFsnPqpoBLHoshgv0MsUUStA3Q=niM8hP9yaHr+rSQvh-JWHZA@mail.gmail.com>
	<7vlinbdkb0.fsf@alter.siamese.dyndns.org>
	<vpq1up3aqk8.fsf@bauges.imag.fr>
	<7vty1ydh7p.fsf@alter.siamese.dyndns.org>
	<vpqr4x26vyp.fsf@bauges.imag.fr>
	<7vipie85nk.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Jeremy Morton <jeremy@configit.com>,
	=?iso-8859-15?q?Carlos_Mart=EDn_Nieto?= <cmn@elego.de>,
	Thomas Rast <trast@inf.ethz.ch>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Mar 09 15:42:21 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S611Q-00037u-CE
	for gcvg-git-2@plane.gmane.org; Fri, 09 Mar 2012 15:42:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754477Ab2CIOmP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 Mar 2012 09:42:15 -0500
Received: from mail-we0-f174.google.com ([74.125.82.174]:40806 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754110Ab2CIOmO (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Mar 2012 09:42:14 -0500
Received: by wejx9 with SMTP id x9so1136372wej.19
        for <git@vger.kernel.org>; Fri, 09 Mar 2012 06:42:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        bh=Wmv3OeDAP+zLt2M5hjDInSAK3cpOBXexswd+3e+DyP8=;
        b=MPm0OwhLOsP9D0vKj7E2VNI1KvDXMAlpHj0e2mmZKZKqBtWrsIU0iOKNuasILrru6x
         IAqi56+qsEz5Smq7N1ZDLG2GbbSYPtjImO0Y4W/FZE3yoPXKViXSmzRpGQADDXwn4b79
         5UWOiWgVy1yxfZ+sOuupp92vW/ya2DaKexQSZIliaiXc8rBN+TRrEPjMidHo0B0ILnh0
         b/O4XdAhw5+uasy+QYA1/J99HyBsOyXn6fETrnDPXcZxnr/wSFwNccTlVFMLezrp6NTz
         3FsuLhh8w2eDNOd2JHDaf8g2NJiyPTpjnP6q7Q0qAAiaHnsOlXSE0eUC5DS2bI4p2OVl
         jFPQ==
Received: by 10.216.132.8 with SMTP id n8mr1565132wei.36.1331304133561;
        Fri, 09 Mar 2012 06:42:13 -0800 (PST)
Received: from localhost.localdomain (abwp68.neoplus.adsl.tpnet.pl. [83.8.239.68])
        by mx.google.com with ESMTPS id w14sm5571130wiv.11.2012.03.09.06.42.10
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 09 Mar 2012 06:42:12 -0800 (PST)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id q29Eg7iO005885;
	Fri, 9 Mar 2012 15:42:07 +0100
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id q29Eg5dA005882;
	Fri, 9 Mar 2012 15:42:05 +0100
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <7vipie85nk.fsf@alter.siamese.dyndns.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/192721>

[I'm sorry if you received duplicate]

Nb. instead of using `--force` to force push of all relevant branches,
you can always force push of single branch with `+branch`...

Junio C Hamano <gitster@pobox.com> writes:
> Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> writes:
> 
> > And regardless of the danger, if I look around me, I see almost only
> > people working with shared archives, and a few projects (including Git,
> > obviously) using the "one commiter per repository" workflow (I teach Git
> 
> These days, you do not have to even go to kernel.org to find people
> and projects that use "publish to be pulled" model.  I hear that
> there is a popular site called GitHub where people create their own
> fork, publish their work there and ask the project they forked from
> to pull their work.
> 
> By the way, don't we ask the workflow used by the users in the
> annual user survey?

There is "23) How do you publish/propagate your changes?"[1] but it
doesn't tell if responder was using shared repository approach, or one
fork per person approach.

This would be a good question to ask in this year, I think...
 
[1]: https://www.survs.com/results/Q5CA9SKQ/P7DE07F0PL

-- 
Jakub Narebski

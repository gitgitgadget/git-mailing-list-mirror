From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: vcs for hefty video and graphics files
Date: Tue, 23 Nov 2010 14:41:50 -0600
Message-ID: <20101123204149.GA2373@burratino>
References: <877hg55iyd.fsf@newsguy.com>
 <icg5ia$5an$1@dough.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Philippe Lhoste <PhiLho@GMX.net>
X-From: git-owner@vger.kernel.org Tue Nov 23 21:42:23 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PKzgw-0001jm-Ih
	for gcvg-git-2@lo.gmane.org; Tue, 23 Nov 2010 21:42:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752544Ab0KWUl7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 23 Nov 2010 15:41:59 -0500
Received: from mail-vw0-f46.google.com ([209.85.212.46]:57856 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752514Ab0KWUl6 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Nov 2010 15:41:58 -0500
Received: by vws13 with SMTP id 13so4571881vws.19
        for <git@vger.kernel.org>; Tue, 23 Nov 2010 12:41:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=ysIr8tx824yLAIuZCAWKnKXArDflq8rIlA03PJn6JSk=;
        b=G0OfXI0Sl6ssQ75Mv1HKr9godDNtz2P7wdXVHc4fFog4UZzT2otObC6VfNH+O28VUO
         E7YTXRgasprEKu+pIN17OWgH4NQLAF/azwpVboPej+VUTf91XkPwc2gvTAE+zQRlQ+pN
         dCgJnCbXb8LUZ4SkOAIt7A2gA0f1t0tzif6XU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=omrBUEKHmu2r+4N5YSu43s/ZzkcGSp73tfg+HYGxOmA2Xsv+YWgyBCSIAsTHJ7/ZoN
         ttqczIZlkh36Idkr5Mfl9pep1VSidR99q5tq3p2QIb2oOx/219DctFP/i6PpEcbq4JLi
         S0F9hm+aziJE7AcbS5gtJHlV2ULlsO66nTnEc=
Received: by 10.220.94.207 with SMTP id a15mr1687102vcn.202.1290544916566;
        Tue, 23 Nov 2010 12:41:56 -0800 (PST)
Received: from burratino (adsl-68-255-106-176.dsl.chcgil.ameritech.net [68.255.106.176])
        by mx.google.com with ESMTPS id j21sm1457834vcr.10.2010.11.23.12.41.54
        (version=SSLv3 cipher=RC4-MD5);
        Tue, 23 Nov 2010 12:41:55 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <icg5ia$5an$1@dough.gmane.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/162025>

Philippe Lhoste wrote:

> Some game makers keep track of their (large) binary files, along
> with the rest of the project (source code). Rarely in isolation.
> Perforce and PlasticSCM both boast superior support of these files,
> I won't comment on these allegations (over other VCS), just having
> no experience here.

One small thing to add: for this use case, you might like git-annex[1].

It is a shame no single mailing list to follow up to was mentioned.
Hopefully the reply will get to Harry, anyway.

Regards,
Jonathan

[1] http://git-annex.branchable.com/

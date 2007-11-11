From: "Yin Ping" <pkufranky@gmail.com>
Subject: Re: [PATCH] status&commit: Teach them to show commits of modified submodules.
Date: Sun, 11 Nov 2007 14:24:55 +0800
Message-ID: <46dff0320711102224h7a14329ag27fcfcfcf479823e@mail.gmail.com>
References: <1194722863-14741-1-git-send-email-pkufranky@gmail.com>
	 <8c5c35580711101607l7c45d6f5ge0f40ac6e447031a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Lars Hjemli" <hjemli@gmail.com>
X-From: git-owner@vger.kernel.org Sun Nov 11 07:25:16 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ir6Fv-0001np-KJ
	for gcvg-git-2@gmane.org; Sun, 11 Nov 2007 07:25:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752337AbXKKGY5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 11 Nov 2007 01:24:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752190AbXKKGY5
	(ORCPT <rfc822;git-outgoing>); Sun, 11 Nov 2007 01:24:57 -0500
Received: from py-out-1112.google.com ([64.233.166.176]:50491 "EHLO
	py-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752082AbXKKGY4 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 11 Nov 2007 01:24:56 -0500
Received: by py-out-1112.google.com with SMTP id u77so549559pyb
        for <git@vger.kernel.org>; Sat, 10 Nov 2007 22:24:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=dY8Y8O4wolyQnyI6ke7uGSb63tlNp3ia1+rj85cG0js=;
        b=aqjb4jlF9sbz2ew9Xtjwas9DgxM72+7zOrVcj+b4wCBpNMIUv+IxXZJkuO53OWJmsBFpx5irQsJSkB/5dWLFC72sv92x1em7Ltlp5UIwd0m0hQ2SIB1WwLDFdR2owHLOkgHeZv/TD9Egv4y1V+fEw8rM2ztVvNOMoPcVlVzjEVQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=PR5doFsxe93vspjvlRAVzviFZ3PX4V1c2XMl69A/Rf6y6Lrs5vHwQKhnLoz1ytP/s2+9dT6iqvTiaEKRrE6hoQF8R+Au9ns82ZSi6qagrDr8C8i78sxe0F4TLyCfeGWZ8wtdp38NcncK6MZou2+5B/AIN28qY5+hqIQnEr1T3QU=
Received: by 10.35.111.14 with SMTP id o14mr4364822pym.1194762295673;
        Sat, 10 Nov 2007 22:24:55 -0800 (PST)
Received: by 10.35.108.1 with HTTP; Sat, 10 Nov 2007 22:24:55 -0800 (PST)
In-Reply-To: <8c5c35580711101607l7c45d6f5ge0f40ac6e447031a@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/64413>

On Nov 11, 2007 8:07 AM, Lars Hjemli <hjemli@gmail.com> wrote:
> On Nov 10, 2007 8:27 PM, Ping Yin <pkufranky@gmail.com> wrote:
> > This commit teaches git status/commit to also show commits of user-cared
> > modified submodules since HEAD (or HEAD^ if --amend option is on).
>
> Some nitpicks:
> -we'll need a config option to enable/disable this output in git-status
agree. default off?
> -the feature should probably be implemented in git-submodule.sh
>
I'll want to see the commits of submodules when editing commit msg. So
i implemented
this in git-commit.sh. May be a configuration/option can added to turn
this on or off.

> --
> larsh
>



-- 
Ping Yin

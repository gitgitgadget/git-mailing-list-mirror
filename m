From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH 2/6] gitweb: use_pathinfo filenames start with /
Date: Wed, 1 Oct 2008 01:49:48 +0200
Message-ID: <200810010149.48988.jnareb@gmail.com>
References: <1222030663-22540-1-git-send-email-giuseppe.bilotta@gmail.com> <200809300120.02492.jnareb@gmail.com> <cb7bb73a0809300048j7da35623m44ec9bfe7780fedb@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, "Petr Baudis" <pasky@ucw.cz>,
	"Lea Wiemann" <lewiemann@gmail.com>
To: "Giuseppe Bilotta" <giuseppe.bilotta@gmail.com>
X-From: git-owner@vger.kernel.org Wed Oct 01 01:51:24 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kkozy-00037e-Ud
	for gcvg-git-2@gmane.org; Wed, 01 Oct 2008 01:51:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754410AbYI3Xtx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 30 Sep 2008 19:49:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753585AbYI3Xtx
	(ORCPT <rfc822;git-outgoing>); Tue, 30 Sep 2008 19:49:53 -0400
Received: from ug-out-1314.google.com ([66.249.92.171]:34841 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753476AbYI3Xtw (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Sep 2008 19:49:52 -0400
Received: by ug-out-1314.google.com with SMTP id k3so712788ugf.37
        for <git@vger.kernel.org>; Tue, 30 Sep 2008 16:49:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=nskZtQqW0R5E+mgdK28nhF4KdUk1jxji7bUgaUjJGOQ=;
        b=kUUfc7/MXUqgqXTnMzAHqH0u0yF07uYSweCb/Gqs36KdHRYGRts785febkDBLkY4KZ
         0p1fZrdFF6aDXsHkV8Vf+ptFDxsCmGfcQTlWRQ8V8q/Cqko76TMijk1vpHnFc84F3qQ4
         V889Lw92B+DvJM2bcgXTcn7qTEqKSNEFFwOfQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=vtdrbyoC1rzBpjKuLP504pzjF3/yK2ns9UT3OqrLb0+vctq2v+Jl7HQJsLJZbdBoq0
         N+UymAQmX68kp1Qyx2AymsiOZgH+Do8zghLJvOVPuAa+pNJ+f2HIfoJetLrnVfHsT9/m
         mB1djGHyOKF/Dw/ohcIu+L11J9zTZQDIXdfWQ=
Received: by 10.210.109.20 with SMTP id h20mr8724829ebc.129.1222818590459;
        Tue, 30 Sep 2008 16:49:50 -0700 (PDT)
Received: from ?192.168.1.11? (abvo173.neoplus.adsl.tpnet.pl [83.8.212.173])
        by mx.google.com with ESMTPS id h1sm2034848nfh.19.2008.09.30.16.49.48
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 30 Sep 2008 16:49:49 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <cb7bb73a0809300048j7da35623m44ec9bfe7780fedb@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/97172>

On Tue, 30 Sep 2008, Giuseppe Bilotta wrote:
> On Tue, Sep 30, 2008 at 1:20 AM, Jakub Narebski <jnareb@gmail.com> wrote:
> >
> > Hn. Now I am not sure if it should be squashed, or should be separate.
> 
> Yeah. The fact that it's *specifically* to allow web docs to be used
> in raw view makes it count towarda a feature in itself, even if the
> patch by itself is trivial ...
> 
> So. Squashed or separate? :)

I'm slighty for separate, if only to avoid overly long commit message.
<commit-ish>:<filename> is understandable and expected because it is
what one uses for git-show; making <commit-ish>:/<filename> the default
because of relative links in 'blob_plain' view of HTML file requires
some further explanation.

But is is IMVHO finally your call here.
-- 
Jakub Narebski
Poland

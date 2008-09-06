From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [ANNOUNCE] yap: Yet Another (Git) Porcelain
Date: Sat, 6 Sep 2008 21:01:26 +0200
Message-ID: <200809062101.28672.jnareb@gmail.com>
References: <20080906150723.GA31540@dervierte> <m38wu5p9q4.fsf@localhost.localdomain> <e06498070809060912q2f7ed0cflb02e3efc7b81976e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
To: "Steven Walter" <stevenrwalter@gmail.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Sep 06 21:02:55 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kc33R-0000yj-WB
	for gcvg-git-2@gmane.org; Sat, 06 Sep 2008 21:02:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751896AbYIFTBf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 6 Sep 2008 15:01:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752055AbYIFTBf
	(ORCPT <rfc822;git-outgoing>); Sat, 6 Sep 2008 15:01:35 -0400
Received: from fg-out-1718.google.com ([72.14.220.156]:20858 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751532AbYIFTBe (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 6 Sep 2008 15:01:34 -0400
Received: by fg-out-1718.google.com with SMTP id 19so998786fgg.17
        for <git@vger.kernel.org>; Sat, 06 Sep 2008 12:01:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=2WfPTifRfIguhb+vKrGEiEYhJpc7526soDSNQIgQNms=;
        b=xGk8gnkci7W6gIAl6gQYOfC+as4dPNQ7c0oMQPPS4mybCbOHTW+77eeHfgRy59yrSO
         55Ux8boLGoWKsnM6DxSfeONr5liCjMvHpTfd11hJcGdt5q+cy0TAAi6RcL7U4p62C+Yn
         wkwKW6Y3moBEjiI6JfyAecEwLLWkglb50oilQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:references:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :message-id;
        b=OSSQqQKAMwHFAjSy+3+GyeSaFnUYjIEDG/rmeDrAkLK7o521NPYuDg8rrHFuUMH3NA
         RSjVnsuVmNH3NFkkyGit58PfyviwWzc8v2X5SL8hDRfQp2FJCOLIoau8S9vJju95L26x
         jKEseLq9+Fo7SnWmZqYr/wWrB/ERIEpNwbXsM=
Received: by 10.86.97.7 with SMTP id u7mr9869477fgb.29.1220727691617;
        Sat, 06 Sep 2008 12:01:31 -0700 (PDT)
Received: from ?192.168.1.11? ( [83.8.234.117])
        by mx.google.com with ESMTPS id e20sm2475095fga.1.2008.09.06.12.01.29
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 06 Sep 2008 12:01:30 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <e06498070809060912q2f7ed0cflb02e3efc7b81976e@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/95093>

[Back on git mailing list]

On Sat, 6 Sep 2008, Steven Walter wrote:
> On Sat, Sep 6, 2008 at 11:36 AM, Jakub Narebski <jnareb@gmail.com> wrote:
> >
> > First, a question: how your yap porcelain differs from efforts of
> > EasyGit (eg) and Pyrite?
> 
> In the case of EasyGit, it differs in that yap's interface does not
> have the requirement of being fully backwards-compatible with core
> git.  Dropping that requirement gave me more freedom to simplify and
> clean-up the interface.

I can understand this.  EasyGit is more about making git self
documenting than anything more, from what I understand.

> To my knowledge, Pyrite does not support plugins.

As far as I know Pyrite is one-man work.  Why not to join efforts,
bringing those two projects together?  Both share the same language,
Python.

> > And a request: could you add (short) information about your work to
> > Git Wiki: http://git.or.cz/gitwiki/InterfacesFrontendsAndTools,
> > of course in the "Version Control Interface layers" section?
> 
> Done.

Thanks.


By the way, please take into account 
  http://en.wikipedia.org/wiki/Yap_(disambiguation)

Most commonly known YAP is I think Yet Another Previewer, which is
the name of the DVI viewer included on the widely used MiKTeX TeX
distribution for the Microsoft Windows platform,

YAGP, or YA(G)P, is I think free of such conotations.
-- 
Jakub Narebski
Poland

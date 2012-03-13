From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: git push default behaviour?
Date: Tue, 13 Mar 2012 16:27:30 +0100
Message-ID: <201203131627.30455.jnareb@gmail.com>
References: <CAFsnPqp1+jX3ZY0LZ1QDmvA=2_ebApPBttwFjr36OuTX2_MHug@mail.gmail.com> <m3sjhjs4z5.fsf@localhost.localdomain> <CAFsnPqqJt13gDp2RNiEU4dt59iMwFvMzysfk51mO8aF+_nYGXA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Carlos =?iso-8859-1?q?Mart=EDn_Nieto?= <cmn@elego.de>,
	Thomas Rast <trast@inf.ethz.ch>, git@vger.kernel.org
To: Jeremy Morton <jeremy@configit.com>
X-From: git-owner@vger.kernel.org Tue Mar 13 16:27:46 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S7TdU-0005i6-1l
	for gcvg-git-2@plane.gmane.org; Tue, 13 Mar 2012 16:27:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754451Ab2CMP1f (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 Mar 2012 11:27:35 -0400
Received: from mail-wi0-f178.google.com ([209.85.212.178]:45782 "EHLO
	mail-wi0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751340Ab2CMP1e (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Mar 2012 11:27:34 -0400
Received: by wibhq7 with SMTP id hq7so1046320wib.1
        for <git@vger.kernel.org>; Tue, 13 Mar 2012 08:27:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        bh=7qFBT75tlyZg7FqNObefus+vCB/Jn+RrPvj4Lhn72Tg=;
        b=NeJToYqQ+hDk6L8ziW1b8faxNY74Vu1Drx443mNqcNTYXXNR/QatjAxLVMzBEibo2o
         hvEkeY7/hatcbWy6gEr2BA4rdPDKQNS3mglYFc56a9uDcovYnTUXiplWk5Vj54FgVnmC
         A7chhjmG5fjvWb2ij4j/8y3gwKGpBfKaX66TJHCLHersOZM7YqG1ZEJtayPD0gkgvfql
         qQwj+jXUT1MSYNGrvsZmRPRX6qTVqkG/R6gFM/8SA0bdKmTGETEPs2dTFQPXpezuUUdn
         xT5CIixkVmslvodtZq1Bp90GrmLKM7tDGwZ7GGd4lZzBRvYe2OvTFtdKGA7fAMu1kmo8
         MKDQ==
Received: by 10.180.95.129 with SMTP id dk1mr9882822wib.3.1331652453488;
        Tue, 13 Mar 2012 08:27:33 -0700 (PDT)
Received: from [192.168.1.13] (abwr197.neoplus.adsl.tpnet.pl. [83.8.241.197])
        by mx.google.com with ESMTPS id d7sm3542849wiz.6.2012.03.13.08.27.31
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 13 Mar 2012 08:27:32 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <CAFsnPqqJt13gDp2RNiEU4dt59iMwFvMzysfk51mO8aF+_nYGXA@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/193034>

On Thu, 8 Mar 2012, Jeremy Morton wrote:
> On Thu, Mar 8, 2012 at 11:33 AM, Jakub Narebski <jnareb@gmail.com> wrote:

> > You can always configure server to refuse forced pushes.
> 
> We're using github, and as far as I'm aware, there's no way to
> configure github to do that.

It would be nice if GitHub supported setting receive.denyNonFastForward
and receive.denyDeletes (the receive.*current* do not matter for GitHub).
Though I am not sure if it would not require changes to the custom Git
implementation they use...

-- 
Jakub Narebski
Poland

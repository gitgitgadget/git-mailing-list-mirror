From: "Lars Hjemli" <hjemli@gmail.com>
Subject: Re: Is there any plan to support partial checkout or submoudule improvement?
Date: Tue, 16 Oct 2007 10:08:16 +0200
Message-ID: <8c5c35580710160108s4faeaa61k7585d01703c0c8fc@mail.gmail.com>
References: <20071016032048.771557E80@mail.kooxoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: franky <yinping@kooxoo.com>
X-From: git-owner@vger.kernel.org Tue Oct 16 10:08:54 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IhhTZ-00021q-V3
	for gcvg-git-2@gmane.org; Tue, 16 Oct 2007 10:08:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755188AbXJPIIT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Oct 2007 04:08:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754355AbXJPIIT
	(ORCPT <rfc822;git-outgoing>); Tue, 16 Oct 2007 04:08:19 -0400
Received: from wa-out-1112.google.com ([209.85.146.177]:63483 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751791AbXJPIIR (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Oct 2007 04:08:17 -0400
Received: by wa-out-1112.google.com with SMTP id v27so2291268wah
        for <git@vger.kernel.org>; Tue, 16 Oct 2007 01:08:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=mVA4oiqh23feWu1LwQktXHqkfsCBtcKgIKxkRXJNcMA=;
        b=lJdmO+hvtuytDFnUg/W3qyXfnVFtbDvikE2r3toPa7aok76MRqCULwWR5L+6OLLfBNNBRSaCw0NzD7Jv8xxfZhfFjOahW+akztEtjDxTrSEvfiv8y5BvJu/i8/IapkeO37h6w6emNYen4pGCzvZ95EO+u8Okjw6NSS3Yrjyw65U=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=aaSeKdaxM/QXrLGvef52W8NlCrBJgKfn48HZv58s2OcFtjZ1hIHQ2FC+MFr8K//TiwSWYBoRx8+Q3BGCleselykE6vXE7n9akE5SGDHs3oKPsVv1lCFM/DmeIzMSOw6wZxI9/jvP++BZ9EV5RKWYiUIR83FOQ1ymLmG/4CYCtss=
Received: by 10.114.161.11 with SMTP id j11mr8098360wae.1192522096545;
        Tue, 16 Oct 2007 01:08:16 -0700 (PDT)
Received: by 10.114.235.4 with HTTP; Tue, 16 Oct 2007 01:08:16 -0700 (PDT)
In-Reply-To: <20071016032048.771557E80@mail.kooxoo.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/61113>

On 10/16/07, franky <yinping@kooxoo.com> wrote:
> 2. src, bin not submoudle, just sub directory
>         When src changes, compiled binaries are still put in bin directory.
> However, only one commit is required. Perfect? No, another problem when
> deploying. I don't want the src directory to appear in the deployment
> directory.

If this is just for deployment of your bin directory, you can try

$ cd Project/bin
$ git archive --prefix='Project/bin/' HEAD | gzip > Project-x.y.tar.gz

--
larsh

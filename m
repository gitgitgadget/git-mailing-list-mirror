From: "Avery Pennarun" <apenwarr@gmail.com>
Subject: Re: move git repository out of a folder?
Date: Wed, 4 Jun 2008 16:08:57 -0400
Message-ID: <32541b130806041308y43a18b50s5dbca61f96a52823@mail.gmail.com>
References: <1086fb5f0806041303v7856404dxb95b5a450ac30ae1@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: seanmichaelbrown@gmail.com
X-From: git-owner@vger.kernel.org Wed Jun 04 22:10:11 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K3zJ8-0004nT-SA
	for gcvg-git-2@gmane.org; Wed, 04 Jun 2008 22:10:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756965AbYFDUI7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 Jun 2008 16:08:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756306AbYFDUI7
	(ORCPT <rfc822;git-outgoing>); Wed, 4 Jun 2008 16:08:59 -0400
Received: from fk-out-0910.google.com ([209.85.128.186]:36269 "EHLO
	fk-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755240AbYFDUI6 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Jun 2008 16:08:58 -0400
Received: by fk-out-0910.google.com with SMTP id 18so193527fkq.5
        for <git@vger.kernel.org>; Wed, 04 Jun 2008 13:08:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=Wj9MfNCeum2M0OPIM4KoRVLKrUTW2oSifz58OTkdYeY=;
        b=wF0IiJRnPrQ5XBl4mjeYv2lLWmsY1zDr4NKwHJ0MmknmfrMt5UR4QGTzUwxCwBZcYP
         BbzsD1JCKwEnKgQraP1fObDoe07exCIgZSBDBiIESgqxXtRE79dd4CgHYu7/0fd+Gigw
         gSOPASq0zd3oywKdPU6SoX9Sr0vfrH7qhaCY8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=plBo31VSeFTw17wYhTPhuMNdh14I75PttbcpeOB1ArBVB1SeMmlaUiD/ITpUSRtfOI
         TKDdyQI6dYV6eJr+CCJs7zWWdQhXtDQnljU27afpis4YhCUd9qyPn5RHKNUIjiLNxzbd
         wg555PVyshB53x9pOKDFW4mo0OZsMJcOVV/ho=
Received: by 10.82.107.3 with SMTP id f3mr29251buc.65.1212610137392;
        Wed, 04 Jun 2008 13:08:57 -0700 (PDT)
Received: by 10.82.100.5 with HTTP; Wed, 4 Jun 2008 13:08:57 -0700 (PDT)
In-Reply-To: <1086fb5f0806041303v7856404dxb95b5a450ac30ae1@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/83821>

On 6/4/08, Sean Brown <seanmichaelbrown@gmail.com> wrote:
>  So now when colleagues clone my repository, they get the source code
>  in the "sourcecode" folder.  I'd like to just make the repository
>  simply give them the source files, not in a directory.  In other
>  words, as if I had originally been smart and done this:
>
>  cd /folderA/sourcecode
>  git init
>
>  Can I make that happen without losing all of the history?

You could just make a commit which renames all the files into the
parent folder.  This is relatively harmless and correctly reflects
what really happened.

You might also want to look at git-filter-branch and its
"--subdirectory-filter" option.

Have fun,

Avery

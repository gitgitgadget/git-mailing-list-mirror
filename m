From: Frank Li <lznuaa@gmail.com>
Subject: Re: [PATCH 04/11] Add _MSC_VER predefine macro to make same behaviors 
	with __MINGW32__ Enable MSVC build. MSVC have the save behaviors with 
	msysgit.
Date: Tue, 18 Aug 2009 09:29:39 +0800
Message-ID: <1976ea660908171829se49abf0j5b7d45a74e4c67a7@mail.gmail.com>
References: <1250524872-5148-1-git-send-email-lznuaa@gmail.com>
	 <1250524872-5148-2-git-send-email-lznuaa@gmail.com>
	 <1250524872-5148-3-git-send-email-lznuaa@gmail.com>
	 <1250524872-5148-4-git-send-email-lznuaa@gmail.com>
	 <alpine.DEB.1.00.0908171835590.4991@intel-tinevez-2-302>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, msysgit@googlegroups.com
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue Aug 18 03:29:51 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MdDWG-0001hu-Tr
	for gcvg-git-2@lo.gmane.org; Tue, 18 Aug 2009 03:29:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758559AbZHRB3k (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Aug 2009 21:29:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758533AbZHRB3k
	(ORCPT <rfc822;git-outgoing>); Mon, 17 Aug 2009 21:29:40 -0400
Received: from mail-qy0-f196.google.com ([209.85.221.196]:41361 "EHLO
	mail-qy0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753104AbZHRB3j (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Aug 2009 21:29:39 -0400
Received: by qyk34 with SMTP id 34so2489353qyk.33
        for <git@vger.kernel.org>; Mon, 17 Aug 2009 18:29:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=Ta4Oygv4bJh3tKUfFqvYeW2rZpJef7Zw358ZePD1OWE=;
        b=BWBj73UVGd8t/Vg8D7l0+V/6BApzfP4DEw7OBwZA9ypl33I2+pl7QEU2wSNb5fG1By
         JfNn/Gy5hn4dyOVKXbWb7DiJLnCqcuEkRO6F169b9Jzw5EeZztSw+rmdMY+Co7JUgQ2e
         0BTC1M5Urudsd0YlZmvylfPPVdSHda/msq3zQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=m3FCx5JSv619D/QsAL5NiUC9VrGb3cdw+BCM3CZoEcVmER/iM7fZa4V1UxHgm246Uw
         imb57QVsn9x+1iEwN8l+Sg9BP6ahsD0siVTvBDD5u/yGnp+PtEAqqyew4dejxU9yLrxH
         NXzNxffLnJRKQ85mp5LePcVJhHFbZnMOx126Y=
Received: by 10.224.42.131 with SMTP id s3mr4900136qae.111.1250558980038; Mon, 
	17 Aug 2009 18:29:40 -0700 (PDT)
In-Reply-To: <alpine.DEB.1.00.0908171835590.4991@intel-tinevez-2-302>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/126336>

>
> 	Test whether WIN32 is defined rather than __MINGW32__

I think WIN32 is better, how about 64bit build case?
In 64bit environment, VC define WIN64 not WIN32.

From: Dmitry Potapov <dpotapov@gmail.com>
Subject: Re: Cross-Platform Version Control
Date: Tue, 12 May 2009 22:28:28 +0400
Message-ID: <20090512182828.GA26812@dpotapov.dyndns.org>
References: <419AD153-53B4-4DAB-AF72-4127C17B1CA0@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Esko Luontola <esko.luontola@gmail.com>
X-From: git-owner@vger.kernel.org Tue May 12 20:30:31 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M3wkI-0003JA-Be
	for gcvg-git-2@gmane.org; Tue, 12 May 2009 20:30:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753787AbZELS3o (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 May 2009 14:29:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753233AbZELS3o
	(ORCPT <rfc822;git-outgoing>); Tue, 12 May 2009 14:29:44 -0400
Received: from fg-out-1718.google.com ([72.14.220.154]:16425 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752796AbZELS3n (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 May 2009 14:29:43 -0400
Received: by fg-out-1718.google.com with SMTP id 16so51785fgg.17
        for <git@vger.kernel.org>; Tue, 12 May 2009 11:29:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=IS0BqYHjC/hnD5byERWINIl6WswB0Z8t68+M2mhv2r0=;
        b=cb+Est+dojUnH2wfLlOUmam+r3IvSU7iDCGMO+GNgBmGR2Om/b86u/29tFIr+AvAwp
         eVlxlA+XiALtlgT+NQ5A69GLvJUu4djpL0Cy5CaXmRMcLOVCaHOdLXbzwJuJBG46ek1R
         dVBoOs5Y+ePTHqVcaFGkxP/niZwZ4o2IgPIoU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=K0q8txFyDlfUDuENch911WaBwTCvVdLM+iK3bGdUprpKiHpm5u3LFcj6+0XWCJ+8j3
         Tfpw/mx/xkWpl5ZOqWWc6OqjmfUqNnElO181sA5POKai9tqja9wpFqoLEGtXb5iNedAu
         sGUflA2scQ9o1uyzqwGzF3HykgapyGCPCWHYo=
Received: by 10.86.92.9 with SMTP id p9mr194143fgb.15.1242152982945;
        Tue, 12 May 2009 11:29:42 -0700 (PDT)
Received: from localhost (ppp91-76-16-205.pppoe.mtu-net.ru [91.76.16.205])
        by mx.google.com with ESMTPS id d4sm326587fga.24.2009.05.12.11.29.41
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 12 May 2009 11:29:42 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <419AD153-53B4-4DAB-AF72-4127C17B1CA0@gmail.com>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/118942>

On Tue, May 12, 2009 at 06:06:05PM +0300, Esko Luontola wrote:
> A good start for making Git cross-platform, would be storing the text  
> encoding of every file name and commit message together with the commit. 
> Currently, because Git is oblivious to the encodings and just considers 
> them as a series of bytes, there is no way to make them cross-platform. 

1. Git already stores the endcoding for all commit messages that are not
   in UTF-8.

2. If you really want to be cross-platform portable, you should not use
   any characters in filenames outside of [A-Za-z0-9._-] (i.e. Portable
   Filename Character Set)
   http://www.opengroup.org/onlinepubs/000095399/basedefs/xbd_chap03.html#tag_03_276


Dmitry

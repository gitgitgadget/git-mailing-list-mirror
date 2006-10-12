From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH] Removes the <?xml?> declaration from gitweb.pl
Date: Thu, 12 Oct 2006 23:21:17 +0200
Message-ID: <200610122321.18630.jnareb@gmail.com>
References: <20061011172553.GA1147@linux-mips.org> <egjnk5$bpn$2@sea.gmane.org> <200610120745.00909.robin.rosenberg.lists@dewire.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Oct 12 23:51:06 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GY7zV-0001Ir-2W
	for gcvg-git@gmane.org; Thu, 12 Oct 2006 23:21:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751012AbWJLVVS (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 12 Oct 2006 17:21:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751021AbWJLVVS
	(ORCPT <rfc822;git-outgoing>); Thu, 12 Oct 2006 17:21:18 -0400
Received: from ug-out-1314.google.com ([66.249.92.172]:37269 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1751010AbWJLVVR (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Oct 2006 17:21:17 -0400
Received: by ug-out-1314.google.com with SMTP id o38so369545ugd
        for <git@vger.kernel.org>; Thu, 12 Oct 2006 14:21:15 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-disposition:content-type:content-transfer-encoding:message-id;
        b=VVGbk35IBKZUCpp7tH6GoeVg9cg9yBAjn0hKC4KMG9H+7z6MvJojlYSk6ze7p3ieCTuvTkPALLDxAiNczarzT9F/BqhoOP/JAhNhTSEm861mrCx8fe1n//3X44EgsaJZJfK7dShuPqrTms7I+hWdl0f8sFUjZxrTEBO2McAsjvs=
Received: by 10.67.121.15 with SMTP id y15mr3346464ugm;
        Thu, 12 Oct 2006 14:21:15 -0700 (PDT)
Received: from host-81-190-17-207.torun.mm.pl ( [81.190.17.207])
        by mx.google.com with ESMTP id o1sm147957uge.2006.10.12.14.21.14;
        Thu, 12 Oct 2006 14:21:14 -0700 (PDT)
To: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
User-Agent: KMail/1.9.3
In-Reply-To: <200610120745.00909.robin.rosenberg.lists@dewire.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/28801>

Robin Rosenberg wrote:
> onsdag 11 oktober 2006 23:27 skrev Jakub Narebski:
> > Pazu wrote:
> > > The XML declaration forces IE6 into quirks mode, breaking our
> > > nice standards compliant stylesheet.
> >
> > But isn't it _required_ by XML/XHTML?
> 
> For pure XML document it is required, but not for XHTML, unless the encoding 
> is something other than UTF-8 or (shudder) UTF-16. W3C recommends it though.

So what should be our decision? Honor IE quirks ;-) and either remove
XML declaration, or use Transitional DTD? Add back SPC to &nbsp; conversion
in esc_html? Ignore broken browsers?
-- 
Jakub Narebski
Poland

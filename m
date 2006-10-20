From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: VCS comparison table
Date: Fri, 20 Oct 2006 15:26:42 +0200
Message-ID: <200610201526.42811.jnareb@gmail.com>
References: <Pine.LNX.4.64.0610171605440.3962@g5.osdl.org> <20061019123349.GE20017@pasky.or.cz> <200610201350.12273.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Matthieu Moy <Matthieu.Moy@imag.fr>, Andreas Ericsson <ae@op5.se>,
	"Matthew D. Fuller" <fullermd@over-yonder.net>,
	bazaar-ng@lists.canonical.com, Linus Torvalds <torvalds@osdl.org>,
	Carl Worth <cworth@cworth.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Oct 20 15:26:50 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GauOb-0002fC-2c
	for gcvg-git@gmane.org; Fri, 20 Oct 2006 15:26:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946201AbWJTN0m (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 20 Oct 2006 09:26:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946221AbWJTN0m
	(ORCPT <rfc822;git-outgoing>); Fri, 20 Oct 2006 09:26:42 -0400
Received: from ug-out-1314.google.com ([66.249.92.168]:45759 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1946201AbWJTN0l (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Oct 2006 09:26:41 -0400
Received: by ug-out-1314.google.com with SMTP id o38so742034ugd
        for <git@vger.kernel.org>; Fri, 20 Oct 2006 06:26:40 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=Kt9wapAwyFSdUROp3miBzB2LZfk8hgZ2cjLhWtqLyv3xP2Mao77Ww+caLndfTgS9X2K+xG4xWV9vnkmPGzJSVzJf0x+DNxGAcJn1qFlAT6ZUOSKEV6AsyBkL66SiDT8ekxb2bF9hRq0QyrKl12HLjfqBV+//BnqfQLl1FUCktKQ=
Received: by 10.67.119.5 with SMTP id w5mr1858360ugm;
        Fri, 20 Oct 2006 06:26:39 -0700 (PDT)
Received: from host-81-190-23-110.torun.mm.pl ( [81.190.23.110])
        by mx.google.com with ESMTP id l33sm1417707ugc.2006.10.20.06.26.38;
        Fri, 20 Oct 2006 06:26:39 -0700 (PDT)
To: Petr Baudis <pasky@suse.cz>
User-Agent: KMail/1.9.3
In-Reply-To: <200610201350.12273.jnareb@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/29464>

Jakub Narebski wrote:
> Second, git-diff with only one <commit-ish> generates diff to first
> parent. But you can always use '-c' or '-cc' combined diff format
> or '-m' with default diff format to compare to _all_ parents.

I stand corrected: git-diff refuses to show anything if provided
with only one commit, and commit has more than one parent. So it
does not reat first parent specially.
-- 
Jakub Narebski
Poland

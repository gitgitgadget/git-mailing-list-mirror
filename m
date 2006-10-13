From: Luben Tuikov <ltuikov@yahoo.com>
Subject: Re: [PATCH] git-revert with conflicts to behave as git-merge with conflicts
Date: Thu, 12 Oct 2006 17:31:20 -0700 (PDT)
Message-ID: <20061013003120.98769.qmail@web31813.mail.mud.yahoo.com>
References: <7vvempjcwy.fsf@assigned-by-dhcp.cox.net>
Reply-To: ltuikov@yahoo.com
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Oct 13 02:38:18 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GYAxR-0000rR-OF
	for gcvg-git@gmane.org; Fri, 13 Oct 2006 02:31:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751386AbWJMAbW (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 12 Oct 2006 20:31:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751385AbWJMAbW
	(ORCPT <rfc822;git-outgoing>); Thu, 12 Oct 2006 20:31:22 -0400
Received: from web31813.mail.mud.yahoo.com ([68.142.207.76]:64609 "HELO
	web31813.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1751382AbWJMAbV (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Oct 2006 20:31:21 -0400
Received: (qmail 98771 invoked by uid 60001); 13 Oct 2006 00:31:20 -0000
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:Received:Date:From:Reply-To:Subject:To:Cc:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=pQtq/p5lFV2lP0cMQnfTyklPXMcxqZZ+cCUXdx7YhuxP40MRSpsknx1CEZbMEeQ3pImdDn0L4F8N4Cxo6T3cBDv6UKUj4NyHjiFwM5SFdpk7beHN6VWFRdmHy9W90+h7YMZWGTTejMqQ4/GGXt5ow6xMv8OGopUZLIBBuN+vMkw=  ;
Received: from [64.215.88.90] by web31813.mail.mud.yahoo.com via HTTP; Thu, 12 Oct 2006 17:31:20 PDT
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vvempjcwy.fsf@assigned-by-dhcp.cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/28823>

--- Junio C Hamano <junkio@cox.net> wrote:
> Luben Tuikov <ltuikov@yahoo.com> writes:
> 
> >> If you rely on MERGE_MSG then you would need to clean it after
> >> commit is done.  Currently it does not and checks MERGE_HEAD,
> >> and cleans up MERGE_HEAD when it is done.  MERGE_MSG is not
> >> cleaned.
> >
> > It is cleaned in the lines of the patch you deleted, the section
> > just after the "elif" above:
> 
> Ok, so I can apply that original one with your 'Oops' rolled
> into one patch?

Yes please.

    Luben

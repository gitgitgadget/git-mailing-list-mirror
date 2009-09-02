From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: What's cooking in git.git (Aug 2009, #06; Sun, 30)
Date: Wed, 2 Sep 2009 19:44:56 +0200
Message-ID: <200909021944.59576.jnareb@gmail.com>
References: <7viqg48nxi.fsf@alter.siamese.dyndns.org> <m37hwili5q.fsf@localhost.localdomain> <7vtyzmliai.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Sep 02 19:45:53 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mittd-00031U-Cb
	for gcvg-git-2@lo.gmane.org; Wed, 02 Sep 2009 19:45:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753134AbZIBRpK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 2 Sep 2009 13:45:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753131AbZIBRpK
	(ORCPT <rfc822;git-outgoing>); Wed, 2 Sep 2009 13:45:10 -0400
Received: from fg-out-1718.google.com ([72.14.220.157]:23537 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752920AbZIBRpJ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Sep 2009 13:45:09 -0400
Received: by fg-out-1718.google.com with SMTP id 22so1166805fge.1
        for <git@vger.kernel.org>; Wed, 02 Sep 2009 10:45:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=us0++IcvaX2S0DXQl6rCo7B19GskQebEH8rdgU2Zrac=;
        b=kGGac5kD8K5AXWkm7J1FNT8GLhlL0WdVr+n5FGIRlxoG2v5FY2zuadFF+7wsiW1bjk
         NBI3i2+cM/ft1Ip4X6OwO8kEBTBSPEdQ6atVHrOcV8c5+lhYnDJTt0flDI/+0XSUdTtJ
         e8LJMA6b2DmWkk/xzHXf0HeK0dAQuj7sFsCPs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=Q4nNbszT6zFLDHcRlJnzfvI9opmv4HSHe8ZmGT9Q/aPY3n4DthTeVpn74YULMERn7I
         qYvDLatCiKxKj04api/i6sq1SG0LDoO6UFrpV08fHvcV9SWpmG5GWwOFc6s8XSAiK+Ml
         4rt1aawHvtxBblDWK9aMQKQHEyY/bAENenS84=
Received: by 10.86.12.35 with SMTP id 35mr2884302fgl.20.1251913510592;
        Wed, 02 Sep 2009 10:45:10 -0700 (PDT)
Received: from ?192.168.1.13? (abwf169.neoplus.adsl.tpnet.pl [83.8.229.169])
        by mx.google.com with ESMTPS id l19sm350259fgb.28.2009.09.02.10.45.08
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 02 Sep 2009 10:45:08 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <7vtyzmliai.fsf@alter.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/127611>

On Tue, 1 Sep 2009, Junio C Hamano wrote:
> Jakub Narebski <jnareb@gmail.com> writes:
> 
> > There is replacement series sent to git mailing list a little while
> > ago.  
> 
> Thanks; I've replaced and pushed them out on 'pu' for now.  Will hopefully
> start merging earlier parts to 'next', but how widely is Hires available?

Well, if someone wants to have _optional_ 'timed' feature, ha/she can
install Time::HiRes module.  I think that it is not in Perl core, but
there are RPM and deb packages with Time::HiRes available in extras.
If module is not installed, then only 'timed' feature is not available.


P.S. "Naming is the hardest thing"; should this feature be named 'timed',
or do any of you have some better name for it?

P.P.S. Originally the part about "time to generate page" was for me to be
able to benchmark new code... but then I realized that benchmarking 
'blame_incremental' view on single-core computer, where server process
and AJAX-y JavaScript competes for CPU doesn't a good benchmark make.
Still, this part can be useful.

-- 
Jakub Narebski
Poland

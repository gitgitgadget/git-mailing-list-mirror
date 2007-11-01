From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH] gitweb: Remove CGI::Carp::set_programname() call from t9500 gitweb test
Date: Fri, 2 Nov 2007 00:36:11 +0100
Message-ID: <200711020036.12715.jnareb@gmail.com>
References: <1193923396-17341-1-git-send-email-jnareb@gmail.com> <7vve8l8va0.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Nov 02 00:36:41 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Injaa-00005g-N4
	for gcvg-git-2@gmane.org; Fri, 02 Nov 2007 00:36:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754726AbXKAXg0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 1 Nov 2007 19:36:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754719AbXKAXg0
	(ORCPT <rfc822;git-outgoing>); Thu, 1 Nov 2007 19:36:26 -0400
Received: from ug-out-1314.google.com ([66.249.92.171]:34918 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753290AbXKAXgZ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 Nov 2007 19:36:25 -0400
Received: by ug-out-1314.google.com with SMTP id z38so562868ugc
        for <git@vger.kernel.org>; Thu, 01 Nov 2007 16:36:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        bh=G61ouDt+bStao3O6EqjHPOxUOs/4SuzLoXGTygrX/m8=;
        b=K30c5r9tfS76V2mnMgQhLO67n6AlDKfYFSMo0TFeo/+f4GgH9q6z2t488uGeK2SxjOlYsNIYM9WiP7Fm9xko2/cFv98Dw5wJ1p4CmYbMDHsydBIUi3KmrPkzgrJD00/DBLNsHcNur1lqRrbwW3Cmf3CqKnGyuFaYLGpm2wbddj8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=gToQeWoHTwGxpIMl21QoSF3+kGYlwvyclv8DUCRjWCWOWkRDLmFs2WVnJ9EzjDacezDktmoo2fdahMu4IW1RYrbPMg65q0YUlItoKwwcuQS/c7EpweljlADT4iDhgMrwe2kkSpbiJLWlsBHU2XZ1xEr0OSSD+X7BgJOyJh2OFVY=
Received: by 10.67.100.12 with SMTP id c12mr677930ugm.1193960183977;
        Thu, 01 Nov 2007 16:36:23 -0700 (PDT)
Received: from ?192.168.1.11? ( [83.8.214.154])
        by mx.google.com with ESMTPS id c22sm2873996ika.2007.11.01.16.36.20
        (version=SSLv3 cipher=OTHER);
        Thu, 01 Nov 2007 16:36:21 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <7vve8l8va0.fsf@gitster.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/63034>

Junio C Hamano wrote:
> Jakub Narebski <jnareb@gmail.com> writes:
> 
>> It does appear to do nothing; gitweb is run as standalone program
>> and not as CGI script in this test.  This call caused problems later.
> 
> Care to describe "later problems" a bit more?

Sorry about that. The problems were while creating yet-to-be send
patch
  "gitweb: Add tests for overriding gitweb config with repo config"
Perhaps not in the current version. I forgot details.

Perhaps last sentence "This call caused problems later." should be
simply removed from commit message.

-- 
Jakub Narebski
Poland

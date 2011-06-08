From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 04/19] teach remote-testgit to import non-HEAD refs
Date: Wed, 8 Jun 2011 14:30:49 -0500
Message-ID: <20110608193049.GG27715@elie>
References: <1307558930-16074-1-git-send-email-srabbelier@gmail.com>
 <1307558930-16074-5-git-send-email-srabbelier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, Git List <git@vger.kernel.org>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Ramkumar Ramachandra <artagnon@gmail.com>
To: Sverre Rabbelier <srabbelier@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jun 08 21:31:19 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QUOTG-0002rm-J0
	for gcvg-git-2@lo.gmane.org; Wed, 08 Jun 2011 21:31:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756046Ab1FHTa5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 8 Jun 2011 15:30:57 -0400
Received: from mail-vw0-f46.google.com ([209.85.212.46]:45927 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755444Ab1FHTay (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 Jun 2011 15:30:54 -0400
Received: by vws1 with SMTP id 1so630893vws.19
        for <git@vger.kernel.org>; Wed, 08 Jun 2011 12:30:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=LR/672sLinXQFK6F96nmrepUurL5M28gyzrQVN83kz8=;
        b=owFRTUL0OXbR3if9/DonM3CJI65djrWg1PcaT/cUbgr/GDAPr4Zjd7QEXwtI6hX9TY
         /2VBDWWtm2Voiro++MPXA/QLFREQOlEZZsB9+D8T26x39Yl/iPpIS5HrMWQ/+1G2OFSm
         IFYVAMxsrnUHRcqAujYXZj4yeWheR7qdGpOwo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=bt3h0tKJAFAdCNKtICksDhkOGIWzzMlXIiX2ABF2cELjMXf1+ABbHXe8T4KfI9jyen
         O8H0zEXfwZ9ltUpIO17+A58J3OBCFLtFjbsWaEiF1XXN+2NuW+syFKyMtLEr2o0vETgz
         pbc/E1EgJ0cyqmi762zitHp23ycFBLrjGAZKg=
Received: by 10.220.94.147 with SMTP id z19mr2980066vcm.18.1307561453894;
        Wed, 08 Jun 2011 12:30:53 -0700 (PDT)
Received: from elie (adsl-69-209-61-87.dsl.chcgil.sbcglobal.net [69.209.61.87])
        by mx.google.com with ESMTPS id t10sm126068vci.17.2011.06.08.12.30.52
        (version=SSLv3 cipher=OTHER);
        Wed, 08 Jun 2011 12:30:53 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1307558930-16074-5-git-send-email-srabbelier@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/175448>

Sverre Rabbelier wrote:

>   Unchanged from Peff's series.

Looks good.  What happened to Peff's signoff?

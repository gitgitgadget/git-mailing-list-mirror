X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Salikh Zakirov <Salikh.Zakirov@Intel.com>
Subject: Re: [PATCH] Make git-commit cleverer - have it figure out whether
 it needs -a automatically
Date: Thu, 30 Nov 2006 18:43:53 +0300
Message-ID: <ekmu7u$ddh$1@sea.gmane.org>
References: <fcaeb9bf0611300532x77c7fc8aq2ba77ff57b81cc05@mail.gmail.com> <200611301501.43436.andyparkins@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Thu, 30 Nov 2006 15:45:42 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Injected-Via-Gmane: http://gmane.org/
Original-Lines: 9
Original-X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: msfwpr01.ims.intel.com
User-Agent: Thunderbird 1.5.0.8 (Windows/20061025)
In-Reply-To: <200611301501.43436.andyparkins@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/32756>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Gpo68-00074A-I7 for gcvg-git@gmane.org; Thu, 30 Nov
 2006 16:45:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1030593AbWK3Pox (ORCPT <rfc822;gcvg-git@m.gmane.org>); Thu, 30 Nov 2006
 10:44:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030594AbWK3Pox
 (ORCPT <rfc822;git-outgoing>); Thu, 30 Nov 2006 10:44:53 -0500
Received: from main.gmane.org ([80.91.229.2]:57513 "EHLO ciao.gmane.org") by
 vger.kernel.org with ESMTP id S1030593AbWK3Pow (ORCPT
 <rfc822;git@vger.kernel.org>); Thu, 30 Nov 2006 10:44:52 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43) id
 1Gpo5L-0006sD-8U for git@vger.kernel.org; Thu, 30 Nov 2006 16:44:27 +0100
Received: from msfwpr01.ims.intel.com ([62.118.80.132]) by main.gmane.org
 with esmtp (Gmexim 0.1 (Debian)) id 1AlnuQ-0007hv-00 for
 <git@vger.kernel.org>; Thu, 30 Nov 2006 16:44:27 +0100
Received: from Salikh.Zakirov by msfwpr01.ims.intel.com with local (Gmexim
 0.1 (Debian)) id 1AlnuQ-0007hv-00 for <git@vger.kernel.org>; Thu, 30 Nov 2006
 16:44:27 +0100
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

Andy Parkins wrote:
> Raimund Bauer offered this suggestion (paraphrased):
> 
> "Maybe we could do git-commit -a  _only_ if the index matches HEAD, and
> otherwise keep current behavior?  So people who don't care about the
> index won't get tripped up, and when you do have a dirty index, you get
> told about it?"

Brilliant solution!

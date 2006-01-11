From: Chuck Lever <cel@citi.umich.edu>
Subject: Re: [PATCH] stgit: fix clone
Date: Wed, 11 Jan 2006 17:47:15 -0500
Organization: Network Appliance, Inc.
Message-ID: <43C58AF3.10606@citi.umich.edu>
References: <1137017966.10975.8.camel@dv> <43C58916.6030409@citi.umich.edu>
Reply-To: cel@citi.umich.edu
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------040002000203010003010908"
Cc: Pavel Roskin <proski@gnu.org>,
	Catalin Marinas <catalin.marinas@gmail.com>,
	git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Jan 11 23:47:33 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EwokT-00058K-JG
	for gcvg-git@gmane.org; Wed, 11 Jan 2006 23:47:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932482AbWAKWrS (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 11 Jan 2006 17:47:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932491AbWAKWrS
	(ORCPT <rfc822;git-outgoing>); Wed, 11 Jan 2006 17:47:18 -0500
Received: from mx1.netapp.com ([216.240.18.38]:1377 "EHLO mx1.netapp.com")
	by vger.kernel.org with ESMTP id S932482AbWAKWrR (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 11 Jan 2006 17:47:17 -0500
Received: from smtp1.corp.netapp.com ([10.57.156.124])
  by mx1.netapp.com with ESMTP; 11 Jan 2006 14:47:18 -0800
X-IronPort-AV: i="3.99,357,1131350400"; 
   d="vcf'?scan'208"; a="282880848:sNHT22330592"
Received: from svlexc02.hq.netapp.com (svlexc02.corp.netapp.com [10.57.157.136])
	by smtp1.corp.netapp.com (8.13.1/8.13.1/NTAP-1.6) with ESMTP id k0BMlHiJ024375;
	Wed, 11 Jan 2006 14:47:17 -0800 (PST)
Received: from exsvl02.hq.netapp.com ([10.56.8.60]) by svlexc02.hq.netapp.com with Microsoft SMTPSVC(5.0.2195.6713);
	 Wed, 11 Jan 2006 14:47:17 -0800
Received: from [10.98.28.98] ([10.98.28.98]) by exsvl02.hq.netapp.com with Microsoft SMTPSVC(6.0.3790.1830);
	 Wed, 11 Jan 2006 14:47:16 -0800
User-Agent: Mozilla Thunderbird 1.0 (Windows/20041206)
X-Accept-Language: en-us, en
To: cel@citi.umich.edu
In-Reply-To: <43C58916.6030409@citi.umich.edu>
X-OriginalArrivalTime: 11 Jan 2006 22:47:16.0344 (UTC) FILETIME=[F8836F80:01C61700]
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/14521>

This is a multi-part message in MIME format.
--------------040002000203010003010908
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Chuck Lever wrote:
> hi pavel-
> 
> exactly where does the clone operation fail?  is it at the checkout step?
> 
> seems to me the "git clone" script should create an environment where 
> "git-rev-parse --git-dir" ought to work correctly.

oops.  i see it now.

stgit/main.py does a special stack.Series('master') just for the clone 
command.  it really shouldn't do this -- the crt_series.init() in the 
clone command ought to be fixed to do this properly.

catalin, do you agree?

--------------040002000203010003010908
Content-Type: text/x-vcard; charset=utf-8;
 name="cel.vcf"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="cel.vcf"

begin:vcard
fn:Chuck Lever
n:Lever;Charles
org:Network Appliance, Incorporated;Open Source NFS Client Development
adr:535 West William Street, Suite 3100;;Center for Information Technology Integration;Ann Arbor;MI;48103-4943;USA
email;internet:cel@citi.umich.edu
title:Member of Technical Staff
tel;work:+1 734 763-4415
tel;fax:+1 734 763 4434
tel;home:+1 734 668-1089
x-mozilla-html:FALSE
url:http://troy.citi.umich.edu/u/cel/
version:2.1
end:vcard


--------------040002000203010003010908--

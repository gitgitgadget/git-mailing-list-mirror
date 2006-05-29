From: "Zakirov, Salikh" <salikh.zakirov@intel.com>
Subject: RE: [PATCH] git-receive-pack needs to set umask(2)
Date: Mon, 29 May 2006 16:07:31 +0400
Message-ID: <E124AAE027DA384D8B919F93E4D8C70801F3FAFC@mssmsx402nb>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Cc: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon May 29 14:07:41 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FkgX6-00008q-Pz
	for gcvg-git@gmane.org; Mon, 29 May 2006 14:07:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750910AbWE2MHi (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 29 May 2006 08:07:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751034AbWE2MHi
	(ORCPT <rfc822;git-outgoing>); Mon, 29 May 2006 08:07:38 -0400
Received: from mga02.intel.com ([134.134.136.20]:39768 "EHLO
	orsmga101-1.jf.intel.com") by vger.kernel.org with ESMTP
	id S1750910AbWE2MHh convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 29 May 2006 08:07:37 -0400
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga101-1.jf.intel.com with ESMTP; 29 May 2006 05:07:37 -0700
Received: from fmsmsx332.fm.intel.com (HELO fmsmsx332.amr.corp.intel.com) ([132.233.42.148])
  by orsmga001.jf.intel.com with ESMTP; 29 May 2006 05:07:37 -0700
X-IronPort-AV: i="4.05,184,1146466800"; 
   d="scan'208"; a="42805895:sNHT17155110"
Received: from fmsmsx312.amr.corp.intel.com ([132.233.42.227]) by fmsmsx332.amr.corp.intel.com with Microsoft SMTPSVC(6.0.3790.1830);
	 Mon, 29 May 2006 05:07:36 -0700
Received: from mssmsx402.ccr.corp.intel.com ([10.125.2.12]) by fmsmsx312.amr.corp.intel.com with Microsoft SMTPSVC(6.0.3790.1830);
	 Mon, 29 May 2006 05:07:35 -0700
Content-class: urn:content-classes:message
X-MimeOLE: Produced By Microsoft Exchange V6.5
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH] git-receive-pack needs to set umask(2)
Thread-Index: AcaDE7zgfUKNjYb2SguCCNeNMo7g3QABHu7A
To: <spearce@spearce.org>
X-OriginalArrivalTime: 29 May 2006 12:07:36.0213 (UTC) FILETIME=[792DB450:01C68318]
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/20944>

Thanks a lot, that works!

Shawn wrote:
>
> > Could you please elaborate on what does it mean "make it shared"?
> 
> Try setting 'core.sharedRepository' to true:
> 
> 
> 	git repo-config core.sharedRepository true
> 
> and running your chmod script one last time.  See
> Documentation/config.txt for some details on this switch.

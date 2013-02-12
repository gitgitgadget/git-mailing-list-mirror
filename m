From: "Olsen, Alan R" <alan.r.olsen@intel.com>
Subject: RE: Fetch and -t
Date: Tue, 12 Feb 2013 18:28:39 +0000
Message-ID: <4B2793BF110AAB47AB0EE7B9089703854FEE45E9@fmsmsx110.amr.corp.intel.com>
References: <4B2793BF110AAB47AB0EE7B9089703854FEE40B6@fmsmsx110.amr.corp.intel.com>
 <7v621yjmla.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Feb 12 19:29:13 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U5KbN-00029B-9Q
	for gcvg-git-2@plane.gmane.org; Tue, 12 Feb 2013 19:29:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933560Ab3BLS2p (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 Feb 2013 13:28:45 -0500
Received: from mga09.intel.com ([134.134.136.24]:25739 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933421Ab3BLS2p convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 12 Feb 2013 13:28:45 -0500
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga102.jf.intel.com with ESMTP; 12 Feb 2013 10:27:24 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.84,650,1355126400"; 
   d="scan'208";a="261633885"
Received: from fmsmsx104.amr.corp.intel.com ([10.19.9.35])
  by orsmga001.jf.intel.com with ESMTP; 12 Feb 2013 10:28:41 -0800
Received: from fmsmsx101.amr.corp.intel.com (10.19.9.52) by
 FMSMSX104.amr.corp.intel.com (10.19.9.35) with Microsoft SMTP Server (TLS) id
 14.1.355.2; Tue, 12 Feb 2013 10:28:41 -0800
Received: from FMSMSX110.amr.corp.intel.com ([169.254.12.199]) by
 FMSMSX101.amr.corp.intel.com ([169.254.1.203]) with mapi id 14.01.0355.002;
 Tue, 12 Feb 2013 10:28:41 -0800
Thread-Topic: Fetch and -t
Thread-Index: Ac4Iub3zTrxaYZv+T/CwQ9/5TEcQRAADl6wWACGfKxA=
In-Reply-To: <7v621yjmla.fsf@alter.siamese.dyndns.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.1.200.107]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/216173>

[Sorry for the top-posting. I *hate* Outlook.]

I will need to check why my system is showing old man pages. I am running something compiled from the git tree on kernel.org.

Thanks!

-----Original Message-----
From: Junio C Hamano [mailto:gitster@pobox.com] 
Sent: Monday, February 11, 2013 6:25 PM
To: Olsen, Alan R
Cc: git@vger.kernel.org
Subject: Re: Fetch and -t

"Olsen, Alan R" <alan.r.olsen@intel.com> writes:

> I have found that if I add a remote and do a "git fetch -t -f 
> remote_name" that it *only* pulls tags.
>
> Reading the man page it seems like it should pull all the remotes and 
> all the tags and the commits only reachable by tags.

This is what appears in the documentation we ship these days.

    -t::
    --tags::
            This is a short-hand for giving "refs/tags/*:refs/tags/*"
            refspec from the command line, to ask all tags to be fetched
            and stored locally.  Because this acts as an explicit
            refspec, the default refspecs (configured with the
            remote.$name.fetch variable) are overridden and not used.

http://git-htmldocs.googlecode.com/git/git-fetch.html

Previous discussion:

    http://thread.gmane.org/gmane.comp.version-control.git/180636

A more recent one:

    http://thread.gmane.org/gmane.comp.version-control.git/211439/focus=211464

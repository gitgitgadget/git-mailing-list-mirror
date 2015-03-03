From: "Keller, Jacob E" <jacob.e.keller@intel.com>
Subject: RE: git notes from incoming patch
Date: Tue, 3 Mar 2015 21:08:45 +0000
Message-ID: <02874ECE860811409154E81DA85FBB585746C272@ORSMSX115.amr.corp.intel.com>
References: <1425346358.13037.13.camel@intel.com>
 <xmqq4mq1bzzb.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Mar 03 22:08:53 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YSu3g-0008Kf-43
	for gcvg-git-2@plane.gmane.org; Tue, 03 Mar 2015 22:08:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756224AbbCCVIr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Mar 2015 16:08:47 -0500
Received: from mga01.intel.com ([192.55.52.88]:37753 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751617AbbCCVIq convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 3 Mar 2015 16:08:46 -0500
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga101.fm.intel.com with ESMTP; 03 Mar 2015 13:08:45 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.09,683,1418112000"; 
   d="scan'208";a="535612406"
Received: from orsmsx103.amr.corp.intel.com ([10.22.225.130])
  by orsmga003.jf.intel.com with ESMTP; 03 Mar 2015 13:08:44 -0800
Received: from orsmsx115.amr.corp.intel.com ([169.254.10.201]) by
 ORSMSX103.amr.corp.intel.com ([169.254.2.154]) with mapi id 14.03.0195.001;
 Tue, 3 Mar 2015 13:08:45 -0800
Thread-Topic: git notes from incoming patch
Thread-Index: AQHQVVHvnQRaQTyjS0+0ibwrnNmChJ0LMqPSgAAPELA=
In-Reply-To: <xmqq4mq1bzzb.fsf@gitster.dls.corp.google.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.22.254.140]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/264689>

> -----Original Message-----
> From: Junio C Hamano [mailto:gitster@pobox.com]
> Sent: Tuesday, March 03, 2015 12:14 PM
> To: Keller, Jacob E
> Cc: git@vger.kernel.org
> Subject: Re: git notes from incoming patch
> 
> "Keller, Jacob E" <jacob.e.keller@intel.com> writes:
> 
> > I am wondering whether it is possible to read from a format-patch input
> > and add notes when we generate the applied patch.
> 
> I would think post-applypatch hook is the right place to do this.
> The hook has access to the incoming message in $GIT_DIR/rebase-apply
> directory ('next' records the message number in the series, and then
> you have individual pieces of e-mails separated out into 0001, 0002,
> etc. you can read from), and "HEAD" already points at the result of
> applying the patch.
> 
> Peek 'post-applypatch' on my 'todo' branch for inspirations.

Excellent, I will investigate this.

Regards,
Jake

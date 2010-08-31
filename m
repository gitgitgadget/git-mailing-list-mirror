From: "Schalk, Ken" <ken.schalk@intel.com>
Subject: RE: [PATCH] Avoid rename/add conflict when contents are identical
Date: Tue, 31 Aug 2010 14:05:51 -0700
Message-ID: <EF9FEAB3A4B7D245B0801936B6EF4A2533CEF8@azsmsx503.amr.corp.intel.com>
References: <5C4EA6C5B30E6B45A9164CB3A26A0D326F79D9AA04@azsmsx503.amr.corp.intel.com>
	<7vd3tnmht0.fsf@alter.siamese.dyndns.org>
	<EF9FEAB3A4B7D245B0801936B6EF4A25262E13@azsmsx503.amr.corp.intel.com>
 <AANLkTik2op0_Cq13EGit17ja+zCdmbM6WXJ=rfhQMnOQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Junio C Hamano <gitster@pobox.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0_Bjarmason?= <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Tue Aug 31 23:06:04 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OqY1r-0006nF-Cc
	for gcvg-git-2@lo.gmane.org; Tue, 31 Aug 2010 23:06:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754116Ab0HaVF5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 31 Aug 2010 17:05:57 -0400
Received: from mga03.intel.com ([143.182.124.21]:33077 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753970Ab0HaVF4 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 31 Aug 2010 17:05:56 -0400
Received: from azsmga001.ch.intel.com ([10.2.17.19])
  by azsmga101.ch.intel.com with ESMTP; 31 Aug 2010 14:05:55 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.56,300,1280732400"; 
   d="scan'208";a="319341296"
Received: from azsmsx603.amr.corp.intel.com ([10.2.161.23])
  by azsmga001.ch.intel.com with ESMTP; 31 Aug 2010 14:05:55 -0700
Received: from azsmsx503.amr.corp.intel.com ([10.2.121.76]) by
 azsmsx603.amr.corp.intel.com ([10.2.161.23]) with mapi; Tue, 31 Aug 2010
 14:05:54 -0700
Thread-Topic: [PATCH] Avoid rename/add conflict when contents are identical
Thread-Index: ActGmXtlhO/RuxD6TZ+oQKm+74+9cgCtcdNg
In-Reply-To: <AANLkTik2op0_Cq13EGit17ja+zCdmbM6WXJ=rfhQMnOQ@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
acceptlanguage: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/154981>

>On Fri, Aug 27, 2010 at 22:14, Schalk, Ken <ken.schalk@intel.com> wrote:

>> +       ln -s e a &&

>Due to this this (and maybe all the tests) need to depend on the
>SYMLINKS prereq.

I used a symlink here to try and duplicate the original problem case that a git user at Intel brought to me.  I admit I didn't consider the problem of testing on platforms without symlink support.

I'm having a little difficulty generating a rename/add conflict inside this test without using a symlink, which seems odd to me as the symlink doesn't seem to be necessary in an experiment I did by hand.  I'll either re-submit with this portion of the test conditional on symlink support, or with an alternate test that doesn't use symlinks (if I can get that to work in the test).

--Ken

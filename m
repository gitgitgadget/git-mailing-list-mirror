From: "Loyall, David" <david.loyall@nebraska.gov>
Subject: RE: [RFC] Documentation: --options in man-pages synopsys
Date: Tue, 8 Oct 2013 14:03:03 +0000
Message-ID: <FCEE4469EE8B234199968ECA9B0661E230EC61C0@STNEEX10MB01.stone.ne.gov>
References: <CA+gfSn-o7cH3a-KWx_iggNc4-rYzQysbTj7OGdaggutLu-X-BA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
To: Dmitry Ivankov <divanorama@gmail.com>,
	Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Oct 08 16:03:12 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VTXsW-00060z-4v
	for gcvg-git-2@plane.gmane.org; Tue, 08 Oct 2013 16:03:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752969Ab3JHODI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 Oct 2013 10:03:08 -0400
Received: from mx01.ne.gov ([164.119.247.101]:63497 "EHLO mx01.ne.gov"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751797Ab3JHODF convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 8 Oct 2013 10:03:05 -0400
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: AqMEAOcPVFIKFNNw/2dsb2JhbABZgz9SwFlKgTN0giUBAQEEOhQ3BAIBCA4DBAEBCxQJBzEBFAkIAgQBBwsIFQSHcbpHjxEzBQaDGYEEA5kwk3WCKg
X-IPAS-Result: AqMEAOcPVFIKFNNw/2dsb2JhbABZgz9SwFlKgTN0giUBAQEEOhQ3BAIBCA4DBAEBCxQJBzEBFAkIAgQBBwsIFQSHcbpHjxEzBQaDGYEEA5kwk3WCKg
X-IronPort-AV: E=Sophos;i="4.90,1056,1371099600"; 
   d="scan'208";a="12748759"
Received: from stneex104.stone.ne.gov ([10.20.211.112])
  by mxout01.ne.gov with ESMTP; 08 Oct 2013 09:03:04 -0500
Received: from STNEEX10MB01.stone.ne.gov ([fe80::582b:5914:1397:c3e]) by
 STNEEX104.stone.ne.gov ([::1]) with mapi id 14.02.0347.000; Tue, 8 Oct 2013
 09:03:04 -0500
Thread-Topic: [RFC] Documentation: --options in man-pages synopsys
Thread-Index: AQHOxB7s/K7cSpLWw02QbBCVCHJprpnq1Gow
In-Reply-To: <CA+gfSn-o7cH3a-KWx_iggNc4-rYzQysbTj7OGdaggutLu-X-BA@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.20.24.158]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/235774>

As a unix user I'd expect the SYNOPSIS section at the top of the man page to include all options that the command accepts.  Mutually exclusive options are expected to be in the form [-q | --progress | --all-progress], such is already done.

I believe that you'd be safe in following http://pubs.opengroup.org/onlinepubs/009695399/basedefs/xbd_chap12.html unless the git-* family of commands and documentation deviate from it in a way that I am not aware of.

Hope this helps,
--Dave

> -----Original Message-----
> From: git-owner@vger.kernel.org [mailto:git-owner@vger.kernel.org] On
> Behalf Of Dmitry Ivankov
> Sent: Tuesday, October 08, 2013 7:07 AM
> To: Git List
> Subject: [RFC] Documentation: --options in man-pages synopsys
> 
> Hi,
> 
> I've noticed that man git-pack-objects describes cmdline as following
> 
> SYNOPSYS
> 'git pack-objects' [-q | --progress | --all-progress] [--all-progress-implied] [--
> no-reuse-delta] [--delta-base-offset] [--non-empty] [--local] [--incremental]
> [--window=<n>] [--depth=<n>] [--revs [--unpacked | --all]] [--stdout | base-
> name] [--keep-true-parents] < object-list
> 
> while OPTIONS sections has even more options, --no-reuse-objects for
> instance.
> 
> Should it be dealt with and how?
> - add smth like ... at the tail of options in synopsys to indicate that there are
> more options
> - add all the [--options] to synopsys
> - drop all the [--options] as they all are optional
> - pick only the most common/important ones like -q --progress, per
> command or per command classes (hard to maintain and/or verify?)
> --
> To unsubscribe from this list: send the line "unsubscribe git" in the body of a
> message to majordomo@vger.kernel.org More majordomo info at
> http://vger.kernel.org/majordomo-info.html

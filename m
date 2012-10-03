From: =?ISO-8859-1?Q?Torsten_B=F6gershausen?= <tboegi@web.de>
Subject: Re: t1450-fsck (sometimes/often) failes on Mac OS X
Date: Wed, 03 Oct 2012 21:37:51 +0200
Message-ID: <506C940F.4010308@web.de>
References: <5001644F.10901@web.de> <20120715090849.GB18385@sigill.intra.peff.net> <5059ED25.9090002@web.de> <7va9wlhnl3.fsf@alter.siamese.dyndns.org> <506B110B.2050802@web.de> <7v4nmc7fmz.fsf@alter.siamese.dyndns.org> <7vy5jo5xco.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: =?ISO-8859-1?Q?Torsten_B=F6gershausen?= <tboegi@web.de>,
	Jeff King <peff@peff.net>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Oct 04 23:51:36 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TJtIg-0001DP-2L
	for gcvg-git-2@plane.gmane.org; Thu, 04 Oct 2012 23:49:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751733Ab2JCTh4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Oct 2012 15:37:56 -0400
Received: from mout.web.de ([212.227.15.4]:55773 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751461Ab2JCTh4 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Oct 2012 15:37:56 -0400
Received: from birne.lan ([195.67.191.22]) by smtp.web.de (mrweb003) with
 ESMTPA (Nemesis) id 0Lheu9-1ToRwB0AdN-00mV3R; Wed, 03 Oct 2012 21:37:54 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.6; rv:15.0) Gecko/20120907 Thunderbird/15.0.1
In-Reply-To: <7vy5jo5xco.fsf@alter.siamese.dyndns.org>
X-Provags-ID: V02:K0:MPRoUOzQFgFWKpHaIjCcMW8qrKkXhIWP9FWH/cI0q7/
 bSTly3eEffmt90bHK1j8Of5i+JIHYmADAv3heknrOYLraYZHNL
 8GbS0QYNYAJ8nt0E/cRaIP4yGyH5RyH/MBgQNNz1j/I73ITwKR
 TNu2cMgHRcFSCqxOoc4keVi9yirmzeLwhrDDWHeRhopp3cCec+
 l40wlpPV+LBOPEBwGCVFw==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/206930>

On 03.10.12 00:21, Junio C Hamano wrote:
> I think this should suffice.
> [snip]
> -	test_must_fail git fsck --tags 2>out &&
> -	cat out &&
> -	grep "error in tag.*broken links" out
> +	test_must_fail git fsck --tags
[snip]

Thanks, and all TC passed in pu.
/Torsten

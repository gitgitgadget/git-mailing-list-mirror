From: "Philip Oakley" <philipoakley@iee.org>
Subject: Re: [PATCH v8 0/7] ref backend preamble
Date: Fri, 10 Jul 2015 15:34:09 +0100
Organization: OPDS
Message-ID: <8C71190FFE324B1599E89376429C8F84@PhilipOakley>
References: <1436482260-28088-1-git-send-email-dturner@twopensource.com>
Reply-To: "Philip Oakley" <philipoakley@iee.org>
Mime-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="iso-8859-1";
	reply-type=original
Content-Transfer-Encoding: 7bit
To: "David Turner" <dturner@twopensource.com>, <git@vger.kernel.org>,
	<mhagger@alum.mit.edu>, <j6t@kdbg.org>
X-From: git-owner@vger.kernel.org Fri Jul 10 19:02:00 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZDbgU-0001zK-Ow
	for gcvg-git-2@plane.gmane.org; Fri, 10 Jul 2015 19:01:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932641AbbGJRBy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 10 Jul 2015 13:01:54 -0400
Received: from out1.ip01ir2.opaltelecom.net ([62.24.128.237]:50558 "EHLO
	out1.ip01ir2.opaltelecom.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932450AbbGJRBx (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 10 Jul 2015 13:01:53 -0400
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: A2CRLQCe+Z9VPOu1BlxbDoMEgTSGTm27XwQEgU1NAQEBAQEBBwEBAQFBJBtBAQICg1gFAQEBAQIBCAEBLh4BASYGAgMFAgEDDgcMJRQBBBoGBwMUBgESCAIBAgMBiBUMwCuQFYtLiCSBFAWMZIdNAYEGo2iBCWYMAYFnPz0xgksBAQE
X-IPAS-Result: A2CRLQCe+Z9VPOu1BlxbDoMEgTSGTm27XwQEgU1NAQEBAQEBBwEBAQFBJBtBAQICg1gFAQEBAQIBCAEBLh4BASYGAgMFAgEDDgcMJRQBBBoGBwMUBgESCAIBAgMBiBUMwCuQFYtLiCSBFAWMZIdNAYEGo2iBCWYMAYFnPz0xgksBAQE
X-IronPort-AV: E=Sophos;i="5.15,447,1432594800"; 
   d="scan'208";a="793778757"
Received: from host-92-6-181-235.as43234.net (HELO PhilipOakley) ([92.6.181.235])
  by out1.ip01ir2.opaltelecom.net with ESMTP; 10 Jul 2015 18:01:49 +0100
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.5931
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.6157
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/273826>

From: "David Turner" <dturner@twopensource.com>
> The current state of the discussion on alternate ref backends is that
> we're going to continue to store pseudorefs (e.g. CHERRY_PICK_HEAD) as

Assuming this is accepted, should the definition of pseudorefs be 
included in the gitglossary?

Once ref backends become common, the distinction will needed in the 
docs.

> files in $GIT_DIR.  So this re-roll of the refs backend preamble
> doesn't do anything to pseudorefs.  It just does reflog stuff.
>
--
Philip 

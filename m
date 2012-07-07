From: Phil Hord <hordp@cisco.com>
Subject: [PATCH v2 0/2] stash: invoke rerere in case of conflict
Date: Sat,  7 Jul 2012 16:46:00 -0400
Message-ID: <1341693962-17090-1-git-send-email-hordp@cisco.com>
References: <CABURp0oXhZ5ysm4b3Z=7o+2TB+3wFdMjj4oEwxafApjD4c7ozA@mail.gmail.com>
Cc: gitster@pobox.com, phil.hord@gmail.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jul 07 22:47:16 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SnbuK-0000wH-RU
	for gcvg-git-2@plane.gmane.org; Sat, 07 Jul 2012 22:47:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751629Ab2GGUrG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 7 Jul 2012 16:47:06 -0400
Received: from rcdn-iport-7.cisco.com ([173.37.86.78]:13659 "EHLO
	rcdn-iport-7.cisco.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751519Ab2GGUqh (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 7 Jul 2012 16:46:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=cisco.com; i=hordp@cisco.com; l=277; q=dns/txt;
  s=iport; t=1341693997; x=1342903597;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=9FMY4PrswDmZ3xMggMO0JAX2exA2gQYBbQxLitOjbA0=;
  b=MiCeje/lO8DZFi+lhGY7jjqG3Bu6PrMO5aM3v6FTsbbqYS2h4bPGcgCB
   +rCBHXUa1nhAqaHITrJZ0A4n6Z3MafloTbA4zSEHrBOp8FDxTc0H85k5i
   cgR5shS4qgEi5ANC70dcEAFN85mjYFuCf1nvpO33M1JIXInYf0AfkzqXR
   Y=;
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: Av0EAOuf+E+tJXG8/2dsb2JhbABFt1yBB4IhAQEEEgFmEFFXO4drmi2fFI4wgxwDlTaOH4Fmgns
X-IronPort-AV: E=Sophos;i="4.77,543,1336348800"; 
   d="scan'208";a="99675772"
Received: from rcdn-core2-1.cisco.com ([173.37.113.188])
  by rcdn-iport-7.cisco.com with ESMTP; 07 Jul 2012 20:46:21 +0000
Received: from iptv-lnx-hordp.cisco.com (rtp-hordp-8912.cisco.com [10.117.80.99])
	by rcdn-core2-1.cisco.com (8.14.5/8.14.5) with ESMTP id q67KkKss026361;
	Sat, 7 Jul 2012 20:46:20 GMT
X-Mailer: git-send-email 1.7.11.1.213.gb567ea5.dirty
In-Reply-To: <CABURp0oXhZ5ysm4b3Z=7o+2TB+3wFdMjj4oEwxafApjD4c7ozA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/201165>

[PATCH v2 1/2] test: git-stash conflict sets up rerere
A rewritten failing test to verify rerere is used during 
'stash apply' conflicts.

[PATCH v2 2/2] stash: invoke rerere in case of conflict
The fix (written entirely by JCH) and switched the test
to expect success.

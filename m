From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH 0/2] Add documentation for new expiry option values
Date: Thu, 18 Apr 2013 09:46:33 +0200
Message-ID: <1366271195-4276-1-git-send-email-mhagger@alum.mit.edu>
References: <7vbo9ceqb3.fsf@alter.siamese.dyndns.org>
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Heiko Voigt <hvoigt@hvoigt.net>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Apr 18 09:47:11 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1USjYk-0001nt-ET
	for gcvg-git-2@plane.gmane.org; Thu, 18 Apr 2013 09:47:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966294Ab3DRHrF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Apr 2013 03:47:05 -0400
Received: from ALUM-MAILSEC-SCANNER-5.MIT.EDU ([18.7.68.17]:44657 "EHLO
	alum-mailsec-scanner-5.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S966268Ab3DRHrE (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 18 Apr 2013 03:47:04 -0400
X-AuditID: 12074411-b7f286d0000008e8-f5-516fa4f65a87
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-5.mit.edu (Symantec Messaging Gateway) with SMTP id 68.04.02280.6F4AF615; Thu, 18 Apr 2013 03:47:02 -0400 (EDT)
Received: from michael.berlin.jpk.com (ssh.berlin.jpk.com [212.222.128.135])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id r3I7kuV8006934
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Thu, 18 Apr 2013 03:47:00 -0400
X-Mailer: git-send-email 1.8.2.1
In-Reply-To: <7vbo9ceqb3.fsf@alter.siamese.dyndns.org>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrOIsWRmVeSWpSXmKPExsUixO6iqPttSX6gQd8/XYuuK91MFg29V5gt
	Vj6+y2xxe8V8ZosfLT3MDqwef99/YPJof/+O2eNZ7x5Gj4uXlD0+b5ILYI3itklKLCkLzkzP
	07dL4M6Y+Gc7S8FttopzZ9ewNjAuZO1i5OSQEDCReL70FxOELSZx4d56ti5GLg4hgcuMEjPW
	3GSGcM4wSRyYMY8NpIpNQFdiUU8zWIeIgJrExLZDLCBFzAJ9jBL96+aBJYQFnCV2HLzODmKz
	CKhK3J24lLGLkYODFyje8MQaYpuCxPHt2xhBbE4BM4mu53+YQWwhAVOJ7s8rmScw8i5gZFjF
	KJeYU5qrm5uYmVOcmqxbnJyYl5dapGuql5tZopeaUrqJERJUgjsYZ5yUO8QowMGoxMP7YFVe
	oBBrYllxZe4hRkkOJiVRXp75+YFCfEn5KZUZicUZ8UWlOanFhxglOJiVRHgfyQLleFMSK6tS
	i/JhUtIcLErivHxL1P2EBNITS1KzU1MLUotgsjIcHEoSvHMXAzUKFqWmp1akZeaUIKSZODhB
	BBfIBh6gDbNACnmLCxJzizPTIYpOMSpKifOagSQEQBIZpXlwA2Dx/4pRHOgfYd5SkCoeYOqA
	634FNJgJaPCBVdkgg0sSEVJSDYxe7Vf+Kb16XdKx9prlklwGrljGhdWy2csdDKxl/e48uMu5
	ZGXgW/3ZZ++vElmlVGFaO6k64IBG7TXLlMZXXdJB5ku2af32ECs29YgLXeB/akJCsu0m1p+f
	GDs+fwmXMVrGZ+mrt3FabnQgY7J0er5Ba5LtfQWOiHPONv8srPm8Dn3PLg5drMRS 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/221620>

The first patch changes the manpages for "git gc" and "git reflog" to
document the new expiry options made possible by Junio's "date.c: add
parse_expiry_date()".  Feel free to squash this patch onto yours.

The second patch changes the parse_options() API documentation to
mention that a "no-" prefix can also be used for non-boolean options.
It is related only by the fact that I was confused by this omission
when I was trying to understand your patch.

Michael Haggerty (2):
  git-gc.txt, git-reflog.txt: document new expiry options
  api-parse-options.txt: document "no-" for non-boolean options

 Documentation/git-gc.txt                      | 5 +++--
 Documentation/git-reflog.txt                  | 9 +++++++--
 Documentation/technical/api-parse-options.txt | 2 ++
 3 files changed, 12 insertions(+), 4 deletions(-)

-- 
1.8.2.1

From: "Philip Oakley" <philipoakley@iee.org>
Subject: git replace: should it check for object type, and can it replace merges?
Date: Sat, 3 Aug 2013 16:13:46 +0100
Organization: OPDS
Message-ID: <24928554D0C34B4696DAD74F569E2E17@PhilipOakley>
Reply-To: "Philip Oakley" <philipoakley@iee.org>
Mime-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="iso-8859-1";
	reply-type=original
Content-Transfer-Encoding: 7bit
To: "Git List" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Aug 03 17:14:39 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V5dWc-0001A7-9O
	for gcvg-git-2@plane.gmane.org; Sat, 03 Aug 2013 17:13:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751989Ab3HCPNm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 3 Aug 2013 11:13:42 -0400
Received: from out1.ip05ir2.opaltelecom.net ([62.24.128.241]:63252 "EHLO
	out1.ip05ir2.opaltelecom.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751936Ab3HCPNl (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 3 Aug 2013 11:13:41 -0400
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: AsUNAI0d/VFOl3PZ/2dsb2JhbABagwYBNIkerzGHCwEDAQOBHRd0gh8UAQEuHgEBLAIIAgEkOQEEGgYHHRsCAQIDAYgDCJdChnyZBI5+hDt0A4hyhg6KCpAlgTaBYjs
X-IPAS-Result: AsUNAI0d/VFOl3PZ/2dsb2JhbABagwYBNIkerzGHCwEDAQOBHRd0gh8UAQEuHgEBLAIIAgEkOQEEGgYHHRsCAQIDAYgDCJdChnyZBI5+hDt0A4hyhg6KCpAlgTaBYjs
X-IronPort-AV: E=Sophos;i="4.89,807,1367967600"; 
   d="scan'208";a="427600126"
Received: from host-78-151-115-217.as13285.net (HELO PhilipOakley) ([78.151.115.217])
  by out1.ip05ir2.opaltelecom.net with SMTP; 03 Aug 2013 16:13:40 +0100
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.5931
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.6157
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/231598>

A recent comment http://stackoverflow.com/a/18027030/717355 on a 
question I asked two years ago about 'grafts' and 'replace' indicates 
that users think that 'git replace' can't replace a merge commit. The 
documentation doesn't have any examples and gives the naive impression 
that one should only replace a simple commit with another simple commit.

Having looked at the code, I realised that anything can be replaced with 
anything, which is perhaps not what was intended. A simple thought is 
that the replace should be like-for-like with regard to object type, 
though that would not include replacing a sub-module for a tree (and 
vice versa).

Should 'git replace' check the object types to ensure they are sensible?

Would it be reasonable to add examples to indicate the range of 
replacements, and how to prepare alternative merge commits, or is that a 
hostage to fortune?


Philip Oakley

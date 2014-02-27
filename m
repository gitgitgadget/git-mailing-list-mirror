From: "Philip Oakley" <philipoakley@iee.org>
Subject: How to mark a complete sub-directory assume-unchanged/skip-worktree?
Date: Thu, 27 Feb 2014 17:25:29 -0000
Organization: OPDS
Message-ID: <3A9AA61FDE124808AA25DE3511CF99F1@PhilipOakley>
Reply-To: "Philip Oakley" <philipoakley@iee.org>
Mime-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="iso-8859-1";
	reply-type=original
Content-Transfer-Encoding: 7bit
To: "Git List" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Feb 27 18:25:43 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WJ4iG-00077Y-8p
	for gcvg-git-2@plane.gmane.org; Thu, 27 Feb 2014 18:25:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752935AbaB0RZ3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 27 Feb 2014 12:25:29 -0500
Received: from out1.ip05ir2.opaltelecom.net ([62.24.128.241]:17220 "EHLO
	out1.ip05ir2.opaltelecom.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751155AbaB0RZ1 (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 27 Feb 2014 12:25:27 -0500
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: AiQbADF0D1NZ8YVX/2dsb2JhbABagnEKCwFoiGqxDYczAgMBAgGBGxd0aQEBgR8BARQBEwEBLh4BASwCCAIBJDkBBBoGBx0bAgECAwGFOAcBggclmmuHEakTkX+BFASJEoYdmzODLTw
X-IPAS-Result: AiQbADF0D1NZ8YVX/2dsb2JhbABagnEKCwFoiGqxDYczAgMBAgGBGxd0aQEBgR8BARQBEwEBLh4BASwCCAIBJDkBBBoGBx0bAgECAwGFOAcBggclmmuHEakTkX+BFASJEoYdmzODLTw
X-IronPort-AV: E=Sophos;i="4.97,556,1389744000"; 
   d="scan'208";a="446295114"
Received: from host-89-241-133-87.as13285.net (HELO PhilipOakley) ([89.241.133.87])
  by out1.ip05ir2.opaltelecom.net with SMTP; 27 Feb 2014 17:25:25 +0000
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.5931
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.6157
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/242831>

I'm having a long think (sickness R&R) about the possible options for a 
narrow clone implementation.

Is there currently any way in the code base that a complete
sub-directory can be marked as 'missing' as could be the case for a
narrow clone? The assume-unchanged/skip-worktree are close but only
applies to filepaths/blobs, rather than trees.

At the moment 'Cached tree' index extension does list the sha1 for 
unchanged sub-drectories for ease of creating tree's for new commits, 
but I couldn't see if it could be (ab)used to support a narrow clone.

Have there been previous attempts to look at marking sub-dirs 
as --skip-worktree, or some other sentinel value for the missing tree?

---
Philip Oakley

From: Brian Gernhardt <benji@silverinsanity.com>
Subject: Re: Why Is There No Bug Tracker And Why Are Patches Sent Instead Of Pull Requests
Date: Wed, 29 Feb 2012 13:23:00 -0500
Message-ID: <B5097A6C-16DB-4CFA-B93D-F6E1C6714057@silverinsanity.com>
References: <CAM=oOO2i-9zraF-YG5YzvZEmN1eXTnQfhJ-eMF04NP7HGtf41w@mail.gmail.com>
Mime-Version: 1.0 (Apple Message framework v1257)
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
To: opticyclic <opticyclic@gmail.com>
X-From: git-owner@vger.kernel.org Wed Feb 29 19:29:14 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S2oGz-0005YV-Sn
	for gcvg-git-2@plane.gmane.org; Wed, 29 Feb 2012 19:29:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966049Ab2B2S3E (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 29 Feb 2012 13:29:04 -0500
Received: from vs072.rosehosting.com ([216.114.78.72]:56415 "EHLO
	silverinsanity.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965743Ab2B2S3C convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 29 Feb 2012 13:29:02 -0500
X-Greylist: delayed 358 seconds by postgrey-1.27 at vger.kernel.org; Wed, 29 Feb 2012 13:29:02 EST
Received: by silverinsanity.com (Postfix, from userid 5001)
	id E9B9D1FFC009; Wed, 29 Feb 2012 18:22:57 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.2.5 (2008-06-10) on silverinsanity.com
X-Spam-Level: 
X-Spam-Status: No, score=-4.5 required=3.5 tests=ALL_TRUSTED,AWL,BAYES_00
	autolearn=ham version=3.2.5
Received: from [129.21.210.202] (bcg2784.student.rit.edu [129.21.210.202])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by silverinsanity.com (Postfix) with ESMTPSA id 84FC81FFC007;
	Wed, 29 Feb 2012 18:22:57 +0000 (UTC)
In-Reply-To: <CAM=oOO2i-9zraF-YG5YzvZEmN1eXTnQfhJ-eMF04NP7HGtf41w@mail.gmail.com>
X-Mailer: Apple Mail (2.1257)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/191840>


On Feb 29, 2012, at 12:19 PM, opticyclic wrote:

> Secondly, since one of the alleged reasons for creating git was to not
> have to deal with patches, why are pull requests disable and patches
> sent to this mailing 


On the contrary, the design of git was created with the idea of handling patches via e-mail in mind.  Tools like git-format-patch, git-am, and git-send-email exist to allow this workflow.  Linus wanted a tool that would automate and enhance the way the kernel ML already did work instead of demanding that they change.

~~ Brian G

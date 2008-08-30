From: David Christensen <david@endpoint.com>
Subject: Re: [PATCH] Teach git.el to mark/unmark files by regexp
Date: Sat, 30 Aug 2008 14:02:37 -0500
Message-ID: <F0D63233-0302-4CF8-9CE1-FC12F2B80F91@endpoint.com>
References: <1219807480-57122-1-git-send-email-david@endpoint.com> <87myiuwdk0.fsf@wine.dyndns.org>
Mime-Version: 1.0 (Apple Message framework v928.1)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Alexandre Julliard <julliard@winehq.org>
X-From: git-owner@vger.kernel.org Sat Aug 30 21:03:49 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KZVjd-0001sa-Gt
	for gcvg-git-2@gmane.org; Sat, 30 Aug 2008 21:03:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753989AbYH3TCl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 30 Aug 2008 15:02:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753691AbYH3TCk
	(ORCPT <rfc822;git-outgoing>); Sat, 30 Aug 2008 15:02:40 -0400
Received: from sb3.endpoint.com ([64.34.193.88]:56530 "EHLO mail.endcrypt.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753349AbYH3TCk (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 30 Aug 2008 15:02:40 -0400
Received: from [192.168.1.119] (188.142.45.66.cm.sunflower.com [66.45.142.188])
	by mail.endcrypt.com (Postfix) with ESMTP id AC0BB371114;
	Sat, 30 Aug 2008 19:02:38 +0000 (UTC)
In-Reply-To: <87myiuwdk0.fsf@wine.dyndns.org>
X-Mailer: Apple Mail (2.928.1)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/94407>

>> Adds the functions git-mark-regexp and git-unmark-regexp to git.el.
>> Creates a mark-map keymap to support dired-like behavior for
>> marking/unmarking via regexp.  Also adds these functions to the
>> menubar.
>
> I think that emulating dired behavior is a good idea, but you should  
> go
> all the way and make it fully compatible, unmark is supposed to be  
> "* %"
> with a prefix arg, and "* DEL" should be git-unmark-file-up.


Sounds good; I'll review other mark-related dired bindings and see if  
there are other correspondences we can make, and then resubmit a patch.

Regards,

David
--
David Christensen
End Point Corporation
david@endpoint.com

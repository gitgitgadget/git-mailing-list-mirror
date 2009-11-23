From: Brian Gernhardt <brian@gernhardtsoftware.com>
Subject: Re: [PATCH] t/gitweb-lib: Split HTTP response with non-GNU sed
Date: Mon, 23 Nov 2009 13:50:30 -0500
Message-ID: <BF7341BA-DC27-47C6-B140-2D5A074572E7@gernhardtsoftware.com>
References: <1258997622-62403-1-git-send-email-brian@gernhardtsoftware.com> <7vocmtyu3v.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0 (Apple Message framework v1077)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Cc: Git List <git@vger.kernel.org>, Jakub Narebski <jnareb@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Nov 23 19:50:46 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NCdzk-0002e5-7Q
	for gcvg-git-2@lo.gmane.org; Mon, 23 Nov 2009 19:50:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752918AbZKWSu2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 Nov 2009 13:50:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751505AbZKWSu1
	(ORCPT <rfc822;git-outgoing>); Mon, 23 Nov 2009 13:50:27 -0500
Received: from vs072.rosehosting.com ([216.114.78.72]:42024 "EHLO
	silverinsanity.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751363AbZKWSu1 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 23 Nov 2009 13:50:27 -0500
Received: by silverinsanity.com (Postfix, from userid 5001)
	id B66EF1FFC087; Mon, 23 Nov 2009 18:50:28 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.2.5 (2008-06-10) on silverinsanity.com
X-Spam-Level: 
X-Spam-Status: No, score=-4.5 required=4.0 tests=ALL_TRUSTED,AWL,BAYES_00
	autolearn=ham version=3.2.5
Received: from [10.10.10.10] (cpe-67-240-172-169.rochester.res.rr.com [67.240.172.169])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by silverinsanity.com (Postfix) with ESMTPSA id 8A6211FFC06B;
	Mon, 23 Nov 2009 18:50:27 +0000 (UTC)
In-Reply-To: <7vocmtyu3v.fsf@alter.siamese.dyndns.org>
X-Mailer: Apple Mail (2.1077)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/133524>


On Nov 23, 2009, at 1:27 PM, Junio C Hamano wrote:

> Brian Gernhardt <brian@gernhardtsoftware.com> writes:
> 
>> Recognizing \r in a regex is something GNU sed will do, but other sed
>> implementation's won't.  (Found with BSD sed on OS X.) So use a
>> literal carriage return instead.
> 
> I'd actually prefer not having to deal with this issue.  How about doing
> something like this instead?

Works for me.  I just went for the obvious minimal change to make it work.  But since we're testing a perl script, we might as well just use perl to deal with it's output.

~~ Brian

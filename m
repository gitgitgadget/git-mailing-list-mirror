From: Paolo Bonzini <bonzini@gnu.org>
Subject: Re: [PATCH] make commit --interactive lock index
Date: Fri, 30 May 2008 09:42:36 +0200
Message-ID: <483FAFEC.6090306@gnu.org>
References: <E1K1eXH-00063c-Bt@fencepost.gnu.org> <7vr6bkmkbm.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Git mailing list <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri May 30 09:43:43 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K1zGs-0005vd-PC
	for gcvg-git-2@gmane.org; Fri, 30 May 2008 09:43:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751605AbYE3Hmf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 30 May 2008 03:42:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751580AbYE3Hmf
	(ORCPT <rfc822;git-outgoing>); Fri, 30 May 2008 03:42:35 -0400
Received: from fg-out-1718.google.com ([72.14.220.154]:14535 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751550AbYE3Hmf (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 May 2008 03:42:35 -0400
Received: by fg-out-1718.google.com with SMTP id 19so61529fgg.17
        for <git@vger.kernel.org>; Fri, 30 May 2008 00:42:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:x-enigmail-version:content-type:content-transfer-encoding:sender;
        bh=FN+nvEvKZeT51FZxK4Ar7qxrmFkRInpMucpTm4Uvvxw=;
        b=puAgoCBmmH0wqyTWa/EldAYqXBSdZFDfjEoN9S+YXgs0zxwtODWdtLyRJQjo18TICpvTpUNpqmXeLCUvfLWHFoIcY16P/17Hp4ZGVsxWBzZBJyffbQUljkTIDlLm70FuEUSotUO5aFye5F1gRHmu/HsLOuU+S7w0H/pulkCRP8A=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:x-enigmail-version:content-type:content-transfer-encoding:sender;
        b=cZ7OrVduIYxNrNpmf7bHhW91rrqvD0i07ZXXmPccGKbYHyq8YCf6RwTGAaOiq6ses9HTIRZ8I8D/5dPvaHAf+6VANyycQWDoLVCwGAYgtZAUaFQNcr21hOErcM+lVQMkVjC9NZRS2H9QEacwb1jQHYdQVAR8guVy0ipCDT4siP8=
Received: by 10.86.54.4 with SMTP id c4mr195204fga.33.1212133353756;
        Fri, 30 May 2008 00:42:33 -0700 (PDT)
Received: from scientist-2.mobile.usilu.net ( [195.176.176.226])
        by mx.google.com with ESMTPS id 3sm243340fge.3.2008.05.30.00.42.32
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 30 May 2008 00:42:32 -0700 (PDT)
User-Agent: Thunderbird 2.0.0.14 (Macintosh/20080421)
In-Reply-To: <7vr6bkmkbm.fsf@gitster.siamese.dyndns.org>
X-Enigmail-Version: 0.95.6
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/83271>


> Can you explain why this is an improvement?

No, I was just wondering if this was a bug, possibly one that shows in 
weird cases such as when the index is updated under git-commit's feet. 
As I said in the cover letter, I sent this patch only for review from 
more knowledgeable people.

Paolo

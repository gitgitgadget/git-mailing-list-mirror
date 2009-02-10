From: Geoffrey Lee <geoffreyj.lee@gmail.com>
Subject: Re: [RFC] New command: 'git snapshot'.
Date: Tue, 10 Feb 2009 15:39:19 -0800
Message-ID: <83d7aaa40902101539m3c40deeeo2d452f6dbb7c379c@mail.gmail.com>
References: <38cfbb550902091054u78f2e706u67752b4dc9de6c3b@mail.gmail.com>
	 <etsYQzEDjdk-_NxhvO3i6EyShR6eZ202GBdQx7ZZpPHH5iNfWiuV6g@cipher.nrlssc.navy.mil>
	 <38cfbb550902101240x1202c592ra7eb01d66e22da43@mail.gmail.com>
	 <20090210230054.GD26954@coredump.intra.peff.net>
	 <7vy6wdkhzk.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Feb 11 00:41:07 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LX2Dy-0001vt-MX
	for gcvg-git-2@gmane.org; Wed, 11 Feb 2009 00:41:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757403AbZBJXjV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Feb 2009 18:39:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756672AbZBJXjV
	(ORCPT <rfc822;git-outgoing>); Tue, 10 Feb 2009 18:39:21 -0500
Received: from an-out-0708.google.com ([209.85.132.244]:46868 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757391AbZBJXjU (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Feb 2009 18:39:20 -0500
Received: by an-out-0708.google.com with SMTP id c2so73893anc.1
        for <git@vger.kernel.org>; Tue, 10 Feb 2009 15:39:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:content-type
         :content-transfer-encoding;
        bh=zIBtjjBMVGdaL1w6T+5VMR7yipqFkhl2y000TK9XWpE=;
        b=RavLmK6oJByHJdfrDIiZz3P1TcG8lrJCp664AvAVvtrTRg8JWqTrg0/jC9YkmM1SGa
         uFdT/4WvJpb+ufh0nsfk3X+yPJQHpf4XhfKQNLz/PJPk0bjJ82ZUI9C5ywTFQU4qiCrB
         q9WIwmnhZf28VUF4cnVqhYrxkwKGWe/ZYkN1I=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :content-type:content-transfer-encoding;
        b=UbZqoIw7lnffXNFFcXkIG8i1b4UclQhT2SPjt2ucR8JXibukwOvmXR4j7DzZ/3ctpt
         Gs0BG8KbakURVeSxlFFQaPlk9DXSQGiARHOoiXg2ahfs6oSsG+vh4jHjAodGm/fts6Wc
         pZ0wLAXkReYhAtAk8uG09BnQTJp4A7ypIfVPw=
Received: by 10.100.41.9 with SMTP id o9mr5131850ano.39.1234309159169; Tue, 10 
	Feb 2009 15:39:19 -0800 (PST)
In-Reply-To: <7vy6wdkhzk.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/109346>

On Tue, Feb 10, 2009 at 3:08 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Jeff King <peff@peff.net> writes:
> How is it different from "git stash create"?

Git stash doesn't touch untracked files, whereas git snapshot would.
Take another closer look at the table in the original post titled
"What are the differences between 'git stash' and 'git snapshot'?"

-Geoffrey Lee

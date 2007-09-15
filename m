From: "Brian Scott Dobrovodsky" <brian@pontech.com>
Subject: Re: Data Integrity & un-Commited Branches
Date: Fri, 14 Sep 2007 17:40:56 -0700
Message-ID: <2a8a071a0709141740l144b60aevdfec2b6cdab8bb60@mail.gmail.com>
References: <2a8a071a0709140028o472bcr8c82bd88e37cc4e9@mail.gmail.com>
	 <2a8a071a0709140036l5db62c0fl5af01f75f35610ba@mail.gmail.com>
	 <7vk5qtd3le.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Sep 15 02:41:03 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IWLiY-0001Qm-6B
	for gcvg-git-2@gmane.org; Sat, 15 Sep 2007 02:41:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759616AbXIOAk7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 Sep 2007 20:40:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759530AbXIOAk6
	(ORCPT <rfc822;git-outgoing>); Fri, 14 Sep 2007 20:40:58 -0400
Received: from fk-out-0910.google.com ([209.85.128.188]:1180 "EHLO
	fk-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758919AbXIOAk6 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Sep 2007 20:40:58 -0400
Received: by fk-out-0910.google.com with SMTP id z23so888013fkz
        for <git@vger.kernel.org>; Fri, 14 Sep 2007 17:40:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:sender:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references:x-google-sender-auth;
        bh=ASduKfhR+gby7cvaHzVkkigkSN7eCqIaxWYsf5Qq46M=;
        b=ePawQAUJ75rut3IKDHGUbEr/o6GsmJGI5Lj+jhYRAA13R7LP6XZzik7yRzKYe7/ibg4YTfRI/s+c4pEUA7FW0hyyx502W95wnR2FAhYCuZd2RXtKMyBVErjxUvv6g/+je6YcZYzyx2V0XDMf1qPYbhxrfk8aL/81xhxO3I1Z0D8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:sender:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references:x-google-sender-auth;
        b=bnv2yGthM/4Bx8WWBSg2rufqrStB9a5XWvgZ3zUerwO9mQyDe3iW9GAlO6EgV+biLO7W6TmXrqVBJGfG0P/ak9oWJjRTx8BSUaBS8iyxynKZ53oyo0nQniPJLpmhrGA10Of3txbRG4Q/4rxI4KWg7m1OXCFY96yCi2By8GoOwDU=
Received: by 10.82.107.15 with SMTP id f15mr627847buc.1189816856177;
        Fri, 14 Sep 2007 17:40:56 -0700 (PDT)
Received: by 10.82.161.6 with HTTP; Fri, 14 Sep 2007 17:40:56 -0700 (PDT)
In-Reply-To: <7vk5qtd3le.fsf@gitster.siamese.dyndns.org>
Content-Disposition: inline
X-Google-Sender-Auth: 96efbcd3df643cad
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/58214>

It was a misunderstanding of Git's work flow. By switching from 'an
un-committed demo' to a previously committed master: I was expecting
Git to give me the content last commited to master while at the same
time preserving(without having to commit) the changes made in demo.
Intuitively, this is how I expected Git to function.

Indeed, I read through the Crash Courses: 'Git for everyone' & 'Git
for SVN users'.
-- 
Brian Scott Dobrovodsky

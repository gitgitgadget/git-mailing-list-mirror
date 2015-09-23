From: Lars Schneider <larsxschneider@gmail.com>
Subject: Re: git-p4: t9819 failing
Date: Wed, 23 Sep 2015 12:27:45 +0200
Message-ID: <954B65C2-1CF8-4F63-B2DE-F15200553046@gmail.com>
References: <CAE5ih79t+62XUKsj9cnkJCCv4WPhUgQZQ6hF39Nx0ky+WFi-sw@mail.gmail.com>
Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.6\))
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Cc: Git Users <git@vger.kernel.org>
To: Luke Diamand <luke@diamand.org>
X-From: git-owner@vger.kernel.org Wed Sep 23 12:27:56 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZehHG-0005Td-HX
	for gcvg-git-2@plane.gmane.org; Wed, 23 Sep 2015 12:27:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753430AbbIWK1u (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Sep 2015 06:27:50 -0400
Received: from mail-wi0-f169.google.com ([209.85.212.169]:38556 "EHLO
	mail-wi0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753421AbbIWK1t convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 23 Sep 2015 06:27:49 -0400
Received: by wiclk2 with SMTP id lk2so62273235wic.1
        for <git@vger.kernel.org>; Wed, 23 Sep 2015 03:27:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=content-type:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=OPBoRXZT8XaCij+VBgo6Wf3S796WYCWEwWOnyZSW3xQ=;
        b=F6lnB3whjZ4UJjy9Y2CO+93HLdLPNIY1ndjoi8pwSobIBhusfxA5BfDajJtUqk3F5d
         8D+uVnOL39N4b6ukJuU5RlFLj+iIGK76hWgJm57liu9qEe+gEelmBXwGSGMxOPpfq3G3
         W3aKOaQNfqoeNNoxNII1g3eyycRZRdW7dke4nJCER63D6oH6QDVXTqmBLQnnXEWjgD17
         0tv29ftQPaEfKJZeoI7n4KyU9ZbEgvoFj/jtwZEcYuEOclDlrwBNGic33t2au2mEj03x
         QML00Kb3jxjigjpExX/uqEaWCcIQS9lG6GeN6ikoBIkxwaOjS138Yrc7+9XzjaJK61k5
         t7/w==
X-Received: by 10.195.11.101 with SMTP id eh5mr35409780wjd.59.1443004067924;
        Wed, 23 Sep 2015 03:27:47 -0700 (PDT)
Received: from slxbook3.ads.autodesk.com ([62.159.156.210])
        by smtp.gmail.com with ESMTPSA id nf15sm7818561wic.22.2015.09.23.03.27.47
        (version=TLS1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Wed, 23 Sep 2015 03:27:47 -0700 (PDT)
In-Reply-To: <CAE5ih79t+62XUKsj9cnkJCCv4WPhUgQZQ6hF39Nx0ky+WFi-sw@mail.gmail.com>
X-Mailer: Apple Mail (2.1878.6)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/278479>


On 23 Sep 2015, at 11:27, Luke Diamand <luke@diamand.org> wrote:

> Lars,
> 
> I just noticed that your change "git-p4: honor core.ignorecase when
> using P4 client specs" seems to break t9819.
> 
> I suspect that the problem is just that t9819 needs to be updated to
> reflect your change - do you have any thoughts on that?
> 
> Thanks!
> Luke

What OS and what commit do you use for testing? Here is what I got on my machine:

Ubuntu, next (c07a1e8) -> OK
Ubuntu, maint (ee6ad5f) -> OK

OS X, next (c07a1e8) -> broken
OS X, maint (ee6ad5f) -> broken

Thanks,
Lars
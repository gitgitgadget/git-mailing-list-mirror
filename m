From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: t3032 incompatible with Cygwin/Windows
Date: Tue, 16 Jul 2013 11:56:35 -0700
Message-ID: <20130716185635.GN14690@google.com>
References: <51E591FF.7030600@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
To: Mark Levedahl <mlevedahl@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jul 16 20:57:00 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UzAQk-0003Dq-Bc
	for gcvg-git-2@plane.gmane.org; Tue, 16 Jul 2013 20:56:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933329Ab3GPS4j (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Jul 2013 14:56:39 -0400
Received: from mail-pd0-f170.google.com ([209.85.192.170]:39702 "EHLO
	mail-pd0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754956Ab3GPS4j (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Jul 2013 14:56:39 -0400
Received: by mail-pd0-f170.google.com with SMTP id x11so984783pdj.1
        for <git@vger.kernel.org>; Tue, 16 Jul 2013 11:56:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=G+kwRBczX+Cuce+dln+rWqYj6rHWETYMaV6IJDbPRJs=;
        b=EIfIFFhpO+hqmbJotRsi9tOyDGB066R14QxbIleuhg9C0xT3Z5HVPaQAdY+Z7aU6Of
         EXl79BnnPySYfFqBJAuClf2hITnuTOtE4RNTNNb58iv4r1lb6ugjbv4WYgUR2dmV/0PA
         fInHn4Wg9CbMkwv7TVsPx3mVlY7nRC0L2PKeG49Tg8cRJ5akUTr/ZY+7PIlEKy022u44
         3gbemjmtQ1WZyMBQ8HYdyzyKNS5jYsMBgFM+6jFqw68/LEFSkzvAf3sGvlybgpO2u0Vs
         4gvgd0jnIS9tXnKT5XTggqLR/23cf2yWIKgvzLUyDNrn73xZgZwddN6WVUaegryqvY6j
         /6iA==
X-Received: by 10.68.179.101 with SMTP id df5mr3026755pbc.33.1374000998785;
        Tue, 16 Jul 2013 11:56:38 -0700 (PDT)
Received: from google.com ([2620:0:1000:5b00:b6b5:2fff:fec3:b50d])
        by mx.google.com with ESMTPSA id py4sm3367231pbc.14.2013.07.16.11.56.37
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 16 Jul 2013 11:56:38 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <51E591FF.7030600@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/230576>

Mark Levedahl wrote:

> Subtests 6,7, and 9 of t3032 fail on Cygwin, and I presume will fail
> on msysgit for similar reasons. Looking at test 6, the expected
> result is a line ending with \r\n in text.txt. This line is
> extracted with grep (grep 'justice and holiness' text.txt > actual),
> with unavoidable result that on Cygwin the line ending is \n.

Would using perl instead of grep fix this?

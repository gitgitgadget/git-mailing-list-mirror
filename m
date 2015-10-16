From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH] usage: do not insist that standard input must come from
 a file
Date: Fri, 16 Oct 2015 15:58:01 -0700
Message-ID: <20151016225801.GB1901@google.com>
References: <xmqqvba6ekip.fsf@gitster.mtv.corp.google.com>
 <xmqqh9lqcuvk.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Oct 17 00:58:37 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZnDxI-0006pe-Oz
	for gcvg-git-2@plane.gmane.org; Sat, 17 Oct 2015 00:58:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752212AbbJPW6W (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 16 Oct 2015 18:58:22 -0400
Received: from mail-pa0-f54.google.com ([209.85.220.54]:36470 "EHLO
	mail-pa0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752171AbbJPW6F (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 Oct 2015 18:58:05 -0400
Received: by pacfv9 with SMTP id fv9so34734329pac.3
        for <git@vger.kernel.org>; Fri, 16 Oct 2015 15:58:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=8UZWKOcfTO44TF15vamVPnm1U+8Dwpsm2il9mvIi6tk=;
        b=gjm4pOL+o7cWH5TXGMnVnOfTuLpDsVMmrbkTIqfKhfzDPabaECLRFjFt+wYLkBvcEy
         opHkWqTpddMjw3doWvlfZ7HyfFkuYCmbLQ55zwvrVp5Q/YUs2PvRI12u+tYKmqgm/lSQ
         cJIERrkp1SS37/YZe5PnZn1owpQAY6h74iXNPKDCdGzC4oHNxV4VIJFhKQlrVELXOFIa
         D65v7Af1VtKCK+C1geESmmZ8hKyBdQ9j4SHNpu+H6hPievgPH2fzdcYqOoBq7n85at4A
         VWsJ1htyQsIIVnrk5T02akOZJOSp7WIwHVZdJb+ck0bqjtx2MDGf3I5YXqBDjwz6aVL9
         sp3w==
X-Received: by 10.66.160.100 with SMTP id xj4mr19230726pab.39.1445036284530;
        Fri, 16 Oct 2015 15:58:04 -0700 (PDT)
Received: from google.com ([2620:0:1000:5b00:a41c:7a7:1f0e:ffad])
        by smtp.gmail.com with ESMTPSA id bo5sm23090475pbb.76.2015.10.16.15.58.03
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Fri, 16 Oct 2015 15:58:03 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <xmqqh9lqcuvk.fsf@gitster.mtv.corp.google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/279777>

Junio C Hamano wrote:

> Here is what I prepared based on your review in an interdiff form.

For what it's worth,
Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>

Thanks.

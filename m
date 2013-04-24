From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 5/5] git-diff.txt: fix ordering of the [--no-index] form
Date: Wed, 24 Apr 2013 12:06:38 -0700
Message-ID: <20130424190638.GE29963@google.com>
References: <1366821216-20868-1-git-send-email-artagnon@gmail.com>
 <1366821216-20868-6-git-send-email-artagnon@gmail.com>
 <7vmwsndbve.fsf@alter.siamese.dyndns.org>
 <CALkWK0kaFc8cj-=1NbEwC_61U7qUCye70d9MZR66TpKB3i9XyA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Wed Apr 24 21:06:49 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UV51k-0005uU-3G
	for gcvg-git-2@plane.gmane.org; Wed, 24 Apr 2013 21:06:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757170Ab3DXTGo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 24 Apr 2013 15:06:44 -0400
Received: from mail-da0-f53.google.com ([209.85.210.53]:60287 "EHLO
	mail-da0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757057Ab3DXTGn (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Apr 2013 15:06:43 -0400
Received: by mail-da0-f53.google.com with SMTP id n34so1025531dal.26
        for <git@vger.kernel.org>; Wed, 24 Apr 2013 12:06:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=L2ueVc1EbKfeUlBJ14heT9Ia2ANYZjB+mMM8T0Tqb2Y=;
        b=jIqCewrVAnl0bfr9Wfo+UcpFbM2eMEXcoibRjzVVGrZUUoeOuwsASiWdMAEy59r2sU
         0sjg2uzitVLbsSfy2cnCzp9efBb3wJuIBdZLihnW4vTll6iXc7GRf4hkXwOHaxbQinMH
         /S3mwrxMzHPakoFxtITLShysLC3gCL0J0JigCEtvdTgAhgadV8vdnoUv8UaAOCUrNFYX
         8uoOEeE7yUPpUsCoj4NJdGHBUzkphsvAIjJ+23ieeYjkXdt7vANTnftex38MHJ/4YM3t
         HdUi6/UnWEIWeilBJU9SHBALht/L+xpja++p7dk4KHJFvGCqKLKGzTlTrfJU1bQ8bPPP
         HbWQ==
X-Received: by 10.68.172.5 with SMTP id ay5mr49524798pbc.73.1366830402948;
        Wed, 24 Apr 2013 12:06:42 -0700 (PDT)
Received: from google.com ([2620:0:1000:5b00:b6b5:2fff:fec3:b50d])
        by mx.google.com with ESMTPSA id qr7sm4071193pbc.16.2013.04.24.12.06.40
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Wed, 24 Apr 2013 12:06:41 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CALkWK0kaFc8cj-=1NbEwC_61U7qUCye70d9MZR66TpKB3i9XyA@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222298>

Ramkumar Ramachandra wrote:

>                                          The form is a special case of
> the first form where the number of paths are limited to two.  Besides,
> isn't that how the DESCRIPTION section explains it now?

Sort of.  It's a completely different form, but when --no-index is
left out the syntax is a special case of "git diff -- <path>...".

Maybe it would make sense to move towards eliminating the "implicit
--no-index for paths outside the repository" trick.  I use "git diff
--no-index" all the time, but I always spell it out to be careful.

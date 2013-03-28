From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH v2] git-send-email.perl: implement suggestions made by
 perlcritic
Date: Thu, 28 Mar 2013 11:57:07 -0700
Message-ID: <20130328185707.GR28148@google.com>
References: <7vfvzgn3ob.fsf@alter.siamese.dyndns.org>
 <1364474835-23416-1-git-send-email-artagnon@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Thu Mar 28 19:57:42 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ULI16-0001K5-71
	for gcvg-git-2@plane.gmane.org; Thu, 28 Mar 2013 19:57:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751607Ab3C1S5M (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Mar 2013 14:57:12 -0400
Received: from mail-pa0-f45.google.com ([209.85.220.45]:51870 "EHLO
	mail-pa0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751453Ab3C1S5M (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Mar 2013 14:57:12 -0400
Received: by mail-pa0-f45.google.com with SMTP id kl13so38126pab.18
        for <git@vger.kernel.org>; Thu, 28 Mar 2013 11:57:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=duPqAsQIvE6jdFN1dB8IfPi9sYhklfIqY0gYQJS+Ybg=;
        b=Pyqp8oZBcXtUXaVnTXItLDKGnv4oqEh+VIZKgqWB46yx42DExJI7VzaiQBxQhe5phe
         EKxMtcm5qA0GbvHG1edUH8r829TBvm9mFveoOxW0NWQQccXMkvvaxd99CHkBZA32uu+3
         c0Ao/j36csZ2GsF3QprWF/ZId7Zlmk0nIdIupAQ+S2lN9MphFzIvw4U7vfqzPpC07DNu
         nihtH+umwp+OrAIWpNhOPyf1b0hsj1r6t79qhbZIVVhpqjCjWn1rfXM10bR4NOrm0r2h
         PhOacZL4+UdBczlm12CHFANDB529W59Yv9z2Us9au3O5JpjSDawiH3z8Q1gA1qdNglyR
         njUg==
X-Received: by 10.66.248.193 with SMTP id yo1mr348993pac.120.1364497031573;
        Thu, 28 Mar 2013 11:57:11 -0700 (PDT)
Received: from google.com ([2620:0:1000:5b00:b6b5:2fff:fec3:b50d])
        by mx.google.com with ESMTPS id ce16sm290236pac.5.2013.03.28.11.57.09
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Thu, 28 Mar 2013 11:57:10 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1364474835-23416-1-git-send-email-artagnon@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/219446>

Ramkumar Ramachandra wrote:

>  Junio: In future, please tell me explicitly that you're expecting a
>  re-roll with an updated commit message.  It wasn't obvious to me at
>  all.

When there are questions in response to a patch, there are two
possibilities:

 * temporary brainfart --- sorry for the bother
 * the clarity of the patch or commit message has room for improvement

This wasn't a case of the former, so a seasoned contributor could
safely assume that it was definitely a case of the latter.

The explanation in Linux kernel's Documentation/SubmittingPatches
item 10 ("Don't get discouraged.  Re-submit") has some fitting advice.

Hope that helps,
Jonathan

From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH] git format-patch --signature <string | file>
Date: Tue, 13 May 2014 09:07:12 -0700
Message-ID: <20140513160712.GA30685@google.com>
References: <1399969296-31598-1-git-send-email-jmmahler@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jeremiah Mahler <jmmahler@gmail.com>
X-From: git-owner@vger.kernel.org Tue May 13 18:07:31 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WkFEm-00078a-N1
	for gcvg-git-2@plane.gmane.org; Tue, 13 May 2014 18:07:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754551AbaEMQHY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 May 2014 12:07:24 -0400
Received: from mail-pb0-f42.google.com ([209.85.160.42]:42936 "EHLO
	mail-pb0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751198AbaEMQHW (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 May 2014 12:07:22 -0400
Received: by mail-pb0-f42.google.com with SMTP id md12so71418pbc.15
        for <git@vger.kernel.org>; Tue, 13 May 2014 09:07:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=tewXUgFq6L02skItewo8jXYUFJfi3YVQkwJOh+2f/9Q=;
        b=KHd8O1k1q1RQbV0sq8DaellL/udvABoFZ53kZUe+I2rmdrgLMquyn8lnzx6TqXQnlD
         tvAORQSglTCN8VFPyVnXMgkfVZfqrTkR47I60wKi2WwCMVtjMmuNgqw9uhSwySIE6jJo
         vzAObq7Xab0ixRvVNEyxBVqe081LbcHRxgsmrTuHOBOutfhoG6aFW+F+c5LWdu1coLeG
         P2FezwM3nUVwo4daTZY1VzwhRQGoZpAdKVR7vRefCZKNpn1nTxwE83wvbkNkli5u0yZI
         5JqCllvhxvkSDS8w6fagZCUDXSIKX077xZb+xC2jEmq4rYgE1ixjUT5Rn4WJCslXU51R
         rEAA==
X-Received: by 10.68.254.103 with SMTP id ah7mr6219906pbd.159.1399997241533;
        Tue, 13 May 2014 09:07:21 -0700 (PDT)
Received: from google.com ([2620:0:1000:5b00:b6b5:2fff:fec3:b50d])
        by mx.google.com with ESMTPSA id ky8sm28950827pbc.64.2014.05.13.09.07.20
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 13 May 2014 09:07:20 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1399969296-31598-1-git-send-email-jmmahler@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/248791>

Hi,

Jeremiah Mahler wrote:

>   # from a string
>   $ git format-patch --signature "from a string" origin
>
>   # or from a file
>   $ git format-patch --signature ~/.signature origin

Interesting.  But... what if I want my patch to end with

	-- 
	/home/jrnieder/.signature

?  It seems safer to introduce a separate --signature-file option.

[...]
>  builtin/log.c | 26 ++++++++++++++++++++++++--
>  1 file changed, 24 insertions(+), 2 deletions(-)

Tests?

Thanks and hope that helps,
Jonathan

From: David Turner <dturner@twopensource.com>
Subject: Re: [PATCH v6 0/7] refs backend preamble
Date: Mon, 29 Jun 2015 16:48:53 -0400
Organization: Twitter
Message-ID: <1435610933.30953.4.camel@twopensource.com>
References: <1435609076-8592-1-git-send-email-dturner@twopensource.com>
	 <xmqq7fqm9ryv.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: git mailing list <git@vger.kernel.org>, mhagger@alum.mit.edu
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jun 29 22:49:11 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z9fzE-00020p-CI
	for gcvg-git-2@plane.gmane.org; Mon, 29 Jun 2015 22:49:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754073AbbF2UtB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Jun 2015 16:49:01 -0400
Received: from mail-qc0-f181.google.com ([209.85.216.181]:33327 "EHLO
	mail-qc0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753694AbbF2Us4 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Jun 2015 16:48:56 -0400
Received: by qcbcf1 with SMTP id cf1so46768863qcb.0
        for <git@vger.kernel.org>; Mon, 29 Jun 2015 13:48:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:organization:content-type:mime-version
         :content-transfer-encoding;
        bh=vEFWqPbALnA1pTKfZxF/GMBAj2/m9rPVjvOVGnzLXzg=;
        b=NeJ1pR1fw6ZngrspQo9b0AU3yMULMnN1p/ifQYJNruOGCUyD+wSjN8iMMqq7Cqr9DI
         vEQtyCuuzNBfWHGhijzVh6xIWmyna3mldxhJx8qplUdtouAGGgqvR3WJRNshXMfGDhUL
         uAAeL0X+juSnPqpemB6C0pz91a1toZhv3q3xyBGy1UEhlclzfdnLPWeBO6WShpKX4xob
         vjodsFfUQ1MxWgaZXfaNsgha444jIAS0WyrjRJ4JZ8deveDccA4t/vvMw+hRIovd8Vmm
         nPLFiVTT6niGgsPF4O16VX/v2qwAurtyVnLOehx2QeyEwm5YiPkT0DNk3QRiLQsF832B
         fZZQ==
X-Gm-Message-State: ALoCoQnkLwwcvRVDdMRpE3BDsMFXkZq64KUPrRl7vXRizgzXRX1c6ZqxcT8zSflx44RjJZ/tprWl
X-Received: by 10.55.54.65 with SMTP id d62mr35673676qka.59.1435610935455;
        Mon, 29 Jun 2015 13:48:55 -0700 (PDT)
Received: from ubuntu ([192.133.79.145])
        by mx.google.com with ESMTPSA id 197sm11946966qhq.23.2015.06.29.13.48.53
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 29 Jun 2015 13:48:54 -0700 (PDT)
In-Reply-To: <xmqq7fqm9ryv.fsf@gitster.dls.corp.google.com>
X-Mailer: Evolution 3.12.10-0ubuntu1~14.10.1 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/273018>


On Mon, 2015-06-29 at 13:31 -0700, Junio C Hamano wrote:
> David Turner <dturner@twopensource.com> writes:
> 
> > Minor formatting fixes from Junio Hamano.
> 
> There is another.

Would it be simpler for me to push this sort of fixup to github and and
just mention that a new patchset is available?  If so, here it is: 

https://github.com/dturner-tw/git.git
dturner/pluggable-backends-preamble

If not, I'll re-send.

Of course for real reviews, I'll continue sending patches to the mailing
list using git send-email.

> By the way, "unused variable" is not a formatting fix.

Indeed, it is not.

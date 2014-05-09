From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Submodule improvements (Re: What's cooking in git.git (Apr 2014,
 #09; Tue, 29))
Date: Thu, 8 May 2014 17:58:59 -0700
Message-ID: <20140509005859.GF9218@google.com>
References: <xmqq7g67iwxc.fsf@gitster.dls.corp.google.com>
 <20140505184546.GB23935@serenity.lan>
 <xmqqoazb944d.fsf@gitster.dls.corp.google.com>
 <536B3259.1050602@gmail.com>
 <536b38b55b7fc_4fa68b32eca@nysa.notmuch>
 <alpine.DEB.2.02.1405081739310.17457@nftneq.ynat.uz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Felipe Contreras <felipe.contreras@gmail.com>,
	Chris Packham <judge.packham@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	John Keeping <john@keeping.me.uk>, git@vger.kernel.org
To: David Lang <david@lang.hm>
X-From: git-owner@vger.kernel.org Fri May 09 02:59:11 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WiZ9a-0003bV-5k
	for gcvg-git-2@plane.gmane.org; Fri, 09 May 2014 02:59:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753520AbaEIA7F (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 May 2014 20:59:05 -0400
Received: from mail-pa0-f53.google.com ([209.85.220.53]:63395 "EHLO
	mail-pa0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751295AbaEIA7E (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 May 2014 20:59:04 -0400
Received: by mail-pa0-f53.google.com with SMTP id kp14so3546829pab.26
        for <git@vger.kernel.org>; Thu, 08 May 2014 17:59:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=7wztM2YMB7GAFQL+SRr7dwrVLDEJDZuIShI0suQ4+cE=;
        b=p6qxTAAGIwg43wv681OyqFEJF1h1IiGM/27cgrNuL3GiJe5t80+kzQNQlEjYVTIYkw
         0wkIAbpAILqzmGB5kfFVgjpnEWfJr8fMierbJ3I6tgYoYwuJ2us62sKwkwDaot5cY7i9
         DjgJZAd9jiCpdhNyWE3dyGivrpn+ztvWpa4Y+4/wuDZrSb5tpPMq+TpFoZRS0rXoeXRO
         AjraeRVqQAT5q4sF3hiIdbbz34fOhwL3Z3FiryXZYrXODGhmS/uvNiD1h7iwg63+is4u
         AMe9OHDC0YW0a81jRa9iZUJtH7BY68TSfsa1/fj5t0NJjG41KxiNWJk39qf7alyHjPRV
         7M1Q==
X-Received: by 10.66.180.168 with SMTP id dp8mr13938110pac.100.1399597142816;
        Thu, 08 May 2014 17:59:02 -0700 (PDT)
Received: from google.com ([2620:0:1000:5b00:b6b5:2fff:fec3:b50d])
        by mx.google.com with ESMTPSA id gu1sm4285426pbd.0.2014.05.08.17.59.01
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Thu, 08 May 2014 17:59:02 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.02.1405081739310.17457@nftneq.ynat.uz>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/248467>

Hi,

David Lang wrote:

> I haven't been paying close attention for a while, what would have
> to be done to make submodules "an integral part of Git"?

The series at
http://thread.gmane.org/gmane.comp.version-control.git/241455 is a
start.  I'm hoping to get a reroll done soon and then I can talk about
later steps.

https://github.com/jlehmann/git-submod-enhancements/wiki has a rough
roadmap, but really there's lots of commands that could be improved to
recurse into submodules and not many interdependencies involved so
anyone can bite off a chunk.

Thanks,
Jonathan

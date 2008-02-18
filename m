From: "Jay Soffian" <jaysoffian@gmail.com>
Subject: Re: [PATCH] Rename git-core rpm to just git and rename the meta-pacakge to git-all.
Date: Mon, 18 Feb 2008 09:51:02 -0500
Message-ID: <76718490802180651h2ad61c4cg50bae97000957397@mail.gmail.com>
References: <1203100163-17509-1-git-send-email-krh@redhat.com>
	 <7vskzs2exj.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: "=?UTF-8?Q?Kristian_H=C3=B8gsberg?=" <krh@redhat.com>,
	git@vger.kernel.org
To: "Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Feb 18 15:51:53 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JR7LL-0000Nq-4R
	for gcvg-git-2@gmane.org; Mon, 18 Feb 2008 15:51:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752185AbYBROvI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 Feb 2008 09:51:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752176AbYBROvH
	(ORCPT <rfc822;git-outgoing>); Mon, 18 Feb 2008 09:51:07 -0500
Received: from wr-out-0506.google.com ([64.233.184.225]:25395 "EHLO
	wr-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752102AbYBROvE (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Feb 2008 09:51:04 -0500
Received: by wr-out-0506.google.com with SMTP id c48so1525977wra.23
        for <git@vger.kernel.org>; Mon, 18 Feb 2008 06:51:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=XgZ4PvKrCGPEGoWvTUXidiRTxGAlJ6pAFngxTjs7nf8=;
        b=d98kUwY59F/+yWrURVSvichPvRUEt9xo5twogIfrTcxEzsJPpRHY/EEM0bt1lqPX0vFLsimFqXXho95QffiS1rXLTsq89ABdjy9JyHQlpVcVqM5ZpE+wVdCilQIQy6QYd0bAeTM7j3UrIi4+jBFrH1n4eJbu4nHu1FQi2sI/DbU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Kqp2kQ/v4RJ3mnAgqRpZ9RAHf9qzhuRTYpPHpkHgnVACfbRjXiJnRzzM0db64laQ8ypdakZpnYTRfKAdAXC14wjKYWfJ475dkJFEjKpE4aqroFYrOMQKVZyoVKb0b8K8HfWQq9/XxAQSK+SOipRqbPTLRnINBxF8dWw+d6NRrdc=
Received: by 10.114.78.1 with SMTP id a1mr1326649wab.14.1203346262634;
        Mon, 18 Feb 2008 06:51:02 -0800 (PST)
Received: by 10.114.255.11 with HTTP; Mon, 18 Feb 2008 06:51:02 -0800 (PST)
In-Reply-To: <7vskzs2exj.fsf@gitster.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/74299>

On Feb 17, 2008 2:57 AM, Junio C Hamano <gitster@pobox.com> wrote:

> "yum install git" and "yum install git-core" do not give such an
> error but the latter gives quite a bunch of errors ("yum install
> git" goes alright).  This is problem #2.

You probably want "yum upgrade git-core".

The "problem" is that yum by default doesn't process RPM renames (obsoletes)
unless you either have obsoletes=1 in your yum.conf, use "yum --obsoletes
update" or use "yum upgrade".

j.

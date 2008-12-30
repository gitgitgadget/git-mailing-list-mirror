From: "Ping Yin" <pkufranky@gmail.com>
Subject: Re: why still no empty directory support in git
Date: Tue, 30 Dec 2008 23:36:49 +0800
Message-ID: <46dff0320812300736x78e0086dq14fbd2c2f8f7f8c2@mail.gmail.com>
References: <46dff0320812291942y6aeec941k9394586621e9151b@mail.gmail.com>
	 <alpine.DEB.2.00.0812300008060.31590@vellum.laroia.net>
	 <3ab397d0812292128j65e2e1e1xf403a998f4653aac@mail.gmail.com>
	 <200812300758.41988.robin.rosenberg.lists@dewire.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: "Jeff Whiteside" <jeff.m.whiteside@gmail.com>,
	"Asheesh Laroia" <asheesh@asheesh.org>,
	"Git Mailing List" <git@vger.kernel.org>
To: "Robin Rosenberg" <robin.rosenberg.lists@dewire.com>
X-From: git-owner@vger.kernel.org Tue Dec 30 16:38:24 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LHgfc-0005G9-DG
	for gcvg-git-2@gmane.org; Tue, 30 Dec 2008 16:38:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752196AbYL3Pgw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 30 Dec 2008 10:36:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752135AbYL3Pgw
	(ORCPT <rfc822;git-outgoing>); Tue, 30 Dec 2008 10:36:52 -0500
Received: from yw-out-2324.google.com ([74.125.46.30]:17037 "EHLO
	yw-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750722AbYL3Pgv (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Dec 2008 10:36:51 -0500
Received: by yw-out-2324.google.com with SMTP id 9so1657993ywe.1
        for <git@vger.kernel.org>; Tue, 30 Dec 2008 07:36:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=/0abiAq03+1o7Dh5vLMr2tq50CmwEMIgv3x4onJm+vE=;
        b=F8KuUhYpfELt8GVlOVC8bYJVV4iKix/JJCyvb4MOd6IuUF9b0RbWRNq/gMphJtlhCC
         hxaHHfsaAWpByjqYVT5TYkYziBX93hI0jQUT7zwkhJAqXejnxIn8cOlMkm8i1+ZR65Da
         ZG+xrrddzoJaCyn3KLor24AOY8bSBMxE+sLDI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=PGvvHPFKSgj1fP29kE5IghSMbj3If2EnfRzdbw1LkQCw+4L1SB9jLtvm1QwPYO+M2i
         vYIei/22WRW0W3M4KQQEoUih+c+6w5RpepY+Pl6Uqq1N01was4peyGfX/BPdASz5+ybo
         F6nRks2eR8t1e5ga/eXjK4mEJoC3F5WSBSg/M=
Received: by 10.100.13.2 with SMTP id 2mr8367304anm.74.1230651410207;
        Tue, 30 Dec 2008 07:36:50 -0800 (PST)
Received: by 10.100.212.13 with HTTP; Tue, 30 Dec 2008 07:36:49 -0800 (PST)
In-Reply-To: <200812300758.41988.robin.rosenberg.lists@dewire.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/104190>

On Tue, Dec 30, 2008 at 2:58 PM, Robin Rosenberg
<robin.rosenberg.lists@dewire.com> wrote:

> You can have an empty tree, but the index doesn't store them,
> so they would be lost on checkout/commit. Linus sketched a solution,
> but nobody took the bait. Seems doable if anyone really wants it, but
> I'm certain it adds a lot of special cases.
>
> Look for a discussion [RFC PATCH] Re: Empty directories... posted on 2007-07-19.
> It's in the middle of a long thread.
>
Thanks for pointing me to that thread. For other's convenience, the
begin of the thread is
http://article.gmane.org/gmane.comp.version-control.git/52813

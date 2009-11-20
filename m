From: Jeenu V <jeenuv@gmail.com>
Subject: Re: Ambiguous ref names
Date: Fri, 20 Nov 2009 16:18:55 +0530
Message-ID: <5195c8760911200248v1f3d6b56q78987edfceae5541@mail.gmail.com>
References: <5195c8760911200218v5b75d690hbaaf00b44c8df6af@mail.gmail.com> 
	<7vzl6h3319.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Nov 20 11:51:36 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NBR3P-0000Ip-2N
	for gcvg-git-2@lo.gmane.org; Fri, 20 Nov 2009 11:49:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752740AbZKTKtN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 Nov 2009 05:49:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752736AbZKTKtL
	(ORCPT <rfc822;git-outgoing>); Fri, 20 Nov 2009 05:49:11 -0500
Received: from mail-vw0-f192.google.com ([209.85.212.192]:38669 "EHLO
	mail-vw0-f192.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752717AbZKTKtJ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Nov 2009 05:49:09 -0500
Received: by vws30 with SMTP id 30so881882vws.33
        for <git@vger.kernel.org>; Fri, 20 Nov 2009 02:49:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type;
        bh=aC544TUHKH67UpHGmXPUuY5tfoKPyhtj5++Ho272gYw=;
        b=Z36k9Y3eQo0kZ7PMAWp4oNNxwPu7gLtIEZ0XtbrcSnusHPodsu14zWOwjzrsXznheq
         xg7UYEsNMAs51sOWK4rUkmSgvSaBqWiznZ3XTS9Fcx9ZpudObKqEfFwzurfWj4dDdnV6
         C7auX5Vos9SFUeP0cXfG205+ihf3jkW9SVxUg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=u7kUU5xWaf6vCDXpoOjiZb3Ivgty0rdJ6l3Xk2cxET9FdPZ/SRVocIKS+n54aEdyg+
         K6F+n+6CTlgiY4QvqgdqWj5AepEF/FCtt+FW8EpLaJBKI0IDXzD6Nyj3APS6EsBQxMAL
         tmMSJN/Nk87wDsLl/+nT8Az6QhktnqlnMP7AI=
Received: by 10.220.125.40 with SMTP id w40mr1682091vcr.17.1258714155094; Fri, 
	20 Nov 2009 02:49:15 -0800 (PST)
In-Reply-To: <7vzl6h3319.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/133329>

On Fri, Nov 20, 2009 at 3:56 PM, Junio C Hamano <gitster@pobox.com> wrote:
> [...]
> It could be that you have a tag and a branch that are both named a.b.c,
> though.

Hm, right. But I'm getting this from an existing local repo of mine. I
can't see any tags; 'git tag -l' is empty. Is there any more info that
I can provide?

FWIW, I'm running Git under Cygwin.
-- 
:J

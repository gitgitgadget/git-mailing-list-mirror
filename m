From: Nicolas Sebrecht <nicolas.s.dev@gmx.fr>
Subject: Re: Parameter --color-words not documented for "git show"
Date: Fri, 21 Jan 2011 00:16:49 +0100
Message-ID: <20110120231649.GC14184@vidovic>
References: <4D3893EA.5090907@hartwork.org>
 <201101202127.39962.trast@student.ethz.ch>
 <4D389E69.608@hartwork.org>
 <7vk4hzqnbx.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Sebastian Pipping <webmaster@hartwork.org>,
	Thomas Rast <trast@student.ethz.ch>,
	Git ML <git@vger.kernel.org>,
	Nicolas Sebrecht <nicolas.s.dev@gmx.fr>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jan 21 00:17:03 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pg3kT-0000wo-Fv
	for gcvg-git-2@lo.gmane.org; Fri, 21 Jan 2011 00:17:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755617Ab1ATXQ4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 20 Jan 2011 18:16:56 -0500
Received: from mail-ww0-f44.google.com ([74.125.82.44]:55684 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754104Ab1ATXQz (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 Jan 2011 18:16:55 -0500
Received: by wwa36 with SMTP id 36so1247046wwa.1
        for <git@vger.kernel.org>; Thu, 20 Jan 2011 15:16:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=VIt6vWiQjiVu5NwPEUpF4SKfgpPF34dn0p6aAycydyE=;
        b=OJmYbquJOd6/0n/3WUXkVzzR7uawpmO0PFMqenas7CF+8Ut9HfDwPzYrJgtRDVZPMC
         7audLHtYC5H2/kj8Nmr90m1e2lD7YB8v8t7r3mDtMVXGHqmrA9XfoPII3iYsjP9SkTgQ
         +nJpRS9oENJY61hYVp6JjxnzTGcWztGcWVFLE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=lAxD65IvUFC3wVdWwMN5fQL9XIdvS+4fHZNQ80oxaBM014+lNZMVn3JSGnt921Gel7
         2UQsLMCuhky+cnOhSwEhCr2pf7c9K7FExvlAbbVuqk3pFblXYrVmg3O2WgfJSC/tBV0m
         oltbA3sGOlJKx4QuChNkqsewXqhrotpZFJ8Bo=
Received: by 10.216.89.71 with SMTP id b49mr2586984wef.28.1295565414704;
        Thu, 20 Jan 2011 15:16:54 -0800 (PST)
Received: from vidovic (aqu33-8-83-155-187-36.fbx.proxad.net [83.155.187.36])
        by mx.google.com with ESMTPS id o51sm4551004wes.15.2011.01.20.15.16.52
        (version=SSLv3 cipher=RC4-MD5);
        Thu, 20 Jan 2011 15:16:53 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <7vk4hzqnbx.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/165343>

The 20/01/11, Junio C Hamano wrote:
> Sebastian Pipping <webmaster@hartwork.org> writes:
> 
> > On 01/20/11 21:27, Thomas Rast wrote:
> >> Quote from the latter:
> >> 
> >>        This manual page describes only the most frequently used options.
> >
> > Okay.  Is that a good a idea?
> 
> Yes; the alternative is to list everything.

Would it be bad? I tend to think that a manual page is the good place to
list everything the program accepts as parameters and how to use them.
FMHO, Manual page is not where newcomers look to learn but it should
help everybody to find and understand all of the available options.

-- 
Nicolas Sebrecht

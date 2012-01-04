From: =?UTF-8?Q?Jakub_Nar=C4=99bski?= <jnareb@gmail.com>
Subject: Re: [BUG] gitweb generates wrong links in grep search results (git_search_files)
Date: Wed, 4 Jan 2012 17:21:25 +0100
Message-ID: <CANQwDwfnp167Uth5TLbCD6OR-Xe6JD-2vENiJVnipi1YdjnMPQ@mail.gmail.com>
References: <CA+uOhx6i-07kW8K0y3Co++2ABD=Lmaq3r4h1hN4YLskAE+hR1Q@mail.gmail.com>
 <7vhb0cqpix.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Thomas Perl <th.perl@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jan 04 17:21:54 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RiTb7-0002XC-LY
	for gcvg-git-2@lo.gmane.org; Wed, 04 Jan 2012 17:21:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756268Ab2ADQVt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 Jan 2012 11:21:49 -0500
Received: from mail-ee0-f46.google.com ([74.125.83.46]:40007 "EHLO
	mail-ee0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751993Ab2ADQVr (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Jan 2012 11:21:47 -0500
Received: by eekc4 with SMTP id c4so16787720eek.19
        for <git@vger.kernel.org>; Wed, 04 Jan 2012 08:21:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=SlJZb1Kpbj60mIJllTC3ZNUxsG5106yqWTs3wM17fDA=;
        b=p8McYkntb+5BEdlcCFeR9D7/ZQfOfh8N5j56yAxTfoNYBk4+h6PXdJob+dF2IvGw5H
         xFnNA+NrgLL7kSPjVxrxji6rebmp0tnTX30a8OKxhtWu8q2b6vtesctFyOtsupgQ4gm/
         MTaEnrA2MleeHUhP66T7ZcaqzLkS6PT8OBbFE=
Received: by 10.14.94.67 with SMTP id m43mr23059962eef.50.1325694106233; Wed,
 04 Jan 2012 08:21:46 -0800 (PST)
Received: by 10.213.29.145 with HTTP; Wed, 4 Jan 2012 08:21:25 -0800 (PST)
In-Reply-To: <7vhb0cqpix.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/187932>

On Wed, Jan 4, 2012 at 1:28 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Thomas Perl <th.perl@gmail.com> writes:
>
>> I think I found a bug in gitweb when grep'ing for text in a branch
>> different from "master". Here's how to reproduce it:
>
> Thanks for a detailed report (and thanks for gpodder ;-).
>
> Jakub, care to take a look?

I see the bug: it should be 'hash_base' not 'hash' in href()
creating link to "blob" view in git_search_files().

I'll try to send a fix soon...
-- 
Jakub Narebski

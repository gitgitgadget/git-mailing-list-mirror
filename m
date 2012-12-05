From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: remote-testsvn: Hangs at revision
Date: Wed, 5 Dec 2012 19:27:08 +0530
Message-ID: <CALkWK0mAN=qUs893G1ifPuJofWTVzsBYY02fNaSpge2e78pq+g@mail.gmail.com>
References: <CALkWK0meveeKQe81hHyojPX0GH_WRrv7ob9-NA1Q7-TuKso+1w@mail.gmail.com>
 <D435D46EAB6F419CA0608075751C351C@rr-dav.id.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>,
	Florian Achleitner <florian.achleitner.2.6.31@gmail.com>
To: David Michael Barr <b@rr-dav.id.au>
X-From: git-owner@vger.kernel.org Wed Dec 05 14:57:51 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TgFTx-00056F-82
	for gcvg-git-2@plane.gmane.org; Wed, 05 Dec 2012 14:57:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752201Ab2LEN53 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 5 Dec 2012 08:57:29 -0500
Received: from mail-oa0-f46.google.com ([209.85.219.46]:34766 "EHLO
	mail-oa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751587Ab2LEN53 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Dec 2012 08:57:29 -0500
Received: by mail-oa0-f46.google.com with SMTP id h16so5070670oag.19
        for <git@vger.kernel.org>; Wed, 05 Dec 2012 05:57:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=A0lXjT7nxmN3an+rNAVY3v3oaANHM7LNn0dCgF2Spg8=;
        b=nMow5QYdWfCETN/gh3gs7q+NK2WLx68AvKqX19qeOA0OxLfum3BmMMXjikBPGruAKe
         eAV9/vFjmdhguw+3/N+b4K5gFiTTqncHlNzLgPNJGvYEOIzP3phvz0wQWpwwkc1EEGf4
         yenYvnkBxdaFdPwMS4rS6PhHnA1jhMoeqXGHlMrQjTTbKBVUCZIrY3qZb6mBkye9UDfn
         oDRhWPSSE7gmD2GP914JrdfdaY98IwoZYRPrZ1Et+vXBTSy8JaY9oHVZfCiPohrctW2o
         eQgugBHCXg6QPPaMWyL9zzqmHr0VKpwbo+Ancr9EQKwxhMdHTC4ZsbibnfA3hUR2XweZ
         BfmA==
Received: by 10.182.188.36 with SMTP id fx4mr10096993obc.6.1354715848313; Wed,
 05 Dec 2012 05:57:28 -0800 (PST)
Received: by 10.76.75.198 with HTTP; Wed, 5 Dec 2012 05:57:08 -0800 (PST)
In-Reply-To: <D435D46EAB6F419CA0608075751C351C@rr-dav.id.au>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/211125>

David Michael Barr wrote:
> On Wednesday, 5 December 2012 at 5:20 PM, Ramkumar Ramachandra wrote:
>> $ git clone testsvn::http://python-lastfm.googlecode.com/svn/trunk/
> I attempted to clone the same repository and was able to fetch 152 revisions.
> So the issue Ram saw might have been temporal.

Nope, I'm able to reproduce it everytime.  I wonder what's going on.

Ram

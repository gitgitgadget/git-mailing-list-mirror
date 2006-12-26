From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: cgit vs. gitweb
Date: Tue, 26 Dec 2006 01:32:40 +0100
Message-ID: <200612260132.41062.jnareb@gmail.com>
References: <8c5c35580612250921o765e141cq27f81b06364d0a4@mail.gmail.com> <empikd$s32$1@sea.gmane.org> <8c5c35580612251604s5e211518yd958fdc2e73232ef@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: "Git Mailing List" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Dec 26 01:30:07 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by dough.gmane.org with esmtp (Exim 4.50)
	id 1Gz0Ck-0005kA-WE
	for gcvg-git@gmane.org; Tue, 26 Dec 2006 01:30:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754601AbWLZA3z (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 25 Dec 2006 19:29:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754605AbWLZA3z
	(ORCPT <rfc822;git-outgoing>); Mon, 25 Dec 2006 19:29:55 -0500
Received: from ug-out-1314.google.com ([66.249.92.171]:61524 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754601AbWLZA3y (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Dec 2006 19:29:54 -0500
Received: by ug-out-1314.google.com with SMTP id 44so3532513uga
        for <git@vger.kernel.org>; Mon, 25 Dec 2006 16:29:53 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=b0VFB5R7m++oyUJW7K/w6ozF/DYkLD/29hXJDbZ2IQzs5aElLA+5sxYNlFsT1VH9hT5qgKZLjoHeBZdg4gxGweLnV4GC0yAIr+xdoW7aGnqoTjpPXqKS3gedty9mfRBdNvnOtQ+ZV14sp0mg6VPai+TozaagnXGWBeAqbNGTl5I=
Received: by 10.66.219.11 with SMTP id r11mr1593186ugg.1167092993147;
        Mon, 25 Dec 2006 16:29:53 -0800 (PST)
Received: from host-81-190-19-121.torun.mm.pl ( [81.190.19.121])
        by mx.google.com with ESMTP id h1sm17437019ugf.2006.12.25.16.29.52;
        Mon, 25 Dec 2006 16:29:53 -0800 (PST)
To: "Lars Hjemli" <hjemli@gmail.com>
User-Agent: KMail/1.9.3
In-Reply-To: <8c5c35580612251604s5e211518yd958fdc2e73232ef@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/35401>

Lars Hjemli wrote:
> On 12/25/06, Jakub Narebski <jnareb@gmail.com> wrote:
>> Lars Hjemli wrote:
>>
>>> I wanted to compare cgit against gitweb to see the effect of using
>>> libgit and internal caching. So I ran the attached scripts against
>>> http://hjemli.net/git/ and http://hjemli.net/cgi-bin/gitweb.cgi as a
>>> very simplistic benchmark.

[...] 

>> Could you include ApacheBench (ab) results?
> 
> Sure (I didn't know about this tool, thanks for the pointer)
> 
> Here's the result of a few requests:
[snip]
> This does seem to confirm the results of my homemade scripts.

By the way, which version of gitweb did you use (shortened sha1 of 
commit, or result of git-describe)? I'm interested if it is before
or after Robert Fitzsimons patches which replaced 101 forks in
log-like views with 1 fork, which I think affects gitweb performance
a lot.

The page which is optimized is summary view, if you use projects_list
and not projectroot directory...
-- 
Jakub Narebski
Poland

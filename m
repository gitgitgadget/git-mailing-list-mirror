From: Avery Pennarun <apenwarr@gmail.com>
Subject: Re: [PATCH] Clarification for the command "git checkout <branch>"
Date: Thu, 18 Mar 2010 12:36:17 -0400
Message-ID: <32541b131003180936x746dad06k386788d3cb6fcdeb@mail.gmail.com>
References: <4B67227A.7030908@web.de> <7vhbq0wuy6.fsf@alter.siamese.dyndns.org> 
	<4B898F97.90706@web.de> <7vr5o6s5xf.fsf@alter.siamese.dyndns.org> 
	<4B8B9BF1.10408@web.de> <4b8bf32f.0706c00a.26cb.691d@mx.google.com> 
	<4BA104C7.5020207@web.de> <32541b131003170944w7a0215frcace205f32d313bf@mail.gmail.com> 
	<7vaau6q18q.fsf@alter.siamese.dyndns.org> <4BA1FC39.10300@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Junio C Hamano <gitster@pobox.com>,
	Michael Witten <mfwitten@gmail.com>, git@vger.kernel.org
To: Markus Elfring <Markus.Elfring@web.de>
X-From: git-owner@vger.kernel.org Thu Mar 18 17:42:40 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NsInr-0004RI-P9
	for gcvg-git-2@lo.gmane.org; Thu, 18 Mar 2010 17:42:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752723Ab0CRQmV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Mar 2010 12:42:21 -0400
Received: from mail-gy0-f174.google.com ([209.85.160.174]:57313 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751618Ab0CRQmU (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Mar 2010 12:42:20 -0400
Received: by gyg8 with SMTP id 8so1144770gyg.19
        for <git@vger.kernel.org>; Thu, 18 Mar 2010 09:41:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type;
        bh=Ih+kNHJEakyYZPegVC8YzQNfgbzKQNMKgkE1qsKe4Wk=;
        b=daTEoorG2W0D72Ps+/f7sk3S2Zb+l9lqUZC2VDhunf51OyyD1kkq2dzhFdcVz0y5bs
         ewl2AGDU21a4PLAR7dWWfjqsjN39T27d4Z1mGQBEp8yv+9Tomy6wJBJ7c+QxxlVChSB9
         f7e7ZQ5oRXEjoPELs8BrljRMmhpV+h++0Ttb4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=p0Smfi+SiukSJyciKGLn4P6+vGX3b60/30+Rc8X6+E3B6RAsuf1P1M82QQI1Nt8Z6R
         m2TUeYgAJ6MjXQ/QKm4GiZmDedfEwdoo8yuw8PT4fWsRa9ei8Zucr7MbmtNwfZXzb8+a
         zwlHdv335G9D9Cqs5PFlT1+VHluraA0eFFB9I=
Received: by 10.150.47.15 with SMTP id u15mr326721ybu.102.1268930197081; Thu, 
	18 Mar 2010 09:36:37 -0700 (PDT)
In-Reply-To: <4BA1FC39.10300@web.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/142481>

On Thu, Mar 18, 2010 at 6:11 AM, Markus Elfring <Markus.Elfring@web.de> wrote:
>> You may want retry the command after recording the local changes
>> (1) in a temporary commit on the current branch,
>
> Can commits be consistently marked for intermediate use?
> Can such "special" commits be easily found later on?

You just make the commit with a 'FIXME' type commit message, then 'git
commit --amend' to fix it when you come back later.

>> or (2) by using "git stash".
>
> Is this storage operation supported per branch?
> Does a checkout look if any files were stashed away for the specified branch before?

stashing isn't really something you'd want to do on a per-branch
basis.  Most of the point is that you stash away your changes, then
switch to another branch, then restore your stash to your *current*
working state sometime later.

Have fun,

Avery

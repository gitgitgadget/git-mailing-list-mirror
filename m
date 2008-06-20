From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [q] git-diff --reverse 7def2be1..7def2be1^
Date: Fri, 20 Jun 2008 03:05:30 -0700 (PDT)
Message-ID: <m3d4mcmq20.fsf@localhost.localdomain>
References: <20080620082034.GA24913@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Ingo Molnar <mingo@elte.hu>
X-From: git-owner@vger.kernel.org Fri Jun 20 12:07:19 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K9dWL-0005tW-PA
	for gcvg-git-2@gmane.org; Fri, 20 Jun 2008 12:07:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754217AbYFTKFi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 Jun 2008 06:05:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754172AbYFTKFi
	(ORCPT <rfc822;git-outgoing>); Fri, 20 Jun 2008 06:05:38 -0400
Received: from ik-out-1112.google.com ([66.249.90.183]:62426 "EHLO
	ik-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753872AbYFTKFe (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Jun 2008 06:05:34 -0400
Received: by ik-out-1112.google.com with SMTP id c28so661127ika.5
        for <git@vger.kernel.org>; Fri, 20 Jun 2008 03:05:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received
         :x-authentication-warning:to:cc:subject:references:from:in-reply-to
         :message-id:lines:user-agent:mime-version:content-type:date;
        bh=Lx75FM1VptsU9uzr/SBN1MQWBGhijlaNUCqXwgXFL8E=;
        b=i7mLnIilaqeFpKAiWt55Se02Uked4GtVRMCFzDgRnJGh+QbIt9aezDXjWd909YyGql
         mUQFLauBxmDGvvhHhlDzjpMKV8VjDBBVnxsZqib16KgLMWsd9TkdFQfmy1izO9vrhcuu
         rUJUUHyvtAmj4zauPpo5F9u5Eok5kFdl/rmJ4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:in-reply-to
         :message-id:lines:user-agent:mime-version:content-type:date;
        b=f5w5OiNqGMpNFx3KfHfGeJ7sT63qApiu0XBHQEXMdYkgWxHXzLxb4zJaRoOxGoGyk0
         rhC2C+4jDWWYAaxlvRSlfvE3U7euN0/NfEXqzty4RBdNk4E0xnFeosvxzM4RMYqwGkt5
         /aS3rmeOQwF9zAdXZSZFCcFnGXKVS3u+PVjLE=
Received: by 10.210.122.5 with SMTP id u5mr2837884ebc.73.1213956331571;
        Fri, 20 Jun 2008 03:05:31 -0700 (PDT)
Received: from localhost.localdomain ( [83.8.208.51])
        by mx.google.com with ESMTPS id z40sm2543859ikz.7.2008.06.20.03.05.29
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 20 Jun 2008 03:05:30 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id m5K98e7w005318;
	Fri, 20 Jun 2008 11:08:41 +0200
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id m5K98d2D005315;
	Fri, 20 Jun 2008 11:08:39 +0200
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <20080620082034.GA24913@elte.hu>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/85615>

Ingo Molnar <mingo@elte.hu> writes:

> I've got two observations / potential suggestions:
> 
> 1) the SHA1 is duplicated above, is there a way to avoid it? Initially i 
>    tried the obvious extension:
> 
>       git-diff --reverse 7def2be1..^
> 
>    But Git didnt recognize that as a valid commit range.

There is shortcut for rev^..rev, namely rev^! (I'm not sure if it is
documented anywhere, though), so you could have used

        git diff 7def2be1^!
 
>    [ time passes as i read the manpage - the final thing i do when
>      every other measure fails ;-) ]
> 
>    Ah, there's "git-log -R" that would achieve this. 

I think you should have done this first...

-- 
Jakub Narebski
Poland
ShadeHawk on #git

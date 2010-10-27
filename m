From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [BUG?] t9500 --debug prints "sh: ++GIT_BINDIR++/git: not found"
Date: Wed, 27 Oct 2010 15:32:01 -0700 (PDT)
Message-ID: <m3k4l3i7y9.fsf@localhost.localdomain>
References: <20101027204954.GA31386@burratino>
	<m3ocafib6z.fsf@localhost.localdomain>
	<20101027213405.GA10263@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Thu Oct 28 00:32:14 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PBEXU-0003qS-RL
	for gcvg-git-2@lo.gmane.org; Thu, 28 Oct 2010 00:32:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755091Ab0J0WcG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Oct 2010 18:32:06 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:50311 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752256Ab0J0WcF (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Oct 2010 18:32:05 -0400
Received: by fxm16 with SMTP id 16so1208005fxm.19
        for <git@vger.kernel.org>; Wed, 27 Oct 2010 15:32:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received
         :x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        bh=QDCQ4mbRQ0kxwGn2p3g2BVZLRZxc3o/zs0HjIwTiGv0=;
        b=lGqiYfiU0NGCYpax+t7qPLkKsLXVC+D6C3iL+DXuX7gJ2/B7KvuAoHAhpTz2s6C9nM
         0NEoh7Mg+oQwX4HK1yTR/ilq00I8kgxWS3xpPOuk8h5OltSJC+VVWTpP80JOgR4f+9Ph
         F99M9PeUsS3dYWTaKxT2wtEMfD0q9a+NiVr9c=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        b=BjWEWLMR6tfV1vLaCDYKlJFwAC7uKWFUI7AdmQfMCyN+ZL/fVmaJKSZy0hoi2ZH5nM
         +birwInEq548gmcaTBWdhw+AD6HFiJIrIi1tPXCjoViMOKYFRuGT5C5OJYrPs5bB7hZG
         F9u9dODLZz7AEL3YNj0s9ZOCbGJ7kFcbX/bPs=
Received: by 10.223.83.198 with SMTP id g6mr3049676fal.69.1288218722915;
        Wed, 27 Oct 2010 15:32:02 -0700 (PDT)
Received: from localhost.localdomain (abvr250.neoplus.adsl.tpnet.pl [83.8.215.250])
        by mx.google.com with ESMTPS id p2sm177226fak.22.2010.10.27.15.32.00
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 27 Oct 2010 15:32:01 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id o9RMVbIZ031959;
	Thu, 28 Oct 2010 00:31:47 +0200
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id o9RMVQQH031956;
	Thu, 28 Oct 2010 00:31:26 +0200
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <20101027213405.GA10263@burratino>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/160128>

Jonathan Nieder <jrnieder@gmail.com> writes:
> Jakub Narebski wrote:
>> Jonathan Nieder <jrnieder@gmail.com> writes:
>> 
>>>  sh: ++GIT_BINDIR++/git: not found
>>>  ok 3 - no commits: .git summary (implicit)
>>>  [...]
> [...]
>> Fixed in 8ff76f4 (gitweb: Move call to evaluate_git_version after
>> evaluate_gitweb_config, 2010-09-26):
> 
> Oh!  Yes, that works.  Thanks and sorry for the noise.

You are welcome.

I should have perhaps choose comit title differently, e.g.:

  gitweb: Fix ./t950* --debug

or something like that.
-- 
Jakub Narebski
Poland
ShadeHawk on #git

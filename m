From: Paolo Bonzini <bonzini@gnu.org>
Subject: Re: default aliases (ci, di, st, co)
Date: Fri, 10 Jul 2009 01:08:27 +0200
Message-ID: <4A56786B.7040904@gnu.org>
References: <85b5c3130907081649s37f726f7id1a64f2fdbe609f@mail.gmail.com> <m3my7evhky.fsf@localhost.localdomain> <7vskh53iyt.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Jakub Narebski <jnareb@gmail.com>,
	Ondrej Certik <ondrej@certik.cz>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jul 10 01:08:40 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MP2jH-00085g-4V
	for gcvg-git-2@gmane.org; Fri, 10 Jul 2009 01:08:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750838AbZGIXIb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 9 Jul 2009 19:08:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750756AbZGIXIb
	(ORCPT <rfc822;git-outgoing>); Thu, 9 Jul 2009 19:08:31 -0400
Received: from mail-bw0-f225.google.com ([209.85.218.225]:45840 "EHLO
	mail-bw0-f225.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750744AbZGIXIa (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 Jul 2009 19:08:30 -0400
Received: by bwz25 with SMTP id 25so516123bwz.37
        for <git@vger.kernel.org>; Thu, 09 Jul 2009 16:08:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:sender:message-id:date:from
         :user-agent:mime-version:newsgroups:to:cc:subject:references
         :in-reply-to:content-type:content-transfer-encoding;
        bh=omOtx3E70NjqRjlTNdo0FoOBKVCWpVVtsG844UqyL+g=;
        b=R0CmKslZ3/Qa2KNY4iSM+L7fjLuJ9qOnDUb5nfaEnIghN8Co1tKla6pJls6KqigAsA
         5a4Ab7eB0Ozk36brPLj0a+YfThY5l2RWCxmMEbe4Ibp8nK6UCtHAxbsokuiiZIbVe0WM
         Ca2+Cs4OePxAWOg5lnXYJokjWZhzgP+Q3Txhw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=sender:message-id:date:from:user-agent:mime-version:newsgroups:to
         :cc:subject:references:in-reply-to:content-type
         :content-transfer-encoding;
        b=xxxNAVov7DQTB8K7p/K/zsGLkuelf+IgPT448jDsqd92MTKt9PeYb4UN+DEOsxKJT5
         cB8cGqrj5FIwI8PC2zazmrnXAAAViMwGgc7KfRBAUQ2YvVu9i53dOWV/hjQAQcFX97Q4
         xf744GpvnsfNzuiztC7R4pJwauliF7gNuWv9o=
Received: by 10.204.100.71 with SMTP id x7mr1230213bkn.130.1247180908499;
        Thu, 09 Jul 2009 16:08:28 -0700 (PDT)
Received: from yakj.usersys.redhat.com ([85.93.118.17])
        by mx.google.com with ESMTPS id 1sm855361fks.41.2009.07.09.16.08.27
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 09 Jul 2009 16:08:27 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1b3pre) Gecko/20090513 Fedora/3.0-2.3.beta2.fc11 Lightning/1.0pre Thunderbird/3.0b2
Newsgroups: gmane.comp.version-control.git
In-Reply-To: <7vskh53iyt.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/123018>

On 07/09/2009 06:43 PM, Junio C Hamano wrote:
> Jakub Narebski<jnareb@gmail.com>  writes:
>
>>          one = show -s --pretty='format:%h (%s)'
>
> If you use "git one" for quoting a commit in the log message, please use a
> format that shows the date as well (I think I posted mine to the list in
> the past).

Yes, it's in the wiki and in my .gitconfig:

         whatis = "!sh -c 'git show -s --pretty=\"format:%h (%s, %ai\" 
\"$@\" | sed -e \"s/ [012][0-9]:[0-5][0-9]:[0-5][0-9] 
[-+][0-9][0-9][0-9][0-9]$/)\\n/\"' -"

BTW, the wiki shows a nice trick to avoid the extra ' quotation:

         whatis = "!f() { git show -s --pretty='format:%h (%s, %ai' 
\"$@\" | sed -e 's/ [012][0-9]:[0-5][0-9]:[0-5][0-9] 
[-+][0-9][0-9][0-9][0-9]$/)\\n/'; }; f"


Paolo

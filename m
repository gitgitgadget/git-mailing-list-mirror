From: MALET Jean-Luc <jeanluc.malet@gmail.com>
Subject: Re: merging multiple commit into one?
Date: Tue, 12 May 2009 00:11:29 +0200
Message-ID: <4A08A291.2060009@gmail.com>
References: <1de9d39c0905110621p6858bca8y8bb036a167754672@mail.gmail.com> <m38wl3n3zj.fsf@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git <git@vger.kernel.org>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Tue May 12 00:12:36 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M3dje-0005lv-O9
	for gcvg-git-2@gmane.org; Tue, 12 May 2009 00:12:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755743AbZEKWMa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 May 2009 18:12:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755548AbZEKWMa
	(ORCPT <rfc822;git-outgoing>); Mon, 11 May 2009 18:12:30 -0400
Received: from mail-ew0-f224.google.com ([209.85.219.224]:47609 "EHLO
	mail-ew0-f224.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755314AbZEKWM3 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 May 2009 18:12:29 -0400
Received: by mail-ew0-f224.google.com with SMTP id 24so3807542ewy.37
        for <git@vger.kernel.org>; Mon, 11 May 2009 15:12:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:cc:subject:references:in-reply-to
         :content-type:content-transfer-encoding;
        bh=G7SVmiXbArjru0kOEVQalKtiZVcO4h9Z+u1LXMm8eaw=;
        b=Ind4E5iB3orvyv74/f90/s4laQWNE7FUxbgA0ButmWJf3l1Wd3lqqecAAuyJ3vvCwX
         Vl4k3cyyDu5eKFk2+V84H+afX32AhYzSH2HIJqqaxqPx6njmqPcsEKgXjK34XpS0PPKb
         YZCo/9Gr5xKYN1H6rFa6F9fX8j9aMtydREUuI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        b=KS2kfnZtI2oEhKVPJ+qhTRSNGeIKSvt3WNfSdMlUena/1Br25I7BRXOdnF1z5Kfh8p
         GAoVgPOQ5V5vfMfkaYzIfa7miOHy3bAXT8FMaGb9+eX95tyZxguNu40TuOHh2FWGxXge
         O+heVIQ7qrVGNPKRFwg9bnwYeFSGU60go1q+Y=
Received: by 10.210.92.8 with SMTP id p8mr5873090ebb.6.1242079950067;
        Mon, 11 May 2009 15:12:30 -0700 (PDT)
Received: from jlmport.sorcerer (124.115.97-84.rev.gaoland.net [84.97.115.124])
        by mx.google.com with ESMTPS id 10sm364579eyd.32.2009.05.11.15.12.28
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 11 May 2009 15:12:29 -0700 (PDT)
User-Agent: Thunderbird 2.0.0.18 (X11/20090308)
In-Reply-To: <m38wl3n3zj.fsf@localhost.localdomain>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/118854>

Jakub Narebski wrote:
> jean-luc malet <jeanluc.malet@gmail.com> writes:
>
>   
>> Hi,
>> I often commit "useless" code, for example before going into weekend
>> or for saving some state during a dev process
>> often thoses commit are simply useless and the commit message looks
>> like "COMPILE ERROR - temporary save .... "
>> at the end I have LOT of theses commits that are useless and I want to
>> save some space/time/tree complexity merge multiple sequential commits
>> (without branch) into one
>> is it possible?
>>     
>
> It is possible; one solution would be to use "git rebase --interactive"
> and its 'squash' command...
>
>   
>> according to my knowledge of git, removing the commit and rewriting
>> the last commit log so that it better reflect the modification will do
>> the job but I'm not sure git allow it...
>>     
>
> ...but you can simply pick up where you saved snapshot by using "git
> commit --amend" (or doing soft or mixed reset to previous commit
> before comitting changes).
>
>   
hi! thanks for your answers!
I didn't knew about --amend for commit, will certainly use it...
however it seems that I get missunderstood...
A-o-o-o-o-o-B-o-o-o-o-C
                      \-o-o-D-/
let say I have the above tree, o are temporary unbuildable commits, A B 
C D are usable versions
I want as posteriory remove the o to get the following tree
A-B---C
     \-D/
in fact I just wanna clean a little my tree since I forgot to amend ;)
is this possible?
ok I know, the best is to prevent! not to cure! so I'll amend ;)
thanks
JLM

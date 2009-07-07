From: Paolo Bonzini <paolo.bonzini@gmail.com>
Subject: Re: Does CVS has a easy way to compare file with its previous version?
Date: Tue, 07 Jul 2009 21:57:46 +0200
Message-ID: <4A53A8BA.6060505@gmail.com>
References: <1e56aa11-735a-47f7-a273-5b6bf611f528@n11g2000yqb.googlegroups.com>	 <m3hbxxx5jk.fsf@localhost.localdomain> <4A4A9FA5.7000009@gnu.org>	 <alpine.LFD.2.01.0906301813480.3605@localhost.localdomain>	 <loom.20090702T174843-784@post.gmane.org> <4A4DA7A5.7020303@gnu.org> <279b37b20907061639o6d6c72e7qf7bbc2459c7fc77e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Paolo Bonzini <bonzini@gnu.org>, git@vger.kernel.org
To: Eric Raible <raible@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jul 07 21:58:16 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MOGnw-0006qC-4t
	for gcvg-git-2@gmane.org; Tue, 07 Jul 2009 21:58:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757079AbZGGT5v (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 Jul 2009 15:57:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757221AbZGGT5u
	(ORCPT <rfc822;git-outgoing>); Tue, 7 Jul 2009 15:57:50 -0400
Received: from mail-bw0-f225.google.com ([209.85.218.225]:45267 "EHLO
	mail-bw0-f225.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757073AbZGGT5t (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Jul 2009 15:57:49 -0400
Received: by mail-bw0-f225.google.com with SMTP id 25so2315452bwz.37
        for <git@vger.kernel.org>; Tue, 07 Jul 2009 12:57:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:cc:subject:references:in-reply-to
         :content-type:content-transfer-encoding;
        bh=+Zp1I4dkXylssVCVPmDSfAWYje2aKsBLMst6/NZZQIU=;
        b=SOV9UyEHk//LBq0bzk0k8rzhXNyAtGe3yw2zXeBZPt54LDwZaEw8FMuiLN3jvVjFmP
         W5jX0+3CTwDqjwYa/HBd/9eAPhcseZMbSGmpy6h4+PWGL9YV0PCPSVg8j6O39yRbkzMx
         HDhNAXqSEAPwOHgX9N3I1kTRhCi54xr5hWM2k=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        b=uZiLtQzXs/2VATFgCBNL9ph0nX/SCGm/rs9+aREv7SxknQg7KKRxgUU/22nwrC2ma/
         zbsQhvsI7zHb2blH54q5noAsxWCtjnWTb7tPoq/g4wSM4HcDM1kTFNkZzS5nFL9+zq4x
         zTWAtrAGQO5oUCXCGuzcI1lmqFN54kbIjG31w=
Received: by 10.102.219.8 with SMTP id r8mr3598420mug.0.1246996668398;
        Tue, 07 Jul 2009 12:57:48 -0700 (PDT)
Received: from yakj.usersys.redhat.com ([85.93.118.17])
        by mx.google.com with ESMTPS id i7sm7722341mue.48.2009.07.07.12.57.47
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 07 Jul 2009 12:57:47 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1b3pre) Gecko/20090513 Fedora/3.0-2.3.beta2.fc11 Lightning/1.0pre Thunderbird/3.0b2
In-Reply-To: <279b37b20907061639o6d6c72e7qf7bbc2459c7fc77e@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/122865>

On 07/07/2009 01:39 AM, Eric Raible wrote:
> On Thu, Jul 2, 2009 at 11:39 PM, Paolo Bonzini<bonzini@gnu.org>  wrote:
>> On 07/02/2009 08:04 PM, Eric Raible wrote:
>>> Isn't the first one incorrect because<file>    needs to be inside the
>>> backticks?
>>> git diff `git log -2 --pretty=format:%h<file>` --<file>
>>>
>>> And isn't the replacement incorrect also (the diffs are backwards)?
>>> git log --no-merges -p -R -1<file>
>> Yes and no.
>>
>> Paolo
>>
>
> Are you sure that you didn't mean yes and yes?

I'm sure; I'm not sure I was right (though I did retest at the time, and 
I was convinced that Linus's alternative worked).

Paolo

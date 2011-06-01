From: Chengwei Ding <waterding@gmail.com>
Subject: Re: git annotate with date option not working?
Date: Wed, 01 Jun 2011 14:31:35 +0200
Message-ID: <4DE63127.60903@gmail.com>
References: <4DE5F655.9020400@gmail.com> <m3aae1yjnm.fsf@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jun 01 14:31:50 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QRkaS-0001oK-Mf
	for gcvg-git-2@lo.gmane.org; Wed, 01 Jun 2011 14:31:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758821Ab1FAMbn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 1 Jun 2011 08:31:43 -0400
Received: from mail-ey0-f174.google.com ([209.85.215.174]:48653 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755938Ab1FAMbn (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Jun 2011 08:31:43 -0400
Received: by eyx24 with SMTP id 24so2000828eyx.19
        for <git@vger.kernel.org>; Wed, 01 Jun 2011 05:31:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:message-id:date:from:user-agent:mime-version:to
         :cc:subject:references:in-reply-to:content-type
         :content-transfer-encoding;
        bh=oWMnYwQ7SrdWOD5AxgqWffh+pkFn350USnU3LaJgXbA=;
        b=p9FfTODe2M6lLb3S682xqw7O9FvCI/5vQC/845Q5EZYM6Vu6A23pQPA+NUdyd8kg0w
         YP2lHfr+8u/hvY6tXFTxyH3MlFd6WX+JhxXBZhkVra2uV9I9MIwT41IfcT0YElIqxy3N
         HeuKUCJvpk68tyByj7/sVnfeAtkcW0Y6q9C9k=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        b=LYwjcMRWM4OTz0/V5eebA6k2cl9VTHlgmRKjwxITuEEQwxuGvuQij1C4Q9eE9VD+du
         F9hYDHW5vuk6ETx+tsL+J/jTPwiiCAlCM2riTTtKveeb3Yt2N3i6KmWcDlrc63BJ9izx
         UpaTcjFp9XvHXOUFUYUZBdHiISTG36ZBDTA38=
Received: by 10.14.22.65 with SMTP id s41mr701493ees.101.1306931501774;
        Wed, 01 Jun 2011 05:31:41 -0700 (PDT)
Received: from [10.20.9.95] (mail.kreditor.se [213.136.42.60])
        by mx.google.com with ESMTPS id g48sm677566eea.26.2011.06.01.05.31.39
        (version=SSLv3 cipher=OTHER);
        Wed, 01 Jun 2011 05:31:40 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.17) Gecko/20110424 Lightning/1.0b2 Thunderbird/3.1.10
In-Reply-To: <m3aae1yjnm.fsf@localhost.localdomain>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/174862>

On 06/01/2011 11:40 AM, Jakub Narebski wrote:
> Chengwei Ding<waterding@gmail.com>  writes:
>
>> can anyone confirm that this "--date" option is working for git
>> annotate cmd.
>>
>> i tried the same option on blame cmd which seems to be working, but
>> not on the annotate which i use git annotate --date=relative or i
>> wrote date config variable as blame.date which again work for blame
>> but not annotate, but document says it should share same variable.
> "git annotate" is left for backwards compatibility, so it might be
> that not all git-blame switches work correctly with it.
>
> Does "git blame -c --date=relative" work?
>
emm, no luck.

//Chengwei

From: Eugene Sajine <euguess@gmail.com>
Subject: Re: Proper way to abort incorrect cherry-picking?
Date: Wed, 28 Apr 2010 16:05:43 -0400
Message-ID: <s2l76c5b8581004281305i839693d6l400d4d7e1ca86e98@mail.gmail.com>
References: <s2m76c5b8581004281238jf7179fffna7d757fee6ab4f10@mail.gmail.com>
	 <20100428195001.GA2242@progeny.tock>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Wed Apr 28 22:05:53 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O7DW2-0007UC-Pp
	for gcvg-git-2@lo.gmane.org; Wed, 28 Apr 2010 22:05:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756998Ab0D1UFp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 Apr 2010 16:05:45 -0400
Received: from mail-qy0-f179.google.com ([209.85.221.179]:64454 "EHLO
	mail-qy0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754910Ab0D1UFo (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Apr 2010 16:05:44 -0400
Received: by qyk9 with SMTP id 9so21805622qyk.1
        for <git@vger.kernel.org>; Wed, 28 Apr 2010 13:05:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type;
        bh=F6JUT5Rfoi2rE3Z8Hl4UMJlIZlqw/lYEpPm3qa+Wss4=;
        b=hXYfbFXk9LJ4hKx+bUS8910iw0K4UFOQr9Hv/js1F196i2u1fO7Lm2GbLW51STOw0A
         YFlfgIS4UcQv8Jz0Om6Eah07OB6OL92qyUg/EgyXdX4NywROw0SN0+wNS6eXylqyKurM
         HEd06q5kUxQFtSMxa0nSBLZhSsDTl0T40Sojk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=FsAMfV9dAZYKEg9CnM5XqhTLyIv7YBvrN9/OpwNlBNkDK3k8/OddfifMEyQJDue8pM
         zSD2bFyTXA93xGnBdLV7u1HZLOeneArwSLLyW7FJ7WW3HMaJBcPrAi6gbj+9fnsX/HOp
         XshErx69r+/tGp0hG4EdhPtR+kB36Kb+D3ccc=
Received: by 10.229.218.21 with SMTP id ho21mr6294581qcb.79.1272485143198; 
	Wed, 28 Apr 2010 13:05:43 -0700 (PDT)
Received: by 10.229.190.202 with HTTP; Wed, 28 Apr 2010 13:05:43 -0700 (PDT)
In-Reply-To: <20100428195001.GA2242@progeny.tock>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/146011>

On Wed, Apr 28, 2010 at 3:50 PM, Jonathan Nieder <jrnieder@gmail.com> wrote:
> Eugene Sajine wrote:
>
>> the automatic cherry-pick failed and caused conflicts, so in
>> order to to cancel the whole operation i had to do the following:
>>
>> 1. mark the conflicting files as resolved (without even resolving
>> them) by doing git add.
>> 2. unstage all files staged for commit as a result of incomplete cherry picking
>> 3. manually checkout touched files to their correct state (git checkout file)
>>
>> and then i was able to repeat cherry-picking with correct commits.
>>
>> Is there a better way?
>
> git reset --merge
>
> Ideas for where this should be put in the git-cherry-pick.txt manual?
>

That's interesting - thanks a lot!

Yes, it wold be nice to have it mentioned somewhere in help for cherry-picking.

Thanks,
Eugene

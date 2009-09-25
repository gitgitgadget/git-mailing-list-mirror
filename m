From: Marco Costalba <mcostalba@gmail.com>
Subject: Re: git log --pretty=format:%h prints (unrequired) abbreviated sha
Date: Fri, 25 Sep 2009 11:44:51 +0100
Message-ID: <e5bfff550909250344y535a05edx7d30ad7e48a5f036@mail.gmail.com>
References: <e5bfff550909250240q3351d39evbcf507af422fde43@mail.gmail.com>
	 <e5bfff550909250246qed6f2ci4237bdaefd8a18a@mail.gmail.com>
	 <4ABC9C5D.5030202@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Fri Sep 25 12:45:06 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mr8IR-0003LN-Ev
	for gcvg-git-2@lo.gmane.org; Fri, 25 Sep 2009 12:45:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752025AbZIYKos (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 25 Sep 2009 06:44:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751730AbZIYKos
	(ORCPT <rfc822;git-outgoing>); Fri, 25 Sep 2009 06:44:48 -0400
Received: from mail-ew0-f211.google.com ([209.85.219.211]:49593 "EHLO
	mail-ew0-f211.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751816AbZIYKor (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 Sep 2009 06:44:47 -0400
Received: by mail-ew0-f211.google.com with SMTP id 7so2442938ewy.17
        for <git@vger.kernel.org>; Fri, 25 Sep 2009 03:44:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type;
        bh=JIxQ+W1pUN980N4B45rTP/3ysHeOXgBPiq+SffxnlJI=;
        b=lAhSJnkrZfMYLqwmJWVWep4SuN9QOAvztCYjW5XT11vewf9/QF4EXmhcxjKNLwhfne
         V4uLJARVZYIbl46tx0Iq8p1gCTzTEa4dtRaFgqn4IDm51F0/rJz3ihcs0XEz/bEc6Qoy
         PLHJK8wB8pOffTvfLTw0pvSisEmtZT4NJyoeg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=knt0yHTT9FCBKKLNv4TN4F1WyJA3dlS+V8vEE1mLOBq2ogSoBoAkuc9RbQXxOVpHve
         Zz/tlgsgIU+9IITipgV5tvKTNbXntyinTY1FBrfLTuyQHuuOBlUFyvPRuZOFrvwXmC2X
         OSGs0ocwPfbk+FQ7RQb3wGbZWfsmLj7T+1tKc=
Received: by 10.216.10.135 with SMTP id 7mr1053158wev.213.1253875491375; Fri, 
	25 Sep 2009 03:44:51 -0700 (PDT)
In-Reply-To: <4ABC9C5D.5030202@viscovery.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/129075>

On Fri, Sep 25, 2009 at 11:33, Johannes Sixt <j.sixt@viscovery.net> wrote:
> Marco Costalba schrieb:
>> On Fri, Sep 25, 2009 at 10:40, Marco Costalba <mcostalba@gmail.com> wrote:
>>> and now
>>>
>>> git log --pretty=format:%h
>>>
>>
>> Sorry, the correct command is:
>>
>> git log --pretty=format:%H
>>
>> but output is still abbreviated.
>
> Doesn't happen here. %h produces abbreviated SHA1s and %H full SHA1s.
> However, I don't run msysgit, but compile git myself. I run the commands
> from CMD.
>

What (old) version of msgit do you suggest me to try to verify if it
is a new problem ?

BTW gitk does not work correctly. It loads the revisions but doesn't
show the diffs.

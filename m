From: Marco Costalba <mcostalba@gmail.com>
Subject: Re: git log --pretty=format:%h prints (unrequired) abbreviated sha
Date: Fri, 25 Sep 2009 12:30:28 +0100
Message-ID: <e5bfff550909250430x14b0d7f4w5e22467ddd66cc29@mail.gmail.com>
References: <e5bfff550909250240q3351d39evbcf507af422fde43@mail.gmail.com>
	 <e5bfff550909250246qed6f2ci4237bdaefd8a18a@mail.gmail.com>
	 <4ABC9C5D.5030202@viscovery.net>
	 <e5bfff550909250344y535a05edx7d30ad7e48a5f036@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Fri Sep 25 13:30:39 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mr90W-0007jQ-8A
	for gcvg-git-2@lo.gmane.org; Fri, 25 Sep 2009 13:30:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752149AbZIYLa1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 25 Sep 2009 07:30:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751611AbZIYLa0
	(ORCPT <rfc822;git-outgoing>); Fri, 25 Sep 2009 07:30:26 -0400
Received: from ey-out-2122.google.com ([74.125.78.26]:40173 "EHLO
	ey-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751259AbZIYLa0 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 Sep 2009 07:30:26 -0400
Received: by ey-out-2122.google.com with SMTP id d26so578445eyd.19
        for <git@vger.kernel.org>; Fri, 25 Sep 2009 04:30:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type;
        bh=56DA3YNkcEA6NU84EOriUR8RupqbaeQio25jsy7cJa0=;
        b=OE0wFykHkIIKfITg6UESen79BUI9PK6MTv3Gpx4b5vgzFYmQBACwSM35/q7GyLwprp
         pdrCiwoHOkqRSUneuzJqFTgAPr3GsunqqjqgG2xeV8K0+9yfsBHHuVg2+aC1sS3VnWdE
         HFc6B0MJzn8Izu7wvE8lLFIvQ0FXOQQVBbQTo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=PedejhDvh0AlBe2vSueBRh4GvKDwSDkWS1QB2KliR/FCzr2ngMSE+D5DZ/n2gZ3ODF
         zk3fmTel3VUqx3i0uwvB4rDJv7leRkgP3vcFkDHO9NViUwXLgH7vYdolh5/+wsXZ4s1Z
         bFZFMwkIXErIJAgmjbD9+8KS0JoDvutpDIxAI=
Received: by 10.216.3.207 with SMTP id 57mr7612weh.53.1253878228904; Fri, 25 
	Sep 2009 04:30:28 -0700 (PDT)
In-Reply-To: <e5bfff550909250344y535a05edx7d30ad7e48a5f036@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/129076>

On Fri, Sep 25, 2009 at 11:44, Marco Costalba <mcostalba@gmail.com> wrote:
> On Fri, Sep 25, 2009 at 11:33, Johannes Sixt <j.sixt@viscovery.net> wrote:
>> Marco Costalba schrieb:
>>> On Fri, Sep 25, 2009 at 10:40, Marco Costalba <mcostalba@gmail.com> wrote:
>>>> and now
>>>>
>>>> git log --pretty=format:%h
>>>>
>>>
>>> Sorry, the correct command is:
>>>
>>> git log --pretty=format:%H
>>>
>>> but output is still abbreviated.
>>
>> Doesn't happen here. %h produces abbreviated SHA1s and %H full SHA1s.
>> However, I don't run msysgit, but compile git myself. I run the commands
>> from CMD.
>>
>
> What (old) version of msgit do you suggest me to try to verify if it
> is a new problem ?
>
> BTW gitk does not work correctly. It loads the revisions but doesn't
> show the diffs.
>

Also installing an old version I have the same wrong behaviour and the
same version works on another PC and with the same repository I am
testing with.

So I am thinking to some setup somewhere that makes git to use
abbreviated commits instead of full names. Does exist something like
this ?

Thanks

From: Rustom Mody <rustompmody@gmail.com>
Subject: Re: git in emacs
Date: Thu, 25 Jun 2009 18:43:27 +0530
Message-ID: <f46c52560906250613l3759375dk855632b255ddc6e8@mail.gmail.com>
References: <f46c52560906250535k6a0eb0a5ne05dc327760d14bd@mail.gmail.com>
	 <m3bpocxyf4.fsf@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jun 25 15:13:35 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MJolj-0000Is-1K
	for gcvg-git-2@gmane.org; Thu, 25 Jun 2009 15:13:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751973AbZFYNN0 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 25 Jun 2009 09:13:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751865AbZFYNNZ
	(ORCPT <rfc822;git-outgoing>); Thu, 25 Jun 2009 09:13:25 -0400
Received: from mail-px0-f190.google.com ([209.85.216.190]:54427 "EHLO
	mail-px0-f190.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751687AbZFYNNY convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 25 Jun 2009 09:13:24 -0400
Received: by pxi28 with SMTP id 28so1024706pxi.33
        for <git@vger.kernel.org>; Thu, 25 Jun 2009 06:13:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:content-type
         :content-transfer-encoding;
        bh=aXjm82p3PIcZR2L+Xv9t5gEW70bpprD7PeTkVwYbpR0=;
        b=sVPesk+2DBuRje0nlV4CZUX3A3cPkv7KNoYpdn2VqqyNSmX5vJIKuegixcquUsHGEn
         FJti/AaykHRwX1LTBcosDPxdG8XfFXOYn/v3IWV9Ruv4HI5RmCoRxaQddWhMm8Li/cNd
         zjfPk3bjf4ZV4tbIRPPRoH0YmqFj6qDnHyXSM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :content-type:content-transfer-encoding;
        b=xM/A/TlXrkNKEetIurayJT7XMgasl3QZqaRXnhsRmWGrhNowWI5Is66/bSG9FOl0NB
         d9EZv6R0E24N3lb8UVRdQ2pf5AzbqF94d+9zlpCzh3uI/4ruX7EbDTau33UzDTzfgbBh
         iKF48Ki8EPVZ4WEu3BOk2ZW9FxwXO2CVVj7pk=
Received: by 10.114.157.1 with SMTP id f1mr3904626wae.43.1245935607175; Thu, 
	25 Jun 2009 06:13:27 -0700 (PDT)
In-Reply-To: <m3bpocxyf4.fsf@localhost.localdomain>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/122207>

On Thu, Jun 25, 2009 at 6:29 PM, Jakub Narebski<jnareb@gmail.com> wrote=
:
> Rustom Mody <rustompmody@gmail.com> writes:
>
>> Ive been trying to use git.el in emacs
>>
>> When I checked out an internal commit (I guess that's called a
>> detached head?) then git-status (in emacs) starts giving me
>>
>> Branch: =A0 =A0 fatal: ref HEAD is not a symbolic ref
>>
>> This goes away when I do
>> git reset --hard <original-head-sha> --
>> git checkout master
>>
>> [I'm not sure this the best way of restoring the head]
>
> This probably means that git.el (which version do you use) should
> be corrected.

Ok So I had an old version
Now its version 1.0
But I still get the same error :-(
>
>>
>> But my question is more about git in emacs. I gather that there are =
3 options:
>> 1. git.el
>> 2. vc with git backend
>> 3. dvc with git backend
>>
>> Which is best/preferable?
>> Or is it best to stay with the command line?
>
> See http://www.emacswiki.org/emacs-en/Git
>
> --
> Jakub Narebski
> Poland
> ShadeHawk on #git
>

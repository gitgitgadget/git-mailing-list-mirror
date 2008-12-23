From: "Mark Ryden" <markryde@gmail.com>
Subject: Re: Applying patches from a patch set
Date: Tue, 23 Dec 2008 13:25:17 +0200
Message-ID: <dac45060812230325if44148qa166e5fb01d33245@mail.gmail.com>
References: <dac45060812200637m49c71aa5x3c25010fa00f4a63@mail.gmail.com>
	 <7vabaqy5kx.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Dec 23 12:26:41 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LF5PL-0004P5-48
	for gcvg-git-2@gmane.org; Tue, 23 Dec 2008 12:26:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750895AbYLWLZU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 23 Dec 2008 06:25:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750892AbYLWLZU
	(ORCPT <rfc822;git-outgoing>); Tue, 23 Dec 2008 06:25:20 -0500
Received: from rn-out-0910.google.com ([64.233.170.188]:31998 "EHLO
	rn-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750785AbYLWLZS (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Dec 2008 06:25:18 -0500
Received: by rn-out-0910.google.com with SMTP id k40so1785412rnd.17
        for <git@vger.kernel.org>; Tue, 23 Dec 2008 03:25:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=OOYL7RNjXhWTNPmVsGCEy2KA/kNZlyRvySXvzHMk6QQ=;
        b=tnUD8HNs/EH5mvVsX8dAJGOz6V+qWPGSOELy+X3Z0BiOu6sKWcnfRcB9diuineLfoe
         ZeEHIZpC+Z4DqbOAZkDfF0DuVCx90ReRc2sk4NCJCCc1w3t+pp5LQaFB2Wt8rMyFOB1a
         6d6fQ8W9YM8SweeNg8oT+ez70NHEP6/bKcN6g=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=UczQLxmDbOfiT4qDHpzFlzZNGAMCaHJ+cIsAlxU3J97lzR36QG/JBqCwEFjUQ5IHsh
         Xtk8lG0v8csxtQqxZkXuNL9vYX33nnOPjRMIo5i/YP5sV6QbMAKodws9x164lMIkUwft
         rN8Q8x5xLXlBQsA1uvTWOewSBnyDtRHQngqbw=
Received: by 10.90.118.8 with SMTP id q8mr3777386agc.67.1230031517732;
        Tue, 23 Dec 2008 03:25:17 -0800 (PST)
Received: by 10.90.26.11 with HTTP; Tue, 23 Dec 2008 03:25:17 -0800 (PST)
In-Reply-To: <7vabaqy5kx.fsf@gitster.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/103810>

Hello,
  I tried usuing slrn with mutt; mutt seems to me better.
I saved 15 git patches from one patch set into a mailbox
using mutt.
Now I tried:
git am maibox
and got this error:

Patch is empty.  Was it split wrong?

This error occurred after "git am maibox" applied the first 6 patches
in this patch set.

looking at that seventh patch shows that it seems to be perfectly
ok.

Any ideas what can be wrong here?
Regards,
Mark


On Sat, Dec 20, 2008 at 10:06 PM, Junio C Hamano <gitster@pobox.com> wrote:
> "Mark Ryden" <markryde@gmail.com> writes:
>
>> Hello,
>>   I am subscribed to some linux kernel subsystem mailing list; in this
>> list there are sometimes patchsets with more than
>> 30-40 patches.
>> I am using gmail web interface client.
>>
>> In order to apply a patch set I copy and paste each patch from the
>> patchset into a file, and then apply that patch.
>> I assume that there is a better way.
>> Recently I encountered a fatal error when doing so (and I am not sure
>> what caused it).
>>
>> So my question is: does anyone know a more elegant way of applying a
>> large patchset ?
>> Maybe there is better mail client with which this process can be done easily ?
>
> First mistake(?) is you seem to be doing copy&paste from browser.  Don't.
> It can easily damage whitespaces.  Find out how your webmail interface
> allows you to save selected messages in a mbox and let you download it.
>
> Then
>
>        $ git am that-mbox-file
>
>
>
>
>

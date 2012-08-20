From: Erik Faye-Lund <kusmabite@gmail.com>
Subject: Re: What's cooking in git.git (Aug 2012, #06; Sun, 19)
Date: Mon, 20 Aug 2012 18:23:45 +0200
Message-ID: <CABPQNSZpS6YX-WSp7nYnav+Szk0V-N9nx-F+RXtZLw7s6KMBQg@mail.gmail.com>
References: <7v393im4jy.fsf@alter.siamese.dyndns.org> <CABPQNSZ+JskSvEUFbxy78eqB5cg1npq7n_thaVhhoXxd-DK+MQ@mail.gmail.com>
 <7vobm5lejl.fsf@alter.siamese.dyndns.org>
Reply-To: kusmabite@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org, Eric Wong <normalperson@yhbt.net>,
	Pete Wyckoff <pw@padd.com>, Luke Diamand <luke@diamand.org>,
	Stefan Zager <szager@google.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Aug 20 18:24:37 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T3UmH-0006I8-2l
	for gcvg-git-2@plane.gmane.org; Mon, 20 Aug 2012 18:24:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753318Ab2HTQY1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 20 Aug 2012 12:24:27 -0400
Received: from mail-vb0-f46.google.com ([209.85.212.46]:52289 "EHLO
	mail-vb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753051Ab2HTQY0 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Aug 2012 12:24:26 -0400
Received: by vbbff1 with SMTP id ff1so5488035vbb.19
        for <git@vger.kernel.org>; Mon, 20 Aug 2012 09:24:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:reply-to:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=H6E0TImvjaXvZ0dI8vVa8Wgk7U2/Dkyq6YFHQQk7ZV4=;
        b=P3Sk9YPj2qFxdeGFRUXC02sNJ7+7UXn+6bK+YBD8R6LZiKJoJA+1XMYcBu0/gvyJnC
         FXxnzyFn2/IEZfYC11JAUQAEDOOz+QLLmtzicKJYb5dc5/8l1XRwh3J3KeFqRoK8Bhyn
         eslIYGXFyZeEbf30+DBw+eHjRnqfrg4vYV5pyvw7oy9ZyQneXRAZasLdGOUZFf53ra4z
         HUMpMCpQreSP02fmCMPYfCulyAo9h/eJGTf/FgSTue2OAOMiLauxsnSzW+vB0yFaVXjn
         rD0D3K7GwWK4dyWr3gd6Cmdq/SG1CzrXh2KvVspOawIEczfol0MxfPBB65ujx/0ZR2KW
         38MA==
Received: by 10.52.95.46 with SMTP id dh14mr9065053vdb.114.1345479865416; Mon,
 20 Aug 2012 09:24:25 -0700 (PDT)
Received: by 10.58.237.166 with HTTP; Mon, 20 Aug 2012 09:23:45 -0700 (PDT)
In-Reply-To: <7vobm5lejl.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/203851>

On Mon, Aug 20, 2012 at 6:21 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Erik Faye-Lund <kusmabite@gmail.com> writes:
>
>> On Mon, Aug 20, 2012 at 9:00 AM, Junio C Hamano <gitster@pobox.com> wrote:
>>> * ef/win32-cred-helper (2012-08-16) 1 commit
>>>  - contrib: add win32 credential-helper
>>>
>>> Credential helper for Win32 (is this GUI???).
>>
>> No, and credential helpers shouldn't be either.
>
> Hrm, doesn't it even do "the application wants to access your
> keychain.  Allow it [Y/N]?" kind of thing?
>

No. On Windows, you can freely access the keychain as long as a user
is logged in and the machine is not locked.

From: Erik Faye-Lund <kusmabite@gmail.com>
Subject: Re: What's cooking in git.git (Aug 2012, #06; Sun, 19)
Date: Mon, 20 Aug 2012 18:37:01 +0200
Message-ID: <CABPQNSZcyftefO1ikXRj6fqjDxwH1_6rwCLvt4z6Z4g6pGc-Ow@mail.gmail.com>
References: <7v393im4jy.fsf@alter.siamese.dyndns.org> <CABPQNSZ+JskSvEUFbxy78eqB5cg1npq7n_thaVhhoXxd-DK+MQ@mail.gmail.com>
 <7vobm5lejl.fsf@alter.siamese.dyndns.org> <CABPQNSZpS6YX-WSp7nYnav+Szk0V-N9nx-F+RXtZLw7s6KMBQg@mail.gmail.com>
 <7v8vd9ldxh.fsf@alter.siamese.dyndns.org>
Reply-To: kusmabite@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org, Eric Wong <normalperson@yhbt.net>,
	Pete Wyckoff <pw@padd.com>, Luke Diamand <luke@diamand.org>,
	Stefan Zager <szager@google.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Aug 20 18:37:54 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T3Uz7-0000Da-L1
	for gcvg-git-2@plane.gmane.org; Mon, 20 Aug 2012 18:37:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753278Ab2HTQho (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 20 Aug 2012 12:37:44 -0400
Received: from mail-vc0-f174.google.com ([209.85.220.174]:36474 "EHLO
	mail-vc0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752243Ab2HTQhn (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Aug 2012 12:37:43 -0400
Received: by vcbfk26 with SMTP id fk26so5115092vcb.19
        for <git@vger.kernel.org>; Mon, 20 Aug 2012 09:37:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:reply-to:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=dyJxrrTZFoBEy+uf4Hqy8FB1OOOpt/7qQ6eDRmtOFG4=;
        b=ia20ihhsphzCwmEvhYANCGVUAJbsR4Ku0uLe36RJtNhJpzD8yWNbwX/RPCadTTbVyU
         9/kFpb738GGbmER93eEk7tbmc8yesIZbvAiyZWv+R5Azngd9sATQEg2rGTe1yONr2TXP
         ageIWspS/g0Nzg4w2ChPEq0HI8Rb8DwuVdVWs1KeWWsQYzSVXBWJpx8mmtapyKbVTIlK
         nNh9bzt4rgRLts+QSCFmyZFLjIBlZh15TU9hZZedh6JFHVOb6XdKie/GEVw6o2XbMtfN
         W2nckwe3H1Ro3t+Kn9Bmj0JH+NSGU44j5ex0skCRYKYikFmMoHT+Uedu9bHHbJlwjaG6
         OGsg==
Received: by 10.58.32.234 with SMTP id m10mr11516136vei.60.1345480662271; Mon,
 20 Aug 2012 09:37:42 -0700 (PDT)
Received: by 10.58.237.166 with HTTP; Mon, 20 Aug 2012 09:37:01 -0700 (PDT)
In-Reply-To: <7v8vd9ldxh.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/203854>

On Mon, Aug 20, 2012 at 6:35 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Erik Faye-Lund <kusmabite@gmail.com> writes:
>
>> On Mon, Aug 20, 2012 at 6:21 PM, Junio C Hamano <gitster@pobox.com> wrote:
>>> Erik Faye-Lund <kusmabite@gmail.com> writes:
>>>
>>>> On Mon, Aug 20, 2012 at 9:00 AM, Junio C Hamano <gitster@pobox.com> wrote:
>>>>> * ef/win32-cred-helper (2012-08-16) 1 commit
>>>>>  - contrib: add win32 credential-helper
>>>>>
>>>>> Credential helper for Win32 (is this GUI???).
>>>>
>>>> No, and credential helpers shouldn't be either.
>>>
>>> Hrm, doesn't it even do "the application wants to access your
>>> keychain.  Allow it [Y/N]?" kind of thing?
>>>
>>
>> No. On Windows, you can freely access the keychain as long as a user
>> is logged in and the machine is not locked.
>
> OK, so is this a good description to go in the merge commit when it
> goes to 'master'?
>
>     * ef/win32-cred-helper (2012-08-16) 1 commit
>      - contrib: add win32 credential-helper
>
>      Credential helper for Win32, to allow access to the keychain of
>      logged-in user.
>

Looks good to me.

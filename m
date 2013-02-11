From: Ethan Reesor <firelizzard@gmail.com>
Subject: Re: [RFC/PATCH] shell: allow 'help' command to disable interactive shell
Date: Mon, 11 Feb 2013 01:07:13 -0500
Message-ID: <CAE_TNinMTtH3U-3T5AO5zV-L_RB82_R_i2ZNbNz7KE5L=JX-KA@mail.gmail.com>
References: <CAE_TNikk-9sYVRQRwRecNpp3otQ+oc=uV9SPu+7pAkCUNbcUoQ@mail.gmail.com>
 <20130210212538.GA11720@elie.Belkin> <20130210224345.GA32318@sigill.intra.peff.net>
 <7vfw13rd9x.fsf@alter.siamese.dyndns.org> <CAMK1S_jFUXiHM6teVwoxO9gv77B1KBQoSi-B32dwVKemXnDx9w@mail.gmail.com>
 <20130211012016.GA13243@elie.Belkin> <7v7gmfqzt1.fsf@alter.siamese.dyndns.org>
 <20130211041706.GB15329@elie.Belkin> <7vwqufpj50.fsf@alter.siamese.dyndns.org>
 <20130211043247.GD15329@elie.Belkin> <7vpq07pgpy.fsf@alter.siamese.dyndns.org>
 <CAE_TNim2wrL3SWxy_2ugyGmEFDngBJ8+z04y2tJFzMo4N8mUug@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Sitaram Chamarty <sitaramc@gmail.com>,
	Jeff King <peff@peff.net>, git <git@vger.kernel.org>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Greg Brockman <gdb@mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Feb 11 07:08:05 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U4mYd-0004cP-58
	for gcvg-git-2@plane.gmane.org; Mon, 11 Feb 2013 07:08:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752375Ab3BKGHh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Feb 2013 01:07:37 -0500
Received: from mail-qa0-f54.google.com ([209.85.216.54]:57709 "EHLO
	mail-qa0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751823Ab3BKGHe (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Feb 2013 01:07:34 -0500
Received: by mail-qa0-f54.google.com with SMTP id hg5so1036602qab.20
        for <git@vger.kernel.org>; Sun, 10 Feb 2013 22:07:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=m/3I0LpKOEc6Z5jRnf0rc9Pp1Gw3Nvj/pIQZooW0U2U=;
        b=Sg8fde/OLNcKZUg90JlS7GvbCKTm+gy9TxqnFS24Ddx8ABN8dbFfBexuamcBWUAskp
         9Lxy3lB55cuRmkwWXubEgCz2LI/C01UB4JEPk5opw3eTxq15Fycno1bu5uKHy5+SeQ0r
         rHXw0Vww7ecA/FEBHnmXr6x13jy1Ie1GwAGD9ai3m7+65cC2uvyCSBZsIZ60cquXJVkc
         A1d0/o07Rkj8/Sy1M8vmKkrsQoIv+QmFVzMZalx7rJFKrnYIbK72ohTsj65+1Vh01Vzn
         p9hNshlFloYPod3J+ijGauEsriyOsSuL+MQDBkHTnexsUeDi3GLOB6FcHVsHosqo0lLJ
         zWrQ==
X-Received: by 10.224.185.141 with SMTP id co13mr5018127qab.33.1360562853620;
 Sun, 10 Feb 2013 22:07:33 -0800 (PST)
Received: by 10.49.95.225 with HTTP; Sun, 10 Feb 2013 22:07:13 -0800 (PST)
In-Reply-To: <CAE_TNim2wrL3SWxy_2ugyGmEFDngBJ8+z04y2tJFzMo4N8mUug@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/215998>

I noticed a typo I made. I meant `git-config` rather than
`git-commit`. Sorry for my mistake.

On Mon, Feb 11, 2013 at 12:57 AM, Ethan Reesor <firelizzard@gmail.com> wrote:
> On Mon, Feb 11, 2013 at 12:22 AM, Junio C Hamano <gitster@pobox.com> wrote:
>> Hmph, if that is the case, wouldn't it be a better direction to give
>> a better help for majority of the case where git-shell is used as
>> the login shell to allow push and fetch but not for interactive
>> access at all?
>>
>> The first step in that direction may be to give a better canned
>> message, followed by a mechanism (perhaps a hook) that lets a
>> message customized for the site's needs, no?  Why should a site
>> administrator create an otherwise empty directory for each and every
>> user and add an executable in there that shows an error message,
>> only to improve the default message because it is not friendly
>> enough?
>
> Jonathan made the following comment on the thread I started that lead
> to this RFC:
>> You can disable interactive logins by removing the
>> ~/git-shell-commands/ directory.  Unfortunately that doesn't let you
>> customize the message.  Perhaps it would make sense to teach shell.c
>> to look for a
>>
>>        [shell]
>>                greeting = 'Hi %(username)! You've successfully authenticated, but I do not provide interactive shell access.'
>>
>> setting in git's config file.
>
> How is this for an alternative? Have shell.c look for
>         [shell]
>                 missing_commands_directory = "Stuff is broke."
> setting. If the setting is missing, then it prints the default message
> (the current message). That way, there's a default setting, there can
> be a system-wide message, there can be a user specific message, and
> those messages can be set via `git-commit`.
>
> --
> Ethan Reesor



--
Ethan Reesor (Gmail)

From: Orgad Shaneh <orgads@gmail.com>
Subject: Re: git gui replaces amend message when prepare-commit-msg hook is used
Date: Thu, 4 Jul 2013 13:03:31 +0300
Message-ID: <CAGHpTBJqVazwuNxe1m8ggcCPh9d+9Dkuv32aCqU15AZoamGwag@mail.gmail.com>
References: <CAGHpTBKOX8G1PZqE2njQ1UbFJeC_L6WxjnTC5NyT8LSbiBNGXw@mail.gmail.com>
	<20130704100112.GD17597@paksenarrion.iveqy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Fredrik Gustafsson <iveqy@iveqy.com>
X-From: git-owner@vger.kernel.org Thu Jul 04 12:03:41 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UugO0-0004lx-Ly
	for gcvg-git-2@plane.gmane.org; Thu, 04 Jul 2013 12:03:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754007Ab3GDKDd convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 4 Jul 2013 06:03:33 -0400
Received: from mail-ob0-f178.google.com ([209.85.214.178]:64821 "EHLO
	mail-ob0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751895Ab3GDKDc convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 4 Jul 2013 06:03:32 -0400
Received: by mail-ob0-f178.google.com with SMTP id fb19so1411670obc.23
        for <git@vger.kernel.org>; Thu, 04 Jul 2013 03:03:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=sl5Rd4pIprqm7PyCOX5qAVdQQ2H81X0xPUIDX39ShDY=;
        b=X/N3bzUZN4p/rMjs85vX9JWDmeJc0JEvOPjRjIhviNakhmQXOkyBOOj7c/XiuOfAfk
         OmUBw7HOXlf68qu9rsBPXF3pbt4AeQtXmC/K2kuVYaYo7t34yWmz8l0mJ0E7gQGVRM8c
         QyuYqOTruUURbJ0Zj3cYiy+XIzdzQW84AoII0oi2YTWjYh/aCs8L2kYxyrctdPmeC8eE
         +z2A4GY8aYrR22YA5/CMRTLgaaW0+H8ohbaGSHOJHruvrQaPhNyctCL2o+sMpdjugush
         F7YLFkkg4zoxPD9+W/2EMtseG6keT9gcYyHq5UDtGSRY+ucNjsP/EPX/eHHWukTpWbLn
         zSFg==
X-Received: by 10.60.133.235 with SMTP id pf11mr5225337oeb.38.1372932211791;
 Thu, 04 Jul 2013 03:03:31 -0700 (PDT)
Received: by 10.182.128.72 with HTTP; Thu, 4 Jul 2013 03:03:31 -0700 (PDT)
In-Reply-To: <20130704100112.GD17597@paksenarrion.iveqy.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/229567>

On Thu, Jul 4, 2013 at 1:01 PM, Fredrik Gustafsson <iveqy@iveqy.com> wr=
ote:
> On Thu, Jul 04, 2013 at 12:47:28PM +0300, Orgad Shaneh wrote:
>> If a prepare-commit-msg hook is used, git gui executes it for "New C=
ommit".
>>
>> If the "New Commit" is selected, and then immediately "Amend" (befor=
e
>> the hook returns), when the hook returns the message is replaced wit=
h
>> the one produced by the hook.
>
> I don't get it. The message from the hook is replaced with the messag=
e
> from the hook?
>
> What I don't get is how you can amend to a commit that doesn't yet
> exists. How is that possible?
>
> --
> Med v=E4nliga h=E4lsningar
> Fredrik Gustafsson
>
> tel: 0733-608274
> e-post: iveqy@iveqy.com

Did I say anything about a commit that doesn't exist? I have a commit
which I want to amend. If I click the Amend button before the hook is
done, this commit's message is replaced (in the editor, not the actual
commit) with the hook's result.

The message that should appear in the editor should come from the
amended commit, not from the hook.

- Orgad

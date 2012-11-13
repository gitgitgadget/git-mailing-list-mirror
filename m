From: Erik Faye-Lund <kusmabite@gmail.com>
Subject: Re: Launch separate program for HTTPS prompt
Date: Tue, 13 Nov 2012 15:51:15 +0100
Message-ID: <CABPQNSYav4K208a1VVP6rK6LhXBo+nkx-DcG4zUsiufnCJkY5g@mail.gmail.com>
References: <CAHtLG6QY-PYUKbNUicox_Ayh70bUSJOL7LGZrQQMqgbVBDmEiA@mail.gmail.com>
 <vpq6261nt0x.fsf@grenoble-inp.fr>
Reply-To: kusmabite@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?B?5LmZ6YW46Yuw?= <ch3cooli@gmail.com>, git@vger.kernel.org
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Tue Nov 13 15:52:11 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TYHqU-0005GU-Nu
	for gcvg-git-2@plane.gmane.org; Tue, 13 Nov 2012 15:52:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754587Ab2KMOv5 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 13 Nov 2012 09:51:57 -0500
Received: from mail-vc0-f174.google.com ([209.85.220.174]:52418 "EHLO
	mail-vc0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752014Ab2KMOv4 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 13 Nov 2012 09:51:56 -0500
Received: by mail-vc0-f174.google.com with SMTP id fk26so7417630vcb.19
        for <git@vger.kernel.org>; Tue, 13 Nov 2012 06:51:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:reply-to:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type:content-transfer-encoding;
        bh=fPC4+QisUuAQGQZTwhn2vpPcz0n0AMQ2iBobueQJjxc=;
        b=OKO3LTyiNhAHtHT82XHiWhDtD39hgo5FTpukfWavTfGQ5AEYzRDk9aK3YRHJgS5Y0G
         gnjomspXW/74R0Yt4SvNayXbxUgLY0Hwkz6L9JDFNNlrZyElO51q3Ge/XZEGJAe/FVgF
         daSWyupmpJDP1MDvELCpvzz8UnwxuYDuFwNJOAQqdWOsVGk6P8PvwDD8XzHGA13Nq/hy
         OjbANBrAuDQ8diZanO2DlGyo7e7Qpct4Nv2OX3vJSTPqUu8b7pgwVBqJghTH79N950XN
         ZV7iCGiBZT56oUsyI+SpSC8dwaZV/fTeKqWVq4yeVJ9eg8K0Ajgw6dF/TzmXKJojJuAC
         hJUA==
Received: by 10.52.27.106 with SMTP id s10mr27643422vdg.12.1352818315382; Tue,
 13 Nov 2012 06:51:55 -0800 (PST)
Received: by 10.58.169.106 with HTTP; Tue, 13 Nov 2012 06:51:15 -0800 (PST)
In-Reply-To: <vpq6261nt0x.fsf@grenoble-inp.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/209612>

On Tue, Oct 23, 2012 at 4:48 PM, Matthieu Moy
<Matthieu.Moy@grenoble-inp.fr> wrote:
> =E4=B9=99=E9=85=B8=E9=8B=B0 <ch3cooli@gmail.com> writes:
>
>> Hi,
>>
>> Could you launch a separate program for HTTPS prompt like SSH_ASKPAS=
S?
>> This allows GUI programs to answer the trust or not, not via stdin.
>
> Read about credential helpers, this is what they are meant for, and t=
hey
> do launch separate programs.
>

The prompting-support for credential helpers didn't survive the
inclusion; instead we have git_prompt() that consults GIT_ASKPASS and
SSH_ASKPASS or falls back to git_terminal_prompt().

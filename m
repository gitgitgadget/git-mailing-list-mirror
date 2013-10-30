From: =?UTF-8?Q?Vicent_Mart=C3=AD?= <tanoku@gmail.com>
Subject: Re: What's cooking in git.git (Oct 2013, #07; Mon, 28)
Date: Wed, 30 Oct 2013 18:01:16 +0100
Message-ID: <CAFFjANT=-mQoKUU2KsPHo3Hcq7RAuyM1t4kvJu4OfiNeHrA+Ng@mail.gmail.com>
References: <xmqqr4b5dwke.fsf@gitster.dls.corp.google.com> <5271392E.8020003@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git <git@vger.kernel.org>
To: =?UTF-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>
X-From: git-owner@vger.kernel.org Wed Oct 30 18:01:45 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VbZ9K-0001Io-8C
	for gcvg-git-2@plane.gmane.org; Wed, 30 Oct 2013 18:01:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752006Ab3J3RBi convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 30 Oct 2013 13:01:38 -0400
Received: from mail-vc0-f174.google.com ([209.85.220.174]:52748 "EHLO
	mail-vc0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751613Ab3J3RBh convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 30 Oct 2013 13:01:37 -0400
Received: by mail-vc0-f174.google.com with SMTP id ld13so1132933vcb.33
        for <git@vger.kernel.org>; Wed, 30 Oct 2013 10:01:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=9+06BuLGa1NDWAYPk9eciRGHayBM7xnT7jaCZDIVoK4=;
        b=HUH6D86NwygUtjl9xF+zee0x+9Oul0OpJmfjH0BQf7N69O5O4xvU6pCWQuPehWQNwT
         j5pIWhbse3fBVEX6/8pHLlOtPsn5AX3lXkLLsgfjZe4R+dGsqFlUexAa9Jm7y3YI59fy
         L9JKsaQGhXF8wASAH75yRSe5+S57lzxt7IHFNSr0X2o51ZB4xkR+7QJVPOB3JYa3OcBv
         YJKezU8rcpZxKAOmPYg0GEjVn8MdSOx82uPbrkNb1L/9LGERpsuum3NObUQUaRWTUTKp
         NnT1vZhmD6ETnBks33UVN27BNsTKmqnoPyTqUB/I4oL2sQJCZzqJGCH34Fb/Rozfyx3U
         +XPw==
X-Received: by 10.52.34.76 with SMTP id x12mr964213vdi.35.1383152496558; Wed,
 30 Oct 2013 10:01:36 -0700 (PDT)
Received: by 10.221.65.202 with HTTP; Wed, 30 Oct 2013 10:01:16 -0700 (PDT)
In-Reply-To: <5271392E.8020003@web.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/237035>

On Wed, Oct 30, 2013 at 5:51 PM, Torsten B=C3=B6gershausen <tboegi@web.=
de> wrote:
> There is a name clash under cygwin 1.7 (1.5 is OK)
> The following "first aid hot fix" works for me:
> /Torsten

If Cygwin declares its own bswap_64, wouldn't it be better to use it
instead of overwriting it with our own?

From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: collapsing old git history to reduce repo size, while preserving
 commit #s and tags
Date: Wed, 30 Oct 2013 23:06:08 +0700
Message-ID: <CACsJy8BcJMTeyku-37v5pwVvYFixaP2sLMQ24WaerKf8C9-AAw@mail.gmail.com>
References: <CAJSXqrr4nA6azBgaD7rBbYSLWonQkn7PvSsPTXjAPaxW6E+LiA@mail.gmail.com>
 <CAJSXqrqz3KeiPKWz6rFKb4o0F88o9=63Sv37MJSp5qmYtod-6A@mail.gmail.com>
 <CAH5451=DGp0aRaA6c-ThO0Aj0VCAUFX17p8gOKPpURwEnjcpdA@mail.gmail.com>
 <CAJSXqrr7rHxyXX=_+xgJ4FW2UHSts2jRt7zwrkkw1L3uKHnCtw@mail.gmail.com>
 <CAJSXqrrMCWmRBoRNCLuD6DvU=CSk+MVGrSOCeOROROEaKouVKQ@mail.gmail.com> <52712BF2.2080409@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Stas Cherkassky <scherkas@gmail.com>,
	Andrew Ardill <andrew.ardill@gmail.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: =?UTF-8?Q?Jakub_Nar=C4=99bski?= <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Wed Oct 30 17:06:46 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VbYI7-0006UR-NK
	for gcvg-git-2@plane.gmane.org; Wed, 30 Oct 2013 17:06:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752114Ab3J3QGk convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 30 Oct 2013 12:06:40 -0400
Received: from mail-qa0-f49.google.com ([209.85.216.49]:43241 "EHLO
	mail-qa0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751371Ab3J3QGj convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 30 Oct 2013 12:06:39 -0400
Received: by mail-qa0-f49.google.com with SMTP id i13so956809qae.15
        for <git@vger.kernel.org>; Wed, 30 Oct 2013 09:06:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=sCstoamRcjfOJ/eU5zCNPABL5vvti0vTjQBlcSg9G1o=;
        b=b9MrbHFdNtm4Ere/Uw+d+qzUsYfs7fHeb4GhPKhB3uN7TvsiTBh7AtQ1/aRw9Y31TE
         benFtigWW56Wu6y9vWBlNJU34PzuAV+tT5wgCBl456un6eNRWnJTSrqLQFoBj4bu8t7M
         FTOXo0ZP1oGQ34XwYyN+LEkAIVAfcR7YMeuVyS8dzPSTai3YwPks5yylQBZ/oiRB9eaq
         zILzojpscRhvQUcB2BYo45DFEaIxTa0TMEi/zWOOquTX5J3+M3qqVA0Q2kQ7JyPWaikR
         psxdwLJWrVXOD5RyMUW7LkGUEORnOYXM86Pb3IKC1WTuId8kdQapGyJHpw5EaQaUq9Ad
         l0OA==
X-Received: by 10.224.79.12 with SMTP id n12mr3623631qak.109.1383149198739;
 Wed, 30 Oct 2013 09:06:38 -0700 (PDT)
Received: by 10.96.27.202 with HTTP; Wed, 30 Oct 2013 09:06:08 -0700 (PDT)
In-Reply-To: <52712BF2.2080409@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/237030>

On Wed, Oct 30, 2013 at 10:55 PM, Jakub Nar=C4=99bski <jnareb@gmail.com=
> wrote:
> On 2013-10-30 08:52, Stas Cherkassky wrote:
>>
>>
>> Shallow clone (if that's what you meant) is not suitable because it
>> doesn't allow to push/pull to/from this shallow repository.
>
>
> Still?  I think there were some work on making shallow clone to
> allowing push/pull to/from it.

Yes, still :-) I've got a proof of concept, but it needs more work to
address the concern about its automatically turning a full repo into a
shallow one.
--=20
Duy

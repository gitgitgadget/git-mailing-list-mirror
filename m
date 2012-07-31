From: J Smith <dark.panda@gmail.com>
Subject: Re: [PATCH/RFC] grep: add a perlRegexp configuration option
Date: Tue, 31 Jul 2012 18:56:32 -0400
Message-ID: <CADFUPgejLSOcQrmcCGuDt8PYdHFun=UYqCshroZpdcV65inikA@mail.gmail.com>
References: <1343753854-66765-1-git-send-email-dark.panda@gmail.com>
 <7vehnrkdrq.fsf@alter.siamese.dyndns.org> <CADFUPgfHQCzdnXfby5b+z-pRkt5o6MAVEf_1waWER3iVtM1TZA@mail.gmail.com>
 <7vboivishe.fsf@alter.siamese.dyndns.org> <CADFUPgfrG75FkSNV6JS22DAciD3CVkNEjKncNJOPkfRQSf41Pg@mail.gmail.com>
 <7v3947iqup.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Aug 01 00:56:59 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SwLN4-0007I7-Oy
	for gcvg-git-2@plane.gmane.org; Wed, 01 Aug 2012 00:56:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754303Ab2GaW4y (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 31 Jul 2012 18:56:54 -0400
Received: from mail-ob0-f174.google.com ([209.85.214.174]:55876 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752721Ab2GaW4x (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 31 Jul 2012 18:56:53 -0400
Received: by obbuo13 with SMTP id uo13so11271721obb.19
        for <git@vger.kernel.org>; Tue, 31 Jul 2012 15:56:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=XILXi9JlsXYxpU/XViz91fmxLi678jpPflk343rOYrY=;
        b=KFetnHComIHhgb0v0GrUrTBK0Dp/wg3zhJgkVVh99tfVakeDgvUXCxqqiZ4iwzH+sg
         cYD2c+p7xQQb7JOlYYzBdm2XkxME1e3QEBROegwzIBor+YgfMk1wL9RlF3hTN5HRZnIU
         7nh6gyU4U0KwJKWbXsGzgaz6qutpSDirJ2lUPazcEwqvgzXVAHD+gU4Ks9pEHRIHwekb
         3dejY+u2SsRzyoWDhuJiUuS06F5I/hfP6+lYQCTEdH4iuNCtyelWKj1lzgA9dI5hL5FM
         TFMPTOIdQjvSuM/W22TklOklS1LNeRH34LsdWKoyJ5eXgDll6bQh28HsMnF6AvkIYhb2
         KaKg==
Received: by 10.182.207.39 with SMTP id lt7mr26109673obc.67.1343775412831;
 Tue, 31 Jul 2012 15:56:52 -0700 (PDT)
Received: by 10.76.168.200 with HTTP; Tue, 31 Jul 2012 15:56:32 -0700 (PDT)
In-Reply-To: <7v3947iqup.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/202692>

On Tue, Jul 31, 2012 at 5:05 PM, Junio C Hamano <gitster@pobox.com> wrote:
>
> Ok, then grep.patternType it is.
>
> Thanks.

Cool, patches should be on their way. I added options for "basic",
"extended", "fixed" and "perl" for completeness along with the name
change with a BC alias patch separately for perusal.

Cheers.

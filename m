From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH v5 12/10] remote-bzr: support the new 'force' option
Date: Mon, 11 Nov 2013 12:15:53 -0600
Message-ID: <CAMP44s1SC0SQLKWG13-FRwvX6AB6pZmn+z0f1ovnuawC6wcb+w@mail.gmail.com>
References: <1383212197-14259-2-git-send-email-felipe.contreras@gmail.com>
	<1384146656-11811-1-git-send-email-rhansen@bbn.com>
	<5280c4bc4354a_36a51059e74ea@nysa.notmuch>
	<52811E1F.4090500@bbn.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org, Sverre Rabbelier <srabbelier@gmail.com>
To: Richard Hansen <rhansen@bbn.com>
X-From: git-owner@vger.kernel.org Mon Nov 11 19:16:02 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vfw1o-0000WB-Bl
	for gcvg-git-2@plane.gmane.org; Mon, 11 Nov 2013 19:16:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754824Ab3KKSP5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Nov 2013 13:15:57 -0500
Received: from mail-la0-f46.google.com ([209.85.215.46]:60804 "EHLO
	mail-la0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754738Ab3KKSPz (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Nov 2013 13:15:55 -0500
Received: by mail-la0-f46.google.com with SMTP id el20so4219665lab.19
        for <git@vger.kernel.org>; Mon, 11 Nov 2013 10:15:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=91OkUpLC6Nr/HMpv9D11BTngj3+tOGybsV/0Hr8ob1k=;
        b=oKjhDRF77x9A8mC+FenXrP230hoRz6l7krwfG8Kk6tp5ZeY+BCcBGDocZ5Jn1+3Jbv
         K0dwBi3wdPDox0atpYLtMOX6zXRJjoBazuZhywbzo5hzBffz9dp95hyssyQ3xYgZ5gR+
         hLhy3cHInr41CY8Ajjv8Z1e1Fd4RVJipgnNZn6wfdmE8emOxLSfpJ1mzedm/CnbXOIKm
         zAeGfcbITuBVNA00ZAjVnbDZb0EgDT3Zf4tHFveQycY++39lViLneIXYn4afhTcX7epr
         KuVBxoPIweCKOgw4HN6MndhMptOeuhCXGqGzQQ+dfkeeCumnpq0kJsnFeh3Z04CtwYyb
         BoCg==
X-Received: by 10.112.140.137 with SMTP id rg9mr22582771lbb.19.1384193753294;
 Mon, 11 Nov 2013 10:15:53 -0800 (PST)
Received: by 10.114.201.69 with HTTP; Mon, 11 Nov 2013 10:15:53 -0800 (PST)
In-Reply-To: <52811E1F.4090500@bbn.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/237624>

On Mon, Nov 11, 2013 at 12:12 PM, Richard Hansen <rhansen@bbn.com> wrote:
> On 2013-11-11 06:51, Felipe Contreras wrote:

>>     def do_option(parser):
>>       global force
>>       _, key, value = parser.line.split(' ')
>
> I'm surprised you prefer this over 'key, val = parser[1:3]' or even
> '_, key, val = parser[:]'.  Are you intending to eventually remove
> Parser.__getitem__()?

I don't, actually. I'm fine with either way.

Cheers.

-- 
Felipe Contreras

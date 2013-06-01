From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH] run-command: simplify wait_or_whine
Date: Sat, 1 Jun 2013 21:08:52 +0700
Message-ID: <CACsJy8D=oZ0Y0F8_WFfVxgFtnsRJtxxp9y2oQgoxpxd3zU+rsw@mail.gmail.com>
References: <1370094715-2684-1-git-send-email-felipe.contreras@gmail.com>
 <CACsJy8BRYHkSj1YR9mW=_tdKX_+xKNxpVx+RNYEdoW3S36w=8Q@mail.gmail.com> <CAMP44s1jtqGXhFN+KqODR-ooe1BiyQNVD=08nDF0poBc+madxw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>, Johannes Sixt <j6t@kdbg.org>,
	Jonathan Nieder <jrnieder@gmail.com>,
	"John J. Franey" <jjfraney@gmail.com>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jun 01 16:09:33 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UimUp-0007iX-T1
	for gcvg-git-2@plane.gmane.org; Sat, 01 Jun 2013 16:09:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754874Ab3FAOJY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 1 Jun 2013 10:09:24 -0400
Received: from mail-ob0-f174.google.com ([209.85.214.174]:55623 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752438Ab3FAOJX (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 1 Jun 2013 10:09:23 -0400
Received: by mail-ob0-f174.google.com with SMTP id wd20so4838107obb.33
        for <git@vger.kernel.org>; Sat, 01 Jun 2013 07:09:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=mFvFgM8ORtkPVPBEykaVulJw13EpCos5LYjibojmPHg=;
        b=ICF3joUFu0J8ij+NrEZ5XGPT69/N2XlJPD9JbO4CPBHq2x8jR8UOpAP2pmWLRyCGeM
         5aTBwHiysK4YT8WnEB7rLUxkJpbwcBdjP0mjfts8iDiRmRTi17Qs23uMY8JFLgLMszbC
         lXW7F8XULGhVjBvVmjrkGEQd7ZVBX0hdo3N34F2jUCJ85d6t2hWHd+JsJXhiGVuV8i96
         g/zI8/AmYk/O9b781fymuVdQ7fuOWkMZuRZ8TZJj0mtJlcaG1RyM9Q/a4DWiwZuTD515
         Zos6ZBD72iegc41xVRHnPccuxlUP+GhHRctBrgmZbaV+8dtNH4sYGCsHvzePn5Qb/f+l
         oFCg==
X-Received: by 10.60.97.232 with SMTP id ed8mr6493950oeb.96.1370095762545;
 Sat, 01 Jun 2013 07:09:22 -0700 (PDT)
Received: by 10.76.171.199 with HTTP; Sat, 1 Jun 2013 07:08:52 -0700 (PDT)
In-Reply-To: <CAMP44s1jtqGXhFN+KqODR-ooe1BiyQNVD=08nDF0poBc+madxw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/226130>

On Sat, Jun 1, 2013 at 9:06 PM, Felipe Contreras
<felipe.contreras@gmail.com> wrote:
> On Sat, Jun 1, 2013 at 9:03 AM, Duy Nguyen <pclouds@gmail.com> wrote:
>> On Sat, Jun 1, 2013 at 8:51 PM, Felipe Contreras
>> <felipe.contreras@gmail.com> wrote:
>>> Nobody is checking for specific error codes; it's the errno that's
>>> important.
>>
>> Have you just disregarded the in-code comment you just removed with
>> one statement?
>
> Who cares about the comment? As I said, nobody is checking for those codes.

Apparently I do.

>> Did you check all its callers?
>
> Yes, that's why I said nobody is checking for those codes.

Thanks. If would be a few mails less if you stated so in the original message.
--
Duy

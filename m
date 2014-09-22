From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v2 22/32] checkout: support checking out into a new
 working directory
Date: Mon, 22 Sep 2014 19:01:41 -0400
Message-ID: <CAPig+cTVO0JvBB_gBRkFBhGKh8Y=iZ40j4x+K8X0d9fm04nMgw@mail.gmail.com>
References: <1409387642-24492-1-git-send-email-pclouds@gmail.com>
	<1410388928-32265-1-git-send-email-pclouds@gmail.com>
	<1410388928-32265-23-git-send-email-pclouds@gmail.com>
	<5411B98C.1090905@xiplink.com>
	<20140921024101.GA6275@lanh>
	<CAPig+cRbfxUHmxbxxXLw=WKuV3JvBPEhuT4CvrZEOhWR-fbMHQ@mail.gmail.com>
	<CACsJy8CH8mQjexFU1jO1orzajiwTXy4wJ022nq1PEY2GLUGAZA@mail.gmail.com>
	<54208E01.2060205@xiplink.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Duy Nguyen <pclouds@gmail.com>, Git List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: Marc Branchaud <marcnarc@xiplink.com>
X-From: git-owner@vger.kernel.org Tue Sep 23 01:01:48 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XWCc6-0001OG-Pk
	for gcvg-git-2@plane.gmane.org; Tue, 23 Sep 2014 01:01:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755187AbaIVXBn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Sep 2014 19:01:43 -0400
Received: from mail-yk0-f179.google.com ([209.85.160.179]:43091 "EHLO
	mail-yk0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755153AbaIVXBm (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Sep 2014 19:01:42 -0400
Received: by mail-yk0-f179.google.com with SMTP id 142so1431865ykq.24
        for <git@vger.kernel.org>; Mon, 22 Sep 2014 16:01:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=Hl8YL2OPxSprXHKOo9kpwbc/XSovxcET2FNxfEHgFEg=;
        b=XBKd5GAT0BReKabkK31XIkHqOgbuQ4H0yDV9uA2t2+loJvMHgbkfOufvNPCnkKuwlV
         Ja5UgeU9+Q12UPxmHJ85jodNH5RvF3ajRQ00wVww9fcNhFZpw0JVh7mPqn9qUewhjfbo
         lwEM5qlo8FDLh0oYVYCmgTXvnKpM/ZKQzFQwF8Q+d7ZvQCVjsIp6oMI/gFffjd8VEXR8
         fRk8SvtjonQh8fbRnLGILPc6yZ2pk5NVLjN53pwSWWZAx1ZPWK3L5MJIljn7XW11Xoio
         LcEi16b2S1TSQ7jImhKbrteZ7uvy0eELB40fEwZdI78dvtHxSdok6WBAk//IUf0wEvwY
         TOIA==
X-Received: by 10.236.127.77 with SMTP id c53mr29904538yhi.40.1411426901675;
 Mon, 22 Sep 2014 16:01:41 -0700 (PDT)
Received: by 10.170.68.68 with HTTP; Mon, 22 Sep 2014 16:01:41 -0700 (PDT)
In-Reply-To: <54208E01.2060205@xiplink.com>
X-Google-Sender-Auth: E9vBT6ozNRL6vcIuOqdojEn-_IU
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/257390>

On Mon, Sep 22, 2014 at 5:00 PM, Marc Branchaud <marcnarc@xiplink.com> wrote:
> On 14-09-21 05:50 AM, Duy Nguyen wrote:
>> On Sun, Sep 21, 2014 at 10:10 AM, Eric Sunshine <sunshine@sunshineco.com> wrote:
>>> Would it make sense for this "rule of thumb" summary to be presented
>>> first, and then the explanation of that rule after, rather than the
>>> reverse as is currently the case?
>>
>> You mean like this?

Not quite. It was a genuine question rather than an outright
suggestion for change. It is typical to present a high-level overview
and then the low-level details. This case reverses that and presents
the details first and then the overview (in the form of --git-path).
The reader wades through several paragraphs of detailed explanation of
the low-level structure of the .git directory, only to be told at the
end to use --git-path and not worry about those details. Thus, the
organization struck me as a bit odd.

> *shrug*  To me it seems better to leave it at the end here.

The text does work as-is, and presents the necessary information; and
I don't want to turn this into a bike-shedding session, so feel free
to ignore my question.

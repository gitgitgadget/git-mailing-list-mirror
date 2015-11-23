From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v3] ls-files: Add eol diagnostics
Date: Mon, 23 Nov 2015 15:00:53 -0500
Message-ID: <CAPig+cSCoa7wneR5HbHwEf0eZVgcvoHddGY4-UOSPJz8wN3Qhg@mail.gmail.com>
References: <56501EFA.7050105@web.de>
	<56517AD5.6040909@gmail.com>
	<5653474E.6050909@web.de>
	<CAHGBnuO2RQEhK=veSJ7wHoeo_9ngdSt_vJDjYBQxTma1n=Lt5Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>,
	Git Mailing List <git@vger.kernel.org>
To: Sebastian Schuberth <sschuberth@gmail.com>
X-From: git-owner@vger.kernel.org Mon Nov 23 21:01:27 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a0xIf-0007N5-JB
	for gcvg-git-2@plane.gmane.org; Mon, 23 Nov 2015 21:01:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752319AbbKWUA5 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 23 Nov 2015 15:00:57 -0500
Received: from mail-vk0-f49.google.com ([209.85.213.49]:35796 "EHLO
	mail-vk0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751467AbbKWUAy convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 23 Nov 2015 15:00:54 -0500
Received: by vkha189 with SMTP id a189so45623852vkh.2
        for <git@vger.kernel.org>; Mon, 23 Nov 2015 12:00:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type:content-transfer-encoding;
        bh=qthOP9Kn2V0OP2mfKSyobl7aRGrNbYsxTpND2qv5U6E=;
        b=rDd8/DEu2vjrQ1WphxX7Xl8l/vtbZ6g+a0Hz+zJ5EZ+/aDf0yMhyzmCaccB6fy2WQB
         jok52YUq/4leW+TJGzDCqHcEJlRssXC1Pq3NC7xaGQvGkP89gxaS+dDLe39h7pQxAdit
         VVDCdivUcV3yY7FyrU5eaGsFBNIB16lc46YJu5SAreXa2Rom6UGQFSTcMzZ3YH1avXSP
         UcCNZcJFlBbZDLGHEDswrXh952mVnChzjcTB+26Qt3vyncy5ODWdgP38LhIwSMTNAahr
         7jHDcXbaDvlx26yvILBarMI3bamr+rJykQr7rf87wmajDxwGYTcBkl1gyyyO1rnEdiy5
         Fy+w==
X-Received: by 10.31.58.74 with SMTP id h71mr21542656vka.151.1448308853727;
 Mon, 23 Nov 2015 12:00:53 -0800 (PST)
Received: by 10.31.159.204 with HTTP; Mon, 23 Nov 2015 12:00:53 -0800 (PST)
In-Reply-To: <CAHGBnuO2RQEhK=veSJ7wHoeo_9ngdSt_vJDjYBQxTma1n=Lt5Q@mail.gmail.com>
X-Google-Sender-Auth: pOYtHR8vU18YkAv_XCUQI98jjXs
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/281597>

On Mon, Nov 23, 2015 at 2:45 PM, Sebastian Schuberth
<sschuberth@gmail.com> wrote:
> On Mon, Nov 23, 2015 at 6:05 PM, Torsten B=C3=B6gershausen <tboegi@we=
b.de> wrote:
>> git ls-files -o --eol
>> i/              w/binary        attr/          zlib.o
>
> I see, somewhat convincing I have to agree.
>
> On another note, how about making the prefix either all just one
> letter (i.e. "attr/" becomes "a/"), or all multi-letter abbreviations
> (i.e. "i/" becomes "idx/" and "w/" becomes "wt/" or "wtree/" or
> "tree/")?

The latter is answered by [1].

[1]: http://article.gmane.org/gmane.comp.version-control.git/280647

From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH v2 2/2] format-patch: add format.cover-letter configuration
Date: Sat, 6 Apr 2013 10:02:32 -0600
Message-ID: <CAMP44s0Zzdb-1A0ej5Ly_501sv0OOOrHi86GWT9NYkndbiggeg@mail.gmail.com>
References: <1365239012-15079-1-git-send-email-felipe.contreras@gmail.com>
	<1365239012-15079-3-git-send-email-felipe.contreras@gmail.com>
	<CALkWK0kMTt6wDv6sUVe9CbX-WSx=XH+PF6eQ6oXYFjcp_Yi+aQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Thomas Rast <trast@student.ethz.ch>,
	Stephen Boyd <bebarino@gmail.com>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Sat Apr 06 20:03:55 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UOWWu-0001D7-F8
	for gcvg-git-2@plane.gmane.org; Sat, 06 Apr 2013 19:03:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423226Ab3DFQCe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 6 Apr 2013 12:02:34 -0400
Received: from mail-la0-f45.google.com ([209.85.215.45]:37461 "EHLO
	mail-la0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1423222Ab3DFQCe (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 6 Apr 2013 12:02:34 -0400
Received: by mail-la0-f45.google.com with SMTP id fn20so823415lab.32
        for <git@vger.kernel.org>; Sat, 06 Apr 2013 09:02:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type;
        bh=aW/UIIlAU+jy2lVXpK47ydrhUK6dEkU6yj1j3pF5Lpc=;
        b=xFWKR2LOdHBH7xByLAQIe9BFqqt3We8S+EcBa4mKZgOebMDJ8CtMKk2C5Z1kjZnj8H
         KeCBYRuyBjut29h+bexztjONO6W3vrGDA3Zq+jrzgykJA4TMZZfnshYHs/52hMYU5sSM
         E8qYxSaoopEfEo3paiU38q5rxkO16KQrIOtzSKGC+qPcy73I30g+swsmhZrztW5W9WAZ
         ZfDJeeH/MxAiZRVCqb5ffKNy/yeMEdEpfzYO4+A5OzBUwD2KFcTmzRJbUf1CiUsh/jU5
         G5+oeM9A1khyJ7ZNz/jMZBMfKiy8T7iyCekZEOJun5M/gVdxlV3vALGPPLo8J1NOxZmT
         RRyw==
X-Received: by 10.152.135.205 with SMTP id pu13mr8492749lab.48.1365264152466;
 Sat, 06 Apr 2013 09:02:32 -0700 (PDT)
Received: by 10.114.20.36 with HTTP; Sat, 6 Apr 2013 09:02:32 -0700 (PDT)
In-Reply-To: <CALkWK0kMTt6wDv6sUVe9CbX-WSx=XH+PF6eQ6oXYFjcp_Yi+aQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/220252>

On Sat, Apr 6, 2013 at 6:43 AM, Ramkumar Ramachandra <artagnon@gmail.com> wrote:
> Felipe Contreras wrote:
>> Also, add a new option: 'auto', so if there's more than one patch, the
>> cover letter is generated, otherwise it's not.
>
> Awesome!  I wanted to fix this myself, but got sidetracked with the
> whole submodules thing.
>
>> +format.cover-letter::
>> +       Allows to configure the --cover-letter option of format-patch by
>> +       default. In addition, you can set it to 'auto' to automatically
>> +       determine based on the number of patches (generate if there's more than
>> +       one).
>> +
>
> Perhaps you can clarify this: Controls whether to generate a
> cover-letter when format-patch is invoked.  Can be true, false, or
> auto.  "auto" generates a cover-letter only when generating more than
> one patch.

That's good, but I believe if we say it's a boolean, true and false
are implied, and then we have an extra "auto".

-- 
Felipe Contreras

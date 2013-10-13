From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH try2 09/14] apply: add --stage option
Date: Sun, 13 Oct 2013 05:31:31 -0500
Message-ID: <CAMP44s2sZfXOiNcK3ScJnV=un9ra8k2ONmEmcuNHNRh1nH42Sw@mail.gmail.com>
References: <1381561488-20294-1-git-send-email-felipe.contreras@gmail.com>
	<1381561488-20294-7-git-send-email-felipe.contreras@gmail.com>
	<CAPig+cSmVKK_onR8NtLkdahkFci77SCsU6PagyJEBYLo4xZBUQ@mail.gmail.com>
	<CADCnXoaeF9Avjy08C_eJN3YJAMbGZXh6mkKjj4sgfaED=b_GnA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	Git List <git@vger.kernel.org>,
	Piotr Krukowiecki <piotr.krukowiecki.news@gmail.com>,
	Jay Soffian <jaysoffian@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Philip Oakley <philipoakley@iee.org>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	William Swanson <swansontec@gmail.com>,
	Ping Yin <pkufranky@gmail.com>,
	Hilco Wijbenga <hilco.wijbenga@gmail.com>
To: Miles Bader <miles@gnu.org>
X-From: git-owner@vger.kernel.org Sun Oct 13 12:31:48 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VVIxf-000549-Iq
	for gcvg-git-2@plane.gmane.org; Sun, 13 Oct 2013 12:31:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754206Ab3JMKbe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 13 Oct 2013 06:31:34 -0400
Received: from mail-la0-f52.google.com ([209.85.215.52]:33516 "EHLO
	mail-la0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754152Ab3JMKbd (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 13 Oct 2013 06:31:33 -0400
Received: by mail-la0-f52.google.com with SMTP id ev20so4851364lab.11
        for <git@vger.kernel.org>; Sun, 13 Oct 2013 03:31:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=ykHu8/O9CHwAXLW8HPTWjRgVzBwfiP8WbeJX7pwWAnw=;
        b=u5ixGEgyWCo38PMv8VxA1DF+fhRHVYlz2hOUkECW2NVYvPO4SV2PGFbb0LOVCdKoqf
         ZjkTidOi2Szk0VX3yoaY48LVe30i8cc/6NLZHQItoGEfOO3GNBts+8TQxEuCa14sNYmO
         DGevTTk6Ckgzpt1tfFrBE4xe104rvAqo+yn+wzgWbU7Se5ky0jlSGfOmKlFQ5xIWBZuZ
         YbPSFgd0RDO0UoN905bV59/QYjFZBX0fPEIV+ELjlY1hNd9juxye7VUyGR/7xesqJS9w
         ALcgTCpAFqTbUtx7HXYenLapbL8n5XY9f58F069hKk+fQxb+tfN3iJkoIOJMySg1j/58
         VS8Q==
X-Received: by 10.112.168.3 with SMTP id zs3mr25695687lbb.2.1381660291646;
 Sun, 13 Oct 2013 03:31:31 -0700 (PDT)
Received: by 10.114.91.230 with HTTP; Sun, 13 Oct 2013 03:31:31 -0700 (PDT)
In-Reply-To: <CADCnXoaeF9Avjy08C_eJN3YJAMbGZXh6mkKjj4sgfaED=b_GnA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/236074>

On Sun, Oct 13, 2013 at 5:19 AM, Miles Bader <miles@gnu.org> wrote:
> 2013/10/13 Eric Sunshine <sunshine@sunshineco.com>:
>> Here "staged".
> ...
>> But here "stage".
>
> The inconsistency is weird, but isn't the term "staged" a bit odd with
> something that affects the future...?
>
> "Apply to the stage" seems a reasonable english phrasing, but "staged"
> seems more awkward...

That's true, I was thinking since this was supposed to be a
non-intrusive change, it would make sense to keep close to the
--cached option, but the synonym is actually --index, not --cached. So
--stage makes more sense from those two points of view.

-- 
Felipe Contreras

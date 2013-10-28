From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: git-completion.bash error
Date: Mon, 28 Oct 2013 01:31:41 -0400
Message-ID: <CAPig+cRfrr8FjGtk7uFzfP6xBGzFabSPb4oi=EcNV1-OfQZ5eA@mail.gmail.com>
References: <CAGvuA0iGrF5jrUSCjT7-SR85i2OhBwQHfjj4+krAFfz5wnxx8w@mail.gmail.com>
	<CAPig+cQuh0QEbmDxNMHgvhmJ7AFgvP70qvJhfVw3fz6YxaME7w@mail.gmail.com>
	<CAGvuA0gkKWpLXwQm6ipGfWhzpiT-SFCCKxxvvN+FbO8i4_hmPg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: Gabriel <gabriel.so@gmail.com>, Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Oct 28 06:31:49 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VafQZ-0006jg-H5
	for gcvg-git-2@plane.gmane.org; Mon, 28 Oct 2013 06:31:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751848Ab3J1Fbn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Oct 2013 01:31:43 -0400
Received: from mail-lb0-f182.google.com ([209.85.217.182]:51542 "EHLO
	mail-lb0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751458Ab3J1Fbm (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Oct 2013 01:31:42 -0400
Received: by mail-lb0-f182.google.com with SMTP id w6so2398410lbh.41
        for <git@vger.kernel.org>; Sun, 27 Oct 2013 22:31:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:content-type;
        bh=IVS4k27wpFFcpOBhB2OdsGniMRLw99LLEpUvE6opgaw=;
        b=eogX5utGBGEL8jmReZYhO3DeVAjRH5L4W2IZcJT+XMgV6RFKFQZlAxV+PDiV0Ix3C5
         IxSFA15GSvIEFpqhhCepR0Ofy2yk9aHwUmbXWxWs4mIsxhQ68AeiqmHV74sDADdWK27R
         wCR0tfCPqlRjH3oEUWsS/f7nEdM3ZHomGBBxQVxEFiFmiFJWZWo6blPZgDtVogSiTriR
         hAt9LJwe5rxBfDxfmsuDHnSkVwuBSHJYbG7A420beL/8WYWBDS1vVhIMw9AKuw/EzANU
         3rK884TV9QWajEbzHSHyZdlsrGvK0dYoidb+LPDMc5PUrkyYpU0GDpYtFrDS2pjOYeds
         3/uw==
X-Received: by 10.112.149.197 with SMTP id uc5mr9868026lbb.19.1382938301259;
 Sun, 27 Oct 2013 22:31:41 -0700 (PDT)
Received: by 10.114.200.180 with HTTP; Sun, 27 Oct 2013 22:31:41 -0700 (PDT)
In-Reply-To: <CAGvuA0gkKWpLXwQm6ipGfWhzpiT-SFCCKxxvvN+FbO8i4_hmPg@mail.gmail.com>
X-Google-Sender-Auth: DNSmVCi_qY8agsjut42zOH5wABs
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/236818>

[re-adding git mailing list]

Please do use Reply All and respond inline (as below) rather than top-posting.

On Sun, Oct 27, 2013 at 8:47 PM, Gabriel <gabriel.so@gmail.com> wrote:
> I have a possible broken "shell pipe".
>
> grep/egrep works fine when I pass a pattern and a file or folder, but
> it breaks after pipe.
>
> The content of the line that breaks on my machine is:
> git help -a|egrep '^  [a-zA-Z0-9]'

Are you using a broken egrep? On Mavericks, mine shows:

% type egrep
egrep is /usr/bin/egrep
% egrep --version
egrep (BSD grep) 2.5.1-FreeBSD


> This commands breaks outputting the regexp not being a valid file or directory.
>
> I'll keep investigating but I've never seen a broken shell pipe function =(
>
> Thanks
>
> On Sun, Oct 27, 2013 at 8:34 PM, Eric Sunshine <sunshine@sunshineco.com> wrote:
>> On Sun, Oct 27, 2013 at 4:59 PM, Gabriel <gabriel.so@gmail.com> wrote:
>>> I've just made a clean install of OS X Mavericks and installed Git via
>>> Homebrew, which obviously includes the contrib files.
>>>
>>> I sourced the git-completion.bash into my profile and I get stuck on a
>>> error every time I try to use the autocomplete. The error outputted
>>> is:
>>>
>>> egrep: ^ [a-zA-Z0-9]: No such file or directory
>>>
>>> I believe this is related to this line (this commands outputs the same
>>> error when entered directly):
>>> https://github.com/git/git/blob/master/contrib/completion/git-completion.bash#L614
>>
>> Unable to reproduce on Mavericks either via the completion script or
>> manual entry.
>>
>>> I don't know if this issue is directly related to OS X Mavericks or
>>> anything else.

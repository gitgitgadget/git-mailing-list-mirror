From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH v2] Add new remote-hg transport helper
Date: Sat, 20 Oct 2012 18:04:06 +0200
Message-ID: <CAMP44s14LeQY5OumDrMRN9foQPTnAUxtYoyf0Z5YHzjxOybcsA@mail.gmail.com>
References: <1350745206-28955-1-git-send-email-felipe.contreras@gmail.com>
	<20121020154301.GA31829@glandium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Ilari Liusvaara <ilari.liusvaara@elisanet.fi>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Jeff King <peff@peff.net>,
	Michael J Gruber <git@drmicha.warpmail.net>
To: Mike Hommey <mh@glandium.org>
X-From: git-owner@vger.kernel.org Sat Oct 20 18:04:27 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TPbXB-0007eV-Gz
	for gcvg-git-2@plane.gmane.org; Sat, 20 Oct 2012 18:04:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754533Ab2JTQEJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 20 Oct 2012 12:04:09 -0400
Received: from mail-ob0-f174.google.com ([209.85.214.174]:53885 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754501Ab2JTQEH (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 20 Oct 2012 12:04:07 -0400
Received: by mail-ob0-f174.google.com with SMTP id uo13so1294917obb.19
        for <git@vger.kernel.org>; Sat, 20 Oct 2012 09:04:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=y7w2FSsEpXqmyfU55lN4JOA99ttcuTBi6lvJ4S2iafY=;
        b=sYRwQCTm/aDQ2oOaGvnj2nlhDRka3hyAKoQNjqTkAVqlP++wFzJsrBu+fVy5oh75Lg
         Cr94igyMjhluLQsp9Hp0+FUAoKvZA5zVL9deHjdNQ25wiaE8hu8YfpXQzxB/fTm/Enxy
         a5FxvBubQkWnWZLkaOZ7HqLVchH2dxKZ5X77Gfp0puzwdQry/NTr9vqPo6ZWOvlMCplF
         O6YJOOjnIyYnqhKCPPkfF152uaRK1MepKW0cA856GoI4zXsZnNCSPHsFm/0fekR5AZhZ
         4kTd+rrFHZ1x0uArutt0eRDIdUxTuecYOZ/2/GJoKtY48LTh2ktlqwd2yilB+M7VuwCc
         QFCg==
Received: by 10.60.22.228 with SMTP id h4mr4193469oef.30.1350749046361; Sat,
 20 Oct 2012 09:04:06 -0700 (PDT)
Received: by 10.60.4.74 with HTTP; Sat, 20 Oct 2012 09:04:06 -0700 (PDT)
In-Reply-To: <20121020154301.GA31829@glandium.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/208089>

On Sat, Oct 20, 2012 at 5:43 PM, Mike Hommey <mh@glandium.org> wrote:
> On Sat, Oct 20, 2012 at 05:00:06PM +0200, Felipe Contreras wrote:
>> Changes since v1:
>>
>>  * Improved documentation
>>  * Use more common 'python' binary
>>  * Warn, don't barf when a branch has multiple heads
>>  * Fixed marks to fetch after cloned
>>  * Support for cloning/pulling remote repositories
>>  * Use a more appropriate internal directory (e.g. .git/hg/origin)
>>  * Fixes for python3
>
> Are the resulting commits identical to what you'd get from using hg-git?

No, but should be easy to implement.

-- 
Felipe Contreras

From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH 1/9] remote-bzr: trivial cleanups
Date: Thu, 25 Apr 2013 14:33:38 -0500
Message-ID: <CAMP44s1hw_Rq2=N+emKWMzKyVxO5FVLM_H9WJ3x5awte-siw=A@mail.gmail.com>
References: <1366888849-19607-1-git-send-email-felipe.contreras@gmail.com>
	<1366888849-19607-2-git-send-email-felipe.contreras@gmail.com>
	<CALkWK0meg1FgU=-4MFoFGjpDq_oa9XR_+qeiseR0J85mS71dNg@mail.gmail.com>
	<5179842D.6060500@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Ramkumar Ramachandra <artagnon@gmail.com>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>,
	Christophe Simonis <christophe@kn.gl>,
	Simon Ruderich <simon@ruderich.org>, Max Horn <max@quendi.de>
To: Stefano Lattarini <stefano.lattarini@gmail.com>
X-From: git-owner@vger.kernel.org Thu Apr 25 21:33:47 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UVRvM-0005Br-Ns
	for gcvg-git-2@plane.gmane.org; Thu, 25 Apr 2013 21:33:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932815Ab3DYTdk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Apr 2013 15:33:40 -0400
Received: from mail-lb0-f182.google.com ([209.85.217.182]:61128 "EHLO
	mail-lb0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932250Ab3DYTdk (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Apr 2013 15:33:40 -0400
Received: by mail-lb0-f182.google.com with SMTP id v20so3132995lbc.27
        for <git@vger.kernel.org>; Thu, 25 Apr 2013 12:33:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type;
        bh=ctsStLem2N+bj4Q3assHr+/PlaHr8KtNIPED6/FA/8w=;
        b=z73mlDwCz5MyiCXJni6p//87ftYxO8XX1Q+dYj1OI4mX6oAOLe9HfTVYihekOPkOK1
         7VzIWk5aXAOjMnz5LBkwTcdOrZc4LvspNp4kVOgfhzbAWryfL2FL2R6//vO9yDBS0Sp4
         jC2XcYWghaT6Kn38wVoFdt5wVA+0ovu4YJF3ZYeL4TLrtTfVlLH+NguxH/rQp4yYnO5M
         gjgyUjePKoHdMgUlbd+odNDaHcGgSocApJgRSIc08Od8/epkrAOhO/TKFWfm37gV5L/v
         fzAbvWXbx9/FK7gU3EIJo6I3KC6vqJ4uiz+SWaX0VKSgGP2FiHPM7tNlZBGzoKbR5ilZ
         aa9w==
X-Received: by 10.152.20.134 with SMTP id n6mr8828409lae.19.1366918418664;
 Thu, 25 Apr 2013 12:33:38 -0700 (PDT)
Received: by 10.114.83.167 with HTTP; Thu, 25 Apr 2013 12:33:38 -0700 (PDT)
In-Reply-To: <5179842D.6060500@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222421>

On Thu, Apr 25, 2013 at 2:29 PM, Stefano Lattarini
<stefano.lattarini@gmail.com> wrote:
> On 04/25/2013 08:19 PM, Ramkumar Ramachandra wrote:

>>> @@ -521,7 +521,7 @@ def c_style_unescape(string):
>>>      return string
>>>
>>>  def parse_commit(parser):
>>> -    global marks, blob_marks, bmarks, parsed_refs
>>> +    global marks, blob_marks, parsed_refs
>>
>> How is this trivial?  You just removed one argument.
>>
> Maybe bmarks was no longer used there as a global variable
> (left-over from previous patches?), so there is no longer any
> need to declare it global.

Even more, it never was used, it was a mistake carried when copying
this method from remote-hg; we don't have bookmarks in bazaar. And
bmarks wasn't even used in this method in remote-hg either =/

But it would be obvious that it was not used once one ran the tests
and they passed, which they do.

Cheers.

-- 
Felipe Contreras

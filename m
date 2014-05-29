From: Rodrigo Fernandes <rtfrodrigo@gmail.com>
Subject: Re: [BUG REPORT] Git log pretty date
Date: Thu, 29 May 2014 13:24:36 +0100
Message-ID: <CACJZPBvn4nX4aVGiiC1VAhHi7vPZJDBR8T5p13qaE6B+2Q9bUw@mail.gmail.com>
References: <CACJZPBtv-Cpb8_WZMz9Hsk9MrC86YGfbvREt6G=QKvMBjrqsEg@mail.gmail.com>
 <1401361654.26905.2.camel@spirit>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org
To: Dennis Kaarsemaker <dennis@kaarsemaker.net>
X-From: git-owner@vger.kernel.org Thu May 29 14:25:27 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WpzOd-0005tY-B9
	for gcvg-git-2@plane.gmane.org; Thu, 29 May 2014 14:25:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757331AbaE2MZS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 29 May 2014 08:25:18 -0400
Received: from mail-yk0-f182.google.com ([209.85.160.182]:53094 "EHLO
	mail-yk0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756322AbaE2MZR (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 May 2014 08:25:17 -0400
Received: by mail-yk0-f182.google.com with SMTP id 9so166811ykp.41
        for <git@vger.kernel.org>; Thu, 29 May 2014 05:25:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=hLzzKje9ScdU6FV1UBGp0ETYxtE5hFDEuK0eqaRkVcc=;
        b=fjXNRBt/v/z6/KyifSeF9RIVJ92ev2M7g3FX5DG7c8BtqDXFqMOxeGEdR5RTzdCpzN
         IemZEmmpq4z/IKyqJlXDqgzNhePqOQMUWNEbOZn9se1tVkMl3MMb3Wmk0UvXuO0M6w7X
         Ng2/uGI+2y3eQGCsS1MtHmutvX8WBgmEAKGWdgh8l7ra7l7Nf4NK7bH3HLXqWCmiifbn
         O3fwCuBEFMkOmfykZjoHEaj9fjJtBLH5Q94n3JkBZd3CyNZOga7hAE2/NkRwxwvu6z4e
         9gabvGIepZhEoc6p2JDs8voTKWcMgZc9aqnSytoOn/dEwAQHfZh0fTKb8DBvWtPIEBgZ
         ZxPA==
X-Received: by 10.236.185.167 with SMTP id u27mr9939669yhm.128.1401366316745;
 Thu, 29 May 2014 05:25:16 -0700 (PDT)
Received: by 10.170.51.136 with HTTP; Thu, 29 May 2014 05:24:36 -0700 (PDT)
In-Reply-To: <1401361654.26905.2.camel@spirit>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/250365>

Dennis I think that could be an improvement.

Duy, can you point me where is the date print from normal `git log` or
`git show` so I can compare?


On Thu, May 29, 2014 at 12:07 PM, Dennis Kaarsemaker
<dennis@kaarsemaker.net> wrote:
> On do, 2014-05-29 at 11:29 +0100, Rodrigo Fernandes wrote:
>>
>> The problem happens when I try to get a pretty log for a commit with a
>> wrong date.
>
> The commit is:
>
> ===
> $ git cat-file commit e9dddaf24c9de45d9b4efdf38eff7c30eb200f48
> tree d63aeb159635cb231e191505a95a129a3b4a7b38
> parent 9276202f1c0dcc360433df222c90f7874558f072
> author SamWM <sam@webmonkeysolutions.com> 1288370243 --700
> committer SamWM <sam@webmonkeysolutions.com> 1288370243 --700
>
> Update version number, make text formatting and indentation consistent
> with the rest of the code
> ====
>
> Those dates are indeed wrong, I'm not surprised git refuses to parse
> them.
>
> --
> Dennis Kaarsemaker
> www.kaarsemaker.net
>

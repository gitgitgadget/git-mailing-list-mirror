From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH v5 01/15] Add new git-related helper to contrib
Date: Sun, 19 May 2013 10:41:57 -0500
Message-ID: <CAMP44s3idD9pen0PyFuHeXQ=uphA8gVfFCEYhEnDRsx-gszbAw@mail.gmail.com>
References: <1368877615-9563-1-git-send-email-felipe.contreras@gmail.com>
	<1368877615-9563-2-git-send-email-felipe.contreras@gmail.com>
	<CALkWK0ke-Ns0JCt6LAzWqympWZ=2x3rRHOjnzB9QN7gc2=ckgw@mail.gmail.com>
	<CAMP44s1xguzX=iavUJxYXBEPOpGvJtJ_7FDHNCWMrF6qxOsuOQ@mail.gmail.com>
	<CALkWK0kz-pQ9UJPXerFoui9ftNXDzD-xhpkSHY=JX3rbFXgp-g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Duy Nguyen <pclouds@gmail.com>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Sun May 19 17:42:06 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ue5kK-00074K-2d
	for gcvg-git-2@plane.gmane.org; Sun, 19 May 2013 17:42:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750928Ab3ESPl7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 19 May 2013 11:41:59 -0400
Received: from mail-la0-f46.google.com ([209.85.215.46]:49382 "EHLO
	mail-la0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750733Ab3ESPl6 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 19 May 2013 11:41:58 -0400
Received: by mail-la0-f46.google.com with SMTP id er20so1468110lab.5
        for <git@vger.kernel.org>; Sun, 19 May 2013 08:41:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type;
        bh=tVAR+QcV/uDg+rVqpHb3te53jw4YYue0cIGuce+GPDY=;
        b=cwtwB9QcUnXcli1NunWwOkhz3awGTNNXUz+PeQkf7z0Mlg+0pVFMpRyjiAUPZdCv4Q
         32/I4G+JoJ65nOFpGMofpgoMCiYLOrAjw9SuXVP/Q9w4Bq20Wfiw4jQwC8+xUGFYj2tH
         yuByS4IBLIgREmE6rvAMdR4BWo87tAzKKM/FFUfKrXbFVlIwxRGkL0naO8mteOh15wFU
         GP9B1EKYwJWcuqIsdEIHpa2dKQAOAvATgcNLMIhD+0f7N0Y4WnS3XcjnJ4CxfZEzGfMd
         aNd3afHpyR5uOj0rOhHUxW/1rkkovyN91rLNH2fzUk19tZejuJM6IhSZJT2VYBAEQim0
         Qrag==
X-Received: by 10.152.22.168 with SMTP id e8mr26548755laf.20.1368978117449;
 Sun, 19 May 2013 08:41:57 -0700 (PDT)
Received: by 10.114.184.3 with HTTP; Sun, 19 May 2013 08:41:57 -0700 (PDT)
In-Reply-To: <CALkWK0kz-pQ9UJPXerFoui9ftNXDzD-xhpkSHY=JX3rbFXgp-g@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/224893>

On Sun, May 19, 2013 at 10:13 AM, Ramkumar Ramachandra
<artagnon@gmail.com> wrote:
> Felipe Contreras wrote:
>> How exactly is it not equivalent to len = len || 1?
>
> Here, I dug up an article for you on the issue:
>
> http://www.rubyinside.com/what-rubys-double-pipe-or-equals-really-does-5488.html
>
> Although it's fine in this case, I wouldn't recommend using ||=
> because of the potential confusion.

I don't see the confusion, 'len ||= 1' is *exactly* the same as 'len =
1 if not len', which is what I expected.

-- 
Felipe Contreras

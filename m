From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH 7/8] ls-files: support --max-depth
Date: Tue, 25 Mar 2014 18:15:40 +0700
Message-ID: <CACsJy8Awu6oNOS-m5_DNh_HGeHKgcnowUY+iz4efo3s1HYycnQ@mail.gmail.com>
References: <1395310551-23201-1-git-send-email-pclouds@gmail.com>
 <1395310551-23201-8-git-send-email-pclouds@gmail.com> <1457323768.788823.1395737758945.JavaMail.zimbra@imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Cc: Git Mailing List <git@vger.kernel.org>
To: Matthieu Moy <matthieu.moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Tue Mar 25 12:16:43 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WSPLW-0005pE-CC
	for gcvg-git-2@plane.gmane.org; Tue, 25 Mar 2014 12:16:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751644AbaCYLQM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 25 Mar 2014 07:16:12 -0400
Received: from mail-qg0-f50.google.com ([209.85.192.50]:39421 "EHLO
	mail-qg0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751448AbaCYLQL convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 25 Mar 2014 07:16:11 -0400
Received: by mail-qg0-f50.google.com with SMTP id q108so862814qgd.9
        for <git@vger.kernel.org>; Tue, 25 Mar 2014 04:16:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=+N2h2iO6T1cA1TBVj1Df6nqBMJVwqyLuFqMJqZYUQcw=;
        b=LqAwOL58J0x4n2VWLb/av84R0lBaOyxpocEn/XPMyMo79+uDyYZPMXFxzo/BfMHfZ4
         lHHaNop3/Unikytw6qjc5yVWOWig/6j9NlFGzyNh/YSFxoY7Ww8ugnW+fnVMBP56TTp7
         CVgHBjqkivHkhCfgLG9yQL66RYaYG/cJWYwLJe8dHuIThp8U+zoabQhQKOy8H+Ki7GKo
         FGoqNHW50nv1TNYwiNwqFO22vtMmvKDKylon3aYNWOSi/qkGDaEKaSW4pw9AAefzk56H
         nWO62d/Z4xCb26IvXEtpNgONRFBd/+rO+1VkQHhyL1ZzQ8393YUpVB0ff0Ag/Tsek1oE
         Um4A==
X-Received: by 10.140.93.244 with SMTP id d107mr76542296qge.41.1395746170422;
 Tue, 25 Mar 2014 04:16:10 -0700 (PDT)
Received: by 10.96.103.166 with HTTP; Tue, 25 Mar 2014 04:15:40 -0700 (PDT)
In-Reply-To: <1457323768.788823.1395737758945.JavaMail.zimbra@imag.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/245027>

On Tue, Mar 25, 2014 at 3:55 PM, Matthieu Moy
<matthieu.moy@grenoble-inp.fr> wrote:
> ----- Original Message -----
>> The use case in mind is --max-depth=0 to stop recursion. With this we can do
>>
>> git config --global alias.ls 'ls-files --column --color --max-depth=0'
>>
>> and have "git ls" with an output very similar to GNU ls.
>
> One big difference though: your "git ls" does not show directories. I understand that this is easier to implement, but from the user point of view it resulted in a "wtf" from me running "git ls" in a repository containing essentially directories, and seeing just a README file in the output.

I was hoping you didn't notice :) It'll be more difficult but not impossible.

> Ideally (for me), directories should be shown with a trailing / like "ls -F" does.

I'd rather go with no trailing slash by default and add -F (which
seems to be more than just '/')
-- 
Duy

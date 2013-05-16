From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH 1/3] fetch: add --allow-local option
Date: Thu, 16 May 2013 04:34:41 -0500
Message-ID: <CAMP44s0x62h+n29osEdRvuhBtvDY7bD3m1_jDq4ZDMrgFwP0ow@mail.gmail.com>
References: <1368689474-28911-1-git-send-email-felipe.contreras@gmail.com>
	<1368689474-28911-2-git-send-email-felipe.contreras@gmail.com>
	<CALkWK0=OTBVauqpxZO5br5zRy8D_o3DzgLfaDRVx9Y_EVm19qA@mail.gmail.com>
	<CAMP44s1SWORAzBP-WO_Xc62F=YFckgU4knLyse0DSDRW33crZA@mail.gmail.com>
	<CALkWK0nT7fySb5um1RcKW2R4v6AE_EQ0gTod8_kNNJOFbwFnWQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Jens Lehmann <Jens.Lehmann@web.de>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Thu May 16 11:34:48 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UcuaF-0002MO-4N
	for gcvg-git-2@plane.gmane.org; Thu, 16 May 2013 11:34:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751712Ab3EPJen (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 16 May 2013 05:34:43 -0400
Received: from mail-lb0-f172.google.com ([209.85.217.172]:44312 "EHLO
	mail-lb0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751281Ab3EPJem (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 May 2013 05:34:42 -0400
Received: by mail-lb0-f172.google.com with SMTP id y6so2903810lbh.17
        for <git@vger.kernel.org>; Thu, 16 May 2013 02:34:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type;
        bh=M2kKUjCinmVv05/VEz9GiEzIESnx5i58+rhLfF6p8QM=;
        b=FTCAaAbZssG1WG7G+EIQeiOzgLUNWinzIGOcrENOiwfLjFuQPZ8xlUsGgRTuihHw2i
         yWI+YCPzH30wJqHkNzKdGSk38B5bLm+8hdesm+DzfWvDHYFDSj0OTnClqmV27qfGz45J
         Cswbe/DGSjhAdk1/KHtZgyJo6Uc4sfaKIa1pNASqKIFfVvOFRpA/6aWGLkp65ez6oTpx
         u/O2RCuC6qqCdmRWpAJ89qdQit7a794iv9UZ4GTZSCJaqxOmgXLumgkE3vJxwMz/wjP5
         sIm81vK9jkJmnAi9W8QkOLaYAeD11zrtnvzuMleEVfTcC+pnPeeWBFWtXoFuuWKePKUo
         wh+g==
X-Received: by 10.112.166.101 with SMTP id zf5mr19270700lbb.59.1368696881206;
 Thu, 16 May 2013 02:34:41 -0700 (PDT)
Received: by 10.114.184.3 with HTTP; Thu, 16 May 2013 02:34:41 -0700 (PDT)
In-Reply-To: <CALkWK0nT7fySb5um1RcKW2R4v6AE_EQ0gTod8_kNNJOFbwFnWQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/224524>

On Thu, May 16, 2013 at 4:27 AM, Ramkumar Ramachandra
<artagnon@gmail.com> wrote:
> Felipe Contreras wrote:
>> % git checkout -t -b devel master
>
> Interesting.  Have you considered changing -t to inherit the parent
> branch's remote?  (Would everyone like that?)

Why would I do that? When I do 'git rebase' I want to rebase on top of
'master', not 'origin/master' (or whatever the upstream of 'master'
is).

-- 
Felipe Contreras

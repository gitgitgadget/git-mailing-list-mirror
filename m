From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH v4 01/11] Add new git-related helper to contrib
Date: Fri, 26 Apr 2013 17:52:54 -0500
Message-ID: <CAMP44s0nvWvicFAJEqe0jC+zT3ZvA=Qx3MWXK36zYb2-uYV-aA@mail.gmail.com>
References: <1366919983-27521-1-git-send-email-felipe.contreras@gmail.com>
	<1366919983-27521-2-git-send-email-felipe.contreras@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Duy Nguyen <pclouds@gmail.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Apr 27 00:53:02 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UVrVl-0003h5-AO
	for gcvg-git-2@plane.gmane.org; Sat, 27 Apr 2013 00:53:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754985Ab3DZWw5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 26 Apr 2013 18:52:57 -0400
Received: from mail-lb0-f173.google.com ([209.85.217.173]:47369 "EHLO
	mail-lb0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754111Ab3DZWw4 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Apr 2013 18:52:56 -0400
Received: by mail-lb0-f173.google.com with SMTP id 10so4189974lbf.4
        for <git@vger.kernel.org>; Fri, 26 Apr 2013 15:52:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type;
        bh=zCgdKyMzSuBLq8n4yAhBLI8iahroTeh1TTMFF4jhviw=;
        b=c/HkVVmA3j8LjA01l1nhXIAsrJe1oeGTixxY12F5usF1icVAbJ2SZ9GOheTpth6LpM
         QEZoGwyGPqS0Y3Kay8abz3VMyWDSQ/KMG6/WBDNH3HutonMgATi3Ty2R8DmaDxC/nD2S
         C1SEY8Ovxaq3efri5W2VFx05XZf0komJjAPIX8ixori4zwoR+S6BQdMDTciZxQlCdNGu
         DCexSirjiOai4Hxc5glk5+eFeyG93yuIImVXEdynrSybscvUptCM7WOVT2fSQuTklyao
         vM84MKXfq9eDVoFkc228lAohrU9/pQchFjgypkJNFeM7uGT8TMVmLD9Kg0v4wAglwI5c
         fDtg==
X-Received: by 10.112.163.6 with SMTP id ye6mr22516020lbb.59.1367016774835;
 Fri, 26 Apr 2013 15:52:54 -0700 (PDT)
Received: by 10.114.83.167 with HTTP; Fri, 26 Apr 2013 15:52:54 -0700 (PDT)
In-Reply-To: <1366919983-27521-2-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222602>

Hi,

On Thu, Apr 25, 2013 at 2:59 PM, Felipe Contreras
<felipe.contreras@gmail.com> wrote:
> This script find people that might be interested in a patch, by going
> back through the history for each single hunk modified, and finding
> people that reviewed, acknowledge, signed, or authored the code the
> patch is modifying.
>
> It does this by running 'git blame' incrementally on each hunk, and then
> parsing the commit message. After gathering all the relevant people, it
> groups them to show what exactly was their role when the participated in
> the development of the relevant commit, and on how many relevant commits
> they participated. They are only displayed if they pass a minimum
> threshold of participation.

Is this patch still not understandable? If so, I would gladly strip
away functionality, like the ability to show the roles. But for the
functionality it provides, I don't see how it could be any simpler.

Sure, code comments might help, but first I would like to make the
code as self-documenting as possible, so I would give a try at a
simplified version first, and then perhaps adding a Person object.

Better for me if the code was good enough as it is though.

Cheers.

-- 
Felipe Contreras

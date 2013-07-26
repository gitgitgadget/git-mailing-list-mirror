From: Fredrik Gustafsson <iveqy@iveqy.com>
Subject: Re: Why can't I push from a shallow clone?
Date: Fri, 26 Jul 2013 08:55:28 +0200
Message-ID: <20130726065528.GA4940@paksenarrion.iveqy.com>
References: <CANEZYrdsCgH+3NnZnnmsn_znt=+01aNn02u4mWyb3td9XypUog@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Gulshan Singh <gsingh2011@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jul 26 08:53:24 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V2btz-00012G-0Z
	for gcvg-git-2@plane.gmane.org; Fri, 26 Jul 2013 08:53:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752458Ab3GZGxT convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 26 Jul 2013 02:53:19 -0400
Received: from mail-lb0-f171.google.com ([209.85.217.171]:58593 "EHLO
	mail-lb0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752149Ab3GZGxS (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Jul 2013 02:53:18 -0400
Received: by mail-lb0-f171.google.com with SMTP id 13so2196140lba.2
        for <git@vger.kernel.org>; Thu, 25 Jul 2013 23:53:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=M1r5vkItVCOZSjEVaz4xjdB1zHtzSG+wn8Qop/A2KzA=;
        b=X8Bz7C5DRB/OXLcYBKwQ5jrZfEtejdFi0l+RybRLAUxcsbGK2vymijNJWtZ8dvJ7BG
         dnwRajNLwex5UWAOnMlxEetxWODR9ncXrye1Y6Q7DNh1tOG9xWfADiL6H3R84gJccbE3
         R5ZuL9CUgYXWWJrFOaFWx8UxPb7kGRLSLlRZOhFIICPFbOw7Ebiq1RjwvMCArQPQa7s1
         GwFeVHmp5/tDXJjjuv7l63BhrgRuzyPrhzn0rYMVJSLYVLrNgBmVJFS8zWibyfLeol5I
         FVNA3O4yimvjzuVng0XZtJ+4gSYFsbfLRKXIOihV6l0NT2sEf9CPZ02rVlvGE4Pqeg4b
         T8Lg==
X-Received: by 10.152.3.74 with SMTP id a10mr20847527laa.74.1374821596524;
        Thu, 25 Jul 2013 23:53:16 -0700 (PDT)
Received: from paksenarrion.iveqy.com (c83-250-233-181.bredband.comhem.se. [83.250.233.181])
        by mx.google.com with ESMTPSA id p20sm395906lbb.17.2013.07.25.23.53.15
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Thu, 25 Jul 2013 23:53:15 -0700 (PDT)
Received: from iveqy by paksenarrion.iveqy.com with local (Exim 4.72)
	(envelope-from <iveqy@paksenarrion.iveqy.com>)
	id 1V2bw0-0006cB-Bd; Fri, 26 Jul 2013 08:55:28 +0200
Content-Disposition: inline
In-Reply-To: <CANEZYrdsCgH+3NnZnnmsn_znt=+01aNn02u4mWyb3td9XypUog@mail.gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/231170>

On Thu, Jul 25, 2013 at 07:33:16PM -0700, Gulshan Singh wrote:
> I've been trying to figure out why I can't push from a shallow clone
> (using --depth) to a repository. I've made simple examples where it
> works, but I've read that in doesn't work in every case. However, I
> can't come up with a case where it doesn't work. Googling gives this
> answer: http://stackoverflow.com/questions/6900103/why-cant-i-push-fr=
om-a-shallow-clone,
> but I don't completely understand the explanation, so I was hoping
> someone could explain it.

I can't explain it better than what Junio did in the link you just
provide. However there's ongoing work to allow shallow clones to be abl=
e
to push. You can read about it here:
http://thread.gmane.org/gmane.comp.version-control.git/230612/focus=3D2=
30878

--=20
Med v=E4nliga h=E4lsningar
=46redrik Gustafsson

tel: 0733-608274
e-post: iveqy@iveqy.com

From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH v5 01/15] Add new git-related helper to contrib
Date: Sun, 19 May 2013 03:29:32 -0500
Message-ID: <51988d6c4eceb_76e0f31e2080975@nysa.mail>
References: <1368877615-9563-1-git-send-email-felipe.contreras@gmail.com>
 <1368877615-9563-2-git-send-email-felipe.contreras@gmail.com>
 <CAMP44s0QYrzVBsmba1PYMG0yo0CpvTnVm=QHfYif6iu_Zo=tNA@mail.gmail.com>
 <7vli7bza98.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Ramkumar Ramachandra <artagnon@gmail.com>,
	Duy Nguyen <pclouds@gmail.com>
To: Junio C Hamano <gitster@pobox.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Sun May 19 10:32:10 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Udz2H-0007Oc-Ca
	for gcvg-git-2@plane.gmane.org; Sun, 19 May 2013 10:32:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753897Ab3ESIcE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 19 May 2013 04:32:04 -0400
Received: from mail-oa0-f44.google.com ([209.85.219.44]:45184 "EHLO
	mail-oa0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753858Ab3ESIcC (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 19 May 2013 04:32:02 -0400
Received: by mail-oa0-f44.google.com with SMTP id n12so6712430oag.31
        for <git@vger.kernel.org>; Sun, 19 May 2013 01:32:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:date:from:to:cc:message-id:in-reply-to:references
         :subject:mime-version:content-type:content-transfer-encoding;
        bh=10SlM7lGCD0eQpyBrKw2sel/vLeck17MKBWP8WPpzOg=;
        b=qgGWmwSe0ldFPAw6QlkykSGbJYdUBXUP/GIduCurnXfzN/Bysykh/YPQGGYsM/FWCI
         aJheVwPkuF3NSnp46Bh7x131Qhp/iLsDrLwwXjv/B7FdIcZ1B7Kqes6M8wB67qlT9tcx
         a8vzOjAWj9TvTuWx7E/6ENeQa5MX1sB2mCaztiJDX8li8ZbMo9/1wzxt8lp7plwtUNqM
         kMaDdrwinIEDWwXKxKAPpAYggCkx+ISziVjySkZEPdgHEXFQOHnmP7DnqAPhaRSxxwxy
         bChrhjbOTKi1lhF4tahCOgZdu6Ts4kSwx0BqixPN8/6GXIxgMWRlRjqtcuoG8x64bD3d
         xSHw==
X-Received: by 10.60.84.2 with SMTP id u2mr4540869oey.24.1368952321604;
        Sun, 19 May 2013 01:32:01 -0700 (PDT)
Received: from localhost (187-163-100-70.static.axtel.net. [187.163.100.70])
        by mx.google.com with ESMTPSA id eq4sm15166733obb.5.2013.05.19.01.31.59
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Sun, 19 May 2013 01:32:00 -0700 (PDT)
In-Reply-To: <7vli7bza98.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/224832>

Junio C Hamano wrote:
> Felipe Contreras <felipe.contreras@gmail.com> writes:
> 
> > On Sat, May 18, 2013 at 6:46 AM, Felipe Contreras
> > <felipe.contreras@gmail.com> wrote:
> >
> >>  contrib/related/git-related | 124 ++++++++++++++++++++++++++++++++++++++++++++
> >>  1 file changed, 124 insertions(+)
> >>  create mode 100755 contrib/related/git-related
> >
> > I tried everything and I don't think it's physically possible to make
> > this script any simpler without severely crippling it's main goal.
> 
> Hmm, I haven't read these patches yet (I just came back a few hours
> ago to a state in which I am well enough to read and write e-mails),
> but did anybody complain that it is too complex?

This comment was again targetted to Ramkumar, who yes, indeed he complained
about it being too complex, at least v3.

-- 
Felipe Contreras

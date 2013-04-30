From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH] Add new @ shortcut for HEAD
Date: Tue, 30 Apr 2013 17:16:39 +0700
Message-ID: <CACsJy8C34vN7SB62-+Z3BNZeroTB_vm-n-NMhFRbAuBPQZFKcA@mail.gmail.com>
References: <1367264106-2351-1-git-send-email-felipe.contreras@gmail.com>
 <CACsJy8D_gPpprETkAxf+eYp5DMt7uVt6nanCwthZO=vVfBT28Q@mail.gmail.com>
 <517F6E40.1040606@alum.mit.edu> <CALkWK0naGx6Vrb3_iZbXefQqmwOhaTSRXxBT6K-cheiUwr3Ptw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Michael Haggerty <mhagger@alum.mit.edu>,
	Felipe Contreras <felipe.contreras@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	Jon Seymour <jon.seymour@gmail.com>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Tue Apr 30 12:17:18 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UX7ca-0000He-GP
	for gcvg-git-2@plane.gmane.org; Tue, 30 Apr 2013 12:17:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759939Ab3D3KRM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 30 Apr 2013 06:17:12 -0400
Received: from mail-ob0-f170.google.com ([209.85.214.170]:56044 "EHLO
	mail-ob0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753176Ab3D3KRL (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Apr 2013 06:17:11 -0400
Received: by mail-ob0-f170.google.com with SMTP id eh20so290212obb.1
        for <git@vger.kernel.org>; Tue, 30 Apr 2013 03:17:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=p0z/HT8/vFhJ0scM5eK5wCLd5GZdn3sLLLyKntk7lZg=;
        b=hoaAcd+tTBavIVRWMGpTuBRapdgF/hUyILv6GeOp/jCwtIW9ZmYPsT3JIM4wwDCdCp
         TZFdOscDtiTGpZSm3aWNkJQmbFm98cpPBCJCZE2oKJtSyUqIyXlXXSslULSVhoHG7CRM
         Ax45OQEWu9ky+qVZ9gaj9537yoJE0v3VD+Xks0+FUVVdfmaoNi9DZbuahNshhjac5UJG
         5oHrtbZzEuvnsVSL8WrrEr6dt7yEIEfrJ1B3V9PKSiiEqQQSnwZ2hH/gO2pG141MdS81
         jBjfYWCy9cipG8rGgi0ccTzuoFokKeEPTGSkyWmJ7blDk+IDWM/+G2rvAk9C2mhX6ywB
         H0Ew==
X-Received: by 10.60.50.70 with SMTP id a6mr26566125oeo.43.1367317031162; Tue,
 30 Apr 2013 03:17:11 -0700 (PDT)
Received: by 10.76.180.138 with HTTP; Tue, 30 Apr 2013 03:16:39 -0700 (PDT)
In-Reply-To: <CALkWK0naGx6Vrb3_iZbXefQqmwOhaTSRXxBT6K-cheiUwr3Ptw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222923>

On Tue, Apr 30, 2013 at 2:35 PM, Ramkumar Ramachandra
<artagnon@gmail.com> wrote:
> Michael Haggerty wrote:
>>     git symbolic-ref -m "Create @ alias for HEAD" @ HEAD
>
> I find this very interesting.  I already have a symbolic ref H
> pointing to HEAD, but it has some quirks: H@{u} complains that H is an
> invalid branch for example.  When I create the symbolic-ref @, I'm not
> _exactly_ creating a synonym for HEAD: @{u} works, not @@{u}.

Habits aside, why do you do H@{u} when @{u} is enough (and shorter)?
--
Duy

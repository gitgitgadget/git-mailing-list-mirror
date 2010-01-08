From: Karl Wiberg <kha@treskal.com>
Subject: Re: [StGit PATCH 1/3] Populate the cached config options with the 
	defaults
Date: Fri, 8 Jan 2010 15:30:48 +0100
Message-ID: <b8197bcb1001080630i6daad79anf8323f8001d38db3@mail.gmail.com>
References: <20100108123403.24161.3495.stgit@pc1117.cambridge.arm.com>
	 <20100108123559.24161.14842.stgit@pc1117.cambridge.arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Catalin Marinas <catalin.marinas@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jan 08 15:30:56 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NTFrb-0006wm-LG
	for gcvg-git-2@lo.gmane.org; Fri, 08 Jan 2010 15:30:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752896Ab0AHOav convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 8 Jan 2010 09:30:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752712Ab0AHOav
	(ORCPT <rfc822;git-outgoing>); Fri, 8 Jan 2010 09:30:51 -0500
Received: from mail1.space2u.com ([62.20.1.135]:61931 "EHLO mail1.space2u.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752132Ab0AHOau convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 8 Jan 2010 09:30:50 -0500
Received: from mail-fx0-f225.google.com (mail-fx0-f225.google.com [209.85.220.225])
	(authenticated bits=0)
	by mail1.space2u.com (8.14.3/8.14.3) with ESMTP id o08EUZJr003386
	(version=TLSv1/SSLv3 cipher=DES-CBC3-SHA bits=168 verify=NOT)
	for <git@vger.kernel.org>; Fri, 8 Jan 2010 15:30:35 +0100
Received: by fxm25 with SMTP id 25so12670500fxm.21
        for <git@vger.kernel.org>; Fri, 08 Jan 2010 06:30:48 -0800 (PST)
Received: by 10.103.84.15 with SMTP id m15mr3452446mul.43.1262961048217; Fri, 
	08 Jan 2010 06:30:48 -0800 (PST)
In-Reply-To: <20100108123559.24161.14842.stgit@pc1117.cambridge.arm.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/136441>

Hmm. What's the point of this rewrite?

On Fri, Jan 8, 2010 at 1:35 PM, Catalin Marinas <catalin.marinas@arm.co=
m> wrote:

> + =C2=A0 =C2=A0 =C2=A0 =C2=A0try:
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return self.__cache[name][=
-1]
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0except KeyError:
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return None

You could write this as

  return self.__cache.get(name, [None])[-1]

--=20
Karl Wiberg, kha@treskal.com
   subrabbit.wordpress.com
   www.treskal.com/kalle

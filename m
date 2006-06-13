From: Timo Hirvonen <tihirvon@gmail.com>
Subject: Re: [PATCH 0/8] Make a couple of commands builtin
Date: Wed, 14 Jun 2006 00:54:37 +0300
Message-ID: <20060614005437.69ff6a62.tihirvon@gmail.com>
References: <448F1E41.1040607@etek.chalmers.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: junkio@cox.net, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jun 13 23:54:46 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FqGqH-0007Zb-8f
	for gcvg-git@gmane.org; Tue, 13 Jun 2006 23:54:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932350AbWFMVya convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Tue, 13 Jun 2006 17:54:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932355AbWFMVya
	(ORCPT <rfc822;git-outgoing>); Tue, 13 Jun 2006 17:54:30 -0400
Received: from nf-out-0910.google.com ([64.233.182.187]:129 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S932350AbWFMVy3 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 13 Jun 2006 17:54:29 -0400
Received: by nf-out-0910.google.com with SMTP id x37so1109707nfc
        for <git@vger.kernel.org>; Tue, 13 Jun 2006 14:54:25 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:in-reply-to:references:x-mailer:mime-version:content-type:content-transfer-encoding;
        b=IfHexSHJvCT0FcsQv/jEm/HqYku+d2ad7LfoD0fmy8LwALcX3fJfPComwtkpO+c4aB7iZzNdaO71U9d7RBV1BoCNYN/pGzQCOqnqRAf4/SzzJ9JBAjrqdK08l2bj5L3GnYHG9hUj2kxZXVadhyZ/diXLMXXeAAsDTUTPpoi9/hE=
Received: by 10.48.238.3 with SMTP id l3mr6189160nfh;
        Tue, 13 Jun 2006 14:54:23 -0700 (PDT)
Received: from garlic.home.net ( [82.128.201.71])
        by mx.gmail.com with ESMTP id z73sm7780753nfb.2006.06.13.14.54.22;
        Tue, 13 Jun 2006 14:54:23 -0700 (PDT)
To: lukass@etek.chalmers.se
In-Reply-To: <448F1E41.1040607@etek.chalmers.se>
X-Mailer: Sylpheed version 2.2.6 (GTK+ 2.8.18; i686-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/21815>

Lukas Sandstr=F6m <lukass@etek.chalmers.se> wrote:

> This patchseries has the ultimate goal of making
> git-am a builtin.
>=20
> The version of git-am I'm sending out makes quite heavy
> use of system(), but I think that can be worked around.
> I just haven't figured out how, yet.

I don't think git-stripspace needs to be a built-in.  It doesn't even
depend on git.  It is just a tiny helper program used by git-am,
git-applymbox, git-commit and git-tag.  If all these commands are made
built-in then git-stripspace becomes useless.

--=20
http://onion.dynserv.net/~timo/

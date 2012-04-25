From: Steven Penny <svnpenn@gmail.com>
Subject: Re: Build without BUILT_INS
Date: Tue, 24 Apr 2012 22:11:09 -0500
Message-ID: <CAAXzdLXa_s4yDzV4HJk3dV1hYU1cekMXqcvEvoPcDrTm0tAyXQ@mail.gmail.com>
References: <CAAXzdLVbqp-_9A+BwcOuiHi3A39gAJb7_NqANfhAfuK9-+iZ0g@mail.gmail.com>
	<xmqqmx61hmtu.fsf@junio.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Apr 25 05:11:17 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SMsdQ-0003SK-L5
	for gcvg-git-2@plane.gmane.org; Wed, 25 Apr 2012 05:11:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758454Ab2DYDLK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Apr 2012 23:11:10 -0400
Received: from mail-iy0-f174.google.com ([209.85.210.174]:41423 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757390Ab2DYDLJ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Apr 2012 23:11:09 -0400
Received: by iadi9 with SMTP id i9so1864491iad.19
        for <git@vger.kernel.org>; Tue, 24 Apr 2012 20:11:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=3vof2a0uEB0MAcUG3Ngh3aJA2HW7hg1Wq/9Qfot9hRQ=;
        b=HLuVPu+Pzm/k5guvgOJOSEfZ9fGkqfjuRWS+R/Y136cSlpYEUzr9hmvVoiYOvygx+K
         9GP0hvDKPUje/1ZVj+vZFzZkdB9sZguS3yrNBFxWsCG4geanREwDrVMeezRWrMoD1DfJ
         cCHt9EvFzfWI568oJg3dscLZ7LVXeo7POgAdBaJPuPUygckTd+dzqx0mgU/TYuPJ7QMx
         hya/evZp2yYR26MfoHsFxsIoxVPk52skmZQiTrdEVo6QPvpQ4ovqE+KZ4xphjV/LBgep
         CXRNBahIAe9Y9EYUAVtZy5pe3R63uRlLRmbhupxtdATAQbuK2C+jAlBOXeC/wI6uJ12i
         B7ig==
Received: by 10.50.45.234 with SMTP id q10mr582920igm.54.1335323469077; Tue,
 24 Apr 2012 20:11:09 -0700 (PDT)
Received: by 10.231.80.147 with HTTP; Tue, 24 Apr 2012 20:11:09 -0700 (PDT)
In-Reply-To: <xmqqmx61hmtu.fsf@junio.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/196298>

Junio C Hamano wrote:
> And no, it will *not* be a compilation option, as the resulting
> installation will break the age-old promise we made to script writers.

A compilation option, does not break any promise to script writers.

The default build still has hard links.

A compilation option, such as "make NO_BUILTINS=1" would merely give
users the choice to build without the hard links; an option they do
_not_ have currently.

Seeing how there already is

NO_GETTEXT
NO_OPENSSL
NO_TCLTK

and so on, I dont see this as being a big issue to add.

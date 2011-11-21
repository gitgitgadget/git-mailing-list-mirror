From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH] spec: add missing build dependency
Date: Mon, 21 Nov 2011 17:43:29 +0200
Message-ID: <CAMP44s0qU2kaq74yRe7OJbSHONDLs=GOFgNgKhNwXXjU1-6L3A@mail.gmail.com>
References: <1321889726-29620-1-git-send-email-felipe.contreras@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Felipe Contreras <felipe.contreras@nokia.com>
X-From: git-owner@vger.kernel.org Mon Nov 21 16:43:39 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RSW1y-0003KN-4G
	for gcvg-git-2@lo.gmane.org; Mon, 21 Nov 2011 16:43:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752028Ab1KUPna (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Nov 2011 10:43:30 -0500
Received: from mail-pz0-f42.google.com ([209.85.210.42]:59857 "EHLO
	mail-pz0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750965Ab1KUPna (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Nov 2011 10:43:30 -0500
Received: by pzk36 with SMTP id 36so14204669pzk.1
        for <git@vger.kernel.org>; Mon, 21 Nov 2011 07:43:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=+GfO0g02TgDysGoCvQu56xR25eMy59wtY6sH7ffiKgI=;
        b=RCdaoTraoxLqOMJ7Fgh6AbUbuKOw1iL1Jt1L1x9JweVSTRA3QSV1D1SNpcfNxoexGJ
         irwvn1gw9hqAwAKZzKbTKZ3FpDY0AC7W7sewJPhY7oAZo/g+pLU/QqxKVQdN5JuWJoJl
         lLFbptC0Aabbq4HWjv2mS31dR09Jq+omb6hSw=
Received: by 10.68.0.193 with SMTP id 1mr36861931pbg.110.1321890209835; Mon,
 21 Nov 2011 07:43:29 -0800 (PST)
Received: by 10.68.58.38 with HTTP; Mon, 21 Nov 2011 07:43:29 -0800 (PST)
In-Reply-To: <1321889726-29620-1-git-send-email-felipe.contreras@nokia.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/185748>

On Mon, Nov 21, 2011 at 5:35 PM, Felipe Contreras
<felipe.contreras@nokia.com> wrote:
> From: Felipe Contreras <felipe.contreras@gmail.com>
>
> Otherwise:
>
> /usr/bin/perl Makefile.PL PREFIX='/opt/git' INSTALL_BASE=''
> Can't locate ExtUtils/MakeMaker.pm in @INC (@INC contains: /usr/local/lib/perl5 /usr/local/share/perl5 /usr/lib/perl5/vendor_perl /usr/share/perl5/vendor_perl /usr/lib/perl5 /usr/share/perl5 .) at Makefile.PL line 1.
> BEGIN failed--compilation aborted at Makefile.PL line 1.
> make[1]: *** [perl.mak] Error 2
> make: *** [perl/perl.mak] Error 2

Just to clarify... I didn't actually build the RPM, just doing 'make
install' after getting the dependencies from the spec. So I'm not sure
if this is really needed.

-- 
Felipe Contreras

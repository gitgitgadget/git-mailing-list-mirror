From: Chris Rorvick <chris@rorvick.com>
Subject: Re: What's cooking in git.git (Jan 2013, #08; Tue, 22)
Date: Thu, 24 Jan 2013 22:55:57 -0600
Message-ID: <CAEUsAPagzN9wWAsSpBVOv7+ei3fAix407dB0EAUd7q7k7SugPw@mail.gmail.com>
References: <7va9s0n8gv.fsf@alter.siamese.dyndns.org>
	<20130122234554.GI7498@serenity.lan>
	<7vobgglpv4.fsf@alter.siamese.dyndns.org>
	<20130123092858.GJ7498@serenity.lan>
	<7vsj5rhlfs.fsf@alter.siamese.dyndns.org>
	<20130123211237.GR7498@serenity.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	"Eric S. Raymond" <esr@thyrsus.com>
To: John Keeping <john@keeping.me.uk>
X-From: git-owner@vger.kernel.org Fri Jan 25 05:56:25 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TybKw-0001Du-Iv
	for gcvg-git-2@plane.gmane.org; Fri, 25 Jan 2013 05:56:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755304Ab3AYE4A (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 Jan 2013 23:56:00 -0500
Received: from mail-lb0-f178.google.com ([209.85.217.178]:46439 "EHLO
	mail-lb0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753775Ab3AYEz7 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Jan 2013 23:55:59 -0500
Received: by mail-lb0-f178.google.com with SMTP id n1so54717lba.9
        for <git@vger.kernel.org>; Thu, 24 Jan 2013 20:55:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type;
        bh=Y3QHB/DPm+u9859Nz/YY/xv5JuaoWVRIAJpP8WQKqmc=;
        b=pP9YICVlgla7YIh+QQon757JZ3zJPr3FVvnWKlVS42g1C+GDDB8ygXgYbxtWhYA8yT
         EJRenexUhlV7CQ2Ds6aUHSHw4r+q2gcuzesl6hvqQlGfkutcYDYidd2Zr3h8vX31nKL3
         OZj7EhLRytFmo5ltrCH3jTZ5y6inb2/qnYmeFjms0iR+Vxwj08qZ1KD9XUMtRBPitkdl
         deVsfO5sLqvo3qk6ITxrseSPLyKsLNoS8nCO+s3sEpCn1haZklWSC0eeg7/LT+WJigjr
         r2Nl/VKvaOGLekra9+NAXF4rKYbesq/y0/FtAPawqvZPnsuDHRCtVXpEVzGqjiB3Ys7w
         qWNw==
X-Received: by 10.152.110.129 with SMTP id ia1mr3948690lab.56.1359089757872;
 Thu, 24 Jan 2013 20:55:57 -0800 (PST)
Received: by 10.114.2.97 with HTTP; Thu, 24 Jan 2013 20:55:57 -0800 (PST)
In-Reply-To: <20130123211237.GR7498@serenity.lan>
X-Google-Sender-Auth: GnsCWTmYh-xfZ7qIYAyTLfVEMJY
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/214495>

On Wed, Jan 23, 2013 at 3:12 PM, John Keeping <john@keeping.me.uk> wrote:
> The existing script (git-cvsimport.perl) won't ever work with cvsps-3
> since features it relies on have been removed.

Not reporting the ancestry branch seems to be the big one.  Are there
others?  I had a version of the Perl script sort of working, but only
well enough to pass the t9600 and t9604 tests.

Chris

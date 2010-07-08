From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: Why is "git tag --contains" so slow?
Date: Thu, 8 Jul 2010 16:30:57 -0500
Message-ID: <AANLkTik3Cp8W5wrWhL7DW736QPt7-2V-E8EAWJB5JYd1@mail.gmail.com>
References: <20100701121711.GF1333@thunk.org> <AANLkTikVNkObOxGQhDJ5Qau-vYn2YcomHQW2p2zsMof9@mail.gmail.com> 
	<alpine.LFD.2.00.1007081559300.6020@xanadu.home> <201007082320.05017.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jakub Narebski <jnareb@gmail.com>,
	Avery Pennarun <apenwarr@gmail.com>,
	Theodore Tso <tytso@mit.edu>, Jeff King <peff@peff.net>,
	Will Palmer <wmpalmer@gmail.com>, git@vger.kernel.org
To: Nicolas Pitre <nico@fluxnic.net>
X-From: git-owner@vger.kernel.org Thu Jul 08 23:31:25 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OWygm-00086y-KE
	for gcvg-git-2@lo.gmane.org; Thu, 08 Jul 2010 23:31:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757078Ab0GHVbT convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 8 Jul 2010 17:31:19 -0400
Received: from mail-gx0-f174.google.com ([209.85.161.174]:40976 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753238Ab0GHVbS convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 8 Jul 2010 17:31:18 -0400
Received: by gxk23 with SMTP id 23so765173gxk.19
        for <git@vger.kernel.org>; Thu, 08 Jul 2010 14:31:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=H1cjnYq4TbT6+8+WNPrk24TLrLTnh4Y1Wk09WYXyChY=;
        b=uJz926LP7sZrVWM6mpLL5xb5+tiS6tyygwXqH+MVqk4EqHxyYPHrS2+Sj14+TZAIJG
         p7Tw/FxxVFLlfOBC1j52eIFnd2xt3xxnKbhNv6EjPNIvsdzvbO7JxgnT3U5rkocqy3jl
         nrI9DIJ7uAfcgKysMek3NNfLjWQaI2SbLnHwU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=AFvbG3Z2HRXIOti+gWTy+nOTY2J/hNoRYTWd4yl15OKXnXYbPnjcXNmJM5OElQ9Yhe
         OQaKgHVwByvFjlsE+m2wULk9OJADYruwBkBDkJJN2rXJ015NzzvjvnQKDAxNmpoNL/2B
         DOw3scfyP/lb/jbZ83UXEau5pQ0OL51HbHTCQ=
Received: by 10.150.215.17 with SMTP id n17mr1061009ybg.4.1278624677223; Thu, 
	08 Jul 2010 14:31:17 -0700 (PDT)
Received: by 10.150.184.8 with HTTP; Thu, 8 Jul 2010 14:30:57 -0700 (PDT)
In-Reply-To: <201007082320.05017.jnareb@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/150614>

Heya,

2010/7/8 Jakub Narebski <jnareb@gmail.com>:
> By the way, rev-cache project was started mainly to make "counting
> objects" part of clone / fetch faster. =C2=A0Would pack v4 offer the =
same
> without rev-cache?

Speaking of pack v4 features...

I remember from GitTogether08 that one hope was that the metadata
would be in a different file, such that it could be retrieved
separately (allowing shallow clones to create and push new commits).
Is this not something that is part of the design goals for packv4?

--=20
Cheers,

Sverre Rabbelier

From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH] Add new @ shortcut for HEAD
Date: Tue, 30 Apr 2013 23:07:51 +0530
Message-ID: <CALkWK0=d-posGyemoBoWg+uxC-x3cwy8o8AQq2JYpq5r1sm2bg@mail.gmail.com>
References: <1367264106-2351-1-git-send-email-felipe.contreras@gmail.com>
 <CACsJy8D_gPpprETkAxf+eYp5DMt7uVt6nanCwthZO=vVfBT28Q@mail.gmail.com> <7vppxcdjd1.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Duy Nguyen <pclouds@gmail.com>,
	Felipe Contreras <felipe.contreras@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	Jon Seymour <jon.seymour@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Apr 30 19:38:39 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UXEVh-0000NC-OR
	for gcvg-git-2@plane.gmane.org; Tue, 30 Apr 2013 19:38:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760805Ab3D3Rid (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 30 Apr 2013 13:38:33 -0400
Received: from mail-ie0-f174.google.com ([209.85.223.174]:49273 "EHLO
	mail-ie0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759921Ab3D3Rib (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Apr 2013 13:38:31 -0400
Received: by mail-ie0-f174.google.com with SMTP id 10so948032ied.19
        for <git@vger.kernel.org>; Tue, 30 Apr 2013 10:38:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=bYkVrg3U2XiC0OgYLIBfVSFmk0+xg8uaIyyVwEkLqw4=;
        b=G4XHappADF3z1oKU6JVzWTDorYVDZWjUUT7g3Bnplq7miu32XaCIXnedg9yJs+1UB/
         9rYFd1WXT5x8W48ZoC8o2ibK/sB+zIEVSARD6p0Fwz4A02J6t6FQy7NE9xK0D/bNTFA0
         DAnBHwAGbjeJtkXwu7OQqthjnThMFiwSDDGPYXG3N5ww2nQ/KlhVrJq4BnnoPhrxWFF5
         ceSqN/y7J3GbCGwFj4hKlgDRtxKvOAQ1lmyc2z1Y4c/jvt0IBJzumsGmTJivBygVVUVE
         7cvLYsk8gM/AdvuHh+8maBCw99B3p/9suwU0ff8VmVtYzDS6LyDNbECs2d6N3l8cquJF
         ywlQ==
X-Received: by 10.50.3.38 with SMTP id 6mr4484292igz.44.1367343511438; Tue, 30
 Apr 2013 10:38:31 -0700 (PDT)
Received: by 10.64.46.1 with HTTP; Tue, 30 Apr 2013 10:37:51 -0700 (PDT)
In-Reply-To: <7vppxcdjd1.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222965>

Junio C Hamano wrote:
> If you accept only "@" but not "master@", that behaviour needs a
> wrong world model to understand and justify (one of which is "@ is a
> synonym for HEAD").  If your rule is "In $anything@{$n}, you can
> drop {$n} when $n==0", then HEAD@{0} becomes HEAD@ and master@{0}
> becomes master@, and @{0} becomes @ naturally.

You're telling me how to get @ from @{0}, but not how to get @ from
HEAD.  @{0}@{4} is meaningless, but HEAD@{4} is meaningful.

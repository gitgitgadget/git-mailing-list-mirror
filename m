From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH] Add new @ shortcut for HEAD
Date: Wed, 1 May 2013 00:15:44 +0530
Message-ID: <CALkWK0m6VeHxwi4ytSFrib2r5GS1acph+WA+YXD80KuBhr74+g@mail.gmail.com>
References: <1367264106-2351-1-git-send-email-felipe.contreras@gmail.com>
 <CACsJy8D_gPpprETkAxf+eYp5DMt7uVt6nanCwthZO=vVfBT28Q@mail.gmail.com>
 <7vppxcdjd1.fsf@alter.siamese.dyndns.org> <CALkWK0=GbhALxX0G-ka5oAbixoJv4uKPHAx5LPezgTyGxW_3MQ@mail.gmail.com>
 <CAMP44s28aQ7aDCBk=TwPJsb4xoyQMfx85DhaNB4P+XzbgctoPw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>, Duy Nguyen <pclouds@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	Jon Seymour <jon.seymour@gmail.com>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Tue Apr 30 20:46:39 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UXFZU-0001Rw-SF
	for gcvg-git-2@plane.gmane.org; Tue, 30 Apr 2013 20:46:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932839Ab3D3Sq0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 30 Apr 2013 14:46:26 -0400
Received: from mail-ie0-f170.google.com ([209.85.223.170]:57624 "EHLO
	mail-ie0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760856Ab3D3SqZ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Apr 2013 14:46:25 -0400
Received: by mail-ie0-f170.google.com with SMTP id at1so1066722iec.1
        for <git@vger.kernel.org>; Tue, 30 Apr 2013 11:46:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=tbEvy5bE3iF39A+Freo3GxZVitxDom/ALGV+d81TqGc=;
        b=dJWiLoSKALEqT3b7lO57HO4QkKEIHZHL26MatajytxJkIwfwr1DXYeWQ6OZL8Dvohp
         sXkMfTBYUEQkkhwqcG+n7mvJWgwzmtfqmVgPSsSm7f6wpqxxnwSAo4KeKcLZQ/i3y1J8
         gu5xXJyzTMzvvdVggYYt5MhqOgSlsQv+hK0haHSPcVu8kOF12ly498aPHoCWsURM532p
         1EUm7zrpg0aKxW8/bS5Ohmr5SfJX5RFi6JqBq0Jza7sh4wnZo9J0H6iHlATVuh4fG3eF
         ju7F4GR62JaIMdcnH6fVEzdt99bZSH9Kdn16Y4nCYmQvomNEstv+16uQQZ3L2iiL4F/Z
         2mQA==
X-Received: by 10.42.27.146 with SMTP id j18mr21208072icc.54.1367347584494;
 Tue, 30 Apr 2013 11:46:24 -0700 (PDT)
Received: by 10.64.46.1 with HTTP; Tue, 30 Apr 2013 11:45:44 -0700 (PDT)
In-Reply-To: <CAMP44s28aQ7aDCBk=TwPJsb4xoyQMfx85DhaNB4P+XzbgctoPw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222987>

Felipe Contreras wrote:
> It's not. The same way master^0^0~4 is not useful, yet it's works;
> it's a logical result from the syntax.

It's logical if you explain @ as a shortcut for @{0}, and make
@{0}@{1} resolve somehow [*1*].

[Footnotes]

*1*: The best I can do is @{0} is like a ref (while @{>0} are
revisions), but you can't update-ref or symbolic-ref it.  Kludgy,
don't you think?

From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: [RFC PATCH 06/13] transport-helper: update ref status after push
 with export
Date: Sun, 29 Aug 2010 19:29:15 -0500
Message-ID: <AANLkTimX4am2VZBRuYjOui9+-_ouGO1s1ck8V+-ajB3E@mail.gmail.com>
References: <1283053540-27042-1-git-send-email-srabbelier@gmail.com>
 <1283053540-27042-7-git-send-email-srabbelier@gmail.com> <20100829222554.GJ1890@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Ramkumar Ramachandra <artagnon@gmail.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Mon Aug 30 02:29:41 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OpsFp-000432-0x
	for gcvg-git-2@lo.gmane.org; Mon, 30 Aug 2010 02:29:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753590Ab0H3A3g (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 29 Aug 2010 20:29:36 -0400
Received: from mail-gy0-f174.google.com ([209.85.160.174]:39340 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753357Ab0H3A3f (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 29 Aug 2010 20:29:35 -0400
Received: by gyd8 with SMTP id 8so1796296gyd.19
        for <git@vger.kernel.org>; Sun, 29 Aug 2010 17:29:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:cc:content-type;
        bh=bhLoULhbSAwdgfoZJndnjD7bJPiYXZBojN7415B6wzE=;
        b=aRZpkuv77bw9iK3kIUaAIYGhROw/fvzAQ87pJCEvZpijHaTAHFUQXmLqpn1JGsNWff
         B7njjuvjImWrTcNIz0QO1Qei4wkRn5BR13PVtbcw/W4pX9E0ssK9OSN1l/k9YyyJ+Bg7
         pWngLy4RQGzsQ4ZqPc7f6lF6sXp5gVnap7xwA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=UpVGkS9ibLtPXSOkJq+NxkyjqS7l5xuJFh9vOsO8E2NIPbjJjhxHN1zaoFCCQhfQp5
         ApsQzTJ9mvWc0Z/Ei7X3hXqVEbImQ746Dlf+7KXLSf+yIalo/Y7ooQNjWoCQO4nkQ2Fv
         d/a477oynS328HNvBOiAoMwjsLda9u/xcg+Ng=
Received: by 10.150.49.8 with SMTP id w8mr931576ybw.363.1283128175183; Sun, 29
 Aug 2010 17:29:35 -0700 (PDT)
Received: by 10.151.49.17 with HTTP; Sun, 29 Aug 2010 17:29:15 -0700 (PDT)
In-Reply-To: <20100829222554.GJ1890@burratino>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/154735>

Heya,

On Sun, Aug 29, 2010 at 17:25, Jonathan Nieder <jrnieder@gmail.com> wrote:
> So I guess testgit should be getting this information from the
> result of non_local.push().

Yes, or for example if a ref is a non-fast-forward, it should probably
detect that before even exporting it :).

-- 
Cheers,

Sverre Rabbelier

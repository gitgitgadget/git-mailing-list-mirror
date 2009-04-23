From: Deskin Miller <deskinm@gmail.com>
Subject: Re: svn cp (local paths) equivalent
Date: Wed, 22 Apr 2009 23:09:58 -0700
Message-ID: <86d4c5e00904222309i2727615aw3db4c0993cae6c77@mail.gmail.com>
References: <CDE4E2DB-9017-4BDD-869C-E470FFDA9CAC@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Lachlan Deck <lachlan.deck@gmail.com>
X-From: git-owner@vger.kernel.org Thu Apr 23 08:11:56 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lws9z-0003bs-MT
	for gcvg-git-2@gmane.org; Thu, 23 Apr 2009 08:11:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755242AbZDWGKB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 23 Apr 2009 02:10:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755146AbZDWGKA
	(ORCPT <rfc822;git-outgoing>); Thu, 23 Apr 2009 02:10:00 -0400
Received: from mail-gx0-f166.google.com ([209.85.217.166]:63085 "EHLO
	mail-gx0-f166.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754430AbZDWGJ7 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 23 Apr 2009 02:09:59 -0400
Received: by gxk10 with SMTP id 10so864655gxk.13
        for <git@vger.kernel.org>; Wed, 22 Apr 2009 23:09:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=KNy0lrAT9aFYPM9WPJZyUl9A43R3AsIIouHSWNI5XzI=;
        b=KVZH75qvTt+t+Krj0fVgbYnj/i70S/KHHUAuwK/UClidlVcs/Cz6Rnw/lhFCgVHwnN
         LsACDKK1M7hPT+Wfa5wQG0Jd8/AaE+m8KBsuJxvOHybGIHZ0PRqGu2+QlexoFSZkluOH
         7TI/9O5MPhES6q6fk2SvSQ+2kp+VVlBdnEai0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=VZidv6OJLk6+q3k2PYldaaEMB+oIMLvUTQsdCcKcNxJZy7LE6u8TKeylA+qNiaDCRK
         IZuoTZc7RIoliVhQ8/QYpcMX8a0CJHNVGtONcXGmaIobaC9VNImVI2FeSeAeJ2diMV94
         Hqt154d1g1PzF5OCnj4g/byBLsQ99wQUI8w7s=
Received: by 10.151.125.10 with SMTP id c10mr65219ybn.138.1240466998477; Wed, 
	22 Apr 2009 23:09:58 -0700 (PDT)
In-Reply-To: <CDE4E2DB-9017-4BDD-869C-E470FFDA9CAC@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/117301>

On Wed, Apr 22, 2009 at 23:03, Lachlan Deck <lachlan.deck@gmail.com> wrote:
> Hi there,
>
> just a quick question: in svn you can cp a file or dir within your checkout.
> Is there an equivalent in git?

$ cp file file-copy
$ git add file-copy

It works with directories too.

Deskin Miller

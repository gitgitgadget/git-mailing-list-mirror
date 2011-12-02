From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: git auto-repack is broken...
Date: Fri, 2 Dec 2011 17:27:24 +0100
Message-ID: <CACBZZX7Q5qb1r_Oh0QfMiWh9UAM1c6QWBn4abv-xHpFBaKuyKg@mail.gmail.com>
References: <CA+55aFznj49hx6Ce6NhJ1rRd2nvNyOERseyyrC6SNcW-z9dyfg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Fri Dec 02 17:27:54 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RWVxn-0001wU-Un
	for gcvg-git-2@lo.gmane.org; Fri, 02 Dec 2011 17:27:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757015Ab1LBQ1r (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 2 Dec 2011 11:27:47 -0500
Received: from mail-bw0-f46.google.com ([209.85.214.46]:46157 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756990Ab1LBQ1q (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 Dec 2011 11:27:46 -0500
Received: by bkas6 with SMTP id s6so4041213bka.19
        for <git@vger.kernel.org>; Fri, 02 Dec 2011 08:27:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=AVvyYADLcv+/7Ljpw8fQ0LF6AFroltaGcRobEixxNoo=;
        b=g7mJCxOnNM95/rL5v1VDj9bADicyVHdHTu23n6WOlVwchJ9pqVSG+6D9Xk7AqrjfGp
         Am2UjLI38i/7FGwGvzK+xdLOUs4ZJSWRS8mbpivN7xRuOiwofWbY5gctTSZ0l/4j7GCh
         8yfMCV+M1W4PzyDozqGoqhPwN1c9jOi3GwvWA=
Received: by 10.205.139.2 with SMTP id iu2mr10979653bkc.128.1322843265187;
 Fri, 02 Dec 2011 08:27:45 -0800 (PST)
Received: by 10.204.69.71 with HTTP; Fri, 2 Dec 2011 08:27:24 -0800 (PST)
In-Reply-To: <CA+55aFznj49hx6Ce6NhJ1rRd2nvNyOERseyyrC6SNcW-z9dyfg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/186227>

On Fri, Dec 2, 2011 at 17:22, Linus Torvalds
<torvalds@linux-foundation.org> wrote:

> Maybe we should make "git gc --auto" remove any unreachable objects?

Wouldn't that mean that any loose commit objects you have lying around
would be removed by the automatic git gc?

One feature of git that I personally rely on is that I can liberally
move heads around / make commits on detached heads and not have those
commits gc'd unless I explicitly ask for it for a while.

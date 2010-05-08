From: Clemens Buchacher <drizzd@aon.at>
Subject: Re: What's cooking in git.git (May 2010, #01; Sun, 2)
Date: Sat, 8 May 2010 18:43:19 +0200
Message-ID: <20100508164319.GA19037@localhost>
References: <7v7hnmuvtv.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat May 08 18:43:38 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OAn7l-00041S-8M
	for gcvg-git-2@lo.gmane.org; Sat, 08 May 2010 18:43:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754029Ab0EHQn2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 8 May 2010 12:43:28 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:39378 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753435Ab0EHQn1 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 8 May 2010 12:43:27 -0400
Received: by fxm10 with SMTP id 10so1417021fxm.19
        for <git@vger.kernel.org>; Sat, 08 May 2010 09:43:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:received:received:sender:received:date:from:to
         :cc:subject:message-id:references:mime-version:content-type
         :content-disposition:in-reply-to:user-agent;
        bh=PUfhgpEhZADYY7U3EknYyVqWHl2Ho5hWZ2OP+uv310k=;
        b=hrJGuA+UEfcuB3LjcxMgosyS28eU6mKLBB6n+qqJ/gNe86oQMWUrTevs/EF5c4ObVG
         7ZzGfFa+ZEdOsIzf3BSF4/AuideUMpmPob48A6qaphs4P4AJBwB2t8Ao0ggqs+bn6a+S
         CL+XnSuxSdVy7YYVkh53nPH+NqD8u5+9FMVgg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=sender:date:from:to:cc:bcc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        b=rj7EdgWP+c2PhNZgIexyOgAwutg8OJ1zEXfnMkSX6XAIUfl4UYgacLqaXxNHQMPW9v
         y/tTfL7bKV+ALCv7aN1CsSeL8UEhQhOxQbS5vVyts08bTtpLVV7hnco/vElU1njQKLyX
         JVEONZ2skExrK7m02+ZrrACiTeGJubqWas3bQ=
Received: by 10.223.53.91 with SMTP id l27mr1823355fag.0.1273337005582;
        Sat, 08 May 2010 09:43:25 -0700 (PDT)
Received: from darc.lan (p549A5C59.dip.t-dialin.net [84.154.92.89])
        by mx.google.com with ESMTPS id y12sm12288884faj.5.2010.05.08.09.43.24
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 08 May 2010 09:43:25 -0700 (PDT)
Received: from drizzd by darc.lan with local (Exim 4.71)
	(envelope-from <drizzd@localhost>)
	id 1OAn7X-0005Kw-89; Sat, 08 May 2010 18:43:19 +0200
Content-Disposition: inline
In-Reply-To: <7v7hnmuvtv.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/146666>

On Sun, May 02, 2010 at 09:12:12AM -0700, Junio C Hamano wrote:

> * cb/assume-unchanged-fix (2010-05-01) 2 commits
>  - Documentation: git-add does not update files marked "assume unchanged"

Please remove the second hunk from that commit, where I add "The assume
unchanged bit is unset for all paths." That is clearly wrong.

Thank you.

Clemens

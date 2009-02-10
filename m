From: Jonas Fonseca <fonseca@diku.dk>
Subject: Re: [ANNOUNCE] tig-0.14
Date: Tue, 10 Feb 2009 22:13:49 +0100
Message-ID: <2c6b72b30902101313r5dcea490s3bc72d404a98997f@mail.gmail.com>
References: <20090205204436.GA6072@diku.dk> <4991814A.6050803@tedpavlic.com>
	 <2c6b72b30902101029s72628a88n16473ee30f853198@mail.gmail.com>
	 <6BA2725C-2127-48BE-871E-7449A507CCD8@silverinsanity.com>
	 <d4bc1a2a0902101129y22224c89y144b223e7d7dd463@mail.gmail.com>
	 <2c6b72b30902101241p67a0e1e9u60c8033c4a03260c@mail.gmail.com>
	 <3902F3BD-6EE5-4896-9E96-C4A1C4B6E9AF@silverinsanity.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Stefan Karpinski <stefan.karpinski@gmail.com>,
	Ted Pavlic <ted@tedpavlic.com>, git <git@vger.kernel.org>
To: Brian Gernhardt <benji@silverinsanity.com>
X-From: git-owner@vger.kernel.org Tue Feb 10 22:15:25 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LWzwt-0007eo-6T
	for gcvg-git-2@gmane.org; Tue, 10 Feb 2009 22:15:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754966AbZBJVNw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Feb 2009 16:13:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754749AbZBJVNw
	(ORCPT <rfc822;git-outgoing>); Tue, 10 Feb 2009 16:13:52 -0500
Received: from mail-fx0-f20.google.com ([209.85.220.20]:41073 "EHLO
	mail-fx0-f20.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754748AbZBJVNv (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Feb 2009 16:13:51 -0500
Received: by fxm13 with SMTP id 13so160971fxm.13
        for <git@vger.kernel.org>; Tue, 10 Feb 2009 13:13:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:sender:received:in-reply-to
         :references:date:x-google-sender-auth:message-id:subject:from:to:cc
         :content-type:content-transfer-encoding;
        bh=VvxwzYBilFHQElkiDtY6kZNnD+w83ziZSmOEJNIwniY=;
        b=LDrJKNECPV8CYgqi17PZ2lOdULQzygANtbMpZ2PvgTVkq6cwP1j2Ls5kPZuY6LzCn5
         1x2AZTo/uJDcfPOd/kxBJ6tHar8febdbLgi/AjvBtqEQG0VErBWIKTaqw1xcOSws9rfo
         ae4iAuTukddoesS4thXMEoaR4/NwtYl4F3pTY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        b=mUyDZMnphjgtV52uuYLZkc+K/ayoMiu1+jL4aFTB7pW0p7a9uBaDlOpHVDE+EAPaTD
         JrKqyoVLTExRi9stdyML7vpZMh8NpZYtUCPY0dCGi/jt19RSCDvdadCOJifQucBn/TmX
         zajcQyNROwV9bKWvAhb+dmGsvZya17QHW7cLU=
Received: by 10.181.30.10 with SMTP id h10mr1285000bkj.200.1234300429355; Tue, 
	10 Feb 2009 13:13:49 -0800 (PST)
In-Reply-To: <3902F3BD-6EE5-4896-9E96-C4A1C4B6E9AF@silverinsanity.com>
X-Google-Sender-Auth: e5e1dfff4ae13ecd
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/109309>

On Tue, Feb 10, 2009 at 21:49, Brian Gernhardt <benji@silverinsanity.com> wrote:
> That fixes half the problem.  It no longer leaves a highlight on the wrong
> line, but the newly selected line does not highlight the empty space at the
> end of the line.

I believe the empty space is the cursor, but I am not sure. At least
tig-0.14 should be more consistent regarding the cursor position,
which is now always placed at the end of the selected line, except
when the input prompt is in use.

-- 
Jonas Fonseca

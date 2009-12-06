From: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
Subject: Re: [PATCHv3 0/3] git-gui: more robust handling of fancy repos
Date: Sun, 6 Dec 2009 09:14:10 +0100
Message-ID: <cb7bb73a0912060014p548884e0g8c4510a5b562901b@mail.gmail.com>
References: <1250467128-29839-1-git-send-email-giuseppe.bilotta@gmail.com> 
	<36ca99e90910270435h69c1e983j78ff9ec49e7e8eae@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org, Markus Heidelberg <markus.heidelberg@web.de>,
	"Shawn O. Pearce" <spearce@spearce.org>
To: Bert Wesarg <bert.wesarg@googlemail.com>
X-From: git-owner@vger.kernel.org Sun Dec 06 09:14:45 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NHCGT-0004Cp-Be
	for gcvg-git-2@lo.gmane.org; Sun, 06 Dec 2009 09:14:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753087AbZLFIO0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 6 Dec 2009 03:14:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751962AbZLFIOZ
	(ORCPT <rfc822;git-outgoing>); Sun, 6 Dec 2009 03:14:25 -0500
Received: from mail-bw0-f227.google.com ([209.85.218.227]:45797 "EHLO
	mail-bw0-f227.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751844AbZLFIOZ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 6 Dec 2009 03:14:25 -0500
Received: by bwz27 with SMTP id 27so2840176bwz.21
        for <git@vger.kernel.org>; Sun, 06 Dec 2009 00:14:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type;
        bh=tfJGvqmiT2OXDIUO3asvs/tuQShFmWA6VpcdcmdBTJ8=;
        b=cmTFEFqAGqPmOzoHNw/VD2ZnU+Bvj1wqxAR6HXtt78LSpJnLakDYacBfqCSNJnb0at
         QO9suiLTz2BwxaqNTa5aFeXDq30M2SkCqOnjJ/kYqrMcbiuKw1dESYoEWrjA/zFLJ7h1
         QrT6/VUSO54f1v5tP63d4YNBjhFfGjUWdxDz4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=nJ4M04yFpKga+fdoQNSyU+PgrvPx/U5OaeTvu9G4HYqvqYHdJ2sXi/lGH0WYe6UVSS
         1Nt6pWo7O8DlvoQWY2z0KzbTYYjPHn6r6Cva+2gqHTLUmT1ZyUH7t/pPBsswTu44MvxT
         UF/4C+sfpaHgukalO3k+oHQcXEHi55Limaiqw=
Received: by 10.204.11.13 with SMTP id r13mr19747bkr.45.1260087270102; Sun, 06 
	Dec 2009 00:14:30 -0800 (PST)
In-Reply-To: <36ca99e90910270435h69c1e983j78ff9ec49e7e8eae@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/134655>

On Tue, Oct 27, 2009 at 12:35 PM, Bert Wesarg
<bert.wesarg@googlemail.com> wrote:
>
> I would also suggest to always export GIT_DIR into the environment, so
> that guitools can relay on this.

I'm sorry I couldn't reply to this email earlier. I have never used
this feature, but if you can provide some example guitools
configuration I'll gladly move the environment export earlier and test
it.

-- 
Giuseppe "Oblomov" Bilotta

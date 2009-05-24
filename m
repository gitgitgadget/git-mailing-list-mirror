From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: partial checkouts
Date: Sun, 24 May 2009 12:07:37 +1000
Message-ID: <fcaeb9bf0905231907q16160ad1t8aa8ef71e2adc8b0@mail.gmail.com>
References: <200905231401.11651.chanika@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Chani <chanika@gmail.com>
X-From: git-owner@vger.kernel.org Sun May 24 04:08:21 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M838O-0000c0-Cg
	for gcvg-git-2@gmane.org; Sun, 24 May 2009 04:08:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754410AbZEXCH5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 23 May 2009 22:07:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754369AbZEXCH4
	(ORCPT <rfc822;git-outgoing>); Sat, 23 May 2009 22:07:56 -0400
Received: from yw-out-2324.google.com ([74.125.46.31]:45457 "EHLO
	yw-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754343AbZEXCH4 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 23 May 2009 22:07:56 -0400
Received: by yw-out-2324.google.com with SMTP id 5so1471401ywb.1
        for <git@vger.kernel.org>; Sat, 23 May 2009 19:07:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=iWiZn2f/eKO/8i9JwEyGQJtQrPtm0YkReJCTJP+6+AU=;
        b=OaLqS86ywf6sV7ZosP25Z54Fl3TZDsCZruF43Ik8AX5zFCcdW1XgLZzxRWktXIVU8M
         U7eXh0DcqNStBp65rPzTsHH+dubx6L50Ay3yWmvphpOyRXCN75J3cc1Yxq3DL33L6u7X
         DqNafh9bgn4se+eNjVxf9DqEFQgA6BCexrbrw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=jHXMDjy5Dis4jfehqXbxbxKFSe+Uq6mZ6TjHmOoYiaEYTLebQTmAxkNepm5TZPvVzN
         EiHQx0+kesyXYoGaSQj/glNPFP33YTetiK9fzb6kDOKciZdxTIc6n0a6NVk4ILatACnV
         t7MZGQNibFwOvNXWSreLR+STpErCB4Tmx70kE=
Received: by 10.100.143.17 with SMTP id q17mr10066686and.114.1243130877174; 
	Sat, 23 May 2009 19:07:57 -0700 (PDT)
In-Reply-To: <200905231401.11651.chanika@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/119809>

On Sun, May 24, 2009 at 7:00 AM, Chani <chanika@gmail.com> wrote:
> checking out the entire git repo isn't really feasible, because once KDE
> finishes switching to git that'll mean checking out all of KDE.
> I don't think that turning every doc folder into a submodule is feasible,
> either - they sound kinda awkward to work with, and I can imagine lots of
> people getting confused and messing them up...

If you don't mind cloning the entire git repo (which may be quite
large in KDE case, I guess), then you may want to try "sparse
checkout". The patch series is available as a topic branch "tp/sco" in
this branch:

http://repo.or.cz/w/git/pclouds.git?a=shortlog;h=refs/heads/inst

Or I can send the patch series to you. It lets you specify what part
of the tree you want to checkout.
-- 
Duy

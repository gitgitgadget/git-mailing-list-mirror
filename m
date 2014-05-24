From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [ANNOUNCE] git reintegrate v0.3; manager of integration branches
Date: Fri, 23 May 2014 23:23:01 -0500
Message-ID: <53801ea595071_e568c52f816@nysa.notmuch>
References: <53795175664d5_10da88d308ce@nysa.notmuch>
 <xmqqha4lxyqt.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Sat May 24 06:34:31 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wo3fC-0004mD-Pi
	for gcvg-git-2@plane.gmane.org; Sat, 24 May 2014 06:34:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750757AbaEXEeY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 24 May 2014 00:34:24 -0400
Received: from mail-ob0-f176.google.com ([209.85.214.176]:58952 "EHLO
	mail-ob0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750713AbaEXEeX (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 24 May 2014 00:34:23 -0400
Received: by mail-ob0-f176.google.com with SMTP id wo20so6215944obc.35
        for <git@vger.kernel.org>; Fri, 23 May 2014 21:34:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-type:content-transfer-encoding;
        bh=EE+a+pUaNf8YTwq1FJRI0sN72tkO1YpHmns2FO7TC1g=;
        b=T3coKsuAgb8m12b6xZRHjy9hhA+SqiWXMBWWPEPCWN3i3ETFDcUrPwPgtHXucuIutz
         y/QkWJhed6klyoKB/15mwIrqiAywuciArW8eGb0mUz9JA7D4mN4ChU7WjZUtkgS4W0mg
         yiBH3IZFfcVsDC1KBzXfMD35IHcdoF8j8rOKdBsA/nIGJ3eMb0n/eZQSvRrTpZow/eiH
         CUnu8WQ0iUa2nrcXHel8UZOIwTGplKEdLEa1dyXIwQ0fFDtXe2w/O9dKDk77dd5OSdkn
         ej8kQ7+SYcPiIBXgZ41twi+Lmww+qap/UPQzsrceffrOue2VFtcZlPK1adyur894AncA
         F2Ww==
X-Received: by 10.182.58.83 with SMTP id o19mr9797985obq.26.1400906063199;
        Fri, 23 May 2014 21:34:23 -0700 (PDT)
Received: from localhost (189-211-224-40.static.axtel.net. [189.211.224.40])
        by mx.google.com with ESMTPSA id tz6sm9275790obc.10.2014.05.23.21.34.20
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 23 May 2014 21:34:21 -0700 (PDT)
In-Reply-To: <xmqqha4lxyqt.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/250055>

Junio C Hamano wrote:
> I presume that the workflow can be mimicked by having another branch
> 'match-next' and building it on top of 'master', and then building
> 'jch' on top of it, and then building 'pu' on top of it.  Then you
> should be able to play 'match-next' instruction on top of 'next'
> (provided that there is a way to tell it to replay on HEAD and
> ignore "base" and have "merge" instruction become a no-op when the
> branch has already been merged).

Done.

% git checkout next
% git reintegrate --apply match-next

https://github.com/felipec/git-reintegrate/commit/036395b

-- 
Felipe Contreras

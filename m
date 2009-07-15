From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: Git/Terminal issue
Date: Wed, 15 Jul 2009 14:51:47 +0200
Message-ID: <81b0412b0907150551x718bd46eq6d5bc8f332a9db1f@mail.gmail.com>
References: <24495974.post@talk.nabble.com>
	 <alpine.LNX.2.00.0907150450290.14159@xerxes.uplinklabs.net>
	 <4A5DC56E.8050607@erskinedesign.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Steven Noonan <steven@uplinklabs.net>, git@vger.kernel.org
To: glen@erskinedesign.com
X-From: git-owner@vger.kernel.org Wed Jul 15 14:52:05 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MR3xo-0008Dv-DA
	for gcvg-git-2@gmane.org; Wed, 15 Jul 2009 14:52:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754145AbZGOMvw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 15 Jul 2009 08:51:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753318AbZGOMvw
	(ORCPT <rfc822;git-outgoing>); Wed, 15 Jul 2009 08:51:52 -0400
Received: from mail-fx0-f218.google.com ([209.85.220.218]:35187 "EHLO
	mail-fx0-f218.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752089AbZGOMvv (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 15 Jul 2009 08:51:51 -0400
Received: by fxm18 with SMTP id 18so3429520fxm.37
        for <git@vger.kernel.org>; Wed, 15 Jul 2009 05:51:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=5q0CJcmWwCFPoz0QQMsZIb4JncnkL5FVxY0oGzjhMTM=;
        b=G44YGViuMW3iunw0lUw1m9n+LNxskVcnP4c3wWcIZPTF6E0FBmgTS8YoSGlcQ2unAr
         DZ8Lv4HYsNopWdw+titCyzkk+eF1BeGibJfFn+GSZYBilG0/zf7HEepoVa52vRKpSyyr
         FiMFRdGhrXoskrj37B2Zn0EiyMZOofEzatbFY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=eXGxXqyYkMsPU6NA4Pt1j4Bu2SxcIGJQkID2ETXw1VNwVKRKOpSbRWv8V1uT7CB8Wr
         mY5vsvPB/pe6y+U1X6eryxQqr3/KQLq2Bfpw1XBK38rbo49dbhIhn9HMTPWOThwanLdo
         eg1rrpFkqZgqbtO5MrpqfhWOETe3jtYEIYSXs=
Received: by 10.204.114.140 with SMTP id e12mr7625698bkq.68.1247662307982; 
	Wed, 15 Jul 2009 05:51:47 -0700 (PDT)
In-Reply-To: <4A5DC56E.8050607@erskinedesign.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/123305>

On Wed, Jul 15, 2009 at 14:02, Glen Swinfield<glen@erskinedesign.com> wrote:
> I cleared my .profile file but it didn't seem to have an effect. I also
> removed any aliases.
>
> If that's what it sounds like I'll have another dig around.

Just do

  echo $PS1

and look at the commands it uses. If you just want to get rid
of the prompt set it to something trivial (i.e. "PS1=\w$ ")

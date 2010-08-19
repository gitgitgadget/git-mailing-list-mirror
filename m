From: Tay Ray Chuan <rctay89@gmail.com>
Subject: Re: [PATCH re-roll] Do not display 'Switched to a new branch' when
 the branch existed
Date: Thu, 19 Aug 2010 11:21:31 +0800
Message-ID: <AANLkTi=fkgmx4+oYO71OiaayEpehcmxb5aOeR6WvU7DL@mail.gmail.com>
References: <AANLkTimaZF1Q6BPB7CN0Wa5-Ov2ejVfPsmL34vps2VqK@mail.gmail.com>
	<AANLkTi=3z9gJdT8LL3NANFyppUjvOVcrszjf5J5zAKPe@mail.gmail.com>
	<20100818091603.GA6263@burratino>
	<AANLkTikHbj4zA6Kj0wUp6uQUY3w6cM_z0=Pes1jLLTky@mail.gmail.com>
	<AANLkTimU75krdgQFvw0fEvAPqJb-eKaPXHg_5Hv2A8wh@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Knittl <knittl89@googlemail.com>
X-From: git-owner@vger.kernel.org Thu Aug 19 05:21:50 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OlvhK-0007Gv-P9
	for gcvg-git-2@lo.gmane.org; Thu, 19 Aug 2010 05:21:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751323Ab0HSDVe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 Aug 2010 23:21:34 -0400
Received: from mail-ey0-f174.google.com ([209.85.215.174]:34281 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751050Ab0HSDVc (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Aug 2010 23:21:32 -0400
Received: by eyg5 with SMTP id 5so919879eyg.19
        for <git@vger.kernel.org>; Wed, 18 Aug 2010 20:21:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type;
        bh=Bwvk0WCdXQBz31svsDLj7sBfnE5WgVqMTZx7FhfinqA=;
        b=iX6iX7hmi6p7TbZ1ufzGtUXoWlabzhqviI7Uv8N7IYDThSTR2i3OEUVntUd+ZPX+Lg
         nN1z0Ybc27+Es4OmydgwTIOmzd8sH6TL56T4UwrlVqwMj7UZO/fu0/yiuGSjwk2lNolZ
         knu2hXezW2nqnhwpYLKdJDBf+AmgTlh/PpY1s=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=QYZLhuyxq88PSMnG20NRaWPKmC1m2OpdZiUJLdoZ4ld9tbr47B8CQvztHWxqUkjfpY
         iW+NDEzyTgdzsOqKlhaeZlFWLG40lVwUTdNweFJKpnSI23julmQfgFdJRviIr3k3+7Ox
         TD5kbbvfnRgzjegZ5S933Gwb6epUxyN9hdE00=
Received: by 10.213.33.130 with SMTP id h2mr981665ebd.78.1282188091496; Wed,
 18 Aug 2010 20:21:31 -0700 (PDT)
Received: by 10.213.22.134 with HTTP; Wed, 18 Aug 2010 20:21:31 -0700 (PDT)
In-Reply-To: <AANLkTimU75krdgQFvw0fEvAPqJb-eKaPXHg_5Hv2A8wh@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/153906>

Hi,

oops, seems like you dropped everyone from the Cc list, including the
mailing list. Try using the "Reply to all" next time.

On Wed, Aug 18, 2010 at 9:56 PM, Knittl <knittl89@googlemail.com> wrote:
> [snip
> yes, i branched off of your bad commit (or rather the commit after
> your bad commit "fix detached head usage") and created the commit with
> git commit -c HEAD^ to have the same heading and similar wording
> without opening a second terminal to copy it over. so i accidentally
> sent the patch with your name as author, which i then fixed with git
> amend --reset-author

Why copy over the old commit message? You should be writing one that
fits what you're did, not what *I* did.

-- 
Cheers,
Ray Chuan

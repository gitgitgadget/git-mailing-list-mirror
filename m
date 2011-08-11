From: Philippe Vaucher <philippe.vaucher@gmail.com>
Subject: Suggestions to make git easier to understand
Date: Thu, 11 Aug 2011 09:48:37 +0200
Message-ID: <CAGK7Mr5T4-DBK7rXeH-1=SNu5HBOEkLBW=CAh5Lhf7oHKjFAiw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Aug 11 09:49:50 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QrQ1V-0003mF-7l
	for gcvg-git-2@lo.gmane.org; Thu, 11 Aug 2011 09:49:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751591Ab1HKHtL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Aug 2011 03:49:11 -0400
Received: from mail-qw0-f46.google.com ([209.85.216.46]:52425 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751085Ab1HKHtJ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Aug 2011 03:49:09 -0400
Received: by qwk3 with SMTP id 3so932311qwk.19
        for <git@vger.kernel.org>; Thu, 11 Aug 2011 00:49:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:from:date:message-id:subject:to:content-type;
        bh=IUclgLOZ4do+gFFuzqgh88qzigDsjHfYN7q3rNGU6+o=;
        b=lEDWNjhlvMCf0pBHP6jQG28HkkzHG55mkh2DMfUbzaoh5NnKIf7uNJgTsw/MbJoIlZ
         ofZyKkxyeLpfBpdcmJ34/Q8oOKHm+D2Krw0dydJrtPCSnqEUU18WV/c4p6Ks0ZOvHQ23
         4O7SuLm3XZ4NpbYxaRR9TQHh0lnitDa6IN0ow=
Received: by 10.224.70.212 with SMTP id e20mr2785529qaj.9.1313048947227; Thu,
 11 Aug 2011 00:49:07 -0700 (PDT)
Received: by 10.229.43.224 with HTTP; Thu, 11 Aug 2011 00:48:37 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/179090>

Hello,

The other day I fell on this post:

http://raflabs.com/blogs/silence-is-foo/2011/04/07/staging-area-index-cache-git/

I thought it made some good points about git being kinda confusing,
for example sentences like "Changed but not updated" in git status
could use a better sentence like "Changed but not in the index". Maybe
--cached could have an alias like --index-only for things to be more
intuitive as well.

`git rm --index-only somefile` is more understandable than `git rm
--cached somefile` imho.

Also, in ls-files, --stage could maybe use an alias like --contents
for it to be more self-explanatory.

Philippe

p.s: not saying we should absolutly do what I suggest, but rather
start a discussion about how to make git's terminology more intuitive
and self-explanatory.

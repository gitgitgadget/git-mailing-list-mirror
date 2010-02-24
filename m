From: mat <matthieu.stigler@gmail.com>
Subject: Looks like --amend create commit... don't understand
Date: Wed, 24 Feb 2010 22:27:32 +0100
Message-ID: <4B8599C4.1050409@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Feb 24 22:27:48 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NkOll-0007HO-QE
	for gcvg-git-2@lo.gmane.org; Wed, 24 Feb 2010 22:27:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758144Ab0BXV1j convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 24 Feb 2010 16:27:39 -0500
Received: from mail-fx0-f219.google.com ([209.85.220.219]:34489 "EHLO
	mail-fx0-f219.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754696Ab0BXV1i (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Feb 2010 16:27:38 -0500
Received: by fxm19 with SMTP id 19so5579347fxm.21
        for <git@vger.kernel.org>; Wed, 24 Feb 2010 13:27:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:subject:content-type
         :content-transfer-encoding;
        bh=5KJicpy/A3JGOWtG31o8uQFhUVt8qJuqMtj5hsBVwkY=;
        b=t7nZ6xAfm56wgaXvAQUVZwKxcwam9bGQH+BHER+4KCS0d7Bi0G80wtDfP3U0g1LCql
         TqGnUzHFg/nld27ZVWMwhCB16SkM8dKDeMnDzGP2U+bRLzhmH9GZsH811D9YAeglhvoT
         yoknTLYN4GN2IGpXbwUu6qpURVKHhC+Vf1EWI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:subject
         :content-type:content-transfer-encoding;
        b=sklFZ7Ybesv8p9RWoioEG+YIY1ZlduNaVz4u4XvfYLq0qguBx0i0TUi+iSfoNRTMne
         j1EhollkZIxwBUNxR9IG8oac/zH/get6WfcuAzv+Na6U0FJn8ntljR82+tik4UxLAjm6
         Z+dYb6SrZTs5kKHmsTEropVdpsnbUbyGpqwFg=
Received: by 10.87.65.9 with SMTP id s9mr851355fgk.48.1267046856474;
        Wed, 24 Feb 2010 13:27:36 -0800 (PST)
Received: from ?192.168.178.21? (ip-28-110.sn2.eutelia.it [83.211.28.110])
        by mx.google.com with ESMTPS id 9sm80145fks.26.2010.02.24.13.27.33
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 24 Feb 2010 13:27:35 -0800 (PST)
User-Agent: Thunderbird 2.0.0.23 (X11/20090817)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/140989>

Hi

Sorry for this question that might appear soo simple but I'm a little=20
bit lost :-(

When editing my code, I like to --amend it a lot between bigger commits=
=2E=20
But when looking on gitk, I see that
git commit blabla --amend

does create each and every time a new commit, I mean: with git log,=20
there is only one commit, but on gitk, I see many, with the same name=20
but different revision ID.... My understanding was that it would only=20
replace, not create each time a new revision.. Could you please explain=
=20
me where I=E0m wrong and what is happening exactly?

=46urthermore, if I wish to delete all those intermediary amend commit,=
=20
can I do it? If yes, how?

Thanks a lot for this help!

Matthieu

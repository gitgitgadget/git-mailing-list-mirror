From: Robin Rosenberg <robin.rosenberg@gmail.com>
Subject: Re: [EGIT] Push to GitHub caused corruption
Date: Tue, 11 Aug 2009 08:10:45 +0200
Message-ID: <200908110810.45369.robin.rosenberg@gmail.com>
References: <3ae83b000908101446q2d4f1101we4bbd7023f78b03@mail.gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git <git@vger.kernel.org>
To: John Bito <jwbito@gmail.com>
X-From: git-owner@vger.kernel.org Tue Aug 11 14:41:17 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MaqfC-0002q8-QJ
	for gcvg-git-2@gmane.org; Tue, 11 Aug 2009 14:41:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751572AbZHKMkv convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 11 Aug 2009 08:40:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751543AbZHKMkv
	(ORCPT <rfc822;git-outgoing>); Tue, 11 Aug 2009 08:40:51 -0400
Received: from mail-ew0-f214.google.com ([209.85.219.214]:39979 "EHLO
	mail-ew0-f214.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751443AbZHKMku convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 11 Aug 2009 08:40:50 -0400
Received: by ewy10 with SMTP id 10so3736296ewy.37
        for <git@vger.kernel.org>; Tue, 11 Aug 2009 05:40:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:message-id;
        bh=IWrzUnnNRMcQe5HK1t3cAkinL1+9lHXneBV/DOuHJt0=;
        b=f8NgHDkEJ6kQNyTEyMy+t5DREZjluJXMyRHbFjn9n9WT6qk4jz+NEoX3tK+0rM4VQ7
         wc0Oz3Q4A5SOgqJJDCNAa8sPSKjgJoLIuZtL4HKlowJjXQQeNMf67WW6Lks9VDirdpev
         u4o6UY/9jaGhkcqQbVH9yg1mRdLeh3KaMmWmk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding:message-id;
        b=m7Eke34EIrdgWsvlfcGrTHypxKT9TlAberAo4+1jFY8EZIEuUVKhCdxzoEQNf96dSz
         IN8LtIHZVWD8O8jjDeiNNNteTBHnYZ60hWoxTWskwqf0qCvhj8vbsgpv7JjtStdOa3PI
         95P3VCFVv4pmLA0u5jXcgCbuE/XbF4l9lxvok=
Received: by 10.210.110.5 with SMTP id i5mr6016770ebc.3.1249971047927;
        Mon, 10 Aug 2009 23:10:47 -0700 (PDT)
Received: from sleipner.localnet (h59n1fls34o811.telia.com [213.67.102.59])
        by mx.google.com with ESMTPS id 28sm13232849eye.44.2009.08.10.23.10.47
        (version=SSLv3 cipher=RC4-MD5);
        Mon, 10 Aug 2009 23:10:47 -0700 (PDT)
User-Agent: KMail/1.12.0 (Linux/2.6.28-11-generic; KDE/4.3.0; i686; ; )
In-Reply-To: <3ae83b000908101446q2d4f1101we4bbd7023f78b03@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/125540>

m=E5ndag 10 augusti 2009 23:46:34 skrev John Bito <jwbito@gmail.com>:
> Using the 'release' build of EGit (0.4.9.200906240051) I pushed a
> commit to GitHub.  After that, using git to pull, I get 'bad tree
> object' resulting in 'remote: aborting due to possible repository
> corruption on the remote side'.  I had a similar problem back in Apri=
l
> (using integration builds of 0.4.0).  I'm willing to investigate if
> there's interest in finding the root of the problem.

=46ixing problems related to repository integrity is definitely interes=
ting. One
can live all kinds of problem, as long as they don't destroy anything.=20

-- robin

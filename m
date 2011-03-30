From: Tilman Vogel <tilman.vogel@web.de>
Subject: RFC: script to manually associate files after failed rename detection
 in conflicting merge
Date: Wed, 30 Mar 2011 15:38:37 +0200
Message-ID: <4D93325D.70403@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Mar 30 15:38:50 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q4vbj-0007Ky-11
	for gcvg-git-2@lo.gmane.org; Wed, 30 Mar 2011 15:38:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754785Ab1C3Nim (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Mar 2011 09:38:42 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:35357 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750798Ab1C3Nil (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Mar 2011 09:38:41 -0400
Received: by fxm17 with SMTP id 17so1047113fxm.19
        for <git@vger.kernel.org>; Wed, 30 Mar 2011 06:38:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:sender:message-id:date:from:user-agent
         :mime-version:to:subject:x-enigmail-version:content-type
         :content-transfer-encoding;
        bh=+aTD4SthEZNjklpKm4wh7mGXI9BQ5DnrlHaxJmoNDzA=;
        b=Oyuc4Zzokw2QyeTpA/kPuIN2ESkFNPBFSylWWYlCrIAyLRDvvzXOv0C0tVYx5hlpuy
         ZXnELC/P/HU+Dj+VopNeiH7dO7taD7444TbDmCeTYmq5D6eBouXwONiFZw9jesnNWXtB
         lX/qoz8SYuKN/7J8E6Bgcjgw16Eza7U1iRZbo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=sender:message-id:date:from:user-agent:mime-version:to:subject
         :x-enigmail-version:content-type:content-transfer-encoding;
        b=J4rSf3sbuva411JN9zoMOtcD+2OeRyvQe2dgNQO+XfLqKXAXbTctn9MydnIDrvKUZQ
         lGqLaG/urR1TrjNPPc6l8Go+rxv5mZtxtRvKpKpY2FsX3EGBLQOTqQJLibpXD5hJespn
         bRvX0WBPnqoWfmHI+e3C7sJTZlgPsToJt/MmY=
Received: by 10.223.2.2 with SMTP id 2mr1277722fah.47.1301492320187;
        Wed, 30 Mar 2011 06:38:40 -0700 (PDT)
Received: from atrium.lan (e178193092.adsl.alicedsl.de [85.178.193.92])
        by mx.google.com with ESMTPS id n15sm45334fam.36.2011.03.30.06.38.38
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 30 Mar 2011 06:38:39 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; de; rv:1.9.2.11) Gecko/20101013 SUSE/3.1.5 Thunderbird/3.1.5
X-Enigmail-Version: 1.1.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/170385>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Hi!

I am aware of the fact that recently, git gained the ability to control
the rename-threshold in merges. Still, it might sometimes be useful to
have manual control about what gets associated as a rename.

This is a first try to write a script that makes this task easy. I
tested it here on CONFLICT (delete/modify) results and it seems to work
quite well.

I would be interested in feedback, in particular whether something
similar is present already, even though I couldn't find anything other
than the instructions in the FAQ.

I put the script on gist.github.com at

<https://gist.github.com/894374>

Another, a little related question: Is anybody already working on making
"git checkout -m" allow "-X" options? I'd really he happy about "-X
ignore-space-change" and its relatives.

Thanks for any feedback,

Tilman

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.15 (GNU/Linux)
Comment: Using GnuPG with SUSE - http://enigmail.mozdev.org/

iEYEARECAAYFAk2TMl0ACgkQ9ZPu6Yae8lkbiQCgkZ6KkzYqPER6sjKgd+JmZU4P
9joAnjWflRjgqJ24RX+8AjcRU2uKBmGK
=7GfJ
-----END PGP SIGNATURE-----

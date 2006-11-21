X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: "Sean Kelley" <sean.v.kelley@gmail.com>
Subject: Stupid Git question
Date: Tue, 21 Nov 2006 15:41:32 -0600
Message-ID: <89b129c60611211341j71079633g53b0ec1d2e3193a5@mail.gmail.com>
References: <89b129c60611211331r3bb286b6re3c2c8f65ec3896f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Tue, 21 Nov 2006 21:41:41 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=f3XcZmJzDj3VQF+9ipnnxKJxkF6nTy0rJcCSIUk7lIl15840WxHcT7h7/uu0WC9joDNV/EjwgzAQ15PZTadYYJ1wAlDDq4ELmYIn6Gc0I7qnhHTWQ2JQVzFt8W9efPkiECWZtuWZxhI7g1YKLXkp+CtRRWzPxyeEWxNVgncKeIE=
In-Reply-To: <89b129c60611211331r3bb286b6re3c2c8f65ec3896f@mail.gmail.com>
Content-Disposition: inline
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/32040>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GmdN5-0005XS-3J for gcvg-git@gmane.org; Tue, 21 Nov
 2006 22:41:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1031437AbWKUVlf (ORCPT <rfc822;gcvg-git@m.gmane.org>); Tue, 21 Nov 2006
 16:41:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1031440AbWKUVlf
 (ORCPT <rfc822;git-outgoing>); Tue, 21 Nov 2006 16:41:35 -0500
Received: from ug-out-1314.google.com ([66.249.92.170]:42839 "EHLO
 ug-out-1314.google.com") by vger.kernel.org with ESMTP id S1031437AbWKUVle
 (ORCPT <rfc822;git@vger.kernel.org>); Tue, 21 Nov 2006 16:41:34 -0500
Received: by ug-out-1314.google.com with SMTP id m3so1663220ugc for
 <git@vger.kernel.org>; Tue, 21 Nov 2006 13:41:32 -0800 (PST)
Received: by 10.78.142.14 with SMTP id p14mr6994167hud.1164145292114; Tue, 21
 Nov 2006 13:41:32 -0800 (PST)
Received: by 10.78.179.10 with HTTP; Tue, 21 Nov 2006 13:41:32 -0800 (PST)
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

Hi,

I have a stupid git question.  We are doing embedded development using
git for our kernel mods.

git clone git+ssh://git.example.com/git/kernel/mh.git kernel

git checkout -b fm-modulator

edit/add/commit

git checkout origin

git pull . fm-modulator

git push origin

Everything up-to-date  <<< It pushes nothing

My problem is that I don't understand why when I tell git to push the
changes to our repository it says everything is up-to-date.  It
clearly hasn't pushed it yet to our server.

My git layout is like this:

A single repository representing our Monahans kernel "mh.git"  hosted
on a remote server accessed by git+ssh.

Four developers work on the kernel and drivers for the target platform.

Any suggestions much appreciated.  My prior experience is with
StarTeam and more recently Subversion.

Thanks,

Sean

-- 
Sean Kelley

-- 

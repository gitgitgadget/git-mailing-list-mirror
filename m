From: Robert Buck <buck.robert.j@gmail.com>
Subject: what file extensions must be explicitly configured with respect to
 eol-type in gitattributes?
Date: Mon, 20 Sep 2010 12:19:38 -0400
Message-ID: <AANLkTikK2oL3sUYHdqoQ7C47nd6Pi53N17GSfh8nx6Q-@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: "git@vger.kernel.org List" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Sep 20 18:19:48 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Oxj5m-0001EV-W2
	for gcvg-git-2@lo.gmane.org; Mon, 20 Sep 2010 18:19:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756831Ab0ITQTk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 20 Sep 2010 12:19:40 -0400
Received: from mail-ey0-f174.google.com ([209.85.215.174]:64623 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752275Ab0ITQTk (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Sep 2010 12:19:40 -0400
Received: by eyb6 with SMTP id 6so1632172eyb.19
        for <git@vger.kernel.org>; Mon, 20 Sep 2010 09:19:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:date:message-id
         :subject:from:to:content-type;
        bh=PO6wVV80nQnfwuZknZyrQWmtgkpU2PjdlVFRJ99i4Zo=;
        b=dqQTAMeT39DHg5NB4r9MYzLgxHG7IFRnoF25B25SOpau2j59+tB0KN5nbOpErIYGd6
         1LfRnAd3XU7Yvb27QUEYvPF0xtJ8pxMiFdyezYgjj78PeDivFtdF27IMnruwBwziH9DM
         Z2zisAxeD2ufCq+g+dVefXl/d45okxG2pYc+g=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type;
        b=PVTvfAV439fNADu9QZwzWo5Dyuctt844hb6teofXRfo77v4Arez3IJ+yuZ9cBGkQvF
         4RV3H7RCrBWwHm0xsb9gLKWBLgiLGmwrHreX7K3aa8NdRdwhpwBUwaNUbwvPLHdLvIrW
         mXGlxAw/HSTC/Z9QbbRywH5uYMzXhm4Q77y8k=
Received: by 10.213.36.3 with SMTP id r3mr2905413ebd.88.1284999578955; Mon, 20
 Sep 2010 09:19:38 -0700 (PDT)
Received: by 10.14.47.74 with HTTP; Mon, 20 Sep 2010 09:19:38 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/156636>

Hello,

One project we have in house has approximately 160 different file
extensions used for the files checked in. In our repository there are
files that MUST be CRLF (.bat, .cmd, .vcproj, etc), files that MUST be
LF (.xml, .xsl, .sh, etc), and files that MUST be binary. All others
are just text and so long as they appear in native form I'd be happy.

It would seem a default rule to handle text files would make sense:

* text=auto

But I have not found material explaining how git identifies binary
files, so one concern would be that it could mangle binary file types
in some cases.

Do I have to explicitly mention all 160 file types in the gitattributes file?

How does git internally determine whether a file is text vs binary?
Does it use the 'file' command in Unix?

And where I am going with this specifically is a question: what rules
MUST be specifically stated in gitattributes and what rules are there
implicitly?

Thank you,

Bob

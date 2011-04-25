From: Michael Treibton <mtreibton@googlemail.com>
Subject: Submodules or separate repos?
Date: Mon, 25 Apr 2011 11:35:10 +0100
Message-ID: <BANLkTinAC2Thuf_z_-DMEHotgF-tqpQYZw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Apr 25 12:35:29 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QEJ8Z-00053I-8x
	for gcvg-git-2@lo.gmane.org; Mon, 25 Apr 2011 12:35:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758298Ab1DYKfQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 Apr 2011 06:35:16 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:64969 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758284Ab1DYKfM (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Apr 2011 06:35:12 -0400
Received: by fxm17 with SMTP id 17so1228079fxm.19
        for <git@vger.kernel.org>; Mon, 25 Apr 2011 03:35:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:mime-version:date:message-id:subject:from:to
         :content-type;
        bh=G4l7fmbqB8EuvchCwZpmAiU0EtF7TQ4bMPRr2rULwK8=;
        b=wvvz0uvTbmr7f4WtgfPeHZMNXRsKxnpUioA4OoBLD7m/cfofVEg+CzUDCz4y3/I8FX
         3n439+8K4ABsoxj9AEEKoblOgzmKgnfUEVymM6dEAW6ndMN/PPYn5CGvwqQwSk9F5s+S
         JjiaudVlhPXXnPAg099dtEiHOAMM9FWhuZ5fU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type;
        b=iC0mGFAH/eFVIntYrZWW+6oOh9FcMwYejVu9NKt6ol4b+u6X+w66wznqZlCm9+HxWL
         glonnFkahxoBBfwDTmAExqy4sBsGbjA0ccNtZBgFI9is+zCM/fVCOEwCCd621VpBceEK
         p/+swVA5iOLx7nu7zny2KwAWgUpOHgYqFDIp4=
Received: by 10.223.14.207 with SMTP id h15mr3115122faa.50.1303727711038; Mon,
 25 Apr 2011 03:35:11 -0700 (PDT)
Received: by 10.223.86.208 with HTTP; Mon, 25 Apr 2011 03:35:10 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/172022>

hi,

please CC me as i am not subscribed

ive recently converted a project that was in svn to use git - and
that's gone well.

in doing this ive been wondering if i can't split up the respository
more.  currently we have this:

project/
    core/
    modules/
        moduleA/
        moduleB/

Which i think is fairly typical of most projects.

i was wondering how feasible it would be to split out "moduleA" and
"moduleB" into their own repositories? to me that makes sense.  but by
themselves neither "moduleA" or "moduleB" would compile without the
core.

So...

does this make more sense for submodules or separate repositories?

And if they were separate repositories, how would this work from a
development point of view?  what about a release of the project? would
there be a makefile which pulled in a known version of tarball
released from each moduleX repository?

What do most other people do in this situation?

TIA!

Michael

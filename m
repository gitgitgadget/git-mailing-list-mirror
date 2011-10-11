From: Howard Miller <howard@e-learndesign.co.uk>
Subject: Submodule confusion when checking out branch
Date: Tue, 11 Oct 2011 10:38:48 +0100
Message-ID: <CAHVO_90rHbqqUx6HCh7tLWO9aP9PyPMpYnZGszCDB2bfNzUXAQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Oct 11 11:38:55 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RDYnW-0007YJ-Ns
	for gcvg-git-2@lo.gmane.org; Tue, 11 Oct 2011 11:38:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753863Ab1JKJiu convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 11 Oct 2011 05:38:50 -0400
Received: from mail-qw0-f46.google.com ([209.85.216.46]:42123 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753107Ab1JKJit convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 11 Oct 2011 05:38:49 -0400
Received: by qadb15 with SMTP id b15so4510308qad.19
        for <git@vger.kernel.org>; Tue, 11 Oct 2011 02:38:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:sender:date:x-google-sender-auth:message-id:subject
         :from:to:content-type:content-transfer-encoding;
        bh=z+55vUxaP8EyE6kP7sZleuxkXIoU0l0/X250mOyxXh4=;
        b=U3bZXXbMuSDgA1M3i+od98BmvwSayC7j2x4zQhL5JLvnELropXf8rHI+1Zwkm8ws1I
         IJDIPCwSClJhcgnRTpRhS/v/dt2zBtapkcrIdVTf6wm5aCP7SOM1eqDOvPW5ljoFD0xB
         wZZsQBWdZFrCxyzBRmdYB3witrPFoBX0EW8Y0=
Received: by 10.182.17.103 with SMTP id n7mr10699412obd.68.1318325928732; Tue,
 11 Oct 2011 02:38:48 -0700 (PDT)
Received: by 10.182.42.99 with HTTP; Tue, 11 Oct 2011 02:38:48 -0700 (PDT)
X-Google-Sender-Auth: MFazm08yqdyxsgSgw-VEPr9oItM
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/183288>

I added a submodule to my project like this (all from the root of the p=
roject)

git submodule add git@..... =A0 path/to/submodule
git submodule init
git add path/to/submodule
git commit -m 'I added a submodule!'
git push

All looks good and 'git status' reports 'nothing to commit'

However, I now cannot change branches. On checkout, I get...

"error: The following untracked working tree files would be
overwritten by checkout:"
(followed by a big list of all the files in the submodule)

Where did I go wrong and what can I do to sort it?

Thanks again!

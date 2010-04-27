From: Ping Yin <pkufranky@gmail.com>
Subject: How to continue to run 'git svn fetch' for a repo with no git-svn 
	metadata
Date: Tue, 27 Apr 2010 17:48:33 +0800
Message-ID: <t2u46dff0321004270248l49d1ae30l6b168342e01a5bfd@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: git mailing list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Apr 27 11:48:42 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O6hPF-00029F-Oy
	for gcvg-git-2@lo.gmane.org; Tue, 27 Apr 2010 11:48:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754650Ab0D0Jsf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Apr 2010 05:48:35 -0400
Received: from mail-qy0-f179.google.com ([209.85.221.179]:33301 "EHLO
	mail-qy0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754421Ab0D0Jsd (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Apr 2010 05:48:33 -0400
Received: by qyk9 with SMTP id 9so19025802qyk.1
        for <git@vger.kernel.org>; Tue, 27 Apr 2010 02:48:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:date:message-id
         :subject:from:to:content-type;
        bh=ixIx4RwnwtYgxx0fVYopY/rHzvBkuL2ioihA3ZPvps0=;
        b=NBeX4CzqNOW/8YdcgpeTq2f7uMb06+5iwG612fzyghHnEmLSVHGYJHRtCmmf1VBmbk
         9OtuGrx8i64I8qs5zlPLP1Ula5/Twf5UVTIQdA1D0TmlMpNjHaUqsAkTCyZYGAgFnFpq
         +4Rv/2HWCcPMvpo81dH+jUsroPXfREd1KSNJc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type;
        b=qbZJDhNKdxaKuFRhfic3CZqBEIX1DcNU9Y5BRd9Pi2lkyCvkaPBQY5+/TN753I47ad
         SLVYH0/UW9EAG0qaoSqKgmaSrksHkGMQZ6URbVngQFIepZxO19cvb4cpb8389ZSE45Du
         FUF2zmZoCAWzst9z9AhM09l5Ok5oqAi8Tv50o=
Received: by 10.229.227.5 with SMTP id iy5mr7095762qcb.29.1272361713125; Tue, 
	27 Apr 2010 02:48:33 -0700 (PDT)
Received: by 10.229.79.3 with HTTP; Tue, 27 Apr 2010 02:48:33 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/145891>

I cloned a repo from a central repo which is mirrored by git-svn. Now
i want to mirror the svn in the cloned local repo by myself, however,
i don't have the git-svn metadata (which is in the central repo). What
should i do to run "git svn fetch" without refetching all the
versions?

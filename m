From: "Aaron Gray" <aaronngray.lists@googlemail.com>
Subject: reverting a file or files back to repository copy
Date: Sat, 2 May 2009 15:54:41 +0100
Message-ID: <137A749092D040488A7F25B4CA5ED1DC@HPLAPTOP>
Mime-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="iso-8859-1";
	reply-type=original
Content-Transfer-Encoding: 7bit
To: "Git Mailing List" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat May 02 16:54:57 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M0Gc8-0003mR-Qq
	for gcvg-git-2@gmane.org; Sat, 02 May 2009 16:54:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755225AbZEBOyp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 2 May 2009 10:54:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754648AbZEBOyp
	(ORCPT <rfc822;git-outgoing>); Sat, 2 May 2009 10:54:45 -0400
Received: from mail-bw0-f163.google.com ([209.85.218.163]:42510 "EHLO
	mail-bw0-f163.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754536AbZEBOyo (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 2 May 2009 10:54:44 -0400
Received: by bwz7 with SMTP id 7so2763075bwz.37
        for <git@vger.kernel.org>; Sat, 02 May 2009 07:54:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:from:to:subject
         :date:mime-version:content-type:content-transfer-encoding:x-priority
         :x-msmail-priority:x-mailer:x-mimeole;
        bh=cFSFY2xtMvrGSbJr4heoOvKQK22wVsHZsbYuzblDgmU=;
        b=azd0PqU6GRT6rXrL0+TiyPDZAnnmtYcQhXR2choyqOMr+d+tf7j59ZQp9WwPnxE261
         iTguY8kT0Jm5PjstpZVp1m4axL7OAiLUJVKSeBzLGMVnklLiGOs2ikBrDbCOh+ODxMkp
         Qyut7GXTRQaYl/rftxefOUHIbHL6BxNjp3Fas=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=message-id:from:to:subject:date:mime-version:content-type
         :content-transfer-encoding:x-priority:x-msmail-priority:x-mailer
         :x-mimeole;
        b=LfrhA5fmvPYrkwTfaypCluMGwxMEzSnIg8SOECgSPlylwo69fWsIJbR3AIUA1YeGZr
         yKV1Yg1POoXCNQpdOgOoPeslO7jDiXDNfvXbTpXq8bKfCcGZaOytBzKrpPyrzuvDgwie
         3HMvqJ994DP5s6XX1cymDBrN3SNF/3guyzduE=
Received: by 10.204.69.143 with SMTP id z15mr3722363bki.29.1241276082610;
        Sat, 02 May 2009 07:54:42 -0700 (PDT)
Received: from HPLAPTOP (mwgray.force9.co.uk [212.159.110.144])
        by mx.google.com with ESMTPS id 13sm6067583fks.14.2009.05.02.07.54.41
        (version=SSLv3 cipher=RC4-MD5);
        Sat, 02 May 2009 07:54:42 -0700 (PDT)
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.5512
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.5579
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/118135>

How do I do the eqivalent of an 'svn revert' on a single file, on a 
directory of files, or on all files ?

I found 'git reset --hard HEAD' but it seems like a hammer to crack open a 
nut.

Many thanks in advance,

Aaron

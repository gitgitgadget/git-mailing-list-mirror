From: "Guilhem Bonnefille" <guilhem.bonnefille@gmail.com>
Subject: Exporting a git repository via FTP
Date: Wed, 14 Feb 2007 14:36:20 +0100
Message-ID: <8b65902a0702140536v4a1cb1d0u3d3549e542aade2@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Feb 14 14:36:26 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HHKJ7-0003zn-Gp
	for gcvg-git@gmane.org; Wed, 14 Feb 2007 14:36:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932276AbXBNNgW (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 14 Feb 2007 08:36:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932279AbXBNNgW
	(ORCPT <rfc822;git-outgoing>); Wed, 14 Feb 2007 08:36:22 -0500
Received: from wx-out-0506.google.com ([66.249.82.229]:17767 "EHLO
	wx-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932276AbXBNNgV (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Feb 2007 08:36:21 -0500
Received: by wx-out-0506.google.com with SMTP id h31so206697wxd
        for <git@vger.kernel.org>; Wed, 14 Feb 2007 05:36:21 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=qajFuDRtgUztv5b9XSFxGpK5j+aOTwLvv8fcJ7uqYf0Dudefw6UP03YP9FkfxrUu7XGPnzeFlAgZEdu5bMuMTYFXpv41wCvOj6v1h0G/44sGwrwahSO4M9fRNZTIv4PJBSuRyhNN+npsWZU/s2mXQ+h1P1sjDx+q4q7MLWnaxxc=
Received: by 10.90.55.19 with SMTP id d19mr560118aga.1171460181017;
        Wed, 14 Feb 2007 05:36:21 -0800 (PST)
Received: by 10.90.51.16 with HTTP; Wed, 14 Feb 2007 05:36:20 -0800 (PST)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/39643>

Hi,

I'm currently looking for the _simplest_ way to share a Git repo on my
HomePage (offered by my ISP). My configuration is:
- a raw HTTP server (no way to have any WebDav features);
- a simple FTP for upload.

Following the documentation, I first used a local directory mirrored
on the server (with the sitecopy tool). It worked, but needs disk
space (and is not funny :-))

So, I tried a direct git-push over ftp URL (as Curl knows FTP download
and upload). But it failed because FTP is not supported in push
operations.

So, I tried curlftpfs: setting up a local mount point connected to my
remote directory. It worked... sometimes. But it freeze really often.


So... I ask the Git community :-)
Is there any hope to see a git-ftp-push command one day? Reading the
http-push.c file, it seems that the most problematic part is that FTP
does not allow LOCKs. But, in my case, LOCKs are not necessary as I'm
the only one user to update my remote repo. No chance for conflicting
updates.
Anybody working on such thing?
-- 
Guilhem BONNEFILLE
-=- #UIN: 15146515 JID: guyou@im.apinc.org MSN: guilhem_bonnefille@hotmail.com
-=- mailto:guilhem.bonnefille@gmail.com
-=- http://nathguil.free.fr/

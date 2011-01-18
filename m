From: Mathieu Malaterre <mathieu.malaterre@gmail.com>
Subject: git submodule vs git mergetool
Date: Tue, 18 Jan 2011 10:04:01 +0100
Message-ID: <AANLkTi=jS1LQY0kfSD_=o0PZ9BAF7k=06QFT+agkvGNa@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jan 18 10:11:32 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pf7b9-0003zb-O9
	for gcvg-git-2@lo.gmane.org; Tue, 18 Jan 2011 10:11:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752740Ab1ARJLZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Jan 2011 04:11:25 -0500
Received: from mail-qy0-f181.google.com ([209.85.216.181]:58930 "EHLO
	mail-qy0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751433Ab1ARJLY (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Jan 2011 04:11:24 -0500
Received: by qyk12 with SMTP id 12so6756856qyk.19
        for <git@vger.kernel.org>; Tue, 18 Jan 2011 01:11:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:from:date:message-id:subject:to
         :content-type;
        bh=Y1HroHDV++3/WZt3ECFyQfQDfz1TMRD2N0luN5n8lnI=;
        b=dtSFnVOQfnLMB+ZfxjdnGsOd9h37COc9ahb+MTOAt6o7dy3rDhA275naEGV4gE++3r
         57bfEAzfGPjsSqthEfu7dYYrWNCYmbUED0AImAE0NXYWz62PDdaHMCGiy2Z5lO6YFoVH
         2GWT5CdrvZMKRJm1O96RozDAf1CNURxFSY1XI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:from:date:message-id:subject:to:content-type;
        b=RoIJO1fQIu5kV5I4doKk0dAokIoDmEqzy9/hqhvkZG8BsAsoaNxrcuASA1T/kBRmp2
         zbUcWzN7bluSkLE4I35ImJ2Sqv6cxbZoUQiq6p0mZFLdcK0NaiNaoPSkEnQk72fISBvL
         Y7kQfc+lKdEzR+VQEaq/6yPRHEGl8pfPNMbNc=
Received: by 10.224.20.17 with SMTP id d17mr4895629qab.371.1295341882984; Tue,
 18 Jan 2011 01:11:22 -0800 (PST)
Received: by 10.90.54.18 with HTTP; Tue, 18 Jan 2011 01:04:01 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/165196>

Hi there,

  not sure if this is the right place to report a problem. anyway I
have two branches (release and master) each one has a Testing/Data
submodule:

git submodule add git://gdcm.git.sourceforge.net/gitroot/gdcm/gdcmData
Testing/Data

  During a merge those two submodules produced a conflict:


$ git mergetool
merge tool candidates: meld opendiff kdiff3 tkdiff xxdiff
tortoisemerge gvimdiff diffuse ecmerge p4merge araxis emerge vimdiff
Merging the files: Testing/Data

mv: cannot stat `Testing/Data': No such file or directory
cp: cannot stat `./Testing/Data.BACKUP.5251': No such file or directory
error: git checkout-index: cannot create temporary subproject
error: git checkout-index: cannot create temporary subproject
Normal merge conflict for 'Testing/Data':
  {local}: created
  {remote}: created
Hit return to start merge resolution tool (gvimdiff):
3 files to edit
Testing/Data seems unchanged.
Was the merge successful? [y/n] y
fatal: unable to stat 'Testing/Data': No such file or directory

I guess this is a minor issue, but I thought I should report it here.

Thanks for this tool !
-- 
Mathieu

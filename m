From: "Weiwei Shu" <shuww1980@gmail.com>
Subject: how to configure Git to treat certain type of ascii files as binary files
Date: Wed, 22 Oct 2008 16:58:28 -0500
Message-ID: <65d12cb10810221458j14ef0009u679cdb0f73299d7f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Oct 22 23:59:44 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ksljy-0008Op-LD
	for gcvg-git-2@gmane.org; Wed, 22 Oct 2008 23:59:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753633AbYJVV6a (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 22 Oct 2008 17:58:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753075AbYJVV6a
	(ORCPT <rfc822;git-outgoing>); Wed, 22 Oct 2008 17:58:30 -0400
Received: from wa-out-1112.google.com ([209.85.146.183]:25980 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752432AbYJVV63 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 Oct 2008 17:58:29 -0400
Received: by wa-out-1112.google.com with SMTP id v27so8201wah.21
        for <git@vger.kernel.org>; Wed, 22 Oct 2008 14:58:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:mime-version:content-type:content-transfer-encoding
         :content-disposition;
        bh=vA2CTNf659SY////C+KgadP2bcIa8wyvf6lhDprDtlM=;
        b=MIgObR2sUgCbx14Lvx5GCMnIsQBOkcAeivQ5Ba+YeQetRafTa5Am0ZEBk0lkRzV+ez
         jBb0bBGABoEq2CM3gR2DAsDv0wGG2Y/n/43mt4Fp+uviFh3LSkYntCv5wzceLD+6yNJf
         abcQTEi0e9I1Ti5D+8nPS5YvWFIH4ViTdgQNg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:mime-version:content-type
         :content-transfer-encoding:content-disposition;
        b=LIUMrLZaIQPlUqaaRB26HlCMtkDEulCjYzdUTF+qHnpknXmPexu0Yq8wZaBl8M5qLr
         SFOx9djVthD/h7TJlLzKOvVlGIB4n+0YrpqskFsWkXtDRrJbMML7dP6D7lrw0w5gOfAO
         70CV11tq6VFBWAWkhst0hGv94WgYDexaapNR0=
Received: by 10.114.195.19 with SMTP id s19mr8099273waf.54.1224712708158;
        Wed, 22 Oct 2008 14:58:28 -0700 (PDT)
Received: by 10.114.160.3 with HTTP; Wed, 22 Oct 2008 14:58:28 -0700 (PDT)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/98918>

Hello everyone,

My first post in this mailing list. Could some one direct me to some
document/manual pages to setup Git to treat ascii files as binary
files? I'm using Git to do circuit schematics (SPICE files)
versioning. I will not do any merging or editing stuff with external
editors. The only way to change it is to use schematic capture GUIs
(Cadence, ADS, etc). So I'd like to treat them as binary files to
reduce the possibilities of messing them up.

I know it seems a little bit stupid to use Git to do such an easy job.
But hey, it's the most eye-catching SCM software, isn't it?



-- 
Weiwei
--Hope Springs Eternal.

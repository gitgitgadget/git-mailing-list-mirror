From: "Peter Teoh" <htmldeveloper@gmail.com>
Subject: error: non-monotonic index
Date: Mon, 3 Nov 2008 10:32:44 +0800
Message-ID: <804dabb00811021832k28276bf7ke0146a8bbd648574@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Nov 03 03:35:16 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KwpHg-0007H3-6V
	for gcvg-git-2@gmane.org; Mon, 03 Nov 2008 03:35:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754124AbYKCCcs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 2 Nov 2008 21:32:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754093AbYKCCcs
	(ORCPT <rfc822;git-outgoing>); Sun, 2 Nov 2008 21:32:48 -0500
Received: from fg-out-1718.google.com ([72.14.220.152]:24121 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754095AbYKCCcr (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 2 Nov 2008 21:32:47 -0500
Received: by fg-out-1718.google.com with SMTP id 19so2012326fgg.17
        for <git@vger.kernel.org>; Sun, 02 Nov 2008 18:32:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:mime-version:content-type:content-transfer-encoding
         :content-disposition;
        bh=NYdgynGYqmkW4FkDDcKPgfHRaPxaBgas5YywjgGrsFU=;
        b=bsJFJl/v6OSo3XFlRbO5UH7xJWFHD2WcDzur0rtqh7p6YZUkAhROdk1DgAm1iesqZU
         BbC6hMjNI9gw6fbHgMdVpwOIckcEHNnYYapx9yQuvBke3jL4SxJRCEvmcpvo2givCsjs
         uY7/wzV8RM7vpKF0Bgz5tn9ZFmdWIYel/eyJw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:mime-version:content-type
         :content-transfer-encoding:content-disposition;
        b=xlOIwdA/pxNrkFQLvOY1cp7fzC33Fc3s+qm0nDjaZU3kcfopWv59uJiQetkHoonKAv
         FlbB2/Wm1rLvJrspnDzF/Dbqg7E00zKjdXdacNv7KcEeEDQOr0oPpsn3GeaSuaSLLwbr
         osrqibq+FudjCx3LntQmMSpjbAJRzgh1Fd7G8=
Received: by 10.181.151.19 with SMTP id d19mr1699589bko.173.1225679564686;
        Sun, 02 Nov 2008 18:32:44 -0800 (PST)
Received: by 10.180.228.4 with HTTP; Sun, 2 Nov 2008 18:32:44 -0800 (PST)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/99896>

I git pull and got errors, then git repack and pull again......the
error increased....what happened?



/hdc1/download/2.6/linux26-acer>git pull
remote: Counting objects: 3959, done.
remote: Compressing objects: 100% (668/668), done.
remote: Total 2422 (delta 1934), reused 2154 (delta 1702)
Receiving objects: 100% (2422/2422), 409.97 KiB | 8 KiB/s, done.
Resolving deltas: 100% (1934/1934), completed with 757 local objects.
From git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux-2.6
   e946217..45beca0  master     -> origin/master
 * [new tag]         v2.6.28-rc3 -> v2.6.28-rc3
error: non-monotonic index
error: non-monotonic index
error: non-monotonic index
fatal: Needed a single revision
45beca08dd8b6d6a65c5ffd730af2eac7a2c7a03 - not something we can merge
/hdc1/download/2.6/linux26-acer>git repack
Counting objects: 9, done.
Compressing objects: 100% (9/9), done.
Writing objects: 100% (9/9), done.
Total 9 (delta 0), reused 0 (delta 0)
/hdc1/download/2.6/linux26-acer>git pull
error: non-monotonic index
error: non-monotonic index
error: non-monotonic index
error: non-monotonic index
error: non-monotonic index
error: non-monotonic index
fatal: Needed a single revision
45beca08dd8b6d6a65c5ffd730af2eac7a2c7a03 - not something we can merge


-- 
Regards,
Peter Teoh

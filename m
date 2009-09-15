From: Martin Larsson <martin.liste.larsson@gmail.com>
Subject: Re: Question about git-svn
Date: Tue, 15 Sep 2009 13:49:16 +0200
Message-ID: <1253015356.6509.52.camel@martin>
References: <b4abed330908310601h197f8909h8f626e918f8e5090@mail.gmail.com>
	 <20090905060940.GB22272@dcvr.yhbt.net>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Eric Wong <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Tue Sep 15 13:49:27 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MnWXG-0004kL-9L
	for gcvg-git-2@lo.gmane.org; Tue, 15 Sep 2009 13:49:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753248AbZIOLtS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Sep 2009 07:49:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753235AbZIOLtR
	(ORCPT <rfc822;git-outgoing>); Tue, 15 Sep 2009 07:49:17 -0400
Received: from mail-ew0-f206.google.com ([209.85.219.206]:42700 "EHLO
	mail-ew0-f206.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753202AbZIOLtQ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Sep 2009 07:49:16 -0400
Received: by ewy2 with SMTP id 2so370267ewy.17
        for <git@vger.kernel.org>; Tue, 15 Sep 2009 04:49:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:subject:from:to:cc
         :in-reply-to:references:content-type:date:message-id:mime-version
         :x-mailer:content-transfer-encoding;
        bh=EQWnO8vI5hNbTzNWfPupH1ERbKaTTuT/CNCpGmj7Sto=;
        b=Ec/4gtOBUB2MKm3ypOkzMvk9KVujzZIDyOTKW+yOsabas7dMu90g77vdeFP/NWiMWH
         fEiwUUv9y1syh6P9WR+6BZXvhYrxh0u9cgDmRl/9yfexVFc1wfaUhHmvF1eGwSaR6luY
         W4smvmLA4gYCc9G01uyt98C68VNEcliH8EFiI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=subject:from:to:cc:in-reply-to:references:content-type:date
         :message-id:mime-version:x-mailer:content-transfer-encoding;
        b=ZOvlAN8EqwNZYpAChFtnsJDIPddcjnKCw4mL4aFfPlAoXQ4cwhlp4GjihqmFw7gKLU
         A+lhAQ8Szd7gZtZyq2gB6PlhYX2U8tv6GGugaTDdx7aRkIiLUkRIhneEpfboRandKz0B
         h0G2tNG3F7XW4FhsH3wgTZCGKWrz2adEGwZLc=
Received: by 10.211.132.3 with SMTP id j3mr3585410ebn.81.1253015358869;
        Tue, 15 Sep 2009 04:49:18 -0700 (PDT)
Received: from ?172.16.10.145? ([82.134.20.254])
        by mx.google.com with ESMTPS id 5sm5682960eyh.27.2009.09.15.04.49.17
        (version=SSLv3 cipher=RC4-MD5);
        Tue, 15 Sep 2009 04:49:17 -0700 (PDT)
In-Reply-To: <20090905060940.GB22272@dcvr.yhbt.net>
X-Mailer: Evolution 2.26.1 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/128530>

On Fri, 2009-09-04 at 23:09 -0700, Eric Wong wrote:
> martin liste larsson <martin.liste.larsson@gmail.com> wrote:
> > I have a problem using git-svn. Is this the right place to ask then?
> 
> Hi, Yes, feel free to Cc me directly as well.

Sorry for the long delay, your answer seemed to get lost in the
flood... :*)


> Just checking the obvious, you are running "git svn fetch", right?

It seemed the download terminated, for some reason. Running "git svn
fetch" again allowed it to continue. After a couple of days and
attempts, everything got downloaded. But it would be helpful if git told
me it had failed. As it was now, the end of a failed run looked like
this (a random selection):
...
r495 = da7253aa4d2af7d3349b36d917573e948ccd2828 (tags/DelfiRaadgiver-2.6.0-b9@1352)
        A       Kildekode/Script.deploy/deploy_all_webapps_utv.cmd
r496 = 28e21ba0098d7f7ae74f134af42fe8dc92718f56 (tags/DelfiRaadgiver-2.6.0-b9@1352)
        M       Kildekode/Database/data/kundespesifikk/fanasb/data_dr_aktivaklasser.sql
r497 = 58543e617e27bb7960e0b64ab2419edd90b5c56e (tags/DelfiRaadgiver-2.6.0-b9@1352)
        M       Kildekode/Moduler/DRBasis/src/java/no/delfidata/raad2/jdbo/func/RaadJDBOOpsImpl.java
r498 = e882fe24795addf8cecdeea9dcb82f1a49697e40 (tags/DelfiRaadgiver-2.6.0-b9@1352)
        M       Kildekode/Database/data/kundespesifikk/fanasb/data_ds_user.sql
r499 = e8f6b1350d2d6fcd7fe786f1aa4837e1f61cf8b3 (tags/DelfiRaadgiver-2.6.0-b9@1352)
        M       Kildekode/Database/dokumentasjon/raad_db_1_1.PDM
r500 = cd273927d38ed673c2ec895f641f322dc8818f9a (tags/DelfiRaadgiver-2.6.0-b9@1352)
Auto packing your repository for optimum performance. You may also
run "git gc" manually. See "git help gc" for more information.
Counting objects: 36, done.
Compressing objects: 100% (34/34), done.
Writing objects: 100% (36/36), done.
Total 36 (delta 10), reused 0 (delta 0)
Removing duplicate objects: 100% (256/256), done.
        M       Kildekode/Database/data/kundespesifikk/handelsbanken/data_ds_user.sql
r501 = 27fc97c162b9cf440ce8a5f6e8dea10354324309 (tags/DelfiRaadgiver-2.6.0-b9@1352)
        M       Kildekode/Database/data/kundespesifikk/sbm/data_dr_aktivaklasser.sql
r502 = 19d5cf2da05f7b92cb134c6ae83f6ffc5f3cde08 (tags/DelfiRaadgiver-2.6.0-b9@1352)
        M       Kildekode/Database/data/kundespesifikk/sbsoer/data_dr_aktivaklasser.sql
        M       Kildekode/Database/data/kundespesifikk/sbsoer/data_dr_aktivaklasser.xls
r503 = f73d7bb66e7bfe6a05647da371be477bf43d36e5 (tags/DelfiRaadgiver-2.6.0-b9@1352)
        A       Kildekode/Database/data/kundespesifikk/sdc/data_ds_user.sql
r504 = 8fdf43287207b4029679e4e86c405eabd2be6596 (tags/DelfiRaadgiver-2.6.0-b9@1352)
        A       Kildekode/Script.deploy/build_all_webapps_utv.xml
        M       Kildekode/Script.deploy/deploy_all_webapps_utv.cmd
r505 = d7a31939c0aed653540b471c8f5e464870fca5b1 (tags/DelfiRaadgiver-2.6.0-b9@1352)
        M       Kildekode/Script.deploy/build_all_webapps_utv.xml
r506 = 4ff67d714dedeed065c359376b7d055d67a4c02b (tags/DelfiRaadgiver-2.6.0-b9@1352)
martin@martin:~/Arbeid/git-rpm$ 

There's no real indication that this failed. But "git branch -a" doesn't
list 'master'.

However, as I said, repeating "git svn fetch" until very tired, made it
finally work...

M.

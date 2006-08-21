From: "Torgil Svensson" <torgil.svensson@gmail.com>
Subject: stgit: deleting a branch doesn't seem to work
Date: Mon, 21 Aug 2006 19:27:02 +0200
Message-ID: <e7bda7770608211027m298ca361pdd78e164b9a524a5@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Mon Aug 21 19:27:22 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GFDYS-0001lj-AN
	for gcvg-git@gmane.org; Mon, 21 Aug 2006 19:27:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422726AbWHUR1M (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 21 Aug 2006 13:27:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965029AbWHUR1M
	(ORCPT <rfc822;git-outgoing>); Mon, 21 Aug 2006 13:27:12 -0400
Received: from nf-out-0910.google.com ([64.233.182.185]:36415 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S964990AbWHUR1K (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Aug 2006 13:27:10 -0400
Received: by nf-out-0910.google.com with SMTP id o25so1942405nfa
        for <git@vger.kernel.org>; Mon, 21 Aug 2006 10:27:02 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=tDydBT9DBrspKp233frb/MXmC5sDRwZQV+MdFJ9yHUbCNQhXRi5Piy12mzwjOkwlVBzNOMMxRut06+6UDiWnMGzRkIm/x6nL/hvNWBrXDzYRMrd3qDIsYy3XK7cGCiV3ml2/yZFA0OvD0j2GclovxIn7DZEakj5M8reEo06OMlo=
Received: by 10.49.43.2 with SMTP id v2mr7982831nfj;
        Mon, 21 Aug 2006 10:27:02 -0700 (PDT)
Received: by 10.49.26.9 with HTTP; Mon, 21 Aug 2006 10:27:02 -0700 (PDT)
To: git@vger.kernel.org
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/25805>

I have three branches and want my "gst10" to be "master" instead

$ stg branch --delete master
Deleting branch "master"... done
$ stg branch -l
Available branches:
  s     gst10   |
        master  |
>       origin  |
$ stg branch --delete master
Deleting branch "master"... done
$ stg branch -r gst10 master
stg branch: Branch "master" already exists

Is there something i'm missing in my logic?

//Torgil

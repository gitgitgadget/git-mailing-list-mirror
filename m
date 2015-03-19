From: Dmitry Neverov <dmitry.neverov@gmail.com>
Subject: submodule.$name.url is ignored during submodule update
Date: Thu, 19 Mar 2015 10:27:50 +0100
Message-ID: <CAC+L6n1RjvzcqX33VDvcM-4CpQPHeaddA7Dhs9S+ma+T+DN28Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Mar 19 10:28:02 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YYWkD-0007qp-2h
	for gcvg-git-2@plane.gmane.org; Thu, 19 Mar 2015 10:28:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753135AbbCSJ1y (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 Mar 2015 05:27:54 -0400
Received: from mail-wi0-f178.google.com ([209.85.212.178]:35000 "EHLO
	mail-wi0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751204AbbCSJ1v (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Mar 2015 05:27:51 -0400
Received: by wibdy8 with SMTP id dy8so112283793wib.0
        for <git@vger.kernel.org>; Thu, 19 Mar 2015 02:27:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:date:message-id:subject:from:to:content-type;
        bh=CMwxi4dOK0O+hIbP3b6yCSwiVyEGz/N++N2UeaedmZ8=;
        b=fEfmhCD6QdIMEhpvaHnsE2FefSd4mzhE4UuHRMS2mSRKtK0rtacMXziIAimoHu7i6a
         WltjYSksadq3vyRE4nwxtxZumc6OQEEr96X5JwSV5cGsldGZzVjeqLpzE8p2Ju1Pd6xr
         BO8TRffUzYc7wh4p/rPXpch//9qRD8pi7NmlOOPMkR41wjCxJYMEwtBZFZDiJdstxzQU
         df3UGkYvbCiuBvLkT58Se+GZ1ZmkZk0akq0DeSLpBA208m1XzMmWr932YD15UFY1ywjJ
         zylXYJNztefaqar8jF9hBcnLrr5n7pBJ99PBtuU/7BVPgAoJ9AkQzd485ANdw1Kx69p9
         IqvA==
X-Received: by 10.194.222.197 with SMTP id qo5mr147931580wjc.142.1426757270084;
 Thu, 19 Mar 2015 02:27:50 -0700 (PDT)
Received: by 10.194.106.34 with HTTP; Thu, 19 Mar 2015 02:27:50 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/265795>

Hi,

I've noticed that the 'submodule.$name.url' config parameter from the
main repository is ignored when a submodule needs to be updated, the
submodule's 'remote.origin.url' is used instead. Is there any way to
customize the submodule url for both the initial clone and for
updates?

--
Dmitry

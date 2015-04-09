From: "Kyle J. McKay" <mackyle@gmail.com>
Subject: Re: [PATCH 0/3] Make httpd tests run
Date: Thu, 9 Apr 2015 06:04:31 -0700
Message-ID: <3997B1B0-98C0-4408-B82E-85BBD78732FD@gmail.com>
References: <cover.1428505184.git.git@drmicha.warpmail.net>
Mime-Version: 1.0 (Apple Message framework v936)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Thu Apr 09 15:04:49 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YgC8T-0001AD-Pj
	for gcvg-git-2@plane.gmane.org; Thu, 09 Apr 2015 15:04:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755030AbbDINEg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 9 Apr 2015 09:04:36 -0400
Received: from mail-pa0-f43.google.com ([209.85.220.43]:35041 "EHLO
	mail-pa0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754947AbbDINEf (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 Apr 2015 09:04:35 -0400
Received: by pabtp1 with SMTP id tp1so43747618pab.2
        for <git@vger.kernel.org>; Thu, 09 Apr 2015 06:04:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:in-reply-to:subject:references:message-id:content-type
         :content-transfer-encoding:mime-version:date:cc;
        bh=RoM+bsjlshiT0NGUKKLHs/lIrK49Z59rxaF01Pu0v1I=;
        b=XKbNCPE7Rd4ow/P3mj4MA7S1ehc/JortbPvS5qPkHjeVFfPNElBXsrgcLZ/RsGnJpe
         PK8Im+BmlG/8yX3wrA5Z0GNnba9u+a7NnsCP473aoNqdc48gni29pPVQVf3cRh75vEuq
         68a1DQEjB7rQhwpQyp6v/YpMIEuFi78OGnnxQOa1349/yUT1ezL7kqMAvY+eNolA5OKB
         rR1EGBxqOwJkJl+Z8z125id+j8irG5nwdIU0qiruWhBTsiDPVR92emCeXcwOp5X0ALoI
         7NztTLJBI+L6/uLNkylXS9j1UctIsdgcnEUW8cdYMoGYRVOKtLYmwdVCzZ9iol88lKcv
         gBsg==
X-Received: by 10.70.136.202 with SMTP id qc10mr55126429pdb.117.1428584675325;
        Thu, 09 Apr 2015 06:04:35 -0700 (PDT)
Received: from ?IPv6:2002:48c0:ad8d::223:12ff:fe05:eebd? ([2002:48c0:ad8d:0:223:12ff:fe05:eebd])
        by mx.google.com with ESMTPSA id rb6sm14296294pbb.96.2015.04.09.06.04.33
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Thu, 09 Apr 2015 06:04:34 -0700 (PDT)
In-Reply-To: <cover.1428505184.git.git@drmicha.warpmail.net>
X-Mauler: Craptastic (2.936)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/266992>

On Apr 8, 2015, at 08:05, Michael J Gruber wrote:

> This series grew from an attempt at enlarging my personal test run  
> coverage
> on a standard Fedora 21 64bit box. Aka chain-lint fall-out.
>
> With 1/3, I get all httpd tests to run (when port is set, of course).
>
> 2/3 and 3/3 are an attempt at getting git-svn over http tests to run.
> 2/3 is certainly correct but not sufficient.
> 3/3 gets httpd to run but svn does not connect. This is WIP and RFH,
> and maybe requires rewriting lib-git-svn to use a config which depends
> on the apache version (like lib-hhtpd does), or to leverage lib-httpd.
>
> Michael J Gruber (3):
>  t/lib-httpd: load mod_unixd
>  t/lib-git-svn: check same httpd module dirs as lib-httpd
>  t/lib-git-svn: adjust config to apache 2.4

The changes in this series appear to break compatibility with Apache  
2.2.

Does that mean that Apache 2.2 is no longer supported for running  
these tests?

Or am I missing something here...

-Kyle

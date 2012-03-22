From: Hong Xu <xuhdev@gmail.com>
Subject: [BUG] git bash-completion is incorrect for "git pull origin mas<tab>"
 if the ssh key is encrypted
Date: Thu, 22 Mar 2012 14:04:42 +0800
Message-ID: <4F6AC0FA.7040708@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Mar 22 07:06:00 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SAb9r-0006fn-Mm
	for gcvg-git-2@plane.gmane.org; Thu, 22 Mar 2012 07:06:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932427Ab2CVGFc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 22 Mar 2012 02:05:32 -0400
Received: from mail-iy0-f174.google.com ([209.85.210.174]:35268 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932313Ab2CVGF2 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 Mar 2012 02:05:28 -0400
Received: by iagz16 with SMTP id z16so2661293iag.19
        for <git@vger.kernel.org>; Wed, 21 Mar 2012 23:05:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:subject
         :content-type:content-transfer-encoding;
        bh=/QvohZyPrbgsUsHI0REPJ8VDFmWDprG8FOYypeE1wfw=;
        b=LtkpYTzghbI9b7X9aqgOx4SAnoD61q7Rc3bla8Un41r6DpEjZbgP75RSMvzPlsXhAq
         Nla8OTogwIjx7C0GWWnenghw5S2QINYdkWJoC4HnuSw4vLm2gxEw6ZgJ3izloUlSsSJE
         A3sUltVhQqDodXxsTE6sJuRXg+wuOxiMc8mH+3SZJVS+pbcgAivBM04XH5Hff5PzHNGA
         idn5z3/VZxhnDr1zreub2B/IJIdUZNkHuCtO2hVJ2qOu28emnj+EVV9wjFCGxDl7bs5m
         NUnZ7CcBZQq2bC1yC724W1eKY88VDzkPMdwYS81fd6MntdU8ja5V71nKtcQBK43Nu3RR
         nr7g==
Received: by 10.50.219.194 with SMTP id pq2mr495512igc.18.1332396328248;
        Wed, 21 Mar 2012 23:05:28 -0700 (PDT)
Received: from [192.168.1.102] ([202.38.85.126])
        by mx.google.com with ESMTPS id gw10sm769877igb.5.2012.03.21.23.05.25
        (version=SSLv3 cipher=OTHER);
        Wed, 21 Mar 2012 23:05:27 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:11.0) Gecko/20120312 Thunderbird/11.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/193634>

Hello everyone,

If my ssh key is encrypted, "git pull origin mas<tab>" will give a 
unexpected result, something like this:

git pull origin masEnter passphrase for key '/home/user/.ssh/id_rsa':

I know maybe it is not possible to complete the "master", but maybe it 
is better to not complete anything than append something like that?

Thanks!

Hong

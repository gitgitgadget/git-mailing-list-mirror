Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2C5712103E
	for <e@80x24.org>; Tue,  5 Jul 2016 09:18:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754589AbcGEJSD (ORCPT <rfc822;e@80x24.org>);
	Tue, 5 Jul 2016 05:18:03 -0400
Received: from mail-oi0-f51.google.com ([209.85.218.51]:35945 "EHLO
	mail-oi0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751248AbcGEJSB (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 5 Jul 2016 05:18:01 -0400
Received: by mail-oi0-f51.google.com with SMTP id f189so221647197oig.3
        for <git@vger.kernel.org>; Tue, 05 Jul 2016 02:18:00 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:from:date:message-id:subject:to;
        bh=F8TktG/RQ+MdfV1e1NhnxPrtT+oTXSjAUQcXCQH+GIs=;
        b=RMfJMOHa4mxeAQqjVZ/56cyIwJUTWbiTJ8QI1R379SpcU65lu4AFq+okl7T9y4/zPq
         +FK+lDG+TdD11Uz+f0HSnNFvSF40h7ybwv6lZPLO4CEukJd3coEH4FZ/Q6e5NE/ZpA7z
         uQXwdz7UBsxyhV1j6ztK45lgtqAmHezQ+1/zFIgh9nE1q/AG72Gmmlb/BVPYG+zuGdk0
         vl6kQQG8b8Dvk4AAP2gcjMZkxlD90AqqbhACJ4OfTebu3u0JnV0xv/Mi4vIWbUGRy/At
         qz8c3QJjSBnPMvnrbfLSNBc9YDR/5ONqj930HzekRvnzHNTAknNZvdBM5Y1vi0y4ph8S
         wsQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=F8TktG/RQ+MdfV1e1NhnxPrtT+oTXSjAUQcXCQH+GIs=;
        b=IbL2kdFHYI4wJR86l7j+OUJ1dS6h8Foi3MK6XogNzbLNc+PrlGgLg/ee0x+XOlO6Q+
         LWkD4LWE7/AbiY7CCda+pe15qf6H+OBAfQBCbDJEjyV3FI36h+Dw5IkchDWi/KfoqkCm
         YiPUn05HV9mMBOEPfNRUkKkxZQkTrXn3frvOGOaioSmJBtFDGWL64QeLNAc4hTZLcd+5
         Rqe3v6/0lZgcimaTNdwXpVzH7RNa6b2p2MZKYhjAE/flOzwuLs9NZzcbwrqWQNOnDYwx
         7F7qRzXr1zZDmc1ZgqcZmPEL3/KZOhYTawKQtD+0Ej7N7DX0AV4+dfFDcMTWGcHpSawF
         Ghmw==
X-Gm-Message-State: ALyK8tKHiuZk6OW+LN0v8D4k9nB2q78yP8pnJ61iMqCvb3RTw7upefpSyraSJFB3pqATc7Wp8uDem4d/WVRunQ==
X-Received: by 10.157.27.103 with SMTP id l94mr9909284otl.54.1467710280200;
 Tue, 05 Jul 2016 02:18:00 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.157.22.241 with HTTP; Tue, 5 Jul 2016 02:17:59 -0700 (PDT)
From:	tarun patanwar <patanwar.tarun@gmail.com>
Date:	Tue, 5 Jul 2016 10:17:59 +0100
Message-ID: <CAKK2_6ezVLd4ZMa4ToKZYq1Ab0Y5w3VJqj_8-BsUCj8Gf8f+ig@mail.gmail.com>
Subject: GIT Integration with Siebel
To:	git@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Dear GIT Team,

We are trying to integrate GIT with Siebel 8.1 for source code
control. We are not able to progress further since there seems to be
no documentation available for the same.

Siebel provides a batch control file (srcctrl.bat) which can be
amended for Source Control Toll integration.

In the past we have used Microsoft VSS and SVN for source control,
Below is a example srcctrl.bat file for reference.

Any help on this will be greatly appreciated.

rem=======================================================
rem =============== User defined parameters ======================
rem ========================================================
set PATH=C:\Program Files\TortoiseSVN\bin;%PATH%
set SVN_URL=svn://svn_ip_address/svn_example
set SVN_REPOS=trunk
set SRC_USR=yourusername
set SRC_PSWD=yourpassword
set LOGFILE=D:\development\projects\svn_example\svn_integration.log
set WORKING_DIR=D:\development\projects\svn_example
rem LOGFILE SHOULD NOT HAVE SPACES IN ITS PATH
rem ================================================
rem ====================================================


Thanks,
Tarun Patanwar
+44-7778471437

From: Francis Moreau <francis.moro@gmail.com>
Subject: Adding "--ignore-submodules" switch to git-describe
Date: Fri, 1 Mar 2013 11:16:09 +0100
Message-ID: <CAC9WiBjHEoX154Y2q1NxEB1my78Gqf__+v-KR5jNVqT-MN9ZaQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Mar 01 11:16:37 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UBN12-000287-4c
	for gcvg-git-2@plane.gmane.org; Fri, 01 Mar 2013 11:16:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751371Ab3CAKQL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 1 Mar 2013 05:16:11 -0500
Received: from mail-vc0-f175.google.com ([209.85.220.175]:63117 "EHLO
	mail-vc0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751253Ab3CAKQK (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 1 Mar 2013 05:16:10 -0500
Received: by mail-vc0-f175.google.com with SMTP id p1so1259364vcq.6
        for <git@vger.kernel.org>; Fri, 01 Mar 2013 02:16:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:date:message-id:subject:from:to
         :content-type;
        bh=jrPkGOfPfEjPuSTfYB/NndcaXAA6ix+dp82Vz8N6aoA=;
        b=quroKz+uByiVvdjxBtm6PkP8BsvvVAjvTOicqBRfx3tfHjBCAVbiDEt3zj7kSViIda
         sbY4xjOaCVkDhZbMSxUCbu/C/FuER6KvQ4ae1cYsE0AcemY+afscdgDZpz9nelQOuX0i
         BKX+y2XSQvZbMbSYa/iubPtkerDv3fTSvemGo7cC+BbwWH413u8RH68nTriZeMDbZLlz
         EdE5BmuvvEdFrJWrSrvSLtqNzIhqkbEdzXWF1EsEJvoMUXAPs4x+hZRHrw5Lx3h1bFNn
         /Dv7dJnYrxB2t5SOAlMBWhRS7iL2YBe0h/PdqmE3gEIKQY7l10NtRgxdh/7nzFHBWa+y
         Ug7Q==
X-Received: by 10.52.90.39 with SMTP id bt7mr3265583vdb.110.1362132969326;
 Fri, 01 Mar 2013 02:16:09 -0800 (PST)
Received: by 10.59.3.229 with HTTP; Fri, 1 Mar 2013 02:16:09 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/217268>

Hello,

Would it make sense to add the option --ignore-submodules (currently
available in git-status) to git-describe when the later is used with
--dirty option ?

Thanks
-- 
Francis

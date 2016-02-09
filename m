From: Stefan Beller <sbeller@google.com>
Subject: Re: COPYING tabs vs whitespaces
Date: Tue, 9 Feb 2016 10:40:01 -0800
Message-ID: <CAGZ79kYaGDBunX8fFiEq0dD0Rq6vjZ3ttMnLZUmy3c7DhgfkOw@mail.gmail.com>
References: <56B32BDA.4010909@redhat.com>
	<xmqqsi18i8xv.fsf@gitster.mtv.corp.google.com>
	<56B85ECE.4020607@redhat.com>
	<xmqqfux39kmz.fsf@gitster.mtv.corp.google.com>
	<56B91299.9060001@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Petr Stodulka <pstodulk@redhat.com>
X-From: git-owner@vger.kernel.org Tue Feb 09 19:40:09 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aTDCr-0001qF-2P
	for gcvg-git-2@plane.gmane.org; Tue, 09 Feb 2016 19:40:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755364AbcBISkE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Feb 2016 13:40:04 -0500
Received: from mail-io0-f180.google.com ([209.85.223.180]:35165 "EHLO
	mail-io0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753259AbcBISkC (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Feb 2016 13:40:02 -0500
Received: by mail-io0-f180.google.com with SMTP id d63so26723581ioj.2
        for <git@vger.kernel.org>; Tue, 09 Feb 2016 10:40:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=AZM38IZNxgRg1SwiHlcPgqzqFRBUSOG+63CmBzfco34=;
        b=E4gNwvZ1xvpUSYz6zXJtQ6xsjSMlYaTE06Jlpz0Ka+nqzAnW5FA4/Gw9QqWPmrj4ey
         20qGUDfe1qn+/KdA2N5+R8JVpuR57ncHK6PMmRWr21OsyNjyprRLq0agLAQxftX2Zwlo
         qQQmNOZQx0M+7sMpY21PYtLNc0RmNmqvPPvZqN8vNQM57zhSZdRGEU8liUVzQa5VtcX7
         fVfBAaIrlyyq84oeIXVfL864acuIb1aUECTCzEl0pmi+37xEYQzbQ5UqlxrQk9ewLdYB
         OsD99UEGmzs5TuSJrtP6ivsejsdZGiDTX+Nxx73ZHgyKw5AB2RpetjScToPfhBf3NqoY
         alPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=AZM38IZNxgRg1SwiHlcPgqzqFRBUSOG+63CmBzfco34=;
        b=ikMYljWZbX+GRPW7iucSJEsSRmRpG37UdrwLQFcmy61wh5t5l6QgLD7z2Z632WT1AB
         nmRZeVHMg31qjvP5mZNNqxDPOSyAswPlVStojjG40jBdM/tRxCbFCBfXiLU+x+83cRYg
         Fg7b/ZBtcIIWjR8J6iEsVjKCGpgvQiT1YERNL+3aYuLWXhKxhkTXxh46lSJxY5BYzGqv
         XHQ0nyGbZs+usgQ14EIJP5uiy8IrDL0rVi2qWVCBn7M5Cs9Hnt7B3Q9iWNdwIIezrMsg
         99iJ+oDKLNYNObAce5M6aI2A93Jtr3vX84biynVg7CH8Y+S3Ni+v2NvNuc5LPld7ce9i
         yEdQ==
X-Gm-Message-State: AG10YORj8o73vfGqMqal+vspaHFOlCbEQQy1mulBHQur0Cx20effQsNzTWWeKL7gVDnl8X4RCdWvVCN7iLj2R8JV
X-Received: by 10.107.168.149 with SMTP id e21mr34117971ioj.96.1455043201126;
 Tue, 09 Feb 2016 10:40:01 -0800 (PST)
Received: by 10.107.4.210 with HTTP; Tue, 9 Feb 2016 10:40:01 -0800 (PST)
In-Reply-To: <56B91299.9060001@redhat.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/285848>

As a reference for this discussion,
see c376d96 in git.git or e00bfcbf04 in linux.git
which deals with whitespaces in the developers certificate of origin.

Just send a patch, I'd say.

Thanks,
Stefan

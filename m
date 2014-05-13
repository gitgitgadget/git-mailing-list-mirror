From: =?ISO-8859-2?Q?=22=C1kos=2C_Tajti=22?= <akos.tajti@intland.com>
Subject: Returning error message from custom smart http server
Date: Tue, 13 May 2014 09:39:59 +0200
Message-ID: <5371CC4F.80602@intland.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-2;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 13 09:40:11 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wk7Jq-0003wG-3t
	for gcvg-git-2@plane.gmane.org; Tue, 13 May 2014 09:40:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754763AbaEMHkD convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 13 May 2014 03:40:03 -0400
Received: from mail-ee0-f51.google.com ([74.125.83.51]:50171 "EHLO
	mail-ee0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753191AbaEMHkC (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 May 2014 03:40:02 -0400
Received: by mail-ee0-f51.google.com with SMTP id e51so81441eek.10
        for <git@vger.kernel.org>; Tue, 13 May 2014 00:40:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:date:from:user-agent:mime-version:to
         :subject:content-type:content-transfer-encoding;
        bh=IfGUfprABrsLogzjg6we4dpfzV8wVMekgy5BFdbHq3s=;
        b=brHtKsTyfcp6qsifRAAa7B4QTSx43WFUZoXZSL4uGMvO94X21NiwdqFGvkMNpMPndl
         4hVSGFESBVrZJM2gg7AC8P3RmWVm6gCw9fS0Ockel6kY0aplxJf8dqEGQi/W40zl3cEF
         DZ9X8QYqK1AQEBsqVqaor6roO52O//kXevy+Ub11Bvy3PoD1g7/himm8f2401/j2JOpN
         +cZOuAm+yYZhSx61RjBo2Pk/fWjOHstlPBrovs9cenzm6uYg+0XE4HZ3Ym/gD/ij6+fx
         nPm+Gnb7kfverpnJ8SCUIJv2yuXhJA5lIAXN28F5kdfHFeJIy9QEyIolgrk7EtI+sSJN
         1FCg==
X-Gm-Message-State: ALoCoQkO3qltDrU7xsTyPtLAK+9yjXOWajYSPdfOAbyxh0YfyH/CEGr0yxg/ioqYum+RRmNhQKRI
X-Received: by 10.15.53.135 with SMTP id r7mr817565eew.102.1399966801108;
        Tue, 13 May 2014 00:40:01 -0700 (PDT)
Received: from [127.0.0.1] (78-131-51-79.pool.digikabel.hu. [78.131.51.79])
        by mx.google.com with ESMTPSA id u1sm38306512eex.31.2014.05.13.00.39.59
        for <git@vger.kernel.org>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Tue, 13 May 2014 00:40:00 -0700 (PDT)
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:24.0) Gecko/20100101 Thunderbird/24.5.0
X-Antivirus: avast! (VPS 140512-4, 2014.05.12), Outbound message
X-Antivirus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/248753>

Dear List,

we implemented our own git smart http server to be able to check=20
permissions and other thing before pushes. It works fine, however, the=20
error messages we generate on the server side are not displayed by the=20
command line client. On the server we generate error messages like this=
:

         response.setStatus(HttpServletResponse.SC_UNAUTHORIZED);
         response.getWriter().write(msg);

On the command line we get this:

Total 0 (delta 0), reused 0 (delta 0)
POST git-receive-pack (290 bytes)
efrror: RPC failed; result=3D22, HTTP code =3D 401
atal: The remote end hung up unexpectedly
fatal: The remote end hung up unexpectedly

The server message is completely missing. Is there a solution for this?

Thanks,
=C1kos Tajti


---
A lev=E9l v=EDrus, =E9s rosszindulat=FA k=F3d mentes, mert az avast! An=
tivirus v=E9delme ellen=F5rizte azt.
http://www.avast.com

From: Jan Engelhardt <jengelh@inai.de>
Subject: Re: inconsistent logs when displayed on screen / piped to a file
Date: Tue, 31 Jul 2012 10:08:55 +0200 (CEST)
Message-ID: <alpine.LNX.2.01.1207311008350.11095@frira.zrqbmnf.qr>
References: <CALBOmsYh5AgpRQe28yUcChqemQ7HFMHahesGj_MPwQXDF-EM=Q@mail.gmail.com> <50168E93.2090202@drmicha.warpmail.net> <CALBOmsage+Gx9=bkH0rX1SvViSbMUPUWuYoifjgEnsjw+0=osw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Michael J Gruber <git@drmicha.warpmail.net>, git@vger.kernel.org
To: Mojca Miklavec <mojca.miklavec.lists@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jul 31 10:09:25 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Sw7W9-0005Kv-Ce
	for gcvg-git-2@plane.gmane.org; Tue, 31 Jul 2012 10:09:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754498Ab2GaIJB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 31 Jul 2012 04:09:01 -0400
Received: from seven.medozas.de ([5.9.24.206]:59184 "EHLO seven.medozas.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753545Ab2GaII6 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 31 Jul 2012 04:08:58 -0400
Received: by seven.medozas.de (Postfix, from userid 25121)
	id E7E2D96A02C1; Tue, 31 Jul 2012 10:08:55 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by seven.medozas.de (Postfix) with ESMTP id 9F49696A02C0;
	Tue, 31 Jul 2012 10:08:55 +0200 (CEST)
In-Reply-To: <CALBOmsage+Gx9=bkH0rX1SvViSbMUPUWuYoifjgEnsjw+0=osw@mail.gmail.com>
User-Agent: Alpine 2.01 (LNX 1266 2009-07-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/202632>

On Monday 2012-07-30 16:58, Mojca Miklavec wrote:
>>
>> COLUMNS=YourNumber git log YourArgs > YourFile
>
>Wow, perfect, thank you very much. Setting COLUMNS=200 (the high
>number just in case) solved the problem.

200 ought to be enough for everybody? PATH_MAX is never enough...

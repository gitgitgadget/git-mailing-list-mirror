From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [RFC] Zit (v2): the git-based single file content tracker
Date: Sun, 26 Oct 2008 08:20:17 -0700 (PDT)
Message-ID: <m3k5bvgz83.fsf@localhost.localdomain>
References: <gdok16$vh2$1@ger.gmane.org> <gdqbta$rhe$1@ger.gmane.org>
	<m34p32i83f.fsf@localhost.localdomain>
	<cb7bb73a0810240401q57e40b9dj46c35f90681cfa3d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "Giuseppe Bilotta" <giuseppe.bilotta@gmail.com>
X-From: git-owner@vger.kernel.org Sun Oct 26 16:21:48 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ku7Qy-0001wN-8W
	for gcvg-git-2@gmane.org; Sun, 26 Oct 2008 16:21:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755168AbYJZPUX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 26 Oct 2008 11:20:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755132AbYJZPUX
	(ORCPT <rfc822;git-outgoing>); Sun, 26 Oct 2008 11:20:23 -0400
Received: from nf-out-0910.google.com ([64.233.182.190]:52599 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755075AbYJZPUV (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 26 Oct 2008 11:20:21 -0400
Received: by nf-out-0910.google.com with SMTP id d3so532135nfc.21
        for <git@vger.kernel.org>; Sun, 26 Oct 2008 08:20:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received
         :x-authentication-warning:to:cc:subject:references:from:in-reply-to
         :message-id:lines:user-agent:mime-version:content-type:date;
        bh=wZsX0d2K2H4/Vn7Gcyj6xr86tbBaDaf7xQcJbBmMjPg=;
        b=RQFPuRHPAElZgPf4vw9BVkOwSRNxUamuJYclISTB/ef0iHWnIToZ3aYP5gSaNqZP/z
         lMP2HbtIgntw1fYbnSVkV8HhGwvDmQ3LoerXKU+uQAAdoK2CgNik+LBvGICty2D932qq
         tczG/sLvVF16DZ+9BtSiQu1lWO5V2QgNBVSLo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:in-reply-to
         :message-id:lines:user-agent:mime-version:content-type:date;
        b=Nl2ZcBGQmSP1ESrUCgt5NouNk9k4oJWu7ILzhmf/CWj8E8XMDXFREpWkhr01SvJr2C
         JlMU066w937nH01DGr03GnavbohK7TbRsbyHw7lkrBE3Qrla/6DQKb/vLUWwWRO9O+tI
         JtdHy+heZ3cr8idG90pKyz29Z8mu3V5lS1IH8=
Received: by 10.210.57.12 with SMTP id f12mr5217112eba.199.1225034419568;
        Sun, 26 Oct 2008 08:20:19 -0700 (PDT)
Received: from localhost.localdomain (abxb216.neoplus.adsl.tpnet.pl [83.8.251.216])
        by mx.google.com with ESMTPS id 3sm4043186eyj.3.2008.10.26.08.20.16
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 26 Oct 2008 08:20:17 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id m9QFKFL5004636;
	Sun, 26 Oct 2008 16:20:15 +0100
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id m9QFKDJV004633;
	Sun, 26 Oct 2008 16:20:13 +0100
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <cb7bb73a0810240401q57e40b9dj46c35f90681cfa3d@mail.gmail.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/99167>

"Giuseppe Bilotta" <giuseppe.bilotta@gmail.com> writes:
> On Fri, Oct 24, 2008 at 12:43 PM, Jakub Narebski <jnareb@gmail.com> wrote:
>> Giuseppe Bilotta <giuseppe.bilotta@gmail.com> writes:
>>
>>> The reworked Zit ( git://git.oblomov.eu/zit ) works by creating
>>> .file.git/ to track file's history. .file.git/info/excludes is
>>> initialized to the very strong '*' pattern to ensure that things such
>>> as git status etc only consider the actually tracked file.
>> [...]
>>
>> Could you add it to Git Wiki page:
>>  http://git.or.cz/gitwiki/InterfacesFrontendsAndTools
>>
>> I think that the project is interesting enough to be added there
>> even if it is still in beta, or even alpha, stage.
> 
> Ah, good idea. Done, in Version Control Interface layers section

Thanks.

I have added link to repositoy, as you didn't configure your gitweb to
display those URL links (see gitweb/README and gitweb/INSTALL).

-- 
Jakub Narebski
Poland
ShadeHawk on #git

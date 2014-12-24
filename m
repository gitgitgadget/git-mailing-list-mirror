From: Arup Rakshit <aruprakshit@rocketmail.com>
Subject: Upgrade Git in openSUSE13.1
Date: Thu, 25 Dec 2014 02:32:13 +0630
Organization: CognitiveClouds
Message-ID: <11649454.2G0koPIBX8@linux-wzza.site>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Dec 24 22:09:11 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Y3tB8-0004lx-5e
	for gcvg-git-2@plane.gmane.org; Wed, 24 Dec 2014 22:09:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751518AbaLXVDm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 24 Dec 2014 16:03:42 -0500
Received: from nm27.bullet.mail.sg3.yahoo.com ([106.10.151.22]:56797 "EHLO
	nm27.bullet.mail.sg3.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751483AbaLXVDl (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 24 Dec 2014 16:03:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rocketmail.com; s=s2048; t=1419455019; bh=vFBtAFAT+v37EiTmxvMtGqR6I/DwSK41P7vhNJj+2u0=; h=From:To:Subject:Date:From:Subject; b=s74BLVdje2nafzBHh9YkBCz+chZz7VazGRf2uZLJYFccqxMzQvc0yoi3tScaFes1EISeORLR8szJbLRvzCQrwxhyeBSlGtoranGNY43XT1/yWgRFMxYZ5YXqOtw7zYu7dtmaK3dHWHCJ5oyEJFwMDrrltW7F2fvuy32f7jS2aAEZ5+V3anypPmrOkYGip3AFfYAMIKigURrlVLGarEWC7r7GTUdO3hFn7Hfnp4bNIYVF6ssegVonFXyCc/aIc7uo28U3Rk7FzyJHKfD7+VUe/NI6RqoNYv7WlkMgOlYpH2+Q+s0suNZxcYGBHBjxyQDkMeg9fQgGQmdYXqKbW4j9Fg==
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws; s=s2048; d=rocketmail.com;
	b=kV0iKSDZhwKm+rlITiGEhuSnM8vhQAhGkEw1y6fyFvJK9xmZvu9QNi067n8fkjWCigwIswfhryzqNuaOyjvSZc07v0x/YX0WUOhRGtwrsq30twDNBaPCrP9lrvRP9WH1R1Z48J4dptg8qZ6eM+o/Be918EI4DaWzl94MCQFYcM1oxOVRR9sDvnc/tKpQVcP+k5wdQuudc3ISp76TWhs1VF1J8eyIs8mCaXaaNX3TJz3oUC/PAjDAPOrBSpVVlD9oQyk+AsmAgEHCrMDTH7cvnoRSXgs9GEFLQS4115l9SFL89kjYAgD0ilXw36u+mGZaOLF7ToU4/NVbbv4EECr4Sw==;
Received: from [106.10.166.120] by nm27.bullet.mail.sg3.yahoo.com with NNFMP; 24 Dec 2014 21:03:39 -0000
Received: from [106.10.167.160] by tm9.bullet.mail.sg3.yahoo.com with NNFMP; 24 Dec 2014 21:03:39 -0000
Received: from [127.0.0.1] by smtp133.mail.sg3.yahoo.com with NNFMP; 24 Dec 2014 21:03:39 -0000
X-Yahoo-Newman-Id: 562652.39385.bm@smtp133.mail.sg3.yahoo.com
X-Yahoo-Newman-Property: ymail-3
X-YMail-OSG: E8mKCMAVM1lBhrbin_SApy7KOv0SFmPKQw.HQkmiF5RWwGK
 GpqAodeEjuSfWAJv6jnb.90paV5GMwqx54sBeiO.QdizzYqHXg1a5nrnKTaP
 YvC7GdzlnHEZu_S3CFPfvsdzlGF5FMlSDiU.RPH3YFdgQ0.BsI804x2BZXQ_
 jLDQdPXrcZry_9PwmtgCVsJgAkwqDVgLf3YPGNXPMah9s6TsXbDdodQrG0ex
 bNrsnc8euf3FInPGBVAIrnnTI9X8a.hkaQupBgypS76iFKvC9Gf4iiGNFbgT
 KMD.4651H9Gk5a7023nzXosHhuUZJOO39Uzf8Xkj4BJcr9kZC22PfK4nWnQs
 eumWo5WKZkyuKillcxEamP1Jl.mPUEbvJvChyYYIgVikKFpf3wNVmSfPP4OM
 hHbND8o1fu24pUXs1VZGTnx.jyKvmZ.fsQ3GPM568HZfvf6GzUxB9MlqV5l4
 aTWJIfktGYFolzibLFPL9nsgXnMNufO18f9xOfUns6CDT3HSsEO3PaBi6dLK
 0yPZj3lGWhIRkB5.BeNh3.Vz1JzzdLiKOlvTdGcX5VVP86kscl.Ue2g6vpJq
 MiCI9xA0Psw5rC9JGIncru7xIf_vDfX10xGa7hhvw07hx42sH5_nwWAghN_d
 X3FKICCiD24F8bGtxvRk3_ZMW_4Rbs0BQj6yxlk1t6dZJubERvLmUvPerNow
 LOnTFY_5knTIAX5Ni9Vv4EJaNwCwv6Jzkm5i5peKqThQcuklS55rylyFQJxM
 AQRxq.rJOGLD2Fap0arVvFSIlskCVDgcItzRIf5jLe3QcOmc-
X-Yahoo-SMTP: _NAuC72swBDpdridK5c7mltfXc1K.nFhPY5jXEZ4Gfdya8Gn_0nN
User-Agent: KMail/4.11.5 (Linux/3.11.10-25-default; KDE/4.11.5; i686; ; )
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/261811>

Hi,

I am keep getting the below warning, whenever I am trying to deploy my code 
there :

[arup@to_do_app]$ heroku logs -t
Your version of git is 1.8.4.5. Which has serious security vulnerabilities.
More information here: 
https://blog.heroku.com/archives/2014/12/23/update_your_git_clients_on_windows_and_os_x
2014-12-21T17:58:49.605785+00:00 app[web.1]:    from 
/app/vendor/bundle/ruby/2.1.0/gems/dm-migrations-1.2.0/lib/dm-
migrations/adapters/dm-postgres-adapter.rb:60:in `ensure in without_notices'

I am also not seeing any upgrade here - 
http://software.opensuse.org/package/git

How to upgrade then ?

-- 
================
Regards,
Arup Rakshit
================
Debugging is twice as hard as writing the code in the first place. Therefore, 
if you write the code as cleverly as possible, you are, by definition, not 
smart enough to debug it.

--Brian Kernighan

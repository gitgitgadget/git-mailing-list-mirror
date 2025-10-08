Received: from secure.elehost.com (secure.elehost.com [185.209.179.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6BF81F462D
	for <git@vger.kernel.org>; Wed,  8 Oct 2025 17:27:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.209.179.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759944479; cv=none; b=ok4qzI2ogxmkhXGSd/OGL/napjsBqvnWGBVGjw5WexMsDadl6xfJFMPQ4yvPB9WfR7BCIe18FdQfaeMyNoyH3JGcQEgKKlvyyjl3C5ikaAbQHuRL/PmgnlAHx7b5uXDnOZDDqfJcqKsqzJ+Ro/7pbTATGpobuGDJHAfRQlKk9NM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759944479; c=relaxed/simple;
	bh=EoWxZwWYcwpWtpvluxSRf+tu3mJdZdRgZcU1DGkwbOI=;
	h=From:To:References:In-Reply-To:Subject:Date:Message-ID:
	 MIME-Version:Content-Type; b=uuFuwOJWoiEMbXnyO2t+s17lM3YFfNvc6WRahCbVIXTdNNZ1qtOzjwpcwu3L1fitc+ANnOFZZms4JKGRvdMiU/hrMUnKfD5fv6GXDtLvRfWGM2hn15VcgKjd5VmsnwUemaiMPY+x7ctcHoHRAvVqMwpsr3meL60HEiqpYchy6zE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nexbridge.com; spf=pass smtp.mailfrom=nexbridge.com; arc=none smtp.client-ip=185.209.179.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nexbridge.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nexbridge.com
X-Virus-Scanned: Debian amavisd-new at secure.elehost.com
Received: from Mazikeen (pool-99-228-67-183.cpe.net.cable.rogers.com [99.228.67.183])
	(authenticated bits=0)
	by secure.elehost.com (8.15.2/8.15.2/Debian-22ubuntu3) with ESMTPSA id 598HRrCI1687136
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 8 Oct 2025 17:27:54 GMT
Reply-To: <rsbecker@nexbridge.com>
From: <rsbecker@nexbridge.com>
To: "'Patton, Timothy'" <tpatton@crateandbarrel.com>, <git@vger.kernel.org>
References: <CAMnRnOWm8iV+JNcVReczh79pNX2zwsPcJm2z4a+8Uj3E1xcq5Q@mail.gmail.com>
In-Reply-To: <CAMnRnOWm8iV+JNcVReczh79pNX2zwsPcJm2z4a+8Uj3E1xcq5Q@mail.gmail.com>
Subject: RE: Jenkins Git Plugin
Date: Wed, 8 Oct 2025 13:27:48 -0400
Organization: Nexbridge Inc.
Message-ID: <01e701dc3878$e11c9510$a355bf30$@nexbridge.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQGrkqXoPTDhIpd5DX2lSkGDqOKi3bUZzAbQ
Content-Language: en-ca
X-Antivirus: Norton (VPS 251008-6, 10/8/2025), Outbound message
X-Antivirus-Status: Clean

On October 8, 2025 1:10 PM, Timothy Patton wrote:
>I recently started seeing the following in build console output when =
pulling global
>shared libraries from Git.  I need to see the change history part of =
the build being
>performed.  How can I restore the previous behavior of retrieving the =
changelog
>when the shared libraries are pulled from Git?
>
>Commit message: "updated getChangeset to include 5 history entries"
> > D:\git\bin\git.exe rev-list --no-walk
>d30fad4563120956426e48bdfe1cbdb450bf932d # timeout=3D10 'git =
whatchanged'
>is nominated for removal.
>If you still use this command, please add an extra option, =
'--i-still-use-this', on the
>command line and let us know you still use it by sending an e-mail to
><git@vger.kernel.org>.  Thanks.
>fatal: refusing to run without --i-still-use-this
>ERROR: Unable to retrieve changeset
>hudson.plugins.git.GitException: Error: D:\git\bin\git.exe whatchanged =
--no-abbrev
>-M "--format=3Dcommit %H%ntree %T%nparent %P%nauthor %aN <%aE>
>%ai%ncommitter %cN <%cE> %ci%n%n%w(0,4,4)%B" -n 1024

Please contact the Jenkins GitSCM support group and ask them to fix the =
plugin to
use git log instead of git whatchanged.

--Randall


Received: from secure.elehost.com (secure.elehost.com [185.209.179.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4997541C69
	for <git@vger.kernel.org>; Mon, 13 May 2024 19:09:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.209.179.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715627363; cv=none; b=aCAQHCNQEVUzPro+C/XJ08y04cmXzbnAKVOxL1LS0HxiDm/nES1MFLGRKOIanZDuAKpKoBzpM12cj05jtL0W9HffHl0iRfQb59CTVAy6Et85GFm0gPOvcCIJpKmKzAPYdiZfUl9fO3H0dhBvkNbAWeQlKhp68ycHO2GB0kvX+84=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715627363; c=relaxed/simple;
	bh=kW/MNmTJ8CITiF5gsOc44pYNMyDI7xw4LjZRce6ns8A=;
	h=From:To:Cc:References:In-Reply-To:Subject:Date:Message-ID:
	 MIME-Version:Content-Type; b=gcdvJfDm7QeXjRmaQ1ThQmSORFDU0gc5KsbHTfUKJ1Kt2dmMyeMMoybMjSzrbMx6/K5zaOox6WRHxhn25OR66bXX/SimiF59hFoymbvDkdNf5ClHtalfprZv3TqHsfLs5W8cV0YU/fuMqCk4g81cZrj6S9Vh/h5m6HIyRzgFd4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nexbridge.com; spf=pass smtp.mailfrom=nexbridge.com; arc=none smtp.client-ip=185.209.179.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nexbridge.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nexbridge.com
X-Virus-Scanned: Debian amavisd-new at secure.elehost.com
Received: from Mazikeen (pool-99-228-12-196.cpe.net.cable.rogers.com [99.228.12.196])
	(authenticated bits=0)
	by secure.elehost.com (8.15.2/8.15.2/Debian-22ubuntu3) with ESMTPSA id 44DJ9DN74160964
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 13 May 2024 19:09:13 GMT
Reply-To: <rsbecker@nexbridge.com>
From: <rsbecker@nexbridge.com>
To: "'Sean Allred'" <allred.sean@gmail.com>, <lbdyck@gmail.com>
Cc: <git@vger.kernel.org>
References: <02f201daa547$503df630$f0b9e290$@gmail.com> <m0pltptx3h.fsf@epic96565.epic.com>
In-Reply-To: <m0pltptx3h.fsf@epic96565.epic.com>
Subject: RE: git client enhancement request
Date: Mon, 13 May 2024 15:09:07 -0400
Organization: Nexbridge Inc.
Message-ID: <019201daa569$0ae28f20$20a7ad60$@nexbridge.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQGAerfcO1waJyo8uA6nqAp40soFFQIOt0Dasjlml6A=
Content-Language: en-ca

On Monday, May 13, 2024 1:56 PM, Sean Allred wrote:
><lbdyck@gmail.com> writes:
>> I would like to see the option to allow the git client to request the
>> creation of a new empty git repository on the git server without
>> having to open the web interface to the git server to define a new
>> repository.
>>
>> Perhaps something like:  git server-repo public/private name
>
>Is this even technically feasible? My understanding is that storage =
implementations
>of each forge vary *wildly*. I don't believe this would be under Git's =
ability to
>implement as a project.
>
>You might look into combining your preferred forge's CLI with git
>aliases:
>
>  - GitHub has 'gh': https://cli.github.com
>  - GitLab has 'glab' =
https://docs.gitlab.com/ee/editor_extensions/gitlab_cli
>
>so you could alias
>
>    git config alias.server-repo '!gh repo create'
>
>to get something of what you want.
>
>I believe GitLab also has a feature where you can create repositories =
just by pushing
>an existing repository to an empty project path.

Please have a look at the github/bitbucket/gitlab/azuregit REST API for =
doing what you are trying to do. There is no specific "git client" =
function as git is symmetrical.
--Randall


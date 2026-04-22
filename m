Received: from www610.your-server.de (www610.your-server.de [162.55.254.207])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D055317A300
	for <git@vger.kernel.org>; Wed, 22 Apr 2026 18:48:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.55.254.207
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776883712; cv=none; b=I95ArH0N09ZrF1XrscsLl/tF8+7gqK7U2gBLiQLz6ZwIq6a1B5IHbNi5bt+yDmV7UAseaa1G7wTfwhwxXnBfCkM4DT7oIlZL1tuVtOB98GW8+FqNRikOR5O/O7Seh3O7sI71m09k3EOLl3B5vmDowhzjkq+9rEVDWrgfHTO4wco=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776883712; c=relaxed/simple;
	bh=oUPIQIjlSsPDriJeQ9x+aLYxi8a8HA1QfY++Ixerpc4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=LqskY0cg927g/9xvQeJKaGarAMUo2oc6O+EANDTR3CC4AJx7YIPSFqZJHZNnauQ8OB6r7Axcq6rSmPBlQRKmhqwuevYZLKa/cZGr48lJgJcOJhM55vio/czRT0udE8jOJB16Z1/kTZlWNH1/3wv/gQelC8F4E6DbMW5z3PjgBCE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=beniamino.eu; spf=pass smtp.mailfrom=beniamino.eu; dkim=pass (2048-bit key) header.d=beniamino.eu header.i=@beniamino.eu header.b=MgpYWNjr; arc=none smtp.client-ip=162.55.254.207
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=beniamino.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=beniamino.eu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=beniamino.eu header.i=@beniamino.eu header.b="MgpYWNjr"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=beniamino.eu; s=default2503; h=Content-Transfer-Encoding:MIME-Version:
	Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References;
	bh=Aood3phpqFS6Zy/NsnEHeWChDHKRTmv717YIoM7Q/gs=; b=MgpYWNjrb4FRGeOuk4Yr35C14V
	7fsFsmmdrsUyQdYuOs/DF1pXTFS/kaNW3nuwkBYCLN+tleqTKNWCzepIuR1XtTRPQD8ZVoW02xFcS
	/tdxaLi87XDnKIJo17niNvj4FYD+OcGbP4g8KD95iLk1TejUcY91huHvXBAd/LMZdaHcLBeS6IiDN
	F5JnVpdsXkFi90ueZkWkf8imuk/AFUlXDZP3f5hLLYtQoApRhqg4ifuRohCZG2mRiHBlMGBqVuLHH
	AxHQn9SbyzL/ZINWnCt8a98i5MpoSn9b12W2YlPTsoOFr76BQya6N/62TE8GJoRM1XwxnCst6XRhy
	rD+6m40Q==;
Received: from sslproxy02.your-server.de ([78.47.166.47])
	by www610.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96.2)
	(envelope-from <m.beniamino@beniamino.eu>)
	id 1wFcGE-000GJq-1n;
	Wed, 22 Apr 2026 20:25:18 +0200
Received: from localhost ([127.0.0.1])
	by sslproxy02.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <m.beniamino@beniamino.eu>)
	id 1wFcGE-000BXm-0R;
	Wed, 22 Apr 2026 20:25:18 +0200
From: Matteo Beniamino <beniamino@beniamino.eu>
To: git@vger.kernel.org
Cc: Jiang Xin <worldhello.net@gmail.com>
Subject: Trivial fix in the italian translation
Date: Wed, 22 Apr 2026 20:25:03 +0200
Message-ID: <20260422182516.26667-1-beniamino@beniamino.eu>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: Clear (ClamAV 1.4.3/27979/Wed Apr 22 08:26:01 2026)


This is the current output of `git branch -h`:

$ git branch -h
uso: git branch [<opzioni>] [-r | -a] [--merged] [--no-merged]
  oppure: git branch [<options>] [-f] [--recurse-submodules] <branch-name> [<start-point>]
  oppure: git branch [<options>] [-l] [<pattern>...]
  oppure: git branch [<opzioni>] [-r] (-d | -D) <nome branch>...
  oppure: git branch [<opzioni>] (-m | -M) [<vecchio branch>] <nuovo branch>
  oppure: git branch [<opzioni>] (-c | -C) [<vecchio branch>] <nuovo branch>
  oppure: git branch [<opzioni>] [-r | -a] [--points-at]
  oppure: git branch [<opzioni>] [-r | -a] [--format]
[...]

As you can see `uso:` (`usage:`) and `oppure:` (`or:`) are misaligned. As
commented in the .po the colon of `oppure:` should be aligned with the
one of `usage:`. In the following patch I've substituted `oppure` with
`o` (they're interchangable, and IMHO in the terminal every column
counts) and I've aligned the colons in the two strings.

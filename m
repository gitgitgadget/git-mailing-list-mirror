Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=44.202.169.36
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792552554;
	b=MrxxheQF61f+XbDK2jsHaJu1JFKhV/fgaLtS8R9EdmGXcVu0EPbu/jblgTQ9Su/Y+TxJ
	 ZC2EJejmaCytfRyKirhO+9DckzlEkgTQCOHNQCrdOx0vp09MMgPCMgK/KP1VVIrhgQLXN
	 4B+5c/2GDN8/+AsaIs9Y7gdJKJp4j4Z+KxNbOoMUQTGld655x6e//+JnrHUAsv4f1iAF8
	 g4uq0dsOkSIfVA/m8v1mp30uy127Z3WVVQhH+/2iEw3ht4HhjTucdsKirIclKnskamYjK
	 dzXCC5avGdSsbVExy2jBtKe3h7DEEdYmqbHGbFgbZlur5xDOrfCjydT9efyq+LM6Yfw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792552554;
	h=DMARC-Filter:Received:Received:X-Authority-Analysis:Received:
	 X-Gm-Message-State:X-Received:MIME-Version:From:Date:
	 X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:Subject:To:
	 Content-Type:X-CMAE-Envelope;
	bh=8Jhkmwr7kCf+QWyWmoMtjL0SdVzWN2dMO5qs8ecK8Q8=;
	b=KcDJFHibC+WHtYmnpcL+MG8q8fBYc2+KVydry9lW27ESyCgWwip0ROTIhQ3GH5RUKZsv
	 99YAJEDXjrd6EwyOOkCfr2ILmbTLfx/st6EPHXClZBLbx39ARsZKMUPLk+bleS61vOnfN
	 Z1xi2JzjnArf3xgK3TkEXOMLIDftBVkSKoYHl9S2w5GeQ1mzVO2kACOz97AN6xmyGfVhD
	 OyZsiFeQCod6EteKmx3HEKzbSrofdok5l+HnUshW9YurZ4gEece8HeOJZmztuMgMlZQA+
	 dnXwWkL1543KnlXsUILEkRAECWY7tthGw8J7LGQhhGqJ0KIeahVuAce+O4RW4w5yu6w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=parmet.com;
	spf=pass smtp.mailfrom=parmet.com;
	arc=none smtp.remote-ip=44.202.169.36
Received: from omta037.useast.a.cloudfilter.net (omta037.useast.a.cloudfilter.net [44.202.169.36])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A94E760A380F
	for <git@vger.kernel.org>; Wed, 21 Oct 2026 03:15:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A94E760A380F
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=parmet.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=parmet.com
Received: from eig-obgw-6007b.ext.cloudfilter.net ([10.0.30.166])
	by cmsmtp with ESMTPS
	id JANnx1OTGJFmFJMnrxRggE; Wed, 21 Oct 2026 03:15:47 +0000
Received: from mail-vk1-f177.google.com ([209.85.221.177])
	by cmsmtp with ESMTPSA
	id JMnpxqc2PgKkdJMnqxRDed; Wed, 21 Oct 2026 03:15:47 +0000
Authentication-Results: parmet.com; auth=pass (PLAIN)
 smtp.auth=andrew@parmet.com
X-Authority-Analysis: v=2.4 cv=a9cw9VSF c=1 sm=1 tr=0 ts=6ad82e63
 a=1Gtpy36QMqX7GAVeZi4eNA==:117 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10
 a=oVcKi2cZ8e-OidIuZFQA:9 a=QEXdDO2ut3YA:10
Received: by mail-vk1-f177.google.com with SMTP id 71dfb90a1353d-5eadadf23e5so163919e0c.2
        for <git@vger.kernel.org>; Tue, 20 Oct 2026 20:15:46 -0700 (PDT)
X-Gm-Message-State: AFq9FYJxuZQ8Ev5IDwlZTSuSl+Qxl0vaarHflvyhrc4gh1WI1EwtODi4
	28YiHsGnVwmDoaJiGvdeYVXOcNI06V2r9cwI/PhE+v4e+dUH0U7HPhRFxxF6FDZFWML0TBRnOlw
	dPfdOZAm6KQDSVy+rlDWTQAY3s4iUIeA=
X-Received: by 2002:a05:6122:1d41:b0:5e9:721c:72a8 with SMTP id
 71dfb90a1353d-5eaeba12f6cmr317285e0c.0.1792552545135; Tue, 20 Oct 2026
 20:15:45 -0700 (PDT)
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
From: Andrew Parmet <andrew@parmet.com>
Date: Tue, 20 Oct 2026 23:15:08 -0400
X-Gmail-Original-Message-ID: <CADudEQNrfiP0VdYvxpWxNKZV=yXtc4LkSXPsmD++Bj8VRpXuQQ@mail.gmail.com>
X-Gm-Features: AclHuK9vRNwa1NqZSLpxdKb_NH9KVSZzMrQVGgayHZwJYOHv-0Tc-n2z9Z-zmn0
Message-ID: <CADudEQNrfiP0VdYvxpWxNKZV=yXtc4LkSXPsmD++Bj8VRpXuQQ@mail.gmail.com>
Subject: Partial-clone merge requests a locally created blob from the remote
To: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-CMAE-Envelope: MS4xfCHtkmlgo/EU5+AjxO8kJSpdI0aPLpomPwoCx418dQUKCeSOm97kywjJYw1OwCs3dxHN8RwzcCQINT2KiEMljF0UH5bpqsRwh9o+RIh8RV/XNlWJObbD
 59JR6cYfSqEQqZ+MtSXtgweQMRKJdoI5pESWoO/UAadC9yNgUjnj/vDHkmcvXF8XBu2Bk/vowtJX4UX4aCtv0ttJh75PTTMyz9c=

Hello,

I have a large repository where I have set up partial clones.
Occasionally a merge fails with:

    fatal: remote error: upload-pack: not our ref <object-id>
    fatal: could not fetch <another-object-id> from promisor remote

The rejected object appears to be a blob created locally by the merge
itself. After restoring the worktree to its pre-merge state and
retrying the merge, it succeeds.

With some help from an LLM, I reduced this to a minimal reproducer
below. The same script succeeds when I remove `--filter=blob:none`:

---

#!/bin/sh
# Run with: sh /tmp/reproduce-promisor-merge.sh
# Optional: REPRO_GIT=/path/to/git (and GIT_EXEC_PATH for a separate install).
# Creates local temporary repositories only; retains them for inspection.
# Expected: a clean merge. Affected Git: "not our ref", then exit 128.
set -eu

git() { command "${REPRO_GIT:-git}" "$@"; }
export GIT_CONFIG_NOSYSTEM=1 GIT_CONFIG_GLOBAL=/dev/null
export GIT_AUTHOR_NAME=Reproducer GIT_AUTHOR_EMAIL=repro@example.invalid
export GIT_COMMITTER_NAME="$GIT_AUTHOR_NAME"
GIT_COMMITTER_EMAIL="$GIT_AUTHOR_EMAIL"

root=$(mktemp -d "${TMPDIR:-/tmp}/git-promisor-repro.XXXXXX")
printf 'Repositories retained in: %s\n' "$root"
cd "$root"

# With these contents, the local edit and merged result have blob IDs starting
# with 6c. They share a loose-object directory, exposing its stale cache.
contents() { printf '%s 31\n1\n2\n3\n4\n5\n6\n7\n8\n%s 31\n' "$1" "$2"; }

git init -q --object-format=sha1 -b main server
git -C server config uploadpack.allowFilter true
git -C server config uploadpack.allowAnySHA1InWant true
contents top bottom > server/file.txt
git -C server add file.txt
git -C server commit -qm base

# --no-local makes this local clone use the transport and honor blob filtering.
git clone -q --no-local --filter=blob:none server client
git -C client switch -qc topic
contents ours bottom > client/file.txt
git -C client commit -qam ours

# The upstream edit is at the opposite end, so it merges without conflicts.
# new.txt leaves a genuinely missing blob for the checkout fetch to obtain.
contents top theirs > server/file.txt
printf 'upstream only\n' > server/new.txt
git -C server add .
git -C server commit -qm theirs
git -C client fetch -q origin

# The bug requests the locally created merge result from the server, which
# cannot have it. That rejects the batch also containing the new.txt blob.
export GIT_TRACE_PACKET="$root/packets.log"
git -C client merge --no-edit origin/main

---

Is this a bug in git itself?

Thanks,
Andrew Parmet

Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8733156FE
	for <git@vger.kernel.org>; Wed, 15 Nov 2023 12:57:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b="goZR6ya4"
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C6F7123
	for <git@vger.kernel.org>; Wed, 15 Nov 2023 04:57:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
	t=1700053022; x=1700657822; i=johannes.schindelin@gmx.de;
	bh=YkgxhlZUYvMQ0zfuO4YpVkndmAFujdKNWtOSeCcduaw=;
	h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:
	 References;
	b=goZR6ya4K5D6hY1oxPB8ZWQEsfpD6CFJmWgOpPeCbzclTxgoTwvqCZ5O6C81ugvU
	 23HDkAtWY5/OmPfKOyYKvso0Z4XkCq6CgI7tZyCCKF1fpqUjUgCB3J0qw9z08bfiD
	 xPISRsroFXy6HwaGcsPoij/1mebgHc1nsFbGleZFyDazUe/AXLh4dgWYzJ3Nwm74i
	 iFsAZbsPpDmZOVjCUAoJ1e4uBrG/8QS8ZL2iXlKrd1FJuhPKoKj/9NGs/Dt7sazHo
	 IaiqXJijRNqLXmOF33Mifpt0F4x+CTArRTIhn41wBHQ7wYeTEQKEupjH6kYmeSBsW
	 bZ83idCliNtxEQVSQw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.23.242.68] ([89.1.215.165]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MkYXs-1rmo9A2IYw-00m54J; Wed, 15
 Nov 2023 13:57:02 +0100
Date: Wed, 15 Nov 2023 13:57:00 +0100 (CET)
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Junio C Hamano <gitster@pobox.com>
cc: Taylor Blau <me@ttaylorr.com>, Jeff King <peff@peff.net>, 
    git@vger.kernel.org
Subject: tb/merge-tree-write-pack, was Re: What's cooking in git.git (Nov
 2023, #04; Thu, 9)
In-Reply-To: <xmqqpm0iy00y.fsf@gitster.g>
Message-ID: <14bdff31-5229-bbd5-3715-f77f52b832d5@gmx.de>
References: <xmqq34xg5ek3.fsf@gitster.g> <ZUzcmsfJe6jk4fTk@nand.local> <xmqqpm0iy00y.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:3oU4g/TgHBXLkuXS/qB6qeqbIF3ofTp94DrDCNPqJeglZ5N5874
 2npj5rQN0a00d3bHELOGISP485PtKEqVME3N7IlE3VnBY5VGWaHm/GLAtItdZiLWedZVi93
 ZGypM9qB43/8Zfjp5PrDWuj+kVjCkHv9Ehm72xWqBZA128gLtae7VCjSMd4axC5qTnPQ1ii
 0AXQ9kNQ+zrbrMMkW2x+g==
UI-OutboundReport: notjunk:1;M01:P0:5HTjjMh0XpU=;9cnTplxBcJgnHbx6slyOX5Gvgby
 DMrhSVjntl08eTO27IwQ9xiN8VIJMkEXawkBbF7wEhrkKuevf4Nxr3fQEDbDcD6fc/PIiwkVy
 sinNRcsxwskKa2+kPipypvebWYIyGk2Vl4CrqmE1t6wgkkhmdD5cfJEYibrdIc93PJQZISz0t
 k+YYLvSAbV8GOZ0SF7SpUZARxKX6xkuQPPT/Td66C+v28LB0xEHMV5mXQLsMVUIBLM0f0sFJ1
 Sb9UTvPEBpiTG1D4CLwSYNd6+UBhdfHwmZDE/b1z24817L8NvHgi11iF7YPUh2l/oCLaSAziK
 wXQ91wOvciJWxZa+RIbvxOj4p7wK1h6MuXqBBs+INZIEIjcsnevW90ilNdC6EDYtCK/mYyeIC
 eDqF7BIuQZYdozR5P1Lx3QmM+qxi7Y1ar82XlhBTtmuO9DXaRXL3ThgoFJBeEvPZKUcBAl/23
 quXjVUW+JN7kwLvDfxJRSt+ZuEy27hllnS4WEsOXYZ+DZVJFK90pZndw8xRULyxsHjIbW0oEj
 85eE+au3YK3xH4gubRyzyxz4Ouwm5ktjdT7IL+5h8XPxtIPuaQXh8Q+QfRtH6YHCWeg0pyGO6
 RL1RbzdwezR8W7MHiIP+WWNcXv+M3Ou3XT1dQKVe6r1S8qY0OqSNmQwfzhvPNF4FD0L2BVwcj
 2gbd7iJMnc99VDtatpAwrmEEH4fIP2Z0sL+MmjJxkXR8+MA27Oi9MT8Ram/L2e9WYf7G21UqW
 T07JPiqGRguNCqy1GE2bk5WwG/ksr6K375iW/LB8Qv97PCoCeIUjxpKSLtqQ9nS1D+zsxCWRO
 CSospHxIu4hnVVQ9qyvLQMP8HcAcBdoYps45lasUSFd6Bd7kUZY6dheQC3kTPO2305V7TVT3N
 WQ0Yofik9KqKcIRBGVX6ph6X8glfLWB+pxzFTMXfJdO/ko2NKzY7OHcPiNX+rsqG6vK45EWIe
 9lXplQ==
Content-Transfer-Encoding: quoted-printable

Hi Junio,

On Fri, 10 Nov 2023, Junio C Hamano wrote:

> Taylor Blau <me@ttaylorr.com> writes:
>
> > On Thu, Nov 09, 2023 at 02:40:28AM +0900, Junio C Hamano wrote:
> >> * tb/merge-tree-write-pack (2023-10-23) 5 commits
> > ...
> > This series received a couple of LGTMs from you and Patrick:
> >
> >   - https://lore.kernel.org/git/xmqqo7go7w63.fsf@gitster.g/#t
> >   - https://lore.kernel.org/git/ZTjKmcV5c_EFuoGo@tanuki/
>
> Yup, I am aware of them.
>
> > Johannes had posted some comments[1] about instead using a temporary
> > object store where objects are written as loose that would extend to g=
it
> > replay....
>
> I was hoping to hear from Johannes saying he agrees with the above.
> It is not strictly required, but is much nice to have once we hear
> "let's step back a bit---are we going in the right direction?" and
> it has been responded.

When I wrote about `tmp_objdir`, there were a couple of things going on in
my mind:

- First of all, I was hesitant to write this at all because I knew that I
  lack the time to engage meaningfully in any follow-up discussion.

- To be honest, the approach to teach `merge-ort.c` anything about whether
  objects are written loosely or streamed into a pack strikes me as
  somewhat contrary to the goal of separating concerns. The merge
  machinery should not know, in my mind, how the objects are stored.

- A long-standing paradigm in Git is that pack files are not used until
  finalized. Breaking such a paradigm after being in effect for a long
  time, in my experience, is always followed by unwelcome "gifts that keep
  on giving".

- The streaming pack approach struck me as something that would only work
  properly if Git was designed with single-process operations in mind. But
  Git was originally designed around the process-proliferating Unix
  philosophy, and it is deeply ingrained in Git to this day. As such, I do
  not expect the streaming pack approach to generalize to a noteworthy
  fraction of Git operations, and I would love to focus on an approach
  that generalizes better.

- At the Git Contributor Summit, I had talked about my goals, and Elijah
  helpfully pointed out how `--remerge-diff` does it, and I wanted to
  pursue that idea further.

- The scenario I want to address (and that I assumed the patch series
  under discussion tried to address, too) is a very specific, server-side
  scenario where many `merge-tree`/`replay` runs produce _many_ loose
  objects. Quite a fraction of those are produced by processes that run
  into a SIGTERM-enforced timeout, and the `tmp_objdir` approach would
  naturally help: unneeded loose objects would not even be added to the
  primary object database but be reaped with the temporary object
  databases.

- While it may sound as if the sheer number of loose objects is the
  primary problem, an even more pressing issue I need to address is that
  competing processes that try to work on a snapshot of the loose objects
  (which does not exist, you cannot "take a snapshot", all you can do is
  to enumerate the directories sequentially) seem sometimes to process
  loose tree/commit objects that reference other objects that have been
  missed due to racy reads/writes/enumerations. The reason for this is
  that the loose objects produced by `merge-tree`/`replay` are added
  non-transactionally, and concurrent reads are prone to run into racy
  conditions where they only see a part of those objects.

- Even just using `tmp_objdir_migrate()` could help a lot by narrowing the
  window for those racy conditions.

- The number of inodes has been a concern, yes, but not such a pressing
  one that I could afford spending any further thought on the idea to
  reduce them. In any case, a working theory is that this concern would
  already be helped by avoiding the loose objects produced by failing
  merges/rebases (whose results are not used) or by merges/rebases running
  into a timeout.

- Streaming packs, if I understand correctly, do not do deltas. That in
  and of itself can cause file size issues, and light-weight maintenance
  may not even bother to try finding deltas, thereby causing follow-on
  problems.

With all this in mind, I do not think that I can affort to spend brain
cycles on the streaming-pack approach. I do not intend to discourage
anybody from working on that approach, yet I won't encourage anyone,
either.

Ciao,
Johannes

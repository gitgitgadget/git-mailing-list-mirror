Received: from avasout-ptp-004.plus.net (avasout-ptp-004.plus.net [84.93.230.250])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FF47DDA9
	for <git@vger.kernel.org>; Fri, 26 Sep 2025 00:23:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=84.93.230.250
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758846189; cv=none; b=stZfuOmlA1SQL5ShHdJ/V5jcmSfsXtmQKDID5GpbVqpeVbBi9pvAivjx1gBwZc+59aOEHF7IAaS1LpOMbnLBxLedW84kQG+s7tBamyXktCZs6l8Re1xaoUpA/8GEx+tT1Ia19FHIy4auidzWmdS6GdXrMzmtZMkG+X5mAGTuaO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758846189; c=relaxed/simple;
	bh=Z+MeLf+WFdbcOHhLDTkarnv0ggj/nJv97zu4Oj+6jkg=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=WgbQFikqjyLi/gHFnug6H0Sn8D5iZSil6jI6k0aDYg89obfxqGeTdVLXtW8x9gRZNj6vdqZzFeiMDdVT8UVde0rTwht/9JSXab55gJnGBlh2dT98SkWLPK72wfVeeWeC5Dj6+Wn6ho/EajT4OWcQzNQs+0GiC34/h0BSUieDweg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ramsayjones.plus.com; spf=pass smtp.mailfrom=ramsayjones.plus.com; dkim=pass (2048-bit key) header.d=plus.com header.i=@plus.com header.b=ef9hFLFT; arc=none smtp.client-ip=84.93.230.250
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ramsayjones.plus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ramsayjones.plus.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=plus.com header.i=@plus.com header.b="ef9hFLFT"
Received: from [10.0.2.15] ([80.189.83.109])
	by smtp with ESMTPA
	id 1wBovtzl32D8r1wBpvBRv3; Fri, 26 Sep 2025 01:19:58 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=plus.com; s=042019;
	t=1758845998; bh=IPud+GFj8vKIQV3TautfPHHJsGLAIZFRETHSiXiR1eA=;
	h=Date:To:Cc:From:Subject;
	b=ef9hFLFTaoNKImZ6FN5L4Nd8nv4wECC0kC7s565VCDq5smaf7sAbh9h/0GO9jQN4+
	 vV5I4PqVkmXDQyw7F7/IuPul77S/Mttc8nrhUnArkhfh/RnkTbsSES5yu8K5I3l2/c
	 APNU+3iFnyO/DV1Pm7fDcR3x6w8F10AFrkwmB5OQvZU1t0mQA/uia1WQRbJcZX/tCd
	 NU2kD9y3E0N8JyNQcWYnqdZDHkQGc6V35+xFSkM5W2RBu6l634NXS+xH8WxJy2b+oT
	 Q89ZmNQNxpDZTM8Yqu4ULSDD3Hwd483wQCWsgrguyOmf40J2bbOcFliFIB6Pl9UKAl
	 IWA65wTcs5cBQ==
X-Clacks-Overhead: "GNU Terry Pratchett"
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.4 cv=beTIU/PB c=1 sm=1 tr=0 ts=68d5dc2e
 a=oM5NSl/Bl4BpjFr0C8iQlQ==:117 a=oM5NSl/Bl4BpjFr0C8iQlQ==:17
 a=IkcTkHD0fZMA:10 a=4WCH1Ac9AAAA:8 a=NEAV23lmAAAA:8 a=QyRJ8Xq4AAAA:8
 a=-B5VrbtkW4SaSGHBNsAA:9 a=zO9NMTSik6sIKOqj:21 a=QEXdDO2ut3YA:10
 a=qgWQEkYGNYWIoU-2h2CA:22 a=bU4N5Dn6QmUNwQ-LvVBy:22
X-AUTH: ramsayjones@:2500
Message-ID: <bcb3b3a3-bb13-4808-9363-442b5f9be05f@ramsayjones.plus.com>
Date: Fri, 26 Sep 2025 01:19:56 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: GIT Mailing-list <git@vger.kernel.org>
Cc: Patrick Steinhardt <ps@pks.im>, Elijah Newren <newren@gmail.com>,
 Derrick Stolee <stolee@gmail.com>, Junio C Hamano <gitster@pobox.com>
From: Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: [PATCH 0/4] technical docs in make build
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4xfHw4pr568pk9DXqmRectacoYtnwik7FV4BFvqc5ov5izrTmkLt1inntiGN6S+EBSH9hIaZNHss7CB1zSi+k4QT76tsq1/061GsMNqcY7896irKtVI3WZ
 sT329zCrtfF5cddcMoL9vHJadIOYPvh/r5+GW1LeRZq8MtIV7VLEwyO2zRudcZcCYfhWk5J09Spi+NdGqsgjy8QHkcQVp5kr14M=


I have been trying to get back to the 'misc build updates (part #3)'
patches, so that I can send them to the list, but I have not been able
to find a spare minute for quite some time. :(

However, this sub-sequence of patches hangs together as a single theme and
I need help to finish them up! (asciidoc is not my forte).

The first patch adds some technical documents to the Makefile build which
are already part of the meson build. In particular, the following are
built by meson, but not by the Makefile:

    commit-graph.adoc
    directory-rename-detection.adoc
    packfile-uri.adoc
    remembering-renames.adoc
    repository-version.adoc
    rerere.adoc
    sparse-checkout.adoc
    sparse-index.adoc

Although I am not convinced that some of these files were ever meant to be
formatted by asciidoc, I have assumed that is the case for the purposes of
this patch series. (otherwise, we should remove them from the meson build
and rename the files instead).

When I attempt to build the html docs, with patch #1 applied, on Linux:

  $ make html >out-doc 2>&1

  $ grep SyntaxWarning out-doc | head -n1
  <unknown>:1: SyntaxWarning: invalid escape sequence '\S'
  $ grep SyntaxWarning out-doc | wc -l
  524
  $ 

  $ asciidoc --version
  asciidoc 10.2.0
  $ python3 --version
  Python 3.12.3
  $ 

This is caused by the python version I am using, which was recently changed
(in version 3.12) to issue the SyntaxWarning when a 'non-raw' string contains
some escape sequences (here \S). [some versions prior to 3.12 used to issue
a deprecation warning].

This is a known issue, see e.g. [0], which has been addressed by a patch [1],
and as seen in [2] has been included in a new version 10.2.1 of asciidoc.

  [0] https://trac.macports.org/ticket/70039
  [1] 1https://github.com/asciidoc-py/asciidoc-py/pull/267
  [2] https://github.com/asciidoc-py/asciidoc-py/commits/main/

[cygwin does not have this problem, because the phython version is 3.9.16]

So, ignoring that issue, we still see some warnings from asciidoc:

  $ grep WARNING out-doc
  asciidoc: WARNING: remembering-renames.adoc: line 13: list item index: expected 1 got 0
  asciidoc: WARNING: remembering-renames.adoc: line 15: list item index: expected 2 got 1
  asciidoc: WARNING: remembering-renames.adoc: line 17: list item index: expected 3 got 2
  asciidoc: WARNING: remembering-renames.adoc: line 20: list item index: expected 4 got 3
  asciidoc: WARNING: remembering-renames.adoc: line 23: list item index: expected 5 got 4
  asciidoc: WARNING: remembering-renames.adoc: line 25: list item index: expected 6 got 5
  asciidoc: WARNING: remembering-renames.adoc: line 29: list item index: expected 7 got 6
  asciidoc: WARNING: remembering-renames.adoc: line 31: list item index: expected 8 got 7
  asciidoc: WARNING: remembering-renames.adoc: line 33: list item index: expected 9 got 8
  asciidoc: WARNING: remembering-renames.adoc: line 38: section title out of sequence: expected level 1, got level 2
  asciidoc: WARNING: sparse-checkout.adoc: line 17: section title out of sequence: expected level 1, got level 2
  asciidoc: WARNING: sparse-checkout.adoc: line 928: list item index: expected 1 got 0
  asciidoc: WARNING: sparse-checkout.adoc: line 931: list item index: expected 2 got 1
  asciidoc: WARNING: sparse-checkout.adoc: line 951: list item index: expected 3 got 2
  asciidoc: WARNING: sparse-checkout.adoc: line 974: list item index: expected 4 got 3
  asciidoc: WARNING: sparse-checkout.adoc: line 980: list item index: expected 5 got 4
  asciidoc: WARNING: sparse-checkout.adoc: line 1033: list item index: expected 6 got 5
  asciidoc: WARNING: sparse-checkout.adoc: line 1049: list item index: expected 7 got 6
  $ 

I also tried asciidoctor, just for fun:

  $ asciidoctor --version
  Asciidoctor 2.0.20 [https://asciidoctor.org]
  Runtime Environment (ruby 3.2.3 (2024-01-18 revision 52bb2ac0a6) [x86_64-linux-gnu]) (lc:UTF-8 fs:UTF-8 in:UTF-8 ex:UTF-8)
  $ 

  $ make USE_ASCIIDOCTOR=1 html >out-doctor 2>&1

  $ grep WARNING out-doctor
  asciidoctor: WARNING: remembering-renames.adoc: line 13: list item index: expected 1, got 0
  asciidoctor: WARNING: remembering-renames.adoc: line 15: list item index: expected 2, got 1
  asciidoctor: WARNING: remembering-renames.adoc: line 17: list item index: expected 3, got 2
  asciidoctor: WARNING: remembering-renames.adoc: line 20: list item index: expected 4, got 3
  asciidoctor: WARNING: remembering-renames.adoc: line 23: list item index: expected 5, got 4
  asciidoctor: WARNING: remembering-renames.adoc: line 25: list item index: expected 6, got 5
  asciidoctor: WARNING: remembering-renames.adoc: line 29: list item index: expected 7, got 6
  asciidoctor: WARNING: remembering-renames.adoc: line 31: list item index: expected 8, got 7
  asciidoctor: WARNING: remembering-renames.adoc: line 33: list item index: expected 9, got 8
  asciidoctor: WARNING: remembering-renames.adoc: line 38: section title out of sequence: expected level 1, got level 2
  asciidoctor: WARNING: remembering-renames.adoc: line 94: section title out of sequence: expected level 1, got level 2
  asciidoctor: WARNING: remembering-renames.adoc: line 141: section title out of sequence: expected level 1, got level 2
  asciidoctor: WARNING: remembering-renames.adoc: line 142: section title out of sequence: expected level 1, got level 2
  asciidoctor: WARNING: remembering-renames.adoc: line 184: section title out of sequence: expected level 1, got level 2
  asciidoctor: WARNING: remembering-renames.adoc: line 185: section title out of sequence: expected level 1, got level 2
  asciidoctor: WARNING: remembering-renames.adoc: line 257: section title out of sequence: expected level 1, got level 2
  asciidoctor: WARNING: remembering-renames.adoc: line 288: section title out of sequence: expected level 1, got level 2
  asciidoctor: WARNING: remembering-renames.adoc: line 289: section title out of sequence: expected level 1, got level 2
  asciidoctor: WARNING: remembering-renames.adoc: line 290: section title out of sequence: expected level 1, got level 2
  asciidoctor: WARNING: remembering-renames.adoc: line 397: section title out of sequence: expected level 1, got level 2
  asciidoctor: WARNING: remembering-renames.adoc: line 424: section title out of sequence: expected level 1, got level 2
  asciidoctor: WARNING: remembering-renames.adoc: line 485: section title out of sequence: expected level 1, got level 2
  asciidoctor: WARNING: remembering-renames.adoc: line 486: section title out of sequence: expected level 1, got level 2
  asciidoctor: WARNING: remembering-renames.adoc: line 487: section title out of sequence: expected level 1, got level 2
  asciidoctor: WARNING: sparse-checkout.adoc: line 17: section title out of sequence: expected level 1, got level 2
  asciidoctor: WARNING: sparse-checkout.adoc: line 95: section title out of sequence: expected level 1, got level 2
  asciidoctor: WARNING: sparse-checkout.adoc: line 258: section title out of sequence: expected level 1, got level 2
  asciidoctor: WARNING: sparse-checkout.adoc: line 303: section title out of sequence: expected level 1, got level 2
  asciidoctor: WARNING: sparse-checkout.adoc: line 316: section title out of sequence: expected level 1, got level 2
  asciidoctor: WARNING: sparse-checkout.adoc: line 545: section title out of sequence: expected level 1, got level 2
  asciidoctor: WARNING: sparse-checkout.adoc: line 612: section title out of sequence: expected level 1, got level 2
  asciidoctor: WARNING: sparse-checkout.adoc: line 752: section title out of sequence: expected level 1, got level 2
  asciidoctor: WARNING: sparse-checkout.adoc: line 824: section title out of sequence: expected level 1, got level 2
  asciidoctor: WARNING: sparse-checkout.adoc: line 895: section title out of sequence: expected level 1, got level 2
  asciidoctor: WARNING: sparse-checkout.adoc: line 923: section title out of sequence: expected level 1, got level 2
  asciidoctor: WARNING: sparse-checkout.adoc: line 928: list item index: expected 1, got 0
  asciidoctor: WARNING: sparse-checkout.adoc: line 931: list item index: expected 2, got 1
  asciidoctor: WARNING: sparse-checkout.adoc: line 951: list item index: expected 3, got 2
  asciidoctor: WARNING: sparse-checkout.adoc: line 974: list item index: expected 4, got 3
  asciidoctor: WARNING: sparse-checkout.adoc: line 980: list item index: expected 5, got 4
  asciidoctor: WARNING: sparse-checkout.adoc: line 1033: list item index: expected 6, got 5
  asciidoctor: WARNING: sparse-checkout.adoc: line 1049: list item index: expected 7, got 6
  asciidoctor: WARNING: sparse-checkout.adoc: line 1053: section title out of sequence: expected level 1, got level 2
  $ 

You can see that asciidoc only complains about the first 'section title out of
sequence', whereas asciidoctor complains about them all.

[asciidoctor also reports:
Note: namesp. cut : stripped namespace before processing           Git User Manual]

Patch #2 was a nightmare which I really gave up on! :) An early attempt
involved renumbering the 'outline list' at the top from 0->8 to 1->9
(I thought there was a way to start numbering at zero, but I lost a lot
of time trying to do so, without any success). So, of course I 'just'
tried global search/replace in vim to do the renumbering (backwards).
This was a complete disaster (of course), which I 'fixed' many many times.
(Not everything which is numbered is a section, there are 'cases' as well).

In the end, I just disabled the 'outline' list, by removing the period
on the numbers (again '0\. Assumptions' should have worked, but didn't)
and fixing up the section titles without renumbering them. Note that
asciidoctor mis-formats the 'ascii branch diagrams', which asciidoc
formats correctly. I think there are other formatting problems left.

In patch #3, the formatting changes are confined to the section titles and
renumbering the 'known bugs' from 0->6 to 1->7. (I think I noticed some
sub-sub lists which are not formatted correctly, but I don't seem to be
able to see them now ...).

In patch #4, most of the formatting changes relate to section titles, but
I could not fix some inline text formatting starting at 'File Layouts'
(within 'Commit-Graph Chains') with text that is monospaced with `` but
also contains an '{' character. For example:

  `$OBJDIR/info/commit-graphs/graph-{hash}.graph`

is monospaced (blue colour with asciidoc) up until the {hash}.graph which
does not have any formatting. (It is not so noticeable with asciidoctor
because the formatting consists of a *very* subtle gray background to the
text which, to my eyes anyway, is almost not visible).

I have tried several suggestions from an on-line asciidoc syntax cheatsheet
such as:

  `$OBJDIR/info/commit-graphs/graph-\{hash\}.graph`
  `+$OBJDIR/info/commit-graphs/graph-{hash}.graph+`

but nothing worked. Note that there are many similar instances of this
problem (including just `{hash}`).

Note also that asciidoctor did not render the second diagram correctly
(the one in 'Merging commit-graph files'), but asciidoc was just fine.

The remaining documents:

    directory-rename-detection.adoc
    packfile-uri.adoc
    repository-version.adoc
    rerere.adoc
    sparse-index.adoc

all appear to be formatted correctly.

So, I really need help with the asciidoc formatting, in patches #2->#4,
which I am marking as RFC. Having said that, these patches represent
an improvement over the existing documents in terms of formatting
(just not by much!).

Any help fixing up these patches would be much appreciated. :)

Thanks.

ATB,
Ramsay Jones

 
Ramsay Jones (4):
  doc: add some missing technical documents
  doc: remembering-renames.adoc: fix asciidoc warnings
  doc: sparse-checkout.adoc: fix asciidoc warnings
  doc: commit-graph.adoc: fix up some formatting

 Documentation/Makefile                        |  8 +++
 Documentation/technical/commit-graph.adoc     | 34 +++++-----
 .../technical/remembering-renames.adoc        | 63 +++++++++----------
 Documentation/technical/sparse-checkout.adoc  | 38 +++++------
 4 files changed, 74 insertions(+), 69 deletions(-)

-- 
2.51.0

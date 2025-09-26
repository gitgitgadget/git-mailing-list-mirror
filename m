Received: from avasout-peh-002.plus.net (avasout-peh-002.plus.net [212.159.14.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A3316ADD
	for <git@vger.kernel.org>; Fri, 26 Sep 2025 18:12:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.159.14.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758910333; cv=none; b=Ziqc/nowcZ3I6YMKVG80ZxzVBPrXMR8ymvNjFBMg5YJaH4N3AL+ZPNDadhMwRXhOsQOeMLTcRxZUmPhNAuE510F7/LlwMW1XZmUDveMSiJukKRsR/OH0RjcEDOYu3IOirwy3Wr3fyWiF9KE/tljRVVtz9XTmDxEg+sUcWUNW040=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758910333; c=relaxed/simple;
	bh=rwyGbL/8BsGDYpy7hZN9jZNsvvCfuTVtsZ8DRw92KrE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CGtJhZzx+RLRT0pClhCXJODYZzo8om1aE5MSGtveAXNNI2NUAlWt0CarWbbgBcuxC0E0vBIpqieoBZ6+F6QZEpJZOpHHzOlrSMRiuJ3yNGcZpk/H9WCnPHbwqbT2g1W2PYU/kX3t0wHbrtXLZ7VXjhihSsyJnd7BtK/vbzCHL9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ramsayjones.plus.com; spf=pass smtp.mailfrom=ramsayjones.plus.com; dkim=pass (2048-bit key) header.d=plus.com header.i=@plus.com header.b=q7nROaaf; arc=none smtp.client-ip=212.159.14.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ramsayjones.plus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ramsayjones.plus.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=plus.com header.i=@plus.com header.b="q7nROaaf"
Received: from [10.0.2.15] ([80.189.83.109])
	by smtp with ESMTPA
	id 2CvFvx4BrYrrN2CvHvqpdM; Fri, 26 Sep 2025 19:12:00 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=plus.com; s=042019;
	t=1758910320; bh=laCKpkYR92zEc+aLHLh0i60vRa+j8PP1dmtmgCT3Uw4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=q7nROaafRdvt3VUqwkcMVZD4YkAFpsdAhhyk/qAhKug2QcvN3hBWwarTY1fNAOZIB
	 W2fjmbVcXm/r8pLikrXtDhH5v7JFhoKNHtI7hkUW+h0fcqmIUF5U310uEf8khsAa0P
	 ZbNcQFFl33GXoRuLt6CHcqtAI7MxmCyB5uPg/l3+QTESqxcsYgIVYkgXcr4Ieia8jh
	 s5aXSG6f7aQl5CWDay8kEY9MR6bb3mt+y4/uLNbvTF3aRcAn5iv5Zd+SKBYlIeJ0xC
	 UxuElJ6Xm1kXTJxgHCDQ0wb++1dpd37F2RnUy8SKGJKLWgyuApVB1y++FRdZilTiUm
	 fXqL1mNOo2LyQ==
X-Clacks-Overhead: "GNU Terry Pratchett"
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.4 cv=ELSl0EZC c=1 sm=1 tr=0 ts=68d6d770
 a=oM5NSl/Bl4BpjFr0C8iQlQ==:117 a=oM5NSl/Bl4BpjFr0C8iQlQ==:17
 a=IkcTkHD0fZMA:10 a=EBOSESyhAAAA:8 a=2GgndpBNRjo-BeXyWioA:9 a=QEXdDO2ut3YA:10
 a=yJM6EZoI5SlJf8ks9Ge_:22
X-AUTH: ramsayjones@:2500
Message-ID: <c8e40336-0a16-4da9-b251-d166f80ffeb3@ramsayjones.plus.com>
Date: Fri, 26 Sep 2025 19:11:57 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 4/4] doc: commit-graph.adoc: fix up some formatting
To: Junio C Hamano <gitster@pobox.com>
Cc: GIT Mailing-list <git@vger.kernel.org>, Patrick Steinhardt <ps@pks.im>,
 Derrick Stolee <stolee@gmail.com>
References: <875fb7a0-6dd9-412b-a34a-21758c339871@ramsayjones.plus.com>
 <xmqqfrc9citl.fsf@gitster.g>
Content-Language: en-US
From: Ramsay Jones <ramsay@ramsayjones.plus.com>
In-Reply-To: <xmqqfrc9citl.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4xfOGhjJmqvb2r3CynXpnx6lWfek33hdAI+gyHGORiMPznSQjXvFcMT2OhoFjsJf9TP2HXi2NzFqz9EJ70NaiouwOFXYUgdmTd5v8ll3JAJhalIS2fdKUg
 D8dNMLOxD6WbZvAtN+6xff7bXRtKNQHUzP3FfpTKUaGzLHcgQ2XqIixg4G1vw34gX2GircDDySUPaSOiZDVG7uy6TMXhvVjaKCk=



On 26/09/2025 4:52 pm, Junio C Hamano wrote:
> Ramsay Jones <ramsay@ramsayjones.plus.com> writes:
> 
>> Signed-off-by: Ramsay Jones <ramsay@ramsayjones.plus.com>
>> ---
>>  Documentation/technical/commit-graph.adoc | 34 +++++++++++------------
>>  1 file changed, 16 insertions(+), 18 deletions(-)
> 
> Are these the issues?
> 
>  - Use ={n} prefixes instead of underlines for the section headers.
> 
>  - Use ={n} not #{n} prefixes for the section headers.
> 
>  - A blank line between a leading text before a numbered list.
> 
>  - Mark-up of displayed materials.
> 
> The majority of our pages (I think all of the manual pages) use
> underlines.  Are we getting warnings on them that we'd need to
> change?  I personally find the underlined style easier to read
> in the source text (even though I understand why people would
> prefer to use the ={n} prefix style---having to adjust the length
> of the underline is a bit more work when retitling).

Heh, my first attempt used an '+' character for the underlining of the
'next' level headers, rather than '## ', since that was what I thought
it was (from a very vague memory), but asciidoc disagreed! ;)

I tried searching the web for the answer, without success, so went with
the 'prefix' style used here. However, when I read the above, it made me
look at out current docs and gitworkflows.adoc showed me I should have
used an '~' character instead.

I just tried this and it works great (apart from having to \-quote the
'{' and '}' characters in one title), so a revised 'diff' is given below.

[all the other problems remain, of course]

Would you prefer this 'patch'?

ATB,
Ramsay Jones

--- >8 ---
diff --git a/Documentation/technical/commit-graph.adoc b/Documentation/technical/commit-graph.adoc
index 2c26e95e51..f5522ba437 100644
--- a/Documentation/technical/commit-graph.adoc
+++ b/Documentation/technical/commit-graph.adoc
@@ -39,6 +39,7 @@ A consumer may load the following info for a commit from the graph:
 Values 1-4 satisfy the requirements of parse_commit_gently().
 
 There are two definitions of generation number:
+
 1. Corrected committer dates (generation number v2)
 2. Topological levels (generation number v1)
 
@@ -158,7 +159,8 @@ number of commits in the full history. By creating a "chain" of commit-graphs,
 we enable fast writes of new commit data without rewriting the entire commit
 history -- at least, most of the time.
 
-## File Layout
+File Layout
+~~~~~~~~~~~
 
 A commit-graph chain uses multiple files, and we use a fixed naming convention
 to organize these files. Each commit-graph file has a name
@@ -170,11 +172,11 @@ hashes for the files in order from "lowest" to "highest".
 
 For example, if the `commit-graph-chain` file contains the lines
 
-```
+----
 	{hash0}
 	{hash1}
 	{hash2}
-```
+----
 
 then the commit-graph chain looks like the following diagram:
 
@@ -213,7 +215,8 @@ specifying the hashes of all files in the lower layers. In the above example,
 `graph-{hash1}.graph` contains `{hash0}` while `graph-{hash2}.graph` contains
 `{hash0}` and `{hash1}`.
 
-## Merging commit-graph files
+Merging commit-graph files
+~~~~~~~~~~~~~~~~~~~~~~~~~~
 
 If we only added a new commit-graph file on every write, we would run into a
 linear search problem through many commit-graph files.  Instead, we use a merge
@@ -257,14 +260,15 @@ lock-file.  When the file is flushed, we rename it to `graph-{hash3}`
 according to the computed `{hash3}`. Finally, we write the new chain data to
 `commit-graph-chain.lock`:
 
-```
+----
 	{hash3}
 	{hash0}
-```
+----
 
 We then close the lock-file.
 
-## Merge Strategy
+Merge Strategy
+~~~~~~~~~~~~~~
 
 When writing a set of commits that do not exist in the commit-graph stack of
 height N, we default to creating a new file at level N + 1. We then decide to
@@ -289,7 +293,8 @@ The merge strategy values (2 for the size multiple, 64,000 for the maximum
 number of commits) could be extracted into config settings for full
 flexibility.
 
-## Handling Mixed Generation Number Chains
+Handling Mixed Generation Number Chains
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 
 With the introduction of generation number v2 and generation data chunk, the
 following scenario is possible:
@@ -318,7 +323,8 @@ have corrected commit dates when written by compatible versions of Git. Thus,
 rewriting split commit-graph as a single file (`--split=replace`) creates a
 single layer with corrected commit dates.
 
-## Deleting graph-{hash} files
+Deleting graph-\{hash\} files
+~~~~~~~~~~~~~~~~~~~~~~~~~~~
 
 After a new tip file is written, some `graph-{hash}` files may no longer
 be part of a chain. It is important to remove these files from disk, eventually.
@@ -333,7 +339,8 @@ files whose modified times are older than a given expiry window. This window
 defaults to zero, but can be changed using command-line arguments or a config
 setting.
 
-## Chains across multiple object directories
+Chains across multiple object directories
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 
 In a repo with alternates, we look for the `commit-graph-chain` file starting
 in the local object directory and then in each alternate. The first file that

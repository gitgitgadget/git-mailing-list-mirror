From: =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Subject: Re: [PATCH v3 2/3] perf: make the tests work in worktrees
Date: Mon, 30 May 2016 20:24:49 +0200
Message-ID: <574C8571.6080607@web.de>
References: <cover.1462955446.git.johannes.schindelin@gmx.de>
 <cover.1463145936.git.johannes.schindelin@gmx.de>
 <0f0bc7ac7b6eebed22b05c277cf7352122d164d2.1463145936.git.johannes.schindelin@gmx.de>
 <574B1C3D.3000706@web.de> <alpine.DEB.2.20.1605301026430.4449@virtualbox>
 <xmqqr3cjo23d.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>
To: Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon May 30 20:25:12 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b7RsG-0006ij-0z
	for gcvg-git-2@plane.gmane.org; Mon, 30 May 2016 20:25:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161834AbcE3SZH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 30 May 2016 14:25:07 -0400
Received: from mout.web.de ([212.227.15.14]:65461 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1161330AbcE3SZF (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 May 2016 14:25:05 -0400
Received: from [192.168.178.36] ([79.213.117.50]) by smtp.web.de (mrweb001)
 with ESMTPSA (Nemesis) id 0LfAbI-1brZJX2jjk-00optY; Mon, 30 May 2016 20:24:55
 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:38.0) Gecko/20100101
 Thunderbird/38.7.2
In-Reply-To: <xmqqr3cjo23d.fsf@gitster.mtv.corp.google.com>
X-Provags-ID: V03:K0:IAiab2gI6SRfMGwXwfBmhLR2AYeAjeMzErzw4Dxo2RBKx6OExSQ
 PrcObJix/SzLmtECmpQnG9FOoHawPI/CXHhgDnfX3vnTI3iI61gYbe3JwfCliiPttKublKP
 BtZkdK0lBRTm/+oGM1BgBQNlmWjl7fs0jLvO2d1x1cmcQROAGiX15d3e/0VunmUb1M3/c3o
 ysRVy3qAY36a0RDBgzpIA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:dbxyaZWRcCI=:/JjcEdtN9STHT+Ob315SrT
 nc9nvKLkl9/3vVUZkF1FlwIrZqPflrEYJtVZj7+O3LR01LtzpVhlJ3HU4m6sPbuS+6QdnaC35
 ffN4f+bb6/6wu7/6DG0zSj69zSkcX1iiWFc3GsAgyETyNY2NIzdEmvgmtpkUmpZvrOqO3qeED
 Tub9I+5Q+iJnU6gezZiO1NqRo2W01QTSn9K4COVBaPv3NBsFGufRveCdV4vADsUD3tOlt+vlA
 swKe0tJnNi4iMP2uDFgYCO91jBbexJ54FklyHVLh8TnkPr7QlwV1++LJTexuD4lGdTjNJrjqY
 bIYl9IIDJoT0yw0aSK+3UrnvwsjlRQ3umjQR8HC2KtALg/RWVJ4WgcEONcfga8mp1OrJ5FFOB
 lqwodCzmtccVnustTYYea/ZwBqeDvZuGsXV9aMcV5R+n6hh74O2+dzlPv4q/i0dZ0b+KmQ0TX
 NzQsYZM1O2bzFRM+HRezo/A1A+wBNHWF5H0DOcNFD0jHA+bfJbGPqbanwEZ5m0NWS3vPrHSEe
 LSvPnJrBw5glF7LPqtLrAxiAr/rxX4kwirpxfBz/MnncnzzhuqPlFh9oHNGXVEdqsvOHNopiG
 9xMbKQPbkG7iyglGL9jbsdZpaF2WCtUfa6se+NcVCfp668JhDhkQQSbKuEb/7Y8MfnXKYdbdH
 8bBvXPEQwELWKBnwrvLsxFFZRsr7T2joUeLiKawqKakMnlcecA6pTzcPohZO6H4o9cmlOUA+S
 KcJKhAjDhyEZ0OWVAxphutLkehum0/mZ8vXDeqggWuWnKdBewGvB9EvOxYNz6bfqIhGznvb9 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/295920>

Am 30.05.2016 um 20:03 schrieb Junio C Hamano:
> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
>>> This breaks perf for the non-worktree case:
>>
>> Oh drats!
>>
>>> lsr@debian:~/src/git/t/perf$ make
>>> rm -rf test-results
>>> ./run
>>> === Running 12 tests in this tree ===
>>> cp: cannot stat '.git/objects': No such file or directory
>>> error: failed to copy repository '/home/lsr/src/git/t/..' to '/tmp/trash directory.p0000-perf-lib-sanity'
>>> cp: cannot stat '.git/objects': No such file or directory
>>> error: failed to copy repository '/home/lsr/src/git/t/..' to '/tmp/trash directory.p0001-rev-list'
>>> ...
>>>
>>> Here's a fix:
>>>
>>> -- >8 --
>>> Subject: perf: make the tests work without a worktree
>>>
>>> In regular repositories $source_git and $objects_dir contain relative
>>> paths based on $source.  Go there to allow cp to resolve them.
>>>
>>> Signed-off-by: Rene Scharfe <l.s.r@web.de>
>>> ---
>>>   t/perf/perf-lib.sh | 1 +
>>>   1 file changed, 1 insertion(+)
>>>
>>> diff --git a/t/perf/perf-lib.sh b/t/perf/perf-lib.sh
>>> index 5ef1744..1888790 100644
>>> --- a/t/perf/perf-lib.sh
>>> +++ b/t/perf/perf-lib.sh
>>> @@ -84,6 +84,7 @@ test_perf_create_repo_from () {
>>>   	objects_dir="$(git -C "$source" rev-parse --git-path objects)"
>>>   	mkdir -p "$repo/.git"
>>>   	(
>>> +		cd "$source" &&
>>
>> I fear that interacts badly with the `cd "$repo"` I introduced later
>> (replacing a `cd ..`)...

Oh, right, it does if $repo is a relative path.

> What do you want to do then?  For now before -rc1 we can revert the
> whole thing so that we can get a tested thing that works in both
> layouts.

Put it in its own subshell, e.g. like this?

---
 t/perf/perf-lib.sh | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/t/perf/perf-lib.sh b/t/perf/perf-lib.sh
index 5ef1744..18c363e 100644
--- a/t/perf/perf-lib.sh
+++ b/t/perf/perf-lib.sh
@@ -84,6 +84,7 @@ test_perf_create_repo_from () {
 	objects_dir="$(git -C "$source" rev-parse --git-path objects)"
 	mkdir -p "$repo/.git"
 	(
+		cd "$source" &&
 		{ cp -Rl "$objects_dir" "$repo/.git/" 2>/dev/null ||
 			cp -R "$objects_dir" "$repo/.git/"; } &&
 		for stuff in "$source_git"/*; do
@@ -94,7 +95,9 @@ test_perf_create_repo_from () {
 					cp -R "$stuff" "$repo/.git/" || exit 1
 					;;
 			esac
-		done &&
+		done
+	) &&
+	(
 		cd "$repo" &&
 		git init -q && {
 			test_have_prereq SYMLINKS ||
-- 
2.8.3

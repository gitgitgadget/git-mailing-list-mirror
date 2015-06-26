From: Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: git error in tag ...: unterminated header
Date: Fri, 26 Jun 2015 10:06:20 +0200
Organization: gmx
Message-ID: <d455a77d76b3558fb79d550d6ed4468d@www.dscho.org>
References: <20150625155128.C3E9738005C@gemini.denx.de>
 <xmqqegkzzoaz.fsf@gitster.dls.corp.google.com>
 <20150625201309.5026A384E81@gemini.denx.de>
 <xmqqegkzy1ri.fsf@gitster.dls.corp.google.com>
 <2b124e09d9c89ff3892f246ea91aa3c4@www.dscho.org>
 <xmqqoak3wkkq.fsf@gitster.dls.corp.google.com>
 <xmqqbng3wheu.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: Wolfgang Denk <wd@denx.de>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jun 26 10:06:38 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z8Oek-0004UD-63
	for gcvg-git-2@plane.gmane.org; Fri, 26 Jun 2015 10:06:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752146AbbFZIGd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 26 Jun 2015 04:06:33 -0400
Received: from mout.gmx.net ([212.227.15.19]:62765 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751685AbbFZIGZ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Jun 2015 04:06:25 -0400
Received: from www.dscho.org ([87.106.4.80]) by mail.gmx.com (mrgmx001) with
 ESMTPSA (Nemesis) id 0LyEJp-1Z2sDA18K5-015WxF; Fri, 26 Jun 2015 10:06:21
 +0200
In-Reply-To: <xmqqbng3wheu.fsf@gitster.dls.corp.google.com>
X-Sender: johannes.schindelin@gmx.de
User-Agent: Roundcube Webmail/1.1.0
X-Provags-ID: V03:K0:mCW96L+s3XclLWcc/T1cVlI0jXT7RRxtaOu4qCWujWagBErMlrC
 M/Rgb8gW9uj+mDUs+ncDxbcFRcASy2gw660vopinwfbmY1Tkg0i2lnazlH4pcKpvm6hn4gw
 UYZcXIwjdnRa1ItET+mAfnNk8oz59rDANccYijwjpE5BNPxrql/7w7JaAf4pMpLuOjL8jo3
 v6f7JFL+XO2D1Qe33+nDQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:FQDz3HeyflQ=:qcJuSKPWiwHIg7nnlPxCO+
 nk3vZz66mz8zaq/OYx6PTEljy3DyzIyA+30kxCMbh+HwSIQimF+WN0rajb+CPLVhsXg76wjTO
 RclOJesyRl1TMXy22XQkR35XBgEuzppFBysqBprNNH52vUHkFFLwOMp6BwC07JD0aY4Z5aCtR
 oQVBxe302wdb3wCj9HYOfzN0C/YReJnSOg0s5M207HRR+uzIcHL246olrW+n8MlZVf9XNEDLG
 Vd12RcAvXQD7PhMuwMm/0roPWsuttTNn6rd2kw8E4pZ9D/PKu6PsdWr/9uluWMlUWm809F7au
 SCeJnUlYE5PdCWarP+s+LLZZP6hxH2ipatCWbfh2Jx0Z4G5Mn/0QaQMmUTKfCgrEqKw5DTNmT
 8UwZVmxJkI+ETHXJFq0QMt9tkUmWHbo3J2+eyI18D4ckJZiksM2Ev0mJu/qV7c7uoI60lO7yk
 js/f94D6MdGOpbcRj5jVffKwvj5OxiQLd1cvIzN0BwZfM9dCKwuK/fAHddvOIp3HOcKypbZIw
 sM20Sg58Y0q/A3oA1UKjJSzraeYZFq31DUreuRiS3+ZfwIxmBFcMcQ50C9OepNvjz5DYMrhjJ
 eRnUuTGY9G2tPKVqIwREC8ZEiE5rH9p70BSAgyGxFnX9/DshN3JVzEbt8vDNgceu315TEp2fA
 W5jSds2O1kbTtl7laYPYUxXpM1RA/17NTRlFCBsSwIki6aAjdXlyNH540RdH3N48liiE=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/272765>

Hi Junio,

On 2015-06-26 00:29, Junio C Hamano wrote:
> Junio C Hamano <gitster@pobox.com> writes:
> 
>> Johannes Schindelin <johannes.schindelin@gmx.de> writes:
>> ...
>>> If the buffer does *not* contain an empty line, the fsck code runs the
>>> danger of looking beyond the allocated memory because it uses
>>> functions that assume NUL-terminated strings, while the buffer passed
>>> to the fsck code is a counted string.
>>> that already, but not all of them.
>> ...
>> I do not think you necessarily need a NUL.  As you said, your input
>> is a counted string, so you know the length of the buffer.  And you
>> are verifying line by line.  As long as you make sure the buffer
>> ends with "\n" (instead of saying "it has "\n\n" somewhere),
>> updating the existing code that does ...
>> to do this instead: ...
>> shouldn't be rocket science, no?
> 
> Here is to illustrate what I meant by the above.

I understood what you were saying, but it still appears too fragile to me to mix functions that assume NUL-terminated strings with an ad-hoc counted string check. Take `skip_prefix()` for example: it really assumes implicitly that the string is NUL-terminated because a first argument that is too short for the prefix will simply compare NUL against non-NUL at some stage. With your idea, we will now assume that all the usages of `skip_prefix()` in `fsck.c`, including future ones, will refrain from asking for a prefix containing `\n`. That might not hold true, and worse: it might not be detected because a couple of code paths *already* pass NUL-terminated buffers to fsck.

Now, we are actually talking about really rare objects, right? So why not be a little generous with memory in the very unlikely event that we encounter such a tag object? I am thinking somewhat along these lines:

-- snipsnap --
diff --git a/fsck.c b/fsck.c
index 2fffa43..4c7530a 100644
--- a/fsck.c
+++ b/fsck.c
@@ -238,10 +238,11 @@ static int fsck_tree(struct tree *item, int strict, fsck_error error_func)
 	return retval;
 }
 
-static int require_end_of_header(const void *data, unsigned long size,
+static int require_end_of_header(const char **data, unsigned long size,
 	struct object *obj, fsck_error error_func)
 {
-	const char *buffer = (const char *)data;
+	static char *nul_terminated;
+	const char *buffer = *(const char **)data;
 	unsigned long i;
 
 	for (i = 0; i < size; i++) {
@@ -255,7 +256,14 @@ static int require_end_of_header(const void *data, unsigned long size,
 		}
 	}
 
-	return error_func(obj, FSCK_ERROR, "unterminated header");
+	/* TODO: when fsck-opt hits `next`, test whether to error out here */
+	if (nul_terminated)
+		free(nul_terminated);
+	nul_terminated = xmalloc(size + 1);
+	memcpy(nul_terminated, *data, size);
+	nul_terminated[size] = '\0';
+	*data = nul_terminated;
+	return 0;
 }
 
 static int fsck_ident(const char **ident, struct object *obj, fsck_error error_func)
@@ -297,15 +304,16 @@ static int fsck_ident(const char **ident, struct object *obj, fsck_error error_f
 	return 0;
 }
 
-static int fsck_commit_buffer(struct commit *commit, const char *buffer,
+static int fsck_commit_buffer(struct commit *commit, const char *orig,
 	unsigned long size, fsck_error error_func)
 {
+	const char *buffer = orig;
 	unsigned char tree_sha1[20], sha1[20];
 	struct commit_graft *graft;
 	unsigned parent_count, parent_line_count = 0;
 	int err;
 
-	if (require_end_of_header(buffer, size, &commit->object, error_func))
+	if (require_end_of_header(&buffer, size, &commit->object, error_func))
 		return -1;
 
 	if (!skip_prefix(buffer, "tree ", &buffer))
@@ -356,9 +364,10 @@ static int fsck_commit(struct commit *commit, const char *data,
 	return ret;
 }
 
-static int fsck_tag_buffer(struct tag *tag, const char *data,
+static int fsck_tag_buffer(struct tag *tag, const char *orig,
 	unsigned long size, fsck_error error_func)
 {
+	const char *data = orig;
 	unsigned char sha1[20];
 	int ret = 0;
 	const char *buffer;
@@ -384,7 +393,7 @@ static int fsck_tag_buffer(struct tag *tag, const char *data,
 		}
 	}
 
-	if (require_end_of_header(buffer, size, &tag->object, error_func))
+	if (require_end_of_header(&buffer, size, &tag->object, error_func))
 		goto done;
 
 	if (!skip_prefix(buffer, "object ", &buffer)) {

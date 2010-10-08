From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC PATCH v5 0/3] git-remote-fd & git-remote-ext
Date: Fri, 08 Oct 2010 12:56:51 -0700
Message-ID: <7vtykwv4os.fsf@alter.siamese.dyndns.org>
References: <1286563200-7270-1-git-send-email-ilari.liusvaara@elisanet.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Ilari Liusvaara <ilari.liusvaara@elisanet.fi>
X-From: git-owner@vger.kernel.org Fri Oct 08 21:57:12 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P4J3z-0003Uh-Rv
	for gcvg-git-2@lo.gmane.org; Fri, 08 Oct 2010 21:57:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754829Ab0JHT5B (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 8 Oct 2010 15:57:01 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:53751 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751741Ab0JHT5A (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Oct 2010 15:57:00 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 4D789DD8FE;
	Fri,  8 Oct 2010 15:56:58 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=/qLy9x8RaQeo0T/B8pG0fDphV0Y=; b=YhmHr+
	MZvDtLqNMv933icCTRjIRYf32VKNFHfrGlWacQLKRgird644ndqpPsU/Opepm/CM
	UWzlB7ajs77cRkWppdCqX7dJWtMOmHSOF0hjnM6HIXzG5VL3LtcSIeXLYdWo0FIX
	yCZJ9OEzLt5UiBfHy/nqF4iD3iqL4T5tOZpYU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=YZwML0zvI3qrKB0y03XIHb9ccW30Safz
	QLpGs42ae2wV2CVHUt822LtLUjFBrgnFmwM0uRKWIosZt3jWBxs4s3PqD8/iCDlG
	onStgwx5MxbqR+1A2A7ChCFWsk+n9iggcWqbLCkJF1Mm61NtbMlTuQXj4N7YUs19
	qsfqyzmjBRg=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 0E862DD8FD;
	Fri,  8 Oct 2010 15:56:56 -0400 (EDT)
Received: from pobox.com (unknown [76.102.252.155]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 1CC2ADD8FC; Fri,  8 Oct
 2010 15:56:52 -0400 (EDT)
In-Reply-To: <1286563200-7270-1-git-send-email-ilari.liusvaara@elisanet.fi>
 (Ilari Liusvaara's message of "Fri\,  8 Oct 2010 21\:39\:57 +0300")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 340B8A98-D316-11DF-AC56-030CEE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/158530>

Every time I queued this series, I've been fixing up styles without
complaining.  It is boring and in general not very fun to spend time
fixing style violations, and the worst part of the story is that by the
time I am done, I don't have time left for addressing issues in the
substance of the patch or energy and concentration required for handling
patches from other people.

I think I probably should have complained earlier.  I am assuming that you
are rewriting and rebasing, so once they are fixed at your end, I will
hopefully have to re-fix everything over and over again in the future
round.

Could you fix these up at your end please?

ERROR: space required before the open parenthesis '('
#216: FILE: transport-helper.c:990:
+	while(t->state != SSTATE_FINISHED) {

ERROR: "foo* bar" should be "foo *bar"
#596: FILE: builtin/remote-fd.c:58:
+	char* end;

ERROR: spaces required around that '!=' (ctx:WxV)
#603: FILE: builtin/remote-fd.c:65:
+	if ((end == argv[2]) || (*end != ',' && *end !='/' && *end))
 	                                             ^

ERROR: "foo* bar" should be "foo *bar"
#609: FILE: builtin/remote-fd.c:71:
+		char* end2;

ERROR: spaces required around that '!=' (ctx:WxV)
#612: FILE: builtin/remote-fd.c:74:
+		if ((end2 == end + 1) || (*end2 !='/' && *end2))
 		                                ^

ERROR: do not initialise globals to 0 or NULL
#897: FILE: builtin/remote-ext.c:24:
+char* git_req = NULL;

ERROR: "foo* bar" should be "foo *bar"
#897: FILE: builtin/remote-ext.c:24:
+char* git_req = NULL;

ERROR: do not initialise globals to 0 or NULL
#898: FILE: builtin/remote-ext.c:25:
+char* git_req_vhost = NULL;

ERROR: "foo* bar" should be "foo *bar"
#898: FILE: builtin/remote-ext.c:25:
+char* git_req_vhost = NULL;

ERROR: space required before the open parenthesis '('
#959: FILE: builtin/remote-ext.c:86:
+			switch(str[rpos]) {

ERROR: space required before the open parenthesis '('
#973: FILE: builtin/remote-ext.c:100:
+			switch(str[rpos]) {

ERROR: space required before the open parenthesis '('
#983: FILE: builtin/remote-ext.c:110:
+	switch(special) {

ERROR: "foo** bar" should be "foo **bar"
#1002: FILE: builtin/remote-ext.c:129:
+	char** ret;

ERROR: "foo* bar" should be "foo *bar"
#1006: FILE: builtin/remote-ext.c:133:
+		char* ret;

ERROR: "(foo*)" should be "(foo *)"
#1014: FILE: builtin/remote-ext.c:141:
+	ret = xcalloc(arguments + 1, sizeof(char*));

ERROR: "(foo**)" should be "(foo **)"
#1018: FILE: builtin/remote-ext.c:145:
+	return (const char**)ret;

ERROR: "foo* bar" should be "foo *bar"
#1026: FILE: builtin/remote-ext.c:153:
+	char* buffer;

total: 17 errors, 0 warnings, 851 lines checked

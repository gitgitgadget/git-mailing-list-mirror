From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: What's cooking in git.git (Jul 2015, #07; Mon, 27)
Date: Thu, 30 Jul 2015 11:58:05 +0200
Message-ID: <vpqoaiu9dci.fsf@anie.imag.fr>
References: <xmqqpp3dgurr.fsf@gitster.dls.corp.google.com>
	<20150730002925.GF809807@vauxhall.crustytoothpaste.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: "brian m. carlson" <sandals@crustytoothpaste.net>
X-From: git-owner@vger.kernel.org Thu Jul 30 11:58:31 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZKkbd-00085P-Gy
	for gcvg-git-2@plane.gmane.org; Thu, 30 Jul 2015 11:58:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755357AbbG3J6Z (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 30 Jul 2015 05:58:25 -0400
Received: from mx1.imag.fr ([129.88.30.5]:41025 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755217AbbG3J6Y (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 30 Jul 2015 05:58:24 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id t6U9w5Id027038
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NO);
	Thu, 30 Jul 2015 11:58:07 +0200
Received: from anie.imag.fr (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id t6U9w5W6032559;
	Thu, 30 Jul 2015 11:58:05 +0200
In-Reply-To: <20150730002925.GF809807@vauxhall.crustytoothpaste.net> (brian m.
	carlson's message of "Thu, 30 Jul 2015 00:29:25 +0000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Thu, 30 Jul 2015 11:58:07 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: t6U9w5Id027038
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1438855088.15831@NxDXI/zxTCvNxfvkYUefbQ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/274978>

"brian m. carlson" <sandals@crustytoothpaste.net> writes:

> On Mon, Jul 27, 2015 at 02:23:04PM -0700, Junio C Hamano wrote:
>> * bc/object-id (2015-06-17) 10 commits
>>  . remote.c: use struct object_id in many functions
>>  . object-id: use struct object_id in struct object
>>  . remote.c: use struct object_id in ref_newer()
>>  . transport-helper.c: use struct object_id in push_refs_with_export()
>>  . connect.c: use struct object_id in get_remote_heads()
>>  . remote-curl: use struct object_id in parse_fetch()
>>  . fetch-pack: use struct object_id in add_sought_entry_mem()
>>  . object_id: convert struct ref to use object_id.
>>  . sha1_file: introduce has_object_file() helper
>>  . refs: convert some internal functions to use object_id
>> 
>>  More transition from "unsigned char[40]" to "struct object_id".
>> 
>>  While GSoC and other topics are actively moving existing code
>>  around, this cannot go in; ejected from 'pu'.
>
> Is there anything I can do to make this series less painful (e.g. a
> reroll or such)?

For the GSoC part, "Suggested 'pencils down' date" is August 17th. The
"Firm 'pencils down date'" is on 21th, so things should stabilize.

On the "unify ref-listing commands" side, the big code movement is in
kn/for-each-ref which should hit master soon, but there are other less
intrusive series active.

(That doesn't really answer your question, but may be relevant
information)

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/

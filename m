From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/2] graph.c: avoid compile warnings
Date: Mon, 30 Mar 2009 09:14:50 -0700
Message-ID: <7v1vsff0n9.fsf@gitster.siamese.dyndns.org>
References: <20090330141322.GA6221@linux.vnet>
 <cover.1238428115u.git.johannes.schindelin@gmx.de>
 <7ee8d1c4ca806ce964356a1fe78efac19d56c29b.1238428115u.git.johannes.schindelin@gmx.de> <7vd4bzf1e5.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Allan Caffee <allan.caffee@gmail.com>,
	Jeff King <peff@peff.net>,
	Nanako Shiraishi <nanako3@lavabit.com>
To: Johannes Schindelin <johannes.schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon Mar 30 18:17:05 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LoKAB-0004dB-Uh
	for gcvg-git-2@gmane.org; Mon, 30 Mar 2009 18:16:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753443AbZC3QPF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 30 Mar 2009 12:15:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752745AbZC3QPE
	(ORCPT <rfc822;git-outgoing>); Mon, 30 Mar 2009 12:15:04 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:59253 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753191AbZC3QPB (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Mar 2009 12:15:01 -0400
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id EEEF1A627B;
	Mon, 30 Mar 2009 12:14:58 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 3B66CA6278; Mon,
 30 Mar 2009 12:14:51 -0400 (EDT)
In-Reply-To: <7vd4bzf1e5.fsf@gitster.siamese.dyndns.org> (Junio C. Hamano's
 message of "Mon, 30 Mar 2009 08:58:42 -0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: EA5C1D90-1D45-11DE-B2EE-32B0EBB1AA3C-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/115173>

Junio C Hamano <gitster@pobox.com> writes:

>> diff --git a/graph.c b/graph.c
>> index 2929c8b..5e2f224 100644
>> --- a/graph.c
>> +++ b/graph.c
>> @@ -701,8 +701,8 @@ static void graph_output_pre_commit_line(struct git_graph *graph,
>>  	for (i = 0; i < graph->num_columns; i++) {
>>  		struct column *col = &graph->columns[i];
>>  		if (col->commit == graph->commit) {
>> -			seen_this = 1;
>>  			struct strbuf tmp = STRBUF_INIT;
>> +			seen_this = 1;
>
> Which codebase are you working on top of?

Nevermind.  I didn't realize it was "here are to help whipping your series
into shape" meant for Allan.

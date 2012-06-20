From: Thomas Rast <trast@student.ethz.ch>
Subject: Re: [PATCH 0/9] Extending the shelf life of "git describe" output
Date: Wed, 20 Jun 2012 09:40:00 +0200
Message-ID: <877gv2xwhb.fsf@thomas.inf.ethz.ch>
References: <1340057139-8311-1-git-send-email-gitster@pobox.com>
	<877gv34vtg.fsf@thomas.inf.ethz.ch>
	<7vfw9qyk6m.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Cc: <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jun 20 09:40:11 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ShFWM-000355-PJ
	for gcvg-git-2@plane.gmane.org; Wed, 20 Jun 2012 09:40:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754128Ab2FTHkE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 Jun 2012 03:40:04 -0400
Received: from edge20.ethz.ch ([82.130.99.26]:26129 "EHLO edge20.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752259Ab2FTHkD (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Jun 2012 03:40:03 -0400
Received: from CAS20.d.ethz.ch (172.31.51.110) by edge20.ethz.ch
 (82.130.99.26) with Microsoft SMTP Server (TLS) id 14.2.298.4; Wed, 20 Jun
 2012 09:40:02 +0200
Received: from thomas.inf.ethz.ch.ethz.ch (129.132.153.233) by CAS20.d.ethz.ch
 (172.31.51.110) with Microsoft SMTP Server (TLS) id 14.2.298.4; Wed, 20 Jun
 2012 09:40:01 +0200
In-Reply-To: <7vfw9qyk6m.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
	message of "Tue, 19 Jun 2012 16:08:01 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Originating-IP: [129.132.153.233]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/200288>

Junio C Hamano <gitster@pobox.com> writes:

> Thomas Rast <trast@student.ethz.ch> writes:
>
>> Two random thoughts:
>>
>> * The commit_only flag is only one thing you may "know" about the
>>   parsing, as you state above.  E.g., we may know the distance from a
>>   certain tag.  Given this, wouldn't it be cleaner to patch a struct
>>   things_we_know into the call chain instead of only a flag?
>>
>> * The treeish:path syntax also "knows" that the left side must be or
>>   peel to a tree, so it makes no sense to go looking for a blob.
>
> Both good.  I take it to mean that we found a volunteer to take the
> ownership of the second idea to build on top of the series ;-)

Does the idea come with round tuits included? :-)

-- 
Thomas Rast
trast@{inf,student}.ethz.ch

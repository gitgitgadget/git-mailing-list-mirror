From: greened@obbligato.org (David A. Greene)
Subject: Re: [PATCH v2] contrib/subtree: unwrap tag refs
Date: Tue, 12 Jan 2016 20:42:52 -0600
Message-ID: <878u3up5cj.fsf@waller.obbligato.org>
References: <1447435549-34410-1-git-send-email-mayoff@dqd.com>
	<20151124215258.GC29185@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Rob Mayoff <mayoff@dqd.com>, git@vger.kernel.org, gitster@pobox.com
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Jan 13 03:43:08 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aJBOt-0001lD-Ft
	for gcvg-git-2@plane.gmane.org; Wed, 13 Jan 2016 03:43:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754519AbcAMCnA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 Jan 2016 21:43:00 -0500
Received: from li209-253.members.linode.com ([173.255.199.253]:58462 "EHLO
	johnson.obbligato.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753443AbcAMCm7 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Jan 2016 21:42:59 -0500
Received: from chippewa-nat.cray.com ([136.162.34.1] helo=waller.obbligato.org)
	by johnson.obbligato.org with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
	(Exim 4.85)
	(envelope-from <greened@obbligato.org>)
	id 1aJBPv-0001Yx-Hk; Tue, 12 Jan 2016 20:44:11 -0600
In-Reply-To: <20151124215258.GC29185@sigill.intra.peff.net> (Jeff King's
	message of "Tue, 24 Nov 2015 16:52:58 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.5 (gnu/linux)
X-Filter-Spam-Score: ()
X-Filter-Spam-Report: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/283870>

Jeff King <peff@peff.net> writes:

> On Fri, Nov 13, 2015 at 11:25:49AM -0600, Rob Mayoff wrote:
>
>> If a subtree was added using a tag ref, the tag ref is stored in
>> the subtree commit message instead of the underlying commit's ref.
>> To split or push subsequent changes to the subtree, the subtree
>> command needs to unwrap the tag ref.  This patch makes it do so.
>> 
>> The problem was described in a message to the mailing list from
>> Junio C Hamano dated 29 Apr 2014, with the subject "Re: git subtree
>> issue in more recent versions". The archived message can be found
>> at <http://comments.gmane.org/gmane.comp.version-control.git/247503>.> 
>> Signed-off-by: Rob Mayoff <mayoff@dqd.com>
>> ---
>> 
>> changes since v1:
>> 
>> * remove obsolete sub assignments
>> * wrap lines
>
> Thanks.  David, can I get an Ack on this?

Yep.  I'm sorry I missed this re-roll.

                             -David

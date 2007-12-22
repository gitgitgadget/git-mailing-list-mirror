From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Move git send-email cover letter temporary file to $GIT_DIR
Date: Sat, 22 Dec 2007 00:52:09 -0800
Message-ID: <7vd4szyuva.fsf@gitster.siamese.dyndns.org>
References: <7vhcic9e17.fsf@gitster.siamese.dyndns.org>
	<1198284202-20666-1-git-send-email-hendeby@isy.liu.se>
	<7vmys3358v.fsf@gitster.siamese.dyndns.org>
	<ee77f5c20712211718g230802b6jb70e5db1f6a43973@mail.gmail.com>
	<7vhcib2phi.fsf@gitster.siamese.dyndns.org>
	<ee77f5c20712212304s598d344dg41d03f58084d794e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Junio C Hamano" <gitster@pobox.com>,
	"Gustaf Hendeby" <hendeby@isy.liu.se>, luciano@eurotux.com,
	git@vger.kernel.org
To: "David Symonds" <dsymonds@gmail.com>
X-From: git-owner@vger.kernel.org Sat Dec 22 09:52:54 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J606B-0004Mz-FI
	for gcvg-git-2@gmane.org; Sat, 22 Dec 2007 09:52:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752043AbXLVIwY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 22 Dec 2007 03:52:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750936AbXLVIwX
	(ORCPT <rfc822;git-outgoing>); Sat, 22 Dec 2007 03:52:23 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:51656 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750825AbXLVIwX (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 22 Dec 2007 03:52:23 -0500
Received: from a-sasl-quonix (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id F30AA672E;
	Sat, 22 Dec 2007 03:52:21 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 59A65672D;
	Sat, 22 Dec 2007 03:52:16 -0500 (EST)
In-Reply-To: <ee77f5c20712212304s598d344dg41d03f58084d794e@mail.gmail.com>
	(David Symonds's message of "Sat, 22 Dec 2007 18:04:03 +1100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/69128>

"David Symonds" <dsymonds@gmail.com> writes:

> On Dec 22, 2007 5:49 PM, Junio C Hamano <gitster@pobox.com> wrote:
>>
>> "David Symonds" <dsymonds@gmail.com> writes:
>>
>> > On Dec 22, 2007 12:09 PM, Junio C Hamano <gitster@pobox.com> wrote:
>> >> Don't you have $repo (an instance of Git) at that point?  You
>> >> should be able to ask repo_path() about it, shouldn't you?
>> >
>> > Isn't git-send-email still useful outside a Git repo?
>>
>> Then why does it run "rev-parse --git-dir"?
>
> I'm suggesting that it should still function just fine without being
> inside a repo, so it should adequately handle "rev-parse --git-dir"
> returning 128.

Ah, true.  Then the current behaviour to use the $(pwd) for
temporary file area would be Ok for now.

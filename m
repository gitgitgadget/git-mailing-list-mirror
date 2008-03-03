From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Make builtin-reset.c use parse_options.
Date: Mon, 03 Mar 2008 14:40:40 -0800
Message-ID: <7vwsojfn2v.fsf@gitster.siamese.dyndns.org>
References: <47C98472.8000002@gmail.com>
 <7vir05x2di.fsf@gitster.siamese.dyndns.org>
 <1b46aba20803020437p2a5128a5wfee3e98c32c1a610@mail.gmail.com>
 <7vbq5xqetq.fsf@gitster.siamese.dyndns.org>
 <1b46aba20803030607v726a6ba1y49ca8524e09c6eae@mail.gmail.com>
 <20080303170706.GA23210@artemis.madism.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Carlos Rica <jasampler@gmail.com>, git@vger.kernel.org
To: Pierre Habouzit <madcoder@debian.org>
X-From: git-owner@vger.kernel.org Mon Mar 03 23:41:38 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JWJLc-00005x-Qr
	for gcvg-git-2@gmane.org; Mon, 03 Mar 2008 23:41:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751930AbYCCWku (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 Mar 2008 17:40:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752183AbYCCWku
	(ORCPT <rfc822;git-outgoing>); Mon, 3 Mar 2008 17:40:50 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:41105 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751032AbYCCWkt (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Mar 2008 17:40:49 -0500
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 499A8235D;
	Mon,  3 Mar 2008 17:40:48 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id 890D3235C; Mon,  3 Mar 2008 17:40:42 -0500 (EST)
In-Reply-To: <20080303170706.GA23210@artemis.madism.org> (Pierre Habouzit's
 message of "Mon, 03 Mar 2008 18:07:07 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/75991>

Pierre Habouzit <madcoder@debian.org> writes:

> On Mon, Mar 03, 2008 at 02:07:57PM +0000, Carlos Rica wrote:
>> On Sun, Mar 2, 2008 at 5:18 PM, Junio C Hamano <gitster@pobox.com> wrote:
>> >  Although "--h" still favors "--hard" over "--help":
>> >
>> >         $ ./git-reset --h
>> >         HEAD is now at c149184...
>> >
>> 
>> Pierre, is there a way to give preference to --help over --hard
>> when someone uses --h in command line?
>
>   The problem is that --help (and --help-all for the matter) are "magic"
> arguments that parse-options is not aware of when it deals with
> abbreviations.

Yeah, I do not know if this really matters in real life, though.

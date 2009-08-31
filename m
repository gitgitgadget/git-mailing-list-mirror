From: "Yann Dirson" <ydirson@linagora.com>
Subject: Re: [BUG] git stash refuses to save after "add -N"
Date: Mon, 31 Aug 2009 10:16:34 +0200
Message-ID: <51ce4af01c8de1adb66a1818baab1f8a.squirrel@intranet.linagora.com>
References: <54e098c45bffbf870bdfcee26b9ddecc.squirrel@intranet.linagora.com>
    <20090828190531.GB11488@coredump.intra.peff.net>
    <7vmy5ixn96.fsf@alter.siamese.dyndns.org>
    <20090830095509.GB30922@coredump.intra.peff.net>
    <7v63c5f4vs.fsf@alter.siamese.dyndns.org>
    <20090831042724.GA16646@coredump.intra.peff.net>
    <7vljl0lgms.fsf@alter.siamese.dyndns.org>
    <20090831050554.GA17197@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: "Junio C Hamano" <gitster@pobox.com>,
	"Yann Dirson" <ydirson@linagora.com>, git@vger.kernel.org
To: "Jeff King" <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Aug 31 10:16:35 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mi240-0000yq-Vn
	for gcvg-git-2@lo.gmane.org; Mon, 31 Aug 2009 10:16:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751751AbZHaIQW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 31 Aug 2009 04:16:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751606AbZHaIQW
	(ORCPT <rfc822;git-outgoing>); Mon, 31 Aug 2009 04:16:22 -0400
Received: from alderaan.linagora.com ([84.14.148.74]:57562 "EHLO
	alderaan.linagora.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751166AbZHaIQV (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 31 Aug 2009 04:16:21 -0400
Received: from 10.0.0.2 (unknown [10.75.192.3])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alderaan.linagora.com (Postfix) with ESMTPSA id 12D90429F03;
	Mon, 31 Aug 2009 10:16:22 +0200 (CEST)
Received: from 10.0.0.1 (proxying for 194.206.158.221)
        (SquirrelMail authenticated user ydirson)
        by intranet.linagora.com with HTTP;
        Mon, 31 Aug 2009 10:16:34 +0200
In-Reply-To: <20090831050554.GA17197@coredump.intra.peff.net>
User-Agent: SquirrelMail/1.4.18
X-Priority: 3 (Normal)
Importance: Normal
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/127471>

> On Sun, Aug 30, 2009 at 10:03:07PM -0700, Junio C Hamano wrote:
>
>> >   - "-f" is kind of vague. Would people expect it to force aspects of
>> >     the stash? Should it be "--intent-as-empty"?
>>
>> I am not sure if asking for positive confirmation with "-f" is even
>> worth
>> it.  As you pointed out in your earlier message, which prompted me to
>> respond with a patch, when this codepath is exercised, the user is in a
>> rush, and I do not see what else the user would want to do other than
>> including it in the stash by rerunning with -f.
>
> I guess it was just to mitigate my fear that we are somehow creating a
> stash that will confuse people when they apply it. But really that fear
> is probably unjustified.

Well, indeed each time I use "add -N" it is mostly to get "git diff" show
me the contents of the new file as part of my WIP, so it would not make
much difference to me if "add -N" would just add the file as empty to the
index in the first place.

Out of curiosity, does anyone make any use of the current difference
between not-added-yet and added-as-empty ?

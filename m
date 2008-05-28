From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Commit cce8d6fdb introduces file t/t5100/nul, git tree is now
 incompatible with Cygwin (and probably Windows)
Date: Wed, 28 May 2008 11:27:01 -0700
Message-ID: <7vwslethca.fsf@gitster.siamese.dyndns.org>
References: <483AC2CE.7090801@gmail.com>
 <7vy75vvtxo.fsf@gitster.siamese.dyndns.org>
 <32541b130805280933r573d59d0mf9cdc09f5e5a6a17@mail.gmail.com>
 <7vfxs2uytm.fsf@gitster.siamese.dyndns.org>
 <32541b130805281052o2a56f00m4b64299737d27091@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Mark Levedahl" <mlevedahl@gmail.com>,
	"Git Mailing List" <git@vger.kernel.org>,
	"Johannes Schindelin" <Johannes.Schindelin@gmx.de>
To: "Avery Pennarun" <apenwarr@gmail.com>
X-From: git-owner@vger.kernel.org Wed May 28 20:28:27 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K1QNr-0002s3-AK
	for gcvg-git-2@gmane.org; Wed, 28 May 2008 20:28:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753032AbYE1S1Z (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 May 2008 14:27:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751940AbYE1S1Y
	(ORCPT <rfc822;git-outgoing>); Wed, 28 May 2008 14:27:24 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:34599 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753687AbYE1S1T (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 May 2008 14:27:19 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id EC2D75457;
	Wed, 28 May 2008 14:27:17 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id 09A9F5455; Wed, 28 May 2008 14:27:10 -0400 (EDT)
In-Reply-To: <32541b130805281052o2a56f00m4b64299737d27091@mail.gmail.com>
 (Avery Pennarun's message of "Wed, 28 May 2008 13:52:56 -0400")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: B3F7DD96-2CE3-11DD-A3BA-80001473D85F-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/83122>

"Avery Pennarun" <apenwarr@gmail.com> writes:

> On 5/28/08, Junio C Hamano <gitster@pobox.com> wrote:
>>  Please learn to think before typing, let alone sending such a message to
>>  waste other people's time.
>
> Phew, just mentioning Windows on this list seems to get people flamed.

I did not flame Windows.

> Reading over my message, I'm not sure what I would have written to
> have it interpreted as being negative....
> The part that's not surviving is git-bisect, which is a valid problem
> that resulted in someone asking to rewrite the history.  Clearly
> rewriting the history is not a good solution, thus no good solution
> has yet been proposed, which is why I wrote my message.

Here is what you wrote:

    As an unhappy Windows user myself (sometimes), I think it might be
    better to simply fix git to *survive* failing to create files like
    'nul' on Win32, rather than trying to *fix* such files in the repo.
    It sounds (from the original post) like git has a *fatal* error
    ("cannot be checked out on cygwin") when trying to create 'nul', which
    might be overkill.

"Survive failing to create files"?  "Fatal error when trying to create
'nul', which might be overkill"?  

If you cannot faithfully recreate the work tree state, you cannot test
that revision.  You cannot bisect and test that revision on that system.
Too bad, but you still have "git reset --hard".  You reset to some other
revision that you _can_ checkout and do sensible tests and move on.

How would you know to reset to recover from your system's deficiency
unless git gives "fatal error"?

That's why I asked you to think before type, which again you did not do,
and that is what got you get "flamed", even though I do not think it was
particularly harsh.

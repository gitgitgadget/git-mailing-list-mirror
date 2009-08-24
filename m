From: Jan Engelhardt <jengelh@medozas.de>
Subject: Re: [PATCH] send-email: confirm on empty mail subjects
Date: Mon, 24 Aug 2009 19:27:56 +0200 (CEST)
Message-ID: <alpine.LSU.2.00.0908241927300.5382@fbirervta.pbzchgretzou.qr>
References: <1249490994-23455-1-git-send-email-jengelh@medozas.de> <7vhbwlpigo.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Aug 24 19:28:09 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MfdKx-0007gY-H2
	for gcvg-git-2@lo.gmane.org; Mon, 24 Aug 2009 19:28:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753023AbZHXR14 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 24 Aug 2009 13:27:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753003AbZHXR14
	(ORCPT <rfc822;git-outgoing>); Mon, 24 Aug 2009 13:27:56 -0400
Received: from sovereign.computergmbh.de ([85.214.69.204]:38465 "EHLO
	sovereign.computergmbh.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753021AbZHXR14 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 24 Aug 2009 13:27:56 -0400
Received: by sovereign.computergmbh.de (Postfix, from userid 25121)
	id 6F5879C866; Mon, 24 Aug 2009 19:27:56 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by sovereign.computergmbh.de (Postfix) with ESMTP id 6CF684318936;
	Mon, 24 Aug 2009 19:27:56 +0200 (CEST)
In-Reply-To: <7vhbwlpigo.fsf@alter.siamese.dyndns.org>
User-Agent: Alpine 2.00 (LSU 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/126948>

On Thursday 2009-08-06 08:25, Junio C Hamano wrote:

>Jan Engelhardt <jengelh@medozas.de> writes:
>
>> When the user forgot to enter a subject in a compose session,
>> send-email will now inquire whether this is really intended, similar
>> to what the Alpine MUA does when a subject is absent.
>
>This seems to break t9001...
>

Did I miss something in building?

19:26 sovereign:../git/git-1.6.4.1 > quilt pu
Applying patch patches/send-email-empty-subject.diff
patching file git-send-email.perl

Now at patch patches/send-email-empty-subject.diff
19:26 sovereign:../git/git-1.6.4.1 > cd t
19:26 sovereign:../git-1.6.4.1/t > ./t9001-send-email.sh 
*   ok 1: prepare reference tree
*   ok 2: Setup helper tool
*   ok 3: Extract patches
*   ok 4: No confirm with --suppress-cc
*   ok 5: No confirm with --confirm=never
*   ok 6: No confirm with sendemail.confirm=never
*   ok 7: Send patches
*   ok 8: Verify commandline
*   ok 9: Show all headers
*   ok 10: Prompting works
*   ok 11: cccmd works
*   ok 12: reject long lines
*   ok 13: no patch was sent
*   ok 14: Author From: in message body
*   ok 15: Author From: not in message body
*   ok 16: allow long lines with --no-validate
*   ok 17: Invalid In-Reply-To
*   ok 18: Valid In-Reply-To when prompting
*   ok 19: setup fake editor
*   ok 20: --compose works
*   ok 21: first message is compose text
*   ok 22: second message is patch
*   ok 23: sendemail.cc set
*   ok 24: sendemail.cc unset
*   ok 25: sendemail.cccmd
*   ok 26: --suppress-cc=all
*   ok 27: --suppress-cc=body
*   ok 28: --suppress-cc=body --suppress-cc=cccmd
*   ok 29: --suppress-cc=sob
*   ok 30: --suppress-cc=bodycc
*   ok 31: --suppress-cc=cc
*   ok 32: --confirm=always
*   ok 33: --confirm=auto
*   ok 34: --confirm=cc
*   ok 35: --confirm=compose
*   ok 36: confirm by default (due to cc)
*   ok 37: confirm by default (due to --compose)
*   ok 38: confirm detects EOF (inform assumes y)
*   ok 39: confirm detects EOF (auto causes failure)
*   ok 40: confirm doesnt loop forever
*   ok 41: utf8 Cc is rfc2047 encoded
*   ok 42: --compose adds MIME for utf8 body
*   ok 43: --compose respects user mime type
*   ok 44: --compose adds MIME for utf8 subject
*   ok 45: detects ambiguous reference/file conflict
*   ok 46: feed two files
*   ok 47: in-reply-to but no threading
*   ok 48: no in-reply-to and no threading
*   ok 49: threading but no chain-reply-to
* passed all 49 test(s)

From: Brandon Casey <casey@nrlssc.navy.mil>
Subject: Re: [PATCH] t5540-http-push.sh: avoid non-portable grep -P
Date: Thu, 26 Feb 2009 18:12:26 -0600
Message-ID: <4WGE1cq9SGp9DuzqT2ZuVN0RzLGmBe1mAX4n1O4-TNyRqiZqxDP62A@cipher.nrlssc.navy.mil>
References: <1235677745-939-1-git-send-email-jaysoffian@gmail.com> <7vwsbdq6u4.fsf@gitster.siamese.dyndns.org> <76718490902261243gaebdd8an2bd75bf625556f7b@mail.gmail.com> <7vmyc8rhry.fsf@gitster.siamese.dyndns.org> <76718490902261419r314f6ea4r5eb02e9b5b0c40d0@mail.gmail.com> <7veixkrfif.fsf@gitster.siamese.dyndns.org> <76718490902261440p4c9981fbncbdd58ad12e38349@mail.gmail.com> <7v4oygrd3w.fsf@gitster.siamese.dyndns.org> <wRrDhWKagbvPUgIXKKh8JIhASl974j2rrgyuh-WEzRJFcXywywNupg@cipher.nrlssc.navy.mil> <alpine.DEB.1.00.0902270056270.10279@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Jay Soffian <jaysoffian@gmail.com>, git@vger.kernel.org,
	Tay Ray Chuan <rctay89@gmail.com>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Fri Feb 27 01:14:22 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LcqMu-0007va-HP
	for gcvg-git-2@gmane.org; Fri, 27 Feb 2009 01:14:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759682AbZB0AMg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 Feb 2009 19:12:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759684AbZB0AMg
	(ORCPT <rfc822;git-outgoing>); Thu, 26 Feb 2009 19:12:36 -0500
Received: from mail1.nrlssc.navy.mil ([128.160.35.1]:60429 "EHLO
	mail.nrlssc.navy.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755489AbZB0AMf (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Feb 2009 19:12:35 -0500
Received: by mail.nrlssc.navy.mil id n1R0CQbi008311; Thu, 26 Feb 2009 18:12:27 -0600
In-Reply-To: <alpine.DEB.1.00.0902270056270.10279@pacific.mpi-cbg.de>
X-OriginalArrivalTime: 27 Feb 2009 00:12:26.0694 (UTC) FILETIME=[12437660:01C99870]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/111619>

Johannes Schindelin wrote:
> Hi,
> 
> On Thu, 26 Feb 2009, Brandon Casey wrote:
> 
>>    sed -e 'script' input-file
>>
>> rather than
>>
>>    sed -e 'script' < input-file
> 
> What should make the former more preferable to the latter?

It's less complex, but as you describe in the next paragraph, if the
file name is not desired in the result then the latter is preferable.
I initially viewed the latter form as a useless use of cat, equivalent
to:

   cat input-file | sed -e 'script'

> Especially given that the latter way is preferable with other commands (at 
> least as far as our test suite is concerned), such as grep, because you do 
> not get the file name as part of the result?
> 
> And especially given that sed means _stream_ editor, not file editor?

especially? Your first argument is valid, but this last sentence means nothing.

-brandon

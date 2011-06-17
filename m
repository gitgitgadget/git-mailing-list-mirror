From: Brandon Casey <brandon.casey.ctr@nrlssc.navy.mil>
Subject: Re: git imap-send converting my patches to CRLF line endings?
Date: Fri, 17 Jun 2011 10:37:54 -0500
Message-ID: <Oe8m5NtYZicsi6Z4FtNIXAfsB9Q9XcHSsoAYmKdxQkoDVJOKykQTEg@cipher.nrlssc.navy.mil>
References: <BANLkTimXQQX_Fu0fgtWneF2cCLUZFhTaCg@mail.gmail.com>	<20110617141450.GA12114@sigill.intra.peff.net> <BANLkTin1DAv0pZmZCcrtDyjrUD-ukO6MNQ@mail.gmail.com> <Svak9atXpisIKwqaYKGMzry3LEHEDPnWLLqFpfgP7IOuAVUdRy8brA@cipher.nrlssc.navy.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
To: Michael Mc Donnell <michael@mcdonnell.dk>
X-From: git-owner@vger.kernel.org Fri Jun 17 17:38:11 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QXb7b-0006qW-CQ
	for gcvg-git-2@lo.gmane.org; Fri, 17 Jun 2011 17:38:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759424Ab1FQPiF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 17 Jun 2011 11:38:05 -0400
Received: from mail1.nrlssc.navy.mil ([128.160.35.1]:46663 "EHLO
	mail.nrlssc.navy.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759210Ab1FQPiE (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 17 Jun 2011 11:38:04 -0400
Received: by mail.nrlssc.navy.mil id p5HFbrxJ006646; Fri, 17 Jun 2011 10:37:53 -0500
In-Reply-To: <Svak9atXpisIKwqaYKGMzry3LEHEDPnWLLqFpfgP7IOuAVUdRy8brA@cipher.nrlssc.navy.mil>
X-OriginalArrivalTime: 17 Jun 2011 15:37:54.0401 (UTC) FILETIME=[86592510:01CC2D04]
X-Virus-Scanned: clamav-milter 0.95.3 at mail1
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/175954>

On 06/17/2011 10:08 AM, Brandon Casey wrote:
> On 06/17/2011 09:45 AM, Michael Mc Donnell wrote:
>> On Fri, Jun 17, 2011 at 4:14 PM, Jeff King <peff@peff.net> wrote:
>>> On Fri, Jun 17, 2011 at 03:35:04PM +0200, Michael Mc Donnell wrote:
> 
>>> How do you download and apply the patch exactly? If you are speaking
>>> imap to gmail, generally the client would strip out the CR's from the
>>> mail.
>>
>> I'm just downloading it with Chrome.
>>
>> Steps to reproduce:
>> 1. Upload patch via:
>> $ git format-patch --stdout --keep-subject --attach origin | git imap-send

Wait a second.  You used --attach.

>> 2. Open Gmail in Chrome.
>> 3. Open email in drafts folder.
>> 4. Click attachment download link

Then you downloaded the attachment, which should be a _patch_.

>> 5. Apply patch on a fresh branch with git apply.

Well, scratch what I said before, you were correct in using
git apply.

Shouldn't the attachment have it's content preserved exactly?  Maybe
the fault does belong to gmail.

-Brandon

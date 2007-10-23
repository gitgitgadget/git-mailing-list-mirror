From: Matthieu Lemerre <racin@free.fr>
Subject: Re: git.el fails on non-git managed files
Date: Tue, 23 Oct 2007 20:30:10 +0200
Message-ID: <87lk9tadl9.fsf@free.fr>
References: <1193077008.471ce910f15c5@imp.free.fr>
	<20071023043107.GZ14735@spearce.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-=-="
Cc: git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Tue Oct 23 20:49:56 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IkOp8-0001OR-IS
	for gcvg-git-2@gmane.org; Tue, 23 Oct 2007 20:49:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752497AbXJWStm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 23 Oct 2007 14:49:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752192AbXJWStm
	(ORCPT <rfc822;git-outgoing>); Tue, 23 Oct 2007 14:49:42 -0400
Received: from vader.rez-gif.supelec.fr ([160.228.154.1]:53695 "EHLO
	vader.rez-gif.supelec.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752491AbXJWStl (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Oct 2007 14:49:41 -0400
X-Greylist: delayed 1186 seconds by postgrey-1.27 at vger.kernel.org; Tue, 23 Oct 2007 14:49:41 EDT
Received: from localhost (localhost [127.0.0.1])
	by vader.rez-gif.supelec.fr (Postfix) with ESMTP id 5234E2C6A38;
	Tue, 23 Oct 2007 20:28:21 +0200 (CEST)
X-Virus-Scanned: by amavisd-new at rez-gif.supelec.fr
Received: from vader.rez-gif.supelec.fr ([127.0.0.1])
	by localhost (vader.rez-gif.supelec.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id CBsRIObT-t5L; Tue, 23 Oct 2007 20:28:19 +0200 (CEST)
Received: from localhost (lemerre3.rez-gif.supelec.fr [160.228.154.36])
	by vader.rez-gif.supelec.fr (Postfix) with ESMTP id BD3FF2C6A2F;
	Tue, 23 Oct 2007 20:28:19 +0200 (CEST)
In-Reply-To: <20071023043107.GZ14735@spearce.org> (Shawn O. Pearce's message of "Tue\, 23 Oct 2007 00\:31\:07 -0400")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.1 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/62147>

--=-=-=

"Shawn O. Pearce" <spearce@spearce.org> writes:

> racin@free.fr wrote:
>> I found the following on the development version of git.el: saving
>> non-git-managed files in Emacs threw an error.
>> 
>> It is due to a simple error in the call to condition-case in a
>> recently added function, git-update-save-file.
>> 
>> I attached the patch for your convenience.
>
> I'm not sure what happened, but I didn't receive a patch with
> your email.  Would you mind resending it to the list?  You may
> also want to file a bug with your distribution to get the Emacs
> bindings included.

Sure; the SMTP server of my ISP behaved weirdly yesterday and I had to
use one of these webmail applications.  This time it should be OK.


--=-=-=
Content-Type: application/octet-stream
Content-Disposition: inline; filename=patch
Content-Transfer-Encoding: base64

ZGlmZiAtLWdpdCBhL2NvbnRyaWIvZW1hY3MvZ2l0LmVsIGIvY29udHJpYi9lbWFjcy9naXQuZWwK
aW5kZXggNDI4NmQxNi4uZmY1NTYwNyAxMDA2NDQKLS0tIGEvY29udHJpYi9lbWFjcy9naXQuZWwK
KysrIGIvY29udHJpYi9lbWFjcy9naXQuZWwKQEAgLTEzNTMsNyArMTM1Myw3IEBAIENvbW1hbmRz
OgogICAiVXBkYXRlIHRoZSBjb3JyZXNwb25kaW5nIGdpdC1zdGF0dXMgYnVmZmVyIHdoZW4gYSBm
aWxlIGlzIHNhdmVkLgogTWVhbnQgdG8gYmUgdXNlZCBpbiBgYWZ0ZXItc2F2ZS1ob29rJy4iCiAg
IChsZXQqICgoZmlsZSAoZXhwYW5kLWZpbGUtbmFtZSBidWZmZXItZmlsZS1uYW1lKSkKLSAgICAg
ICAgIChkaXIgKGNvbmRpdGlvbi1jYXNlIG5pbCAoZ2l0LWdldC10b3AtZGlyIChmaWxlLW5hbWUt
ZGlyZWN0b3J5IGZpbGUpKSkpCisgICAgICAgICAoZGlyIChjb25kaXRpb24tY2FzZSBuaWwgKGdp
dC1nZXQtdG9wLWRpciAoZmlsZS1uYW1lLWRpcmVjdG9yeSBmaWxlKSkgKGVycm9yIG5pbCkpKQog
ICAgICAgICAgKGJ1ZmZlciAoYW5kIGRpciAoZ2l0LWZpbmQtc3RhdHVzLWJ1ZmZlciBkaXIpKSkp
CiAgICAgKHdoZW4gYnVmZmVyCiAgICAgICAod2l0aC1jdXJyZW50LWJ1ZmZlciBidWZmZXIK
--=-=-=


I'll also file a bug to debian, that's a good idea.

Matthieu Lemerre

--=-=-=--

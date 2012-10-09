From: David Aguilar <davvid@gmail.com>
Subject: Re: In search of a version control system
Date: Mon, 8 Oct 2012 20:19:26 -0700
Message-ID: <CAJDDKr5PxM3a6TjfdVoCp1VzgCFBKQ6YGhpN-BO-D=CyVTQX3w@mail.gmail.com>
References: <1349719581.76671.YahooMailNeo@web122505.mail.ne1.yahoo.com>
	<CALkWK0kCbLxPMbxh=CLAE8UkkNFNqDa1QbtdM_-Q+Qr3SRh46Q@mail.gmail.com>
	<vpqa9vwstp3.fsf@grenoble-inp.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Ramkumar Ramachandra <artagnon@gmail.com>,
	Maurice Francois <francoismaurice2001@yahoo.ca>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Tue Oct 09 05:19:40 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TLQM7-0001rK-6Q
	for gcvg-git-2@plane.gmane.org; Tue, 09 Oct 2012 05:19:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752605Ab2JIDT2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Oct 2012 23:19:28 -0400
Received: from mail-vc0-f174.google.com ([209.85.220.174]:37553 "EHLO
	mail-vc0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751612Ab2JIDT1 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Oct 2012 23:19:27 -0400
Received: by mail-vc0-f174.google.com with SMTP id fo13so5623983vcb.19
        for <git@vger.kernel.org>; Mon, 08 Oct 2012 20:19:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=FXmmm+nlOBv+eGozqZJSekKIzmg4xDZpPWrXyhT55xs=;
        b=lWKgn3DIWfDJqgQGzXB4kcQcna/MObU6g/u7jUcF0HtUASNDmB0v1fpC32U8/nOsEb
         Thot4fk/C0KIRxWKvyrVn+OwnXxa4n8DNagOsjmuyWAshWwMTEgxIGAtCgXfWtWN3/UC
         QOLF5m+xm8O4nbHIEgxHQZh2/4rSAkIFTKpGCSZPwRb17BpLiTEBI2O2bTVlfUtNxXs2
         fBBAQYXWdqPGrXadWPwWijoXyfKaw7jR4EoS7J02BPOPR1rDr8HRb+nHxhZM//j3VORq
         rzpEwkm8S0Cad0F0nNoo6EQ325oqc1m15zFvOj5Kao1BYmqQySGqVmZgjgETgOglSFvf
         Pz0A==
Received: by 10.52.68.201 with SMTP id y9mr8910713vdt.68.1349752766330; Mon,
 08 Oct 2012 20:19:26 -0700 (PDT)
Received: by 10.58.180.39 with HTTP; Mon, 8 Oct 2012 20:19:26 -0700 (PDT)
In-Reply-To: <vpqa9vwstp3.fsf@grenoble-inp.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/207296>

On Mon, Oct 8, 2012 at 11:30 AM, Matthieu Moy
<Matthieu.Moy@grenoble-inp.fr> wrote:
> Ramkumar Ramachandra <artagnon@gmail.com> writes:
>
>>> So, is it possible to lock a file while someone work on it ?
>>
>> No, and I honestly think it's a bad idea.
>
> If you work on non-mergeable files (e.g. *.doc files. There are merge
> tools for MS Word and LibreOffice, but my experience with them was not
> really pleasant), then file locking is indeed not such a bad idea.

gitolite to the rescue:

http://sitaramc.github.com/gitolite/locking.html

If you want to setup a git server, look at gitolite.
It's really easy and slick.

I would advise against the file locking, though.  You ain't gonna need it ;-)
-- 
David

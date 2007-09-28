From: "Kelvie Wong" <kelvie@ieee.org>
Subject: Re: Mergetool generating blank files (1.5.3)
Date: Thu, 27 Sep 2007 21:17:26 -0700
Message-ID: <94ccbe710709272117s6dee1a8jad6edf71dfb13c81@mail.gmail.com>
References: <94ccbe710709271312k7eac8e35y353180596a0abc9a@mail.gmail.com>
	 <94ccbe710709271338u79ba89beh5a637bf84f8edf44@mail.gmail.com>
	 <7v8x6ru97z.fsf@gitster.siamese.dyndns.org>
	 <7vwsubsuh1.fsf@gitster.siamese.dyndns.org>
	 <94ccbe710709271417h6349c807j6424c25175c26ea2@mail.gmail.com>
	 <94ccbe710709271422x5d1739c2g5da961c88a4336fe@mail.gmail.com>
	 <7vmyv7sshv.fsf@gitster.siamese.dyndns.org>
	 <7vir5vss58.fsf@gitster.siamese.dyndns.org>
	 <94ccbe710709271523s7e4c7a1dh53e34bd460c31d1f@mail.gmail.com>
	 <20070927225218.GD8688@thunk.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Junio C Hamano" <gitster@pobox.com>, git@vger.kernel.org
To: "Theodore Tso" <tytso@mit.edu>
X-From: git-owner@vger.kernel.org Fri Sep 28 06:17:36 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ib7IF-0002J5-0G
	for gcvg-git-2@gmane.org; Fri, 28 Sep 2007 06:17:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753039AbXI1ER3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 28 Sep 2007 00:17:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752922AbXI1ER2
	(ORCPT <rfc822;git-outgoing>); Fri, 28 Sep 2007 00:17:28 -0400
Received: from nz-out-0506.google.com ([64.233.162.228]:34322 "EHLO
	nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752860AbXI1ER1 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 28 Sep 2007 00:17:27 -0400
Received: by nz-out-0506.google.com with SMTP id s18so1945389nze
        for <git@vger.kernel.org>; Thu, 27 Sep 2007 21:17:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references:x-google-sender-auth;
        bh=IDLlP3f/mXArIwutBDFN8U7tttIQekjmMA5PRTkkcmo=;
        b=HGqn+N+xMDU6VSWu4bAlqqVndCnbivNmHajM98WFegMNJcqcbK1tYYl3Grcni++xqn1J1Fi6Ls4zEBcRYg/MBDIixqMoNZPKTMk3zmxQczUSpTuq/2iraTOrv5jXRBoIQD9pFcjAWeHHDHc5GZrovmcGwQUKw+VaJ9wI8nBscq4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references:x-google-sender-auth;
        b=S1kkYwCrxIcsZUWEdawFFATOwoEvf7FRUl5U3zuqiFInQRC1Ou1D21O0KFor5vBVLOAJq/712VsSKl2wHedN34Hc3rbCmFlMnEktZGw6GqjM/MCN5XRuRsI31FboOjSk5v4yOBpoRdcC9MZzx4D886SH+psaq/nRwaScPbRdBHw=
Received: by 10.114.158.1 with SMTP id g1mr1554702wae.1190953046348;
        Thu, 27 Sep 2007 21:17:26 -0700 (PDT)
Received: by 10.114.144.17 with HTTP; Thu, 27 Sep 2007 21:17:26 -0700 (PDT)
In-Reply-To: <20070927225218.GD8688@thunk.org>
Content-Disposition: inline
X-Google-Sender-Auth: d91f04bee1ac3aac
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/59357>

On 9/27/07, Theodore Tso <tytso@mit.edu> wrote:

> It's not that emacs sets $PWD via its first argument, but the output
> file is passed from emerge-files*-command to stashed in the per-buffer
> variable emerge-file-out, which in turn gets passed to the emacs lisp
> file write-file, which is what gets run when you run C-x C-w --- and
> write-file interprets a relative pathname based on the containing
> directory of the existing buffer.
>                                                 - Ted
>

Ah yes, I just started reading up on elisp a little while ago :)

I'd always assumed that emacs kept an internal "pwd" variable (i.e.
what's displayed with M-x pwd), but I guess my way of thinking is
archaic and deprecated :(

-- 
Kelvie

From: "Peter Harris" <git@peter.is-a-geek.org>
Subject: Re: What's the status of MinGW port.
Date: Mon, 8 Sep 2008 14:30:52 -0400
Message-ID: <eaa105840809081130t64e45fc5kc54c79b7d427f55e@mail.gmail.com>
References: <42b562540809072128o62854572y1eb8d2e69e7193f1@mail.gmail.com>
	 <42b562540809072134xed61f0as6f1201a641ec973c@mail.gmail.com>
	 <48C4CF58.4020906@viscovery.net> <20080908110333.GH27478@ece.pdx.edu>
	 <48C50B76.7070506@op5.se> <20080908181848.GI27478@ece.pdx.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Tait <git.git@t41t.com>
X-From: git-owner@vger.kernel.org Mon Sep 08 20:32:12 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KclWr-0001bJ-Rv
	for gcvg-git-2@gmane.org; Mon, 08 Sep 2008 20:32:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751243AbYIHSaz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Sep 2008 14:30:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751291AbYIHSaz
	(ORCPT <rfc822;git-outgoing>); Mon, 8 Sep 2008 14:30:55 -0400
Received: from el-out-1112.google.com ([209.85.162.181]:18793 "EHLO
	el-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750973AbYIHSay (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Sep 2008 14:30:54 -0400
Received: by el-out-1112.google.com with SMTP id z25so109864ele.1
        for <git@vger.kernel.org>; Mon, 08 Sep 2008 11:30:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:sender
         :to:subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references
         :x-google-sender-auth;
        bh=ZjaKp+/+CDbNACfqzetSlVnBFrDcue2z3d+y+EipUvI=;
        b=mwz7lUzR3vKXIxYWzMav/FCfxBO/SoIqPgZUCSoI6BRUGTAJgC4LITAHxfsuJyIqXI
         YvUm5855f3sX9WXPOZcrY1wjNOV9Y2H/aLYHgdH3Blp4hk/96PcVpNl4dSBi2gq/nL4Q
         ftdv79+N9zxXDOA6cag/g+2zKvAajkIQDEW6w=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references:x-google-sender-auth;
        b=aundEwRqg3kBi4Y/uGWOwazvR0f+Eea90A8XJPhwYvNtkUg7+auRd3wVAuj05TZO35
         ncNo3qFyAxEc8zn9ZBkahPvFWTrKCejCQSi2KurNoXwid8bcypFYv1Uz66eL39MAoJKb
         lKiIAyDed8ylCrSr5+EY5Bc9ofY+T3witesT8=
Received: by 10.141.212.5 with SMTP id o5mr9079752rvq.20.1220898652633;
        Mon, 08 Sep 2008 11:30:52 -0700 (PDT)
Received: by 10.141.97.15 with HTTP; Mon, 8 Sep 2008 11:30:52 -0700 (PDT)
In-Reply-To: <20080908181848.GI27478@ece.pdx.edu>
Content-Disposition: inline
X-Google-Sender-Auth: efb8c6a55ed2fb9c
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/95285>

On Mon, Sep 8, 2008 at 2:18 PM, Tait wrote:
> My understanding is that MinGW is a POSIX emulation layer; the underlying
> code is still using POSIX functions like fork and exec that aren't native
> to Windows.

Your understanding is flawed. You're probably thinking of MSYS or
CYGWIN. MinGW is a native Win32 port of gcc.

> So I'll ask again, is there any particular reason why a _native_ Windows
> Git hasn't been attempted (or was abandoned, or whatever)?

MinGW-git is a native Windows application.

Some of the utilities bundled with "msysgit" (eg. bash, rxvt, perl,
and therefore git-svn) use the MSYS POSIX emulation layer, but the git
core is native.

Peter Harris

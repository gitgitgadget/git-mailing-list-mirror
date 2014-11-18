From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: Reachability lists in git
Date: Tue, 18 Nov 2014 11:41:29 -0800
Message-ID: <20141118194129.GI6527@google.com>
References: <Pine.LNX.4.44L0.1411181354320.4374-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Alan Stern <stern@rowland.harvard.edu>
X-From: git-owner@vger.kernel.org Tue Nov 18 20:41:35 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xqoeb-0007Te-JP
	for gcvg-git-2@plane.gmane.org; Tue, 18 Nov 2014 20:41:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754820AbaKRTl3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Nov 2014 14:41:29 -0500
Received: from mail-ie0-f181.google.com ([209.85.223.181]:62453 "EHLO
	mail-ie0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754708AbaKRTl3 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Nov 2014 14:41:29 -0500
Received: by mail-ie0-f181.google.com with SMTP id tp5so5265266ieb.12
        for <git@vger.kernel.org>; Tue, 18 Nov 2014 11:41:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=9BggAnb79orTxigGY6S0vux+tdfHSfpPvydakG7pkxE=;
        b=HsrLJJWo0BMU+HREukp5839tDueDowfIfG7Ujq78oB9rbYFhAqBm8j7s0BDtgSunhV
         JlTKO6jvE4h/Wu1gi5s3s1wnh1OzGg1+ydzUy0Tq8X0UJW11LWqZ17mkApj+D0tSrDGN
         sxbA8iPGVaZpHp44OOKW2UbxYGNDh/OojRhlXOr+Igc/Xzx0x0/za1Aj5NkwpJtGar67
         Tfmt26BY+7teJWXnOlns8InD4LZwC/qd3nv63FsZnWRf54qYNVn0ftVxNb+TZMhAYGr5
         El+zXp/Wdwhv+E0XSDLnTR96SoHK7vobfMxhh4ec7sGLPyqZmKZWlAHaiSdNFIGM04Lx
         bhTw==
X-Received: by 10.107.25.20 with SMTP id 20mr2006915ioz.90.1416339688276;
        Tue, 18 Nov 2014 11:41:28 -0800 (PST)
Received: from google.com ([2620:0:1000:5b00:1d6d:1067:602d:d9c7])
        by mx.google.com with ESMTPSA id d7sm21078628iod.34.2014.11.18.11.41.26
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 18 Nov 2014 11:41:27 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44L0.1411181354320.4374-100000@iolanthe.rowland.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

Alan Stern wrote:

> The "git rev-list A ^B" command lists all the commits that are
> reachable from A but not from B.  Is there a comparable command for the
> converse relation, that is, a command to list all the commits that A is
> reachable from but B isn't?
>
> And if there is such a command, can the output be limited to just the
> latest commits?  That is, list commit X if and only if A is reachable
> from X, B isn't reachable from X, and B is reachable from each of X's
> children?

Someone else can answer your direct question, but you've got my
curiosity.  What is the application?

--ancestry-path is my current favorite tool for walking-forward needs.

Curious,
Jonathan

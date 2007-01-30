From: "Christian MICHON" <christian.michon@gmail.com>
Subject: Re: MinGW port usable
Date: Tue, 30 Jan 2007 09:07:15 +0100
Message-ID: <46d6db660701300007v573832b5pc7ac41059dc4490e@mail.gmail.com>
References: <200701292320.43888.johannes.sixt@telecom.at>
	 <20070129223513.GA31372@spearce.org>
	 <46d6db660701291511v700bfcf7l4851dd6be4fc6e03@mail.gmail.com>
	 <20070129232425.GB31372@spearce.org>
	 <46d6db660701292359v7647306fla30c9a10e5989dcc@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Johannes Sixt" <johannes.sixt@telecom.at>, git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Tue Jan 30 09:07:22 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HBo1R-00052V-L0
	for gcvg-git@gmane.org; Tue, 30 Jan 2007 09:07:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965015AbXA3IHS (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 30 Jan 2007 03:07:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965444AbXA3IHS
	(ORCPT <rfc822;git-outgoing>); Tue, 30 Jan 2007 03:07:18 -0500
Received: from wr-out-0506.google.com ([64.233.184.232]:33033 "EHLO
	wr-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965015AbXA3IHQ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Jan 2007 03:07:16 -0500
Received: by wr-out-0506.google.com with SMTP id i22so1151875wra
        for <git@vger.kernel.org>; Tue, 30 Jan 2007 00:07:16 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=urcBKexg+dACk7vGAJ5jDtHTyF3MiceaHAorfKbQEiDpUrIyTrtzEsq4O0EqdpiE0P27zvq2+7tEAQT/ZzqgAd4/0wFuN+7kU63UzNA07Bzj3hYEakokn1NpN04+8HGiSBjrTopwcbGQOcw6D27Gq2W2DSXjjaOZhS34NrbVcfQ=
Received: by 10.115.89.1 with SMTP id r1mr15363wal.1170144435575;
        Tue, 30 Jan 2007 00:07:15 -0800 (PST)
Received: by 10.115.16.9 with HTTP; Tue, 30 Jan 2007 00:07:15 -0800 (PST)
In-Reply-To: <46d6db660701292359v7647306fla30c9a10e5989dcc@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/38134>

On 1/30/07, Christian MICHON <christian.michon@gmail.com> wrote:
> On 1/30/07, Shawn O. Pearce <spearce@spearce.org> wrote:
> > Try creating a desktop icon (Repository->Create Desktop Icon) and
> > start git-gui from the resulting .bat file.  It *should* come up
> > right on MinGW, but I'm only guessing here.
>
> ok, yes it's working. :)
> but call gitk from inside it fail :(
>
> "error in startup script"
> ( git-peek-remote is not working from git-gui, could be path related.
> It's hard to tell why yet)
>
> --
> Christian
>

just to be more clear: when using the .bat shortcut, calling gitk
from within git-gui fails.

But if I call git-gui from a msys rxvt+bash, I can invoke all tools,
and calling gitk from within git-gui works.

I think this shortcut stuff may not be the best approach yet.

-- 
Christian

From: "Thomas Adam" <thomas.adam22@gmail.com>
Subject: Re: How can I specify multiple refs on one line in the config file?
Date: Wed, 7 May 2008 22:33:12 +0100
Message-ID: <18071eea0805071433j5bde8868w305d9a80c00bd2bd@mail.gmail.com>
References: <588192970805071415wb7b502ch2047ac5e4865c296@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "git mailing list" <git@vger.kernel.org>
To: "Steve Hoelzer" <shoelzer@gmail.com>
X-From: git-owner@vger.kernel.org Wed May 07 23:34:07 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JtrH4-0000We-Eo
	for gcvg-git-2@gmane.org; Wed, 07 May 2008 23:34:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752186AbYEGVdQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 7 May 2008 17:33:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751989AbYEGVdQ
	(ORCPT <rfc822;git-outgoing>); Wed, 7 May 2008 17:33:16 -0400
Received: from fk-out-0910.google.com ([209.85.128.187]:10500 "EHLO
	fk-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751850AbYEGVdO (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 May 2008 17:33:14 -0400
Received: by fk-out-0910.google.com with SMTP id 18so490516fkq.5
        for <git@vger.kernel.org>; Wed, 07 May 2008 14:33:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=0c1auYEAXRVNOsSaG+G8GMzBWrBFJTEflWe/8UbHk7Y=;
        b=iJCHhESQ84drF2C0ureQ7rsdTH53g3Ml+X73jqc6N+cPDzoB7X3tzxy2FWFZPVEcyd4dajyrQvqZGwB6SJOjcCWcfUt22LFNyVdE92rB5T92fVCGir2OZXPIgJ7n8PhszfMbc9O3J7r97wzModRNjl6E5hOl9yNokCaZlDiUu6g=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=ABY5iUzasbqLZVtyrJJquSXz8lqNy6iGPU65Gyw/u1KnbcyaBXo6CK8QNVdvvxptDOwNuH4YDumHNyf9JqZ7LiSt38VlRBQpgej0VSlHwLGZdhgzPCNg/beMqhlFqm0MWlyRlpJzhC/k1kHOMMFtMnMWPT5IQ8QT2S9eITXfv0A=
Received: by 10.82.146.10 with SMTP id t10mr324271bud.51.1210195992375;
        Wed, 07 May 2008 14:33:12 -0700 (PDT)
Received: by 10.82.170.5 with HTTP; Wed, 7 May 2008 14:33:12 -0700 (PDT)
In-Reply-To: <588192970805071415wb7b502ch2047ac5e4865c296@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/81480>

2008/5/7 Steve Hoelzer <shoelzer@gmail.com>:
> How can I specify multiple refs on one line in the config file? For
>  example, I want "git push" to push all heads and all tags by default
>  so I tried this:
>
>     [remote "origin"]
>         push = refs/heads/* refs/tags/*
>
>  That doesn't work, of course, but I imagine it is possible, and I just
>  can't figure out the syntax.

I might be misunderstanding you, but to push tags, there's:

git push --tags

I know that's not inclusive of anything else.

-- Thomas Adam

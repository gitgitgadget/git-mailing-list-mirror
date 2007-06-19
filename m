From: "Martin Langhoff" <martin.langhoff@gmail.com>
Subject: Re: blame follows renames, but log doesn't
Date: Tue, 19 Jun 2007 20:31:38 +1200
Message-ID: <46a038f90706190131ub087df0pd7814b477c2a3b40@mail.gmail.com>
References: <46a038f90706181810p716f914al4d9abba5bfe7eb5@mail.gmail.com>
	 <20070619071916.GC9177@thunk.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Git Mailing List" <git@vger.kernel.org>
To: "Theodore Tso" <tytso@mit.edu>
X-From: git-owner@vger.kernel.org Tue Jun 19 10:31:43 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I0Z7l-0006Ad-EM
	for gcvg-git@gmane.org; Tue, 19 Jun 2007 10:31:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754893AbXFSIbk (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 19 Jun 2007 04:31:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754818AbXFSIbk
	(ORCPT <rfc822;git-outgoing>); Tue, 19 Jun 2007 04:31:40 -0400
Received: from wx-out-0506.google.com ([66.249.82.225]:5541 "EHLO
	wx-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753845AbXFSIbj (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Jun 2007 04:31:39 -0400
Received: by wx-out-0506.google.com with SMTP id t15so1756266wxc
        for <git@vger.kernel.org>; Tue, 19 Jun 2007 01:31:38 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=kxZaCjNdQZoKAIY2YVzCyDk2VpZbYEuLRcM4pc0WwR7f4C84EOd+ziRRz9LhGeW5ZoOI/6Gv9AACvWDOX5ssB67SRlz6FS79OIJ7aBoGnOEMaW0Dnxa6m7qOz3x6zc7Lc8nGis+ajjqw02sr6JhlWpFsocydSjXnLxsCRW5PtA4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=uQm9Y/4iaxYGb3VsKRAb82QI/hxd23Ccxt0wV1MPUgvBQTooibczpsoUBZe6MKlKJpLGZpBHfiuReFjW3zKMYI9ryVTG5WApa3zLQhM4hesWKfimEzO3dClU2rkfU7LKaGwAu59qL+CQAmU7JlUFJSbSbAlLEja60cNRkTSkexo=
Received: by 10.90.83.14 with SMTP id g14mr4566201agb.1182241898845;
        Tue, 19 Jun 2007 01:31:38 -0700 (PDT)
Received: by 10.90.52.9 with HTTP; Tue, 19 Jun 2007 01:31:38 -0700 (PDT)
In-Reply-To: <20070619071916.GC9177@thunk.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/50457>

On 6/19/07, Theodore Tso <tytso@mit.edu> wrote:
> Actually, the bigger missing gap is merges.  Suppose in the
> development branch, you rename a whole bunch of files.  (For example,
> foo_super.c got moved to foo/super.c, foo_inode.c got moved to
> foo/inode.c, etc.)

I thought that the "recursive" strategy covered this - though I don't
work on a tree that merges across branches with renames, so my
experience is _very_ limited.

>From Documentation/merge-strategies.txt:

  Additionally this can detect and handle merges involving
  renames.  This is the default merge strategy when
  pulling or merging one branch.

cheers


m

From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: Announcing git-reparent
Date: Sun, 13 Jan 2013 23:16:08 -0800
Message-ID: <20130114071608.GL3125@elie.Belkin>
References: <CAHREChhnf44CprHnS=z9KO5aOkfDPSG6Xb2GU=Kvaz38eTgbUg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git list <git@vger.kernel.org>
To: Mark Lodato <lodatom@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jan 14 08:16:36 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TueHa-0002RS-51
	for gcvg-git-2@plane.gmane.org; Mon, 14 Jan 2013 08:16:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754850Ab3ANHQO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Jan 2013 02:16:14 -0500
Received: from mail-pa0-f42.google.com ([209.85.220.42]:38844 "EHLO
	mail-pa0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751877Ab3ANHQN (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Jan 2013 02:16:13 -0500
Received: by mail-pa0-f42.google.com with SMTP id rl6so2080609pac.29
        for <git@vger.kernel.org>; Sun, 13 Jan 2013 23:16:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=aLQ1Jn9MJfXva5K1m6lMFLGhCb+Tde+88qwlVqkTDQQ=;
        b=UThoK1ffWwLtjgkGa6AaOT7hOVL7ZnnnF74SNkrMwIH3WqdvppxjEN1kt4xgVOfXKD
         KazSkU6rh6z+PoScGXMrMyXUOjXW1kH95iogSbbItEPOwoPWgSc99Isgn64Vn42OkDrC
         YmM0PeBGa2mPOVIZLwPE/AKHkEoGhdZ3sgGPkFhkcDm1MDGj99rn8sGmYPdIa8+6OcLg
         YkknW9WeGZ1pl+V9Zq9tg0JwdYKSkLtVuo5PpTRi3rphU6VHQWmCsjGIxLFGSM3LrUBX
         zFDQC/a9fdpqcyQG1409MOwfH98JCrNBOF6pdfJiOADGR1nAy74Br47YnxCN//xXphhp
         6v0Q==
X-Received: by 10.68.130.170 with SMTP id of10mr252045204pbb.131.1358147773181;
        Sun, 13 Jan 2013 23:16:13 -0800 (PST)
Received: from elie.Belkin (c-107-3-135-164.hsd1.ca.comcast.net. [107.3.135.164])
        by mx.google.com with ESMTPS id vk5sm7711942pbc.34.2013.01.13.23.16.11
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sun, 13 Jan 2013 23:16:12 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <CAHREChhnf44CprHnS=z9KO5aOkfDPSG6Xb2GU=Kvaz38eTgbUg@mail.gmail.com>
User-Agent: Mutt/1.5.21+51 (9e756d1adb76) (2011-07-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/213458>

Hi Mark,

Mark Lodato wrote:

> Create a new commit object that has the same tree and commit message as HEAD
> but with a different set of parents.  If ``--no-reset`` is given, the full
> object id of this commit is printed and the program exits

I've been wishing for something like this for a long time.  I used to
fake it using "cat-file commit", sed, and "hash-object -w" when
stitching together poorly imported history using "git replace".

Thanks for writing it.

Ciao,
Jonathan

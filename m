From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [WIP PATCH] Add skeleton remote helper for SVN
Date: Mon, 10 May 2010 08:21:17 -0500
Message-ID: <20100510132117.GA5746@progeny.tock>
References: <1273491574-31870-1-git-send-email-artagnon@gmail.com>
 <1273491574-31870-2-git-send-email-artagnon@gmail.com>
 <AANLkTilzn2GLbxz3vLD4SoNIrYDU9_YzFfPI5Wv_WFs2@mail.gmail.com>
 <AANLkTikFl25Hay7UEvsz5bsdg8fdT8485SxqgAZXCYqd@mail.gmail.com>
 <20100510125953.GA5642@progeny.tock>
 <AANLkTil8Ezw3rE-q6pQHr4o-aUNXr-HYbFwbX597VlT1@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Tay Ray Chuan <rctay89@gmail.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	David Michael Barr <david.barr@cordelta.com>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Mon May 10 15:21:29 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OBSvH-0001ej-Lz
	for gcvg-git-2@lo.gmane.org; Mon, 10 May 2010 15:21:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754675Ab0EJNVU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 May 2010 09:21:20 -0400
Received: from mail-pz0-f204.google.com ([209.85.222.204]:58323 "EHLO
	mail-pz0-f204.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751158Ab0EJNVU (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 May 2010 09:21:20 -0400
Received: by pzk42 with SMTP id 42so155203pzk.4
        for <git@vger.kernel.org>; Mon, 10 May 2010 06:21:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=/lq4dWitfk33EQ+H56hCfU/N4ei7Qq5bt0ePcbhIHCk=;
        b=R62sTDN9Q5KB5KhW5pRpYFkgOx8hGzHS+Nh81yJikoPDqAczRoOhZZGx5rbkQ/gj/C
         y7YT9dF29jST4XL/V8gWa5GH4lOMgs8Otxht2yZZ6aza3opoq6MUL0CiUE8E4N3YWzqB
         Hwz4vxrUG9/lAvMyLM0T3pbIPL0t4FOSAJToU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=CPOLbPcWSb5+ZejYaxvTDGQAvWJ9qbX7NQzPzbPsSzGImXd3i97rLAd/uIbm9HEAvz
         2DcERWMJQx1MefOI07tGo0N8fjF89Q9lLnNf6ERMdugZBGXlxTG4ytqR1B0ohJAU8oey
         Wceyljrg/FEl0rLLyqhzjRa+qz+dCm4P5DY9w=
Received: by 10.141.187.13 with SMTP id o13mr2643460rvp.24.1273497679499;
        Mon, 10 May 2010 06:21:19 -0700 (PDT)
Received: from progeny.tock (c-98-212-3-231.hsd1.il.comcast.net [98.212.3.231])
        by mx.google.com with ESMTPS id q10sm1872900rvp.8.2010.05.10.06.21.16
        (version=SSLv3 cipher=RC4-MD5);
        Mon, 10 May 2010 06:21:17 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <AANLkTil8Ezw3rE-q6pQHr4o-aUNXr-HYbFwbX597VlT1@mail.gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/146812>

Ramkumar Ramachandra wrote:

> [1] http://github.com/barrbrain/svn-dump-fast-export.git
> [2] http://github.com/artagnon/svn-dump-fast-export.git

>From README.textile:

| h1. A tool to convert a subversion dump for input to git-fast-import
|
| This project is now largely functionally complete. There is still
| quite a bit of testing and code cleanup to be done before the first
| major release.

Awesome. :) Thank you.

Cheers,
Jonathan

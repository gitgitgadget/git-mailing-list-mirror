From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: Possible error on the git-svn man page
Date: Sat, 6 Jul 2013 19:15:58 -0700
Message-ID: <20130707021558.GC4193@google.com>
References: <20130628095442.3304163d@ifurita.qm.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "git@vger.kernel.org" <git@vger.kernel.org>,
	Eric Wong <normalperson@yhbt.net>,
	Jan =?iso-8859-1?Q?Kr=FCger?= <jk@jk.gs>
To: "Szuba, Marek (IKP)" <Marek.Szuba@kit.edu>
X-From: git-owner@vger.kernel.org Sun Jul 07 04:16:09 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UveWG-0006lE-Hb
	for gcvg-git-2@plane.gmane.org; Sun, 07 Jul 2013 04:16:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751295Ab3GGCQF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 6 Jul 2013 22:16:05 -0400
Received: from mail-pa0-f41.google.com ([209.85.220.41]:36392 "EHLO
	mail-pa0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751200Ab3GGCQD (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 6 Jul 2013 22:16:03 -0400
Received: by mail-pa0-f41.google.com with SMTP id bj3so3303013pad.28
        for <git@vger.kernel.org>; Sat, 06 Jul 2013 19:16:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=W8yiezGfkt5Fpkm4a2eVeKVucoDGbMq0HqxLAkaj1hY=;
        b=Xoi8A9Faw9X+OJzM+v89iGAiaLbAr+CKSUZb5JrM3tBTCF2SyxOLCuL7qWRxEEEqVb
         3cO12CjiWJAIqfQoasVGRUOoRmjoSHtAFHBKtIcq3J7tzu6pSRC4YhCASgNLIydBKv34
         o9MdhyKVVpTGogGc4oZlyGDv7KHe3c/CtvZ1759IJ/DQCG5v/1J6Pq/FVW549xGsDW5n
         bm8qcVg9w52h4cuNcFNBk1hw87o6vsitDe9ajTAEaxViOvKclHx/FD6m2MtPFSweLMOd
         Uwi/v1so+FT/OJxHy/UqHRyvwIB+hXUL4Snbj1kyHL6P2rPv8i01mbbpLVur7MdP3/kb
         W/gg==
X-Received: by 10.68.242.105 with SMTP id wp9mr15514996pbc.153.1373163362105;
        Sat, 06 Jul 2013 19:16:02 -0700 (PDT)
Received: from google.com ([2620:0:1000:5b00:b6b5:2fff:fec3:b50d])
        by mx.google.com with ESMTPSA id y9sm14683595pbb.46.2013.07.06.19.16.00
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Sat, 06 Jul 2013 19:16:01 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20130628095442.3304163d@ifurita.qm.lan>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/229716>

Hi,

Szuba, Marek (IKP) wrote:

> On the git-svn(1) man page, the third example in the "Basic Examples"
[...]
> $ git checkout -b master FETCH_HEAD
> fatal: Cannot update paths and switch to branch 'master' at the same time.
> Did you intend to checkout 'FETCH_HEAD' which can not be resolved as commit?

What branch are you on when you run "git fetch"?  What does "git log
FETCH_HEAD" say?  Is this repository public, which would let people on
this list try it out?

Thanks,
Jonathan

From: Thomas Glanzmann <sithglan@stud.uni-erlangen.de>
Subject: Re: Mercurial 0.3 vs git benchmarks
Date: Wed, 27 Apr 2005 22:39:18 +0200
Message-ID: <20050427203917.GC12882@cip.informatik.uni-erlangen.de>
References: <aec7e5c305042609231a5d3f0@mail.gmail.com> <20050426135606.7b21a2e2.akpm@osdl.org> <Pine.LNX.4.58.0504261405050.18901@ppc970.osdl.org> <20050426155609.06e3ddcf.akpm@osdl.org> <426ED20B.9070706@zytor.com> <871x8wb6w4.fsf@deneb.enyo.de> <20050427151357.GH1087@cip.informatik.uni-erlangen.de> <426FDFCD.6000309@zytor.com> <20050427190144.GA28848@cip.informatik.uni-erlangen.de> <426FF799.4000501@zytor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Wed Apr 27 22:36:34 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DQtFi-0006Fp-50
	for gcvg-git@gmane.org; Wed, 27 Apr 2005 22:35:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262001AbVD0UkE (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 27 Apr 2005 16:40:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262003AbVD0Uj0
	(ORCPT <rfc822;git-outgoing>); Wed, 27 Apr 2005 16:39:26 -0400
Received: from faui03.informatik.uni-erlangen.de ([131.188.30.103]:12010 "EHLO
	faui03.informatik.uni-erlangen.de") by vger.kernel.org with ESMTP
	id S262001AbVD0UjT (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Apr 2005 16:39:19 -0400
Received: from faui03.informatik.uni-erlangen.de (faui03.informatik.uni-erlangen.de [131.188.30.103])
	by faui03.informatik.uni-erlangen.de (8.12.9/8.12.9) with ESMTP id j3RKdIS8015118
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Wed, 27 Apr 2005 20:39:18 GMT
Received: (from sithglan@localhost)
	by faui03.informatik.uni-erlangen.de (8.12.9/8.12.9) id j3RKdIjT015117;
	Wed, 27 Apr 2005 22:39:18 +0200 (CEST)
To: linux-kernel@vger.kernel.org, git@vger.kernel.org
Mail-Followup-To: linux-kernel@vger.kernel.org, git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <426FF799.4000501@zytor.com>
X-URL: http://wwwcip.informatik.uni-erlangen.de/~sithglan/
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Hello,

> Only if you read every single file in each directory every time.  I 
> thought mutt did header indexing and thus didn't need to do that.

it does, but it is a very recent development (coming with the next
release). Prior to this you need a patch, which has debian applied since
some time. And configure it. Otherwise *all* Maildir files we opened and
parsed when a folder is entered.

	Thomas

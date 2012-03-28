From: Miles Bader <miles@gnu.org>
Subject: Re: GSoC intro
Date: Wed, 28 Mar 2012 17:09:34 +0900
Message-ID: <buo8vilf8ox.fsf@dhlpc061.dev.necel.com>
References: <11292500.AVmZFUUvNi@flobuntu>
 <CAFfmPPPabm_H9f2Zr8eWc7Wxo6UDz-km_Vg8cc-O38XhGCrj7Q@mail.gmail.com>
 <11105663.xsXc2sBkNH@flobuntu>
 <CALkWK0nW91PE2810qrZUbL0x-_YTTA_2tLFVhvXBJ2NFGvVxog@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Florian Achleitner <florian.achleitner2.6.31@gmail.com>,
	David Barr <davidbarr@google.com>,
	Git Mailing List <git@vger.kernel.org>,
	Andrew Sayers <andrew-git@pileofstuff.org>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Dmitry Ivankov <divanorama@gmail.com>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Wed Mar 28 10:10:15 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SCnxM-00048D-DO
	for gcvg-git-2@plane.gmane.org; Wed, 28 Mar 2012 10:10:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751598Ab2C1IJo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 Mar 2012 04:09:44 -0400
Received: from relmlor4.renesas.com ([210.160.252.174]:52517 "EHLO
	relmlor4.renesas.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751257Ab2C1IJm (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Mar 2012 04:09:42 -0400
Received: from relmlir3.idc.renesas.com ([10.200.68.153])
 by relmlor4.idc.renesas.com ( SJSMS)
 with ESMTP id <0M1L009175C4FC10@relmlor4.idc.renesas.com> for
 git@vger.kernel.org; Wed, 28 Mar 2012 17:09:40 +0900 (JST)
Received: from relmlac4.idc.renesas.com ([10.200.69.24])
 by relmlir3.idc.renesas.com ( SJSMS)
 with ESMTP id <0M1L00E7J5C44C60@relmlir3.idc.renesas.com> for
 git@vger.kernel.org; Wed, 28 Mar 2012 17:09:40 +0900 (JST)
Received: by relmlac4.idc.renesas.com (Postfix, from userid 0)
	id AC91E48082; Wed, 28 Mar 2012 17:09:40 +0900 (JST)
Received: from relmlac4.idc.renesas.com (localhost [127.0.0.1])
	by relmlac4.idc.renesas.com (Postfix) with ESMTP id A7DDA480A3; Wed,
 28 Mar 2012 17:09:40 +0900 (JST)
Received: from relmlii1.idc.renesas.com [10.200.68.65]	by
 relmlac4.idc.renesas.com with ESMTP id TAD20356; Wed,
 28 Mar 2012 17:09:40 +0900
X-IronPort-AV: E=Sophos;i="4.75,329,1330873200";   d="scan'208";a="74469530"
Received: from unknown (HELO relay41.aps.necel.com) ([10.29.19.9])
 by relmlii1.idc.renesas.com with ESMTP; Wed, 28 Mar 2012 17:09:40 +0900
Received: from dhlpc061 (dhlpc061.dev.necel.com [10.114.98.89])
	by relay41.aps.necel.com (8.14.4+Sun/8.14.4) with ESMTP id q2S89bL2014919;
 Wed, 28 Mar 2012 17:09:37 +0900 (JST)
Received: by dhlpc061 (Postfix, from userid 31295)	id 59B7E52E28D; Wed,
 28 Mar 2012 17:09:36 +0900 (JST)
System-Type: x86_64-unknown-linux-gnu
Blat: Foop
In-reply-to: <CALkWK0nW91PE2810qrZUbL0x-_YTTA_2tLFVhvXBJ2NFGvVxog@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/194110>

Ramkumar Ramachandra <artagnon@gmail.com> writes:
>> Hm, and there are still some general questions:
>> What about git-svn? Whats wrong with it? (I haven't used it) I saw the huge
>> perl script, this looks a little extreme ;). But it provides bi-directional
>> access?!
>
> The main problem with git-svn.perl is that it's hard to maintain or
> extend.  See also: David Barr's LCA talk [1].

git-svn's also pretty annoying to use (e.g.  the way dcommit rebases
anything you push to svn, which makes juggling local git branches
problematic; ugh)... :/

-miles

-- 
.Numeric stability is probably not all that important when you're guessing.

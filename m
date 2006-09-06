From: Karl =?iso-8859-1?Q?Hasselstr=F6m?= <kha@treskal.com>
Subject: Re: stgit bisect feature request
Date: Wed, 6 Sep 2006 10:31:53 +0200
Message-ID: <20060906083153.GA19001@diana.vm.bytemark.co.uk>
References: <e7bda7770609051649j56a92085i8d8a73ab12004c43@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Sep 06 10:32:13 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GKspE-0003Cf-PH
	for gcvg-git@gmane.org; Wed, 06 Sep 2006 10:32:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751791AbWIFIb5 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Wed, 6 Sep 2006 04:31:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751790AbWIFIb5
	(ORCPT <rfc822;git-outgoing>); Wed, 6 Sep 2006 04:31:57 -0400
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:33544 "EHLO
	diana.vm.bytemark.co.uk") by vger.kernel.org with ESMTP
	id S1751654AbWIFIb4 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Sep 2006 04:31:56 -0400
Received: from kha by diana.vm.bytemark.co.uk with local (Exim 3.36 #1 (Debian))
	id 1GKsp7-00056P-00; Wed, 06 Sep 2006 09:31:53 +0100
To: Torgil Svensson <torgil.svensson@gmail.com>
Content-Disposition: inline
In-Reply-To: <e7bda7770609051649j56a92085i8d8a73ab12004c43@mail.gmail.com>
X-Manual-Spam-Check: kha@treskal.com, clean
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/26508>

On 2006-09-06 01:49:15 +0200, Torgil Svensson wrote:

> I think i'd be nice if stgit wraps bisect and you could write
>
> $ stg bisect start
> $ stg bisect bad
> $ stg bisect good ORIG_HEAD
>
> and after bisect checks out the files it pushes the current stack as
> if you had used stg pull at this point

Yes, this sounds very useful for bisecting when you can't test the old
revisions as-is, e.g. because you have to patch for an unrelated bug,
or because you need a patch to trigger the problem.

--=20
Karl Hasselstr=F6m, kha@treskal.com
      www.treskal.com/kalle

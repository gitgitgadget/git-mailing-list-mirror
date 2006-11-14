X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Karl =?iso-8859-1?Q?Hasselstr=F6m?= <kha@treskal.com>
Subject: Re: Missing features in git
Date: Tue, 14 Nov 2006 16:39:22 +0100
Message-ID: <20061114153922.GA5453@diana.vm.bytemark.co.uk>
References: <20061114134958.5326.qmail@science.horizon.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
NNTP-Posting-Date: Tue, 14 Nov 2006 15:40:45 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Content-Disposition: inline
In-Reply-To: <20061114134958.5326.qmail@science.horizon.com>
X-Manual-Spam-Check: kha@treskal.com, clean
User-Agent: Mutt/1.5.9i
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/31348>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Gk0OZ-0003G1-Ub for gcvg-git@gmane.org; Tue, 14 Nov
 2006 16:40:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S965979AbWKNPkF convert rfc822-to-quoted-printable (ORCPT
 <rfc822;gcvg-git@m.gmane.org>); Tue, 14 Nov 2006 10:40:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S966001AbWKNPkF
 (ORCPT <rfc822;git-outgoing>); Tue, 14 Nov 2006 10:40:05 -0500
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:50444 "EHLO
 diana.vm.bytemark.co.uk") by vger.kernel.org with ESMTP id S965979AbWKNPkE
 (ORCPT <rfc822;git@vger.kernel.org>); Tue, 14 Nov 2006 10:40:04 -0500
Received: from kha by diana.vm.bytemark.co.uk with local (Exim 3.36 #1
 (Debian)) id 1Gk0Ne-00022g-00; Tue, 14 Nov 2006 15:39:22 +0000
To: linux@horizon.com
Sender: git-owner@vger.kernel.org

On 2006-11-14 08:49:58 -0500, linux@horizon.com wrote:

> One feature that I noticed is missing, is that there's no easy way
> to do a "git reset --hard" while doing a "git checkout" style merge.
>
> An example of when you'd want to do this is performing a "git
> bisect" with a local "#define DEBUG 1" change. Particularly if you
> hit a non-compiling version and need to back up.

Yes, this feature would be good to have. StGIT makes it a little less
painful to hack around this limitation, but you still have to remember
popping your patches before running "git bisect good|bad".

Then again, in StGIT's case this could be solved by creating an "stg
bisect" command that takes care of this for you. But I still agree
with you that it would be a win if regular git could do as you
describe.

--=20
Karl Hasselstr=F6m, kha@treskal.com

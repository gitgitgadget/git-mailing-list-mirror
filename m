From: Thomas Adam <thomas@xteddy.org>
Subject: Re: Announce gitslave - manage a superproject with slave repositories
Date: Thu, 23 Sep 2010 23:49:30 +0100
Message-ID: <AANLkTimf2Oe-w-QG_XeyP1OJ1FnfW6ym_OjLuUeqKo=F@mail.gmail.com>
References: <201009210139.o8L1d1iY026728@no.baka.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Seth Robertson <in-gitvger@baka.org>
X-From: git-owner@vger.kernel.org Fri Sep 24 00:50:08 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OyucB-0007O5-Nc
	for gcvg-git-2@lo.gmane.org; Fri, 24 Sep 2010 00:50:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755637Ab0IWWtr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 23 Sep 2010 18:49:47 -0400
Received: from mail-qy0-f174.google.com ([209.85.216.174]:45342 "EHLO
	mail-qy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755418Ab0IWWtq (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 23 Sep 2010 18:49:46 -0400
Received: by qyk36 with SMTP id 36so344776qyk.19
        for <git@vger.kernel.org>; Thu, 23 Sep 2010 15:49:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:sender:received
         :in-reply-to:references:from:date:x-google-sender-auth:message-id
         :subject:to:cc:content-type;
        bh=eBQSY4z8hgk2/5PJUC8T6hHgZEqRxKtUTipeC1proBY=;
        b=ofANA3Am02Uas2brcrcu0UACb48JYLncB91C06j2lkH8gjoBo/4JBjRD2c1EshJv1l
         UERLiRRwQQxdH/xZKFV1NsJ3p1YxbHApziU9vmkr1A3385jiXvJH1VQ6qIz0aQ6dvoYQ
         WmcWOkxHLpImYTX2dQ/OUJOxpXBX/ZvbAW8VY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:sender:in-reply-to:references:from:date
         :x-google-sender-auth:message-id:subject:to:cc:content-type;
        b=yEsdGtdcFSrH6xpIOsTW/mtCy5hrJLm3WjtsJuPstxBc2tQZSfqEc9j0Gq6wozLuqG
         wKRVwBfuf8wswk/yxmTAM22hflPgYUu1x63+wsZv1rSFPMuj31Hx46+j7t/icewUXlun
         7JTrySxyIDwqtLi56xR9WHHBzJT/tU2UzBJw8=
Received: by 10.229.99.131 with SMTP id u3mr1934903qcn.17.1285282185814; Thu,
 23 Sep 2010 15:49:45 -0700 (PDT)
Received: by 10.229.121.19 with HTTP; Thu, 23 Sep 2010 15:49:30 -0700 (PDT)
In-Reply-To: <201009210139.o8L1d1iY026728@no.baka.org>
X-Google-Sender-Auth: 8kzT7pGUc4Za8Ms0SUDDZPMDd9E
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/156921>

Hi --

On 21 September 2010 02:39, Seth Robertson <in-gitvger@baka.org> wrote:
>
> I'd like to announce the first public version of gitslave.

I had a very quick cursive look at the perl.  Any reason why you're
using using the Git module shipped with GIt, and relying on your own
use of system() which is arguarbly bad?

-- Thomas Adam

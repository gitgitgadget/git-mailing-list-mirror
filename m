From: Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH v8 4/7] bisect: introduce --no-checkout, --update-ref=<ref> support into porcelain.
Date: Sun, 31 Jul 2011 22:51:51 +0200
Message-ID: <201107312251.51714.chriscool@tuxfamily.org>
References: <1312113321-28760-1-git-send-email-jon.seymour@gmail.com> <CAH3AnrqasW=ZSix0YBgxHg8ca2X+YOvSWknbG2mjsy0NaqV+Mw@mail.gmail.com> <201107312207.58818.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: Christian Couder <christian.couder@gmail.com>, git@vger.kernel.org,
	gitster@pobox.com, j6t@kdbg.org, jnareb@gmail.com
To: Jon Seymour <jon.seymour@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jul 31 22:52:10 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QnczX-000829-So
	for gcvg-git-2@lo.gmane.org; Sun, 31 Jul 2011 22:52:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752013Ab1GaUwC (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 31 Jul 2011 16:52:02 -0400
Received: from smtp3-g21.free.fr ([212.27.42.3]:44163 "EHLO smtp3-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751370Ab1GaUwB (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 31 Jul 2011 16:52:01 -0400
Received: from style.localnet (unknown [82.243.130.161])
	by smtp3-g21.free.fr (Postfix) with ESMTP id 14712A6283;
	Sun, 31 Jul 2011 22:51:53 +0200 (CEST)
User-Agent: KMail/1.13.6 (Linux/2.6.38-8-generic; KDE/4.6.2; x86_64; ; )
In-Reply-To: <201107312207.58818.chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/178274>

> On Sunday 31 July 2011 21:40:35 Jon Seymour wrote:
> > 
> > Probably this would be better :-)
> > 
> > ( test -z "$BISECT_UPDATE_REF" || echo "$BISECT_UPDATE_REF" >
> >  "$GIT_DIR/BISECT_UPDATE_REF" ) &&

Or:

{ test -z "$BISECT_UPDATE_REF" || echo "$BISECT_UPDATE_REF" > 
"$GIT_DIR/BISECT_UPDATE_REF" ; } &&

Thanks,
Christian.

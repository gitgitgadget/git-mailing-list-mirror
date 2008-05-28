From: Wincent Colaiuta <win@wincent.com>
Subject: Re: log --graph: extra space with --pretty=oneline
Date: Wed, 28 May 2008 13:34:47 +0200
Message-ID: <D3963BB7-4F3C-4D4F-9423-D03F05100F10@wincent.com>
References: <20080528112405.GA12065@mithlond.arda.local>
Mime-Version: 1.0 (Apple Message framework v919.2)
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed	delsp=yes
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Adam Simpkins <adam@adamsimpkins.net>, git@vger.kernel.org
To: Teemu Likonen <tlikonen@iki.fi>
X-From: git-owner@vger.kernel.org Wed May 28 13:36:11 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K1Jwl-00068p-C4
	for gcvg-git-2@gmane.org; Wed, 28 May 2008 13:35:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752413AbYE1Le4 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 28 May 2008 07:34:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752456AbYE1Le4
	(ORCPT <rfc822;git-outgoing>); Wed, 28 May 2008 07:34:56 -0400
Received: from wincent1.inetu.net ([209.235.192.161]:50469 "EHLO
	wincent1.inetu.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752195AbYE1Le4 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 28 May 2008 07:34:56 -0400
Received: from cuzco.lan (156.pool85-53-26.dynamic.orange.es [85.53.26.156])
	(authenticated bits=0)
	by wincent1.inetu.net (8.13.8/8.13.8) with ESMTP id m4SBYma3031311
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NO);
	Wed, 28 May 2008 07:34:51 -0400
In-Reply-To: <20080528112405.GA12065@mithlond.arda.local>
X-Mailer: Apple Mail (2.919.2)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/83087>

El 28/5/2008, a las 13:24, Teemu Likonen escribi=F3:
> Sometimes "log --graph --pretty=3Doneline" prints a sort of broken gr=
aph
> line. In the git repository try this:
>
> $ git log --graph --pretty=3Doneline --abbrev-commit -4 8366b7b
>
>
> M   8366b7b... Merge branch 'maint'
> |\
> | M   a2f5be5... Merge branch 'jk/maint-send-email-compose' into main=
t
> | |\
> | M  \  93c7b9c... Merge branch 'hb/maint-send-email-quote-=20
> recipients' into maint
> | |\  |
> | M  \ \  6abf189... Merge branch 'maint-1.5.4' into maint
> | |\  | |
>    ^
>
> Extra spaces there. I don't mind that myself but to some users it may
> look like a bug. Maybe one would expect output like this:
>
>
> M   8366b7b... Merge branch 'maint'
> |\
> | M   a2f5be5... Merge branch 'jk/maint-send-email-compose' into main=
t
> | |\
> | | \
> | M  \  93c7b9c... Merge branch 'hb/maint-send-email-quote-=20
> recipients' into maint
> | |\  \
> | | \  \
> | M  \  |  6abf189... Merge branch 'maint-1.5.4' into maint
> | |\  | |
>
>
> It requires more lines though.

Yes it does, but it definitely looks more readable to me.

W

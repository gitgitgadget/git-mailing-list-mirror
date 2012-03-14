From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: Re: [PATCH 2/2] Documentation/diff-options: reword description of
 --submodule option
Date: Wed, 14 Mar 2012 19:47:55 +0100
Message-ID: <4F60E7DB.3030808@web.de>
References: <1331665251-11147-1-git-send-email-tim.henigan@gmail.com> <1331665251-11147-2-git-send-email-tim.henigan@gmail.com> <7vipi8uv12.fsf@alter.siamese.dyndns.org> <CAFouetgSw7MMzHWOJox6DiPmBWD=6j4mST1KFZYsZyLmKHRrEQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Tim Henigan <tim.henigan@gmail.com>
X-From: git-owner@vger.kernel.org Wed Mar 14 19:48:13 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S7tF0-0004Pp-IE
	for gcvg-git-2@plane.gmane.org; Wed, 14 Mar 2012 19:48:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761440Ab2CNSsE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 Mar 2012 14:48:04 -0400
Received: from fmmailgate04.web.de ([217.72.192.242]:59707 "EHLO
	fmmailgate04.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760630Ab2CNSsA (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Mar 2012 14:48:00 -0400
Received: from moweb001.kundenserver.de (moweb001.kundenserver.de [172.19.20.114])
	by fmmailgate04.web.de (Postfix) with ESMTP id 6D63373C5F5E
	for <git@vger.kernel.org>; Wed, 14 Mar 2012 19:47:59 +0100 (CET)
Received: from [192.168.178.48] ([91.3.202.6]) by smtp.web.de (mrweb002) with
 ESMTPA (Nemesis) id 0MMnD5-1SGQsa06X9-007j8K; Wed, 14 Mar 2012 19:47:59 +0100
User-Agent: Mozilla/5.0 (X11; Linux i686 on x86_64; rv:10.0.2) Gecko/20120216 Thunderbird/10.0.2
In-Reply-To: <CAFouetgSw7MMzHWOJox6DiPmBWD=6j4mST1KFZYsZyLmKHRrEQ@mail.gmail.com>
X-Provags-ID: V02:K0:5fftyAtSUolJfixKuU87HRaNJfONmRM4z3fbCkERp9O
 YiwnFApJxDw9p1Pmtwy+ih5bhn7YN+3QzPSJy7yVKvhgyF46MK
 i4175q8EeQ+gsqyWHKUhQwq1nhXOjIoQM6Y8FMf6eZE+utm0zc
 GCskgMgS9EdKntzE2jKbrSRc7TvxBlfLqcI7qjNkSmJ3QlLN0a
 P2F7gRmZKDm8VBAywvN1A==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/193147>

Am 13.03.2012 21:36, schrieb Tim Henigan:
> Some further minor changes to your version:
> 
>     Specify how differences in submodules are shown.  When `--submodule`
>     or `--submodule=log` is given, the 'log' format is used.  This format lists
>     the commits in the range like linkgit:git-submodule[1] `--summary` does.

Nit:
      the commits in the range like linkgit:git-submodule[1] `summary` does.

(`summary` is a command of "git submodule", not an option)

>     Omitting the `--submodule` option or specifying `--submodule=short`,
>     uses the 'short' format. This format just shows the names of the commits
>     at the beginning and end of the range.

But apart from that I really like it.

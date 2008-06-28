From: =?utf-8?q?=E3=81=97=E3=82=89=E3=81=84=E3=81=97=E3=81=AA=E3=81=AA=E3=81=93?= 
	<nanako3@lavabit.com>
Subject: Re: [PATCH] cmd_reset: don't trash uncommitted changes unless told to
Date: Sat, 28 Jun 2008 09:06:42 +0900
Message-ID: <20080628090642.6117@nanako3.lavabit.com>
References: <7vabh6plyh.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: Theodore Tso <tytso@mit.edu>, Avery Pennarun <apenwarr@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Johannes Sixt <j.sixt@viscovery.net>,
	Boaz Harrosh <bharrosh@panasas.com>,
	Steven Walter <stevenrwalter@gmail.com>, git@vger.kernel.org,
	jeske@google.com
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Jun 28 02:08:19 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KCNzF-0004mT-KW
	for gcvg-git-2@gmane.org; Sat, 28 Jun 2008 02:08:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755967AbYF1AHU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 27 Jun 2008 20:07:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752577AbYF1AHT
	(ORCPT <rfc822;git-outgoing>); Fri, 27 Jun 2008 20:07:19 -0400
Received: from karen.lavabit.com ([72.249.41.33]:41581 "EHLO karen.lavabit.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752557AbYF1AHS (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 Jun 2008 20:07:18 -0400
Received: from c.earth.lavabit.com (c.earth.lavabit.com [192.168.111.12])
	by karen.lavabit.com (Postfix) with ESMTP id 952CAC8941;
	Fri, 27 Jun 2008 19:07:08 -0500 (CDT)
Received: from nanako3.lavabit.com (212.62.97.21)
	by lavabit.com with ESMTP id V1CYJCUHFT06; Fri, 27 Jun 2008 19:07:16 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws; s=lavabit; d=lavabit.com;
  b=c4NPeURigIPoUi1NxjalrlrZoaiQnbFads+gV+j8WgPgG/pUZDzOhOCd00e2s+565EUiCjHlR9WU65AHHgFIBr/6irkSGkwUufaT/qfnpAZBgUY0Wdv0yOWqlgQqZsgmFFzOYx/KRQpo1/MrzF3EyNUFD/TLYFpBIydy2opWzxY=;
  h=From:Subject:To:Cc:Date:In-Reply-To:References:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Quoting Junio C Hamano <gitster@pobox.com>;
In-Reply-To: <7vabh6plyh.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/86684>

Quoting Junio C Hamano <gitster@pobox.com>:

>> Because it is where the convention that is used in all of the UI is
>> described, I think gitcli documentation is an appropriate place.
>
> I am still not convinced it is the best place but I guess it would be
> better than not documenting it anywhere.
>
>> Don't you also want to talk about distinction between --cached and
>> --index that new people are often confused about?  These options are
>> defined consistently across commands but people who do not know it bring
>> up discussions to rename --cached to some commands to --index to make it
>> inconsistent and waste your time every once in a while.

Do you have any comment on the --index/--cached issue?

-- 
Nanako Shiraishi
http://ivory.ap.teacup.com/nanako3/

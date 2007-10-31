From: Wincent Colaiuta <win@wincent.com>
Subject: Re: [PATCH 1/1] Add --first-parent support to interactive rebase.
Date: Wed, 31 Oct 2007 09:24:36 +0100
Message-ID: <B168AF44-265B-4339-BD00-10CD1ECB9394@wincent.com>
References: <1193797309-1161-1-git-send-email-B.Steinbrink@gmx.de> <Pine.LNX.4.64.0710310329520.4362@racer.site> <20071031041751.GA3326@atjola.homenet>
Mime-Version: 1.0 (Apple Message framework v912)
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: =?ISO-8859-1?Q?Bj=F6rn_Steinbrink?= <B.Steinbrink@gmx.de>
X-From: git-owner@vger.kernel.org Wed Oct 31 09:24:58 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1In8sj-000261-Og
	for gcvg-git-2@gmane.org; Wed, 31 Oct 2007 09:24:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753392AbXJaIYo convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 31 Oct 2007 04:24:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753402AbXJaIYn
	(ORCPT <rfc822;git-outgoing>); Wed, 31 Oct 2007 04:24:43 -0400
Received: from wincent.com ([72.3.236.74]:59181 "EHLO s69819.wincent.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752904AbXJaIYm convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 31 Oct 2007 04:24:42 -0400
Received: from cuzco.lan (localhost [127.0.0.1])
	(authenticated bits=0)
	by s69819.wincent.com (8.12.11.20060308/8.12.11) with ESMTP id l9V8ObOV021048;
	Wed, 31 Oct 2007 03:24:38 -0500
In-Reply-To: <20071031041751.GA3326@atjola.homenet>
X-Mailer: Apple Mail (2.912)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

El 31/10/2007, a las 5:17, Bj=F6rn Steinbrink escribi=F3:

> How about:
> \--first-parent::
> 	When this option is given and --preserve-merges is not, then
> 	merge commits are completely ignored and only commits from the
> 	first parent ancestry are rebased. This allows to pretend that
> 	merges never happened.
>
> 	If --preserve-merges is also given, the merge commits are
> 	preserved, but only their first parent is rebased as opposed to
> 	the default behaviour which would rebase all parents.


Minor nitpick:

-	first parent ancestry are rebased. This allows to pretend that
+	first parent ancestry are rebased. This allows you to pretend that

Cheers,
Wincent

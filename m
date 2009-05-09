From: Markus Heidelberg <markus.heidelberg@web.de>
Subject: Re: [PATCH] mergetool--lib: add support for araxis merge
Date: Sat, 9 May 2009 22:56:30 +0200
Message-ID: <200905092256.31964.markus.heidelberg@web.de>
References: <1241313481-17923-1-git-send-email-davvid@gmail.com> <200905030854.28059.markus.heidelberg@web.de> <20090504000956.GD50640@gmail.com>
Reply-To: markus.heidelberg@web.de
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: gitster@pobox.com, snowcoder@gmail.com, spearce@spearce.org,
	Johannes.Schindelin@gmx.de, git@vger.kernel.org,
	charles@hashpling.org
To: David Aguilar <davvid@gmail.com>
X-From: git-owner@vger.kernel.org Sat May 09 22:56:21 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M2tak-0005Wb-Or
	for gcvg-git-2@gmane.org; Sat, 09 May 2009 22:56:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754879AbZEIU4K (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 9 May 2009 16:56:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754823AbZEIU4J
	(ORCPT <rfc822;git-outgoing>); Sat, 9 May 2009 16:56:09 -0400
Received: from fmmailgate02.web.de ([217.72.192.227]:55143 "EHLO
	fmmailgate02.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754815AbZEIU4I (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 9 May 2009 16:56:08 -0400
Received: from smtp06.web.de (fmsmtp06.dlan.cinetic.de [172.20.5.172])
	by fmmailgate02.web.de (Postfix) with ESMTP id F2331FEA6EEF;
	Sat,  9 May 2009 22:56:06 +0200 (CEST)
Received: from [89.59.95.248] (helo=.)
	by smtp06.web.de with asmtp (TLSv1:AES256-SHA:256)
	(WEB.DE 4.110 #277)
	id 1M2taY-00037d-00; Sat, 09 May 2009 22:56:06 +0200
User-Agent: KMail/1.9.9
In-Reply-To: <20090504000956.GD50640@gmail.com>
Jabber-ID: markus.heidelberg@web.de
Content-Disposition: inline
X-Sender: markus.heidelberg@web.de
X-Provags-ID: V01U2FsdGVkX181QXDnFdIawpUbnID/DJe8SohI6c1fRI5KQUV9
	cHF60C1KY1m9CJEFJ81TJ2kNduIKQZ6ThiaDBB8wcR1Wt9JvBr
	YA17FqCEOwA7n6W1FLEw==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/118683>

David Aguilar, 04.05.2009:
> Seeing .diff_XXXX as the filename is bad too

> It would be nice to specialize the ext-diff code to
> generate a more intuitive filename.  Maybe something
> like original_filename.XXXXX.ext instead of the current
> .diff_XXXXX.  Right now the choice of filename breaks
> syntax highlighting in some viewers and also makes
> the usage of --title args necessary since the default
> names tell us nothing about what we're viewing.

Yes, this change would make sense.

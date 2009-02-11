From: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
Subject: Re: [PATCH JGIT] Deal with the signed-off in the commit text dialog
Date: Wed, 11 Feb 2009 01:16:35 +0100
Message-ID: <200902110116.36172.robin.rosenberg.lists@dewire.com>
References: <49917944.6030309@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: "Shawn O. Pearce" <spearce@spearce.org>, git <git@vger.kernel.org>
To: Yann Simon <yann.simon.fr@gmail.com>
X-From: git-owner@vger.kernel.org Wed Feb 11 01:18:22 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LX2o1-0004io-F1
	for gcvg-git-2@gmane.org; Wed, 11 Feb 2009 01:18:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755696AbZBKAQj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Feb 2009 19:16:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755230AbZBKAQj
	(ORCPT <rfc822;git-outgoing>); Tue, 10 Feb 2009 19:16:39 -0500
Received: from mail.dewire.com ([83.140.172.130]:13317 "EHLO dewire.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755504AbZBKAQi (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Feb 2009 19:16:38 -0500
Received: from localhost (localhost [127.0.0.1])
	by dewire.com (Postfix) with ESMTP id 8C161147E8AF;
	Wed, 11 Feb 2009 01:16:37 +0100 (CET)
X-Virus-Scanned: by amavisd-new at dewire.com
Received: from dewire.com ([127.0.0.1])
	by localhost (torino.dewire.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id iZQkxLHkN1Ui; Wed, 11 Feb 2009 01:16:37 +0100 (CET)
Received: from sleipner.localnet (unknown [10.9.0.3])
	by dewire.com (Postfix) with ESMTP id 1CF6E803219;
	Wed, 11 Feb 2009 01:16:37 +0100 (CET)
User-Agent: KMail/1.10.4 (Linux/2.6.27-11-generic; KDE/4.1.4; i686; ; )
In-Reply-To: <49917944.6030309@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/109360>

tisdag 10 februari 2009 13:55:32 skrev Yann Simon:
> The user can see and edit the signed-off in the commit dialog
> before committing.
> 
> Updating the committer updates the signed-off.
> 
> For new lines in the commit dialog, use Text.DELIMITER for
> plateform neutrality.

Spell "platform"

These is two unrelated changes. I don't deeply about the switch, but
I do want the line end handling so we don't get double spaced messages.

The toggle swithch will happily double the SOB-line. It assumes it is
the last line. Isn't that too strict, though it is the common idiom, but
we also have other types of X-by-lines that we often place below
the SOB line.

Signed-off-by: hacker
Signed-off-by: pschorff
Acked-by: bar

-- robin

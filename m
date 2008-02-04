From: "David Tweed" <david.tweed@gmail.com>
Subject: Re: [RFC,PATCH] Make git prune remove temporary packs that look like write failures
Date: Mon, 4 Feb 2008 17:42:05 +0000
Message-ID: <e1dab3980802040942k493e97efr438f75a553400331@mail.gmail.com>
References: <e1dab3980802040610s27a54a9due3b42db5f59c0cd5@mail.gmail.com>
	 <alpine.LSU.1.00.0802041512140.7372@racer.site>
	 <e1dab3980802040724l5ef12528y69f1d572b7ac8d54@mail.gmail.com>
	 <alpine.LSU.1.00.0802041714560.7372@racer.site>
	 <e1dab3980802040939u1329ab6xa730f5ecc52c809a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "gi mailing list" <git@vger.kernel.org>,
	"Nicolas Pitre" <nico@cam.org>
To: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon Feb 04 18:43:21 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JM5L9-0003z6-3w
	for gcvg-git-2@gmane.org; Mon, 04 Feb 2008 18:42:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756230AbYBDRmM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 4 Feb 2008 12:42:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751886AbYBDRmK
	(ORCPT <rfc822;git-outgoing>); Mon, 4 Feb 2008 12:42:10 -0500
Received: from ik-out-1112.google.com ([66.249.90.179]:31201 "EHLO
	ik-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754800AbYBDRmJ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Feb 2008 12:42:09 -0500
Received: by ik-out-1112.google.com with SMTP id c28so167132ika.5
        for <git@vger.kernel.org>; Mon, 04 Feb 2008 09:42:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=i8VQnQKudQ9cIR1x3ROw450EWR1y4Ndbq1AXB7GNB78=;
        b=UnXz6nk6an9phEfnMk9fRqDH+WtX1F1PKy2tao1kqnsDJGpHad6beDfqdbXDU3XGBaRWDUjV6uukjm4lxLqSQUODgp0YG5coD5acQqlLmh8/TO9HMXH3NqrTqc9Y3ZPk79mXw7ZIcAvELjrcHLIes0HhBFcUgFwZ18P457/PVXU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=TYK63L95aSsvHoyeG0WkfWe/5qcCP6fvv2hYvxTSxa56wj4IvMq0gplrPjrgWMlwSeX5RW30tRaPBjr9GVDgLZtyunmyhWWOoR+qdgySsOlwAjldtp0tBPDn0oVZgLmTBxNrQE0RVpBgrAuGwOrx6EE/4rqBvbNHdA0JvdKVDTc=
Received: by 10.150.203.8 with SMTP id a8mr3067643ybg.125.1202146925854;
        Mon, 04 Feb 2008 09:42:05 -0800 (PST)
Received: by 10.150.149.2 with HTTP; Mon, 4 Feb 2008 09:42:05 -0800 (PST)
In-Reply-To: <e1dab3980802040939u1329ab6xa730f5ecc52c809a@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/72533>

Ugh:
On Feb 4, 2008 5:39 PM, David Tweed <david.tweed@gmail.com> wrote:
> You're right (and I didn't intend to suggest otherwise) that it would
> be safe when running a "git prune" concurrently with a separate "git
s/safe/unsafe/
> repack".

-- 
cheers, dave tweed__________________________
david.tweed@gmail.com
Rm 124, School of Systems Engineering, University of Reading.
"while having code so boring anyone can maintain it, use Python." --
attempted insult seen on slashdot

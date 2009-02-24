From: Jay Soffian <jaysoffian@gmail.com>
Subject: Re: [PATCH 04/13] remote: make get_remote_ref_states() always 
	populate states.tracked
Date: Mon, 23 Feb 2009 22:13:53 -0500
Message-ID: <76718490902231913x63ca33cp8dd08b63f337bc7f@mail.gmail.com>
References: <cover.1235368324.git.jaysoffian@gmail.com>
	 <2185ca69c518d60276ba1bc613b7699a6bca7c68.1235368324.git.jaysoffian@gmail.com>
	 <7vvdr0pqhp.fsf@gitster.siamese.dyndns.org>
	 <76718490902231909n44b4ddebl1ce974090f90daff@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Feb 24 04:16:09 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LbnmC-0000Mn-9B
	for gcvg-git-2@gmane.org; Tue, 24 Feb 2009 04:16:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758170AbZBXDN4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 Feb 2009 22:13:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758163AbZBXDN4
	(ORCPT <rfc822;git-outgoing>); Mon, 23 Feb 2009 22:13:56 -0500
Received: from rv-out-0506.google.com ([209.85.198.238]:7619 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758150AbZBXDNz (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Feb 2009 22:13:55 -0500
Received: by rv-out-0506.google.com with SMTP id g37so2248334rvb.1
        for <git@vger.kernel.org>; Mon, 23 Feb 2009 19:13:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=Buz0AdFfZHQnAlDqEG3nvAN0EnVpGpsZORcJ7E7tbGU=;
        b=Bkpqlsrf+rkKFmtSyxjKAGHmNpXq/nDqnVCh2XG0LC05aHmw3MrkuK+N3nNRnoveYp
         UzNqE5d4cmCV8jLprkiRmYLtU1dWhW3Fm3vGqQkHJW/w/HEJZ+oGZkKWs5lB1nEqJj+F
         28gwjak6fUQ3nussu/I7gL2QT3WVCsNoxVRx4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=OddkENgcV09SjvG9eFkeggWxR3QU52eEj/iTCE4aGJjHm9jbjrQc8eDUX5g6fVqjcv
         FZyX0W3j1KJsQq+LwvxoXuDBkLIy4dKr7FNP3LNmfQH5WxlSbsIXgb4i0/UknniJXtN6
         6zk8E67oHaHbctMNwEGKCCHJoKMNyPu3wkoI8=
Received: by 10.141.180.16 with SMTP id h16mr2308963rvp.295.1235445233333; 
	Mon, 23 Feb 2009 19:13:53 -0800 (PST)
In-Reply-To: <76718490902231909n44b4ddebl1ce974090f90daff@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/111202>

On Mon, Feb 23, 2009 at 10:09 PM, Jay Soffian <jaysoffian@gmail.com> wrote:
> No, but I wanted Jeff's changes. I have checked that I can apply the
> "set HEAD" series, then Jeff's changes, then this latest series all to
> next w/o conflict.

Put another way, IMO, the set HEAD series, Jeff's changes, and this
series might very well be a single topic.

>> In other words, you make your series unworkable with if you introduce too
>> many dependencies.

For future reference, should I build on top of master or next?

j.

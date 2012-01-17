From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 2/2] commit, write-tree: allow to ignore CE_INTENT_TO_ADD
 while writing trees
Date: Mon, 16 Jan 2012 20:47:20 -0600
Message-ID: <20120117024720.GA32602@burratino>
References: <1326681407-6344-1-git-send-email-pclouds@gmail.com>
 <1326681407-6344-3-git-send-email-pclouds@gmail.com>
 <7vaa5nutbp.fsf@alter.siamese.dyndns.org>
 <CACsJy8B_qGphVz8PFhPNLsOe-Ve7xb+biNP8Ok7dXiygu3KoSg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jan 17 03:48:02 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rmz5d-0001pR-4Q
	for gcvg-git-2@lo.gmane.org; Tue, 17 Jan 2012 03:48:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751635Ab2AQCrf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 Jan 2012 21:47:35 -0500
Received: from mail-gx0-f174.google.com ([209.85.161.174]:41108 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751621Ab2AQCrd (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Jan 2012 21:47:33 -0500
Received: by ggdk6 with SMTP id k6so2937166ggd.19
        for <git@vger.kernel.org>; Mon, 16 Jan 2012 18:47:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=6g8z1Sb3G6WUuwUPnjTCkTPE16yEe4EgZOuSs1Bs67U=;
        b=QXBjMVR6D+eUQXAuqaC11Ea3FroJCbLz2uwipXqT29HEFGSRXRsviwK5KEIiLX3lfV
         DM/3BtGGZ6Rl1a7fdclf1fbbLIVRr2KaweUq8g3/c2NOSKY96o6IiHqSInQHMzhbUuHk
         F4qsNO6IYdiypoKvGCm9NFrALUh6zfvuJAiVU=
Received: by 10.101.74.1 with SMTP id b1mr6350463anl.43.1326768452842;
        Mon, 16 Jan 2012 18:47:32 -0800 (PST)
Received: from burratino (c-24-1-56-9.hsd1.il.comcast.net. [24.1.56.9])
        by mx.google.com with ESMTPS id d3sm44137662anm.11.2012.01.16.18.47.30
        (version=SSLv3 cipher=OTHER);
        Mon, 16 Jan 2012 18:47:31 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <CACsJy8B_qGphVz8PFhPNLsOe-Ve7xb+biNP8Ok7dXiygu3KoSg@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/188681>

Nguyen Thai Ngoc Duy wrote:

> Although I would not oppose deprecating the old behavior if you go with (2) ;)

My reaction on reading the patch and clarifying followup was similar
to Junio's.  I don't think a configuration item makes sense unless we
are planning to flip the default in the future, and it would probably
be clearer to document it that way.

By the way, thanks very much for working on this.  I wish I had more
time to offer more than comments.

Sincerely,
Jonathan

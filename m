From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: Fw: [git-users] How do I git-push to an FTP server?
Date: Mon, 8 Oct 2012 13:18:16 -0700
Message-ID: <20121008201816.GB7698@elie.Belkin>
References: <CAGK7Mr4L0Us3ykLUoWBdyR2zJUNa_HNguwb-=dEq_h_yXThPPA@mail.gmail.com>
 <CAEcj5uW4aw19MgNi8vJk5TWoL6SEad=s2jthS-h1jLTtuPq7AQ@mail.gmail.com>
 <7vwqz4si87.fsf@alter.siamese.dyndns.org>
 <CALkWK0kXH-U0mTeFtiMq7tqCOpNJT1A7Z==GxOphe-sGdmxRRg@mail.gmail.com>
 <20121007172754.GA29560@elie.Belkin>
 <7vvcemovrh.fsf@alter.siamese.dyndns.org>
 <CALkWK0nSxBsiE5_BZ67dPrwDRQSipL0LBR9Pf252iqL21HwZBA@mail.gmail.com>
 <20121008080208.GC19733@elie.Belkin>
 <7v7gr1nfby.fsf@alter.siamese.dyndns.org>
 <7vzk3wlvs2.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Ramkumar Ramachandra <artagnon@gmail.com>,
	Thomas Ferris Nicolaisen <tfnico@gmail.com>,
	Philippe Vaucher <philippe.vaucher@gmail.com>,
	Konstantin Khomoutov <flatworm@users.sourceforge.net>,
	git@vger.kernel.org, git-users@googlegroups.com,
	August Karlstrom <fusionfile@gmail.com>,
	Sverre Rabbelier <srabbelier@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Oct 08 22:18:48 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TLJmm-0005OF-An
	for gcvg-git-2@plane.gmane.org; Mon, 08 Oct 2012 22:18:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754686Ab2JHUSe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Oct 2012 16:18:34 -0400
Received: from mail-da0-f46.google.com ([209.85.210.46]:58168 "EHLO
	mail-da0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753535Ab2JHUSd (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Oct 2012 16:18:33 -0400
Received: by mail-da0-f46.google.com with SMTP id n41so1729392dak.19
        for <git@vger.kernel.org>; Mon, 08 Oct 2012 13:18:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=ubbDRBWpA0G+/qbEnYvV+CKRXTxUVfKWwAVDOllP1ug=;
        b=cCLnnLLdJH5CikIbF6yIHAFC7j78ot/Vk1rxUU5G2q4UK89090gQxiE5oa9Kg0v7FH
         lTNqsdsqvWzpBhouAdZWWZ4rh6Tco6147gREVMyDltjjTEox3qSWdjgVeOgAZC7/eVBb
         UzkmuCLeg0CZOxcUFMVw9OAJu5SWz9MNKnqqQz0fPaTtV0DyOoJBEsxgMg+sDXt4oftv
         zhWZTz/sVXTON6t2SUCMzh60euVeCw7fAvIvUUM8QLV5qOBcTgFWkwDYrNKI0WK5Soxr
         tfov4gRYwLJgM7tV3xHKdASMkUfh+Ujm6Au+TXKbxZCYXCsbvY2jVPdPHvFofaUs/tAX
         pk3Q==
Received: by 10.68.242.164 with SMTP id wr4mr56618708pbc.41.1349727512813;
        Mon, 08 Oct 2012 13:18:32 -0700 (PDT)
Received: from elie.Belkin (c-67-180-61-129.hsd1.ca.comcast.net. [67.180.61.129])
        by mx.google.com with ESMTPS id y2sm11323275pax.29.2012.10.08.13.18.26
        (version=SSLv3 cipher=OTHER);
        Mon, 08 Oct 2012 13:18:31 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <7vzk3wlvs2.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.21+51 (9e756d1adb76) (2011-07-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/207269>

Junio C Hamano wrote:

> Let's do this, then.

I think it would be nicer to start with the important info (git
supports ssh, git, http, https) and deal with less important parts
like rsync support later in the document, but this looks like a good
minimal fix.  Thanks for pushing it to completion.

For what it's worth,
Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>

From: John Keeping <john@keeping.me.uk>
Subject: Re: [PATCH v3 6/7] completion: get rid of __gitcomp_1
Date: Wed, 10 Apr 2013 12:35:31 +0100
Message-ID: <20130410113531.GJ2222@serenity.lan>
References: <1365577077-12648-1-git-send-email-felipe.contreras@gmail.com>
 <1365577077-12648-7-git-send-email-felipe.contreras@gmail.com>
 <CAPig+cR4_ZB=s8JVT2LRJGcNhM9ZaESWZQ5v6Wa20=bWGoMydg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Felipe Contreras <felipe.contreras@gmail.com>,
	Git List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>,
	SZEDER =?iso-8859-1?Q?G=E1bor?= <szeder@ira.uka.de>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Wed Apr 10 13:35:58 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UPtJf-0001kg-Ac
	for gcvg-git-2@plane.gmane.org; Wed, 10 Apr 2013 13:35:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S936547Ab3DJLfr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Apr 2013 07:35:47 -0400
Received: from jackal.aluminati.org ([72.9.247.210]:58237 "EHLO
	jackal.aluminati.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933890Ab3DJLfq (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Apr 2013 07:35:46 -0400
Received: from localhost (localhost [127.0.0.1])
	by jackal.aluminati.org (Postfix) with ESMTP id C82BDCDA5C6;
	Wed, 10 Apr 2013 12:35:45 +0100 (BST)
X-Virus-Scanned: Debian amavisd-new at serval.aluminati.org
X-Spam-Flag: NO
X-Spam-Score: -12.9
X-Spam-Level: 
X-Spam-Status: No, score=-12.9 tagged_above=-9999 required=6.31
	tests=[ALL_TRUSTED=-1, ALUMINATI_LOCAL_TESTS=-10, BAYES_00=-1.9]
	autolearn=ham
Received: from jackal.aluminati.org ([127.0.0.1])
	by localhost (jackal.aluminati.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 6vD3CrnGRTtr; Wed, 10 Apr 2013 12:35:45 +0100 (BST)
Received: from serenity.lan (tg2.aluminati.org [10.0.7.178])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by jackal.aluminati.org (Postfix) with ESMTPSA id 3313ACDA5A9;
	Wed, 10 Apr 2013 12:35:33 +0100 (BST)
Content-Disposition: inline
In-Reply-To: <CAPig+cR4_ZB=s8JVT2LRJGcNhM9ZaESWZQ5v6Wa20=bWGoMydg@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/220681>

On Wed, Apr 10, 2013 at 06:13:06AM -0400, Eric Sunshine wrote:
> On Wed, Apr 10, 2013 at 2:57 AM, Felipe Contreras
> <felipe.contreras@gmail.com> wrote:
> > we traverse the words ourselves both in __gitcompadd, and __gitcomp_1.
> 
> s/ourselves/ourself/

Huh?  "we traverse ... ourselves" is correct since "ourselves" is
associated with the "we".  I don't think "ourself" is ever correct in
normal usage - the dictionary notes that it applies only to the "royal
we".

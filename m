From: David Bryson <david@statichacks.org>
Subject: Re: [PATCH] Use "git_config_string" to simplify "remote.c" code in
	"handle_config"
Date: Mon, 6 Oct 2008 12:49:06 -0700
Message-ID: <20081006194906.GR5774@eratosthenes.cryptobackpack.org>
References: <20081003033937.GA11594@eratosthenes.cryptobackpack.org> <48E5AD8A.4070301@op5.se> <20081003200613.GO20571@eratosthenes.cryptobackpack.org> <81b0412b0810041546w5eed8859vd8266bb66425ebd3@mail.gmail.com>
Reply-To: David Bryson <david@statichacks.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Alex Riesen <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Mon Oct 06 21:50:33 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kmw66-0006Wj-E9
	for gcvg-git-2@gmane.org; Mon, 06 Oct 2008 21:50:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753219AbYJFTtJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 6 Oct 2008 15:49:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753030AbYJFTtI
	(ORCPT <rfc822;git-outgoing>); Mon, 6 Oct 2008 15:49:08 -0400
Received: from cryptobackpack.org ([64.105.32.74]:38804 "EHLO
	mail.cryptobackpack.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752387AbYJFTtH (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Oct 2008 15:49:07 -0400
Received: by mail.cryptobackpack.org (Postfix, from userid 1000)
	id E2EF410D0271; Mon,  6 Oct 2008 12:49:06 -0700 (PDT)
X-Spam-Checker-Version: SpamAssassin 3.2.1-gr1 (2007-05-02) on
	ptolemy.cryptobackpack.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=5.0 tests=ALL_TRUSTED,AWL,BAYES_00,
	DNS_FROM_SECURITYSAGE autolearn=no version=3.2.1-gr1
Received: from eratosthenes.statichacks.org (heliosphan.cryptobackpack.org [10.6.6.6])
	by mail.cryptobackpack.org (Postfix) with ESMTP id 8552310D01EE;
	Mon,  6 Oct 2008 12:49:06 -0700 (PDT)
Received: by eratosthenes.statichacks.org (Postfix, from userid 1000)
	id 4E26A5BB13; Mon,  6 Oct 2008 12:49:06 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <81b0412b0810041546w5eed8859vd8266bb66425ebd3@mail.gmail.com>
User-Agent: Mutt/1.5.16 (2007-06-09)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/97619>

On Sun, Oct 05, 2008 at 12:46:29AM +0200 or thereabouts, Alex Riesen wrote:
> >
> 
> You can redeclare of the variable in the contexts where
> it is used and not even rename it: it is close to its users then.

I'm not sure I understand entirely, care to elaborate a bit more ?

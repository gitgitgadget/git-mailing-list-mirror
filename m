From: Matthias Kestenholz <mk@spinlock.ch>
Subject: Re: [PATCH] cmd_reset: don't trash uncommitted changes unless told
	to
Date: Wed, 25 Jun 2008 12:24:58 +0200
Message-ID: <1214389498.6634.10.camel@localhost>
References: <20080624222105.GA24549@dervierte>
	 <1214346098-24584-1-git-send-email-stevenrwalter@gmail.com>
	 <7vwskea2ik.fsf@gitster.siamese.dyndns.org> <48620C1A.6000509@panasas.com>
	 <alpine.DEB.1.00.0806251109380.9925@racer>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: Boaz Harrosh <bharrosh@panasas.com>,
	Junio C Hamano <gitster@pobox.com>,
	Steven Walter <stevenrwalter@gmail.com>, git@vger.kernel.org,
	jeske@google.com
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed Jun 25 12:26:44 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KBSCz-0003w0-BZ
	for gcvg-git-2@gmane.org; Wed, 25 Jun 2008 12:26:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754707AbYFYKZh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Jun 2008 06:25:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754083AbYFYKZf
	(ORCPT <rfc822;git-outgoing>); Wed, 25 Jun 2008 06:25:35 -0400
Received: from yw-out-2324.google.com ([74.125.46.30]:43436 "EHLO
	yw-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754547AbYFYKZC (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Jun 2008 06:25:02 -0400
Received: by yw-out-2324.google.com with SMTP id 9so1126408ywe.1
        for <git@vger.kernel.org>; Wed, 25 Jun 2008 03:25:00 -0700 (PDT)
Received: by 10.125.149.3 with SMTP id b3mr1733956mko.81.1214389499573;
        Wed, 25 Jun 2008 03:24:59 -0700 (PDT)
Received: from ?192.168.1.15? ( [213.3.44.95])
        by mx.google.com with ESMTPS id k29sm4231624fkk.2.2008.06.25.03.24.58
        (version=SSLv3 cipher=RC4-MD5);
        Wed, 25 Jun 2008 03:24:59 -0700 (PDT)
In-Reply-To: <alpine.DEB.1.00.0806251109380.9925@racer>
X-Mailer: Evolution 2.22.2 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/86267>

On Wed, 2008-06-25 at 11:16 +0100, Johannes Schindelin wrote:
> Incidentally, a friend just told me that "checkout" is everything but 
> intuitive, and he would have preferred "git branch switch <branch>", but 
> then settled for my proposed "git branch --switch <branch>", which I did 
> not have time to implement yet, unfortunately.

But why? I don't want to 'branch', I want to 'checkout' another branch,
which incidentally matches the git command I need to use to achieve
that.

Matthias

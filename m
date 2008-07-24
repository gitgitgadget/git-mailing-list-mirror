From: =?ISO-8859-1?Q?Ask_Bj=F8rn_Hansen?= <ask@develooper.com>
Subject: Re: git status in clean working dir
Date: Wed, 23 Jul 2008 23:56:48 -0700
Message-ID: <D42305E3-82DA-46C1-B55F-74AD9AD48197@develooper.com>
References: <0ttzeirft8.wl%bremner@pivot.cs.unb.ca> <7vy73ur6pz.fsf@gitster.siamese.dyndns.org> <7vtzeir68z.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0 (Apple Message framework v928.1)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org,
	David Bremner <bremner@unb.ca>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jul 24 08:57:57 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KLulq-0007eP-K1
	for gcvg-git-2@gmane.org; Thu, 24 Jul 2008 08:57:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751040AbYGXG4u (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 Jul 2008 02:56:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751117AbYGXG4u
	(ORCPT <rfc822;git-outgoing>); Thu, 24 Jul 2008 02:56:50 -0400
Received: from x8.develooper.com ([216.52.237.208]:44367 "EHLO
	x8.develooper.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750894AbYGXG4u (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Jul 2008 02:56:50 -0400
Received: (qmail 13957 invoked from network); 24 Jul 2008 06:56:49 -0000
Received: from gw.develooper.com (HELO embla.bn.dev) (ask@mail.dev@64.81.84.140)
  by smtp.develooper.com with (AES128-SHA encrypted) SMTP; 24 Jul 2008 06:56:49 -0000
In-Reply-To: <7vtzeir68z.fsf@gitster.siamese.dyndns.org>
X-Mailer: Apple Mail (2.928.1)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/89841>


On Jul 21, 2008, at 19:40, Junio C Hamano wrote:

> (2) Then why are we even allowing to configure the plumbing to page?


I don't have an opinion on the the appropriateness of paging various  
commands, but to solve the problem of scripts getting tripped up by  
the paging, couldn't the plumping check if STDOUT is a tty and only do  
the paging if so?

(In Perl "page_output(...) if $pager_configured and -t STDOUT")


  - ask

-- 
http://develooper.com/ - http://askask.com/

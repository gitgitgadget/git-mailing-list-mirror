From: Abhijit Menon-Sen <ams@toroid.org>
Subject: Re: git status in clean working dir
Date: Tue, 22 Jul 2008 08:06:26 +0530
Message-ID: <20080722023626.GA31026@toroid.org>
References: <0ttzeirft8.wl%bremner@pivot.cs.unb.ca> <7vy73ur6pz.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: David Bremner <bremner@unb.ca>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jul 22 04:37:35 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KL7kr-0004X7-6R
	for gcvg-git-2@gmane.org; Tue, 22 Jul 2008 04:37:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755112AbYGVCgb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Jul 2008 22:36:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754987AbYGVCga
	(ORCPT <rfc822;git-outgoing>); Mon, 21 Jul 2008 22:36:30 -0400
Received: from fugue.toroid.org ([85.10.196.113]:45701 "EHLO fugue.toroid.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754839AbYGVCg3 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Jul 2008 22:36:29 -0400
Received: from penne.toroid.org (penne-vpn [10.8.0.6])
	by fugue.toroid.org (Postfix) with ESMTP id 45C375584B9;
	Tue, 22 Jul 2008 04:36:27 +0200 (CEST)
Received: by penne.toroid.org (Postfix, from userid 1000)
	id 74D20ADC364; Tue, 22 Jul 2008 08:06:26 +0530 (IST)
Content-Disposition: inline
In-Reply-To: <7vy73ur6pz.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/89426>

At 2008-07-21 19:30:16 -0700, gitster@pobox.com wrote:
>
> I think this is an instance of the c8af1de (make git-status use a
> pager, 2008-04-23) stupidity raising its ugly head again.
> 
> Do people mind reverting that patch?

I think that is an excellent idea. I've found myself annoyed time and
again by "git status" starting the pager for just a couple of lines of
output.

-- ams

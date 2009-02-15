From: =?ISO-8859-1?Q?Santi_B=E9jar?= <santi@agolina.net>
Subject: Re: [PATCH] bash completion: offer more options for gitk
Date: Sun, 15 Feb 2009 10:56:01 +0100
Message-ID: <adf1fd3d0902150156w67a16e6fp3c946446c5ae2bfd@mail.gmail.com>
References: <1234641270-14342-1-git-send-email-trast@student.ethz.ch>
	 <7vfxigniws.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Thomas Rast <trast@student.ethz.ch>, git@vger.kernel.org,
	"Shawn O. Pearce" <spearce@spearce.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Feb 15 10:57:34 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LYdkj-0004QR-TO
	for gcvg-git-2@gmane.org; Sun, 15 Feb 2009 10:57:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751543AbZBOJ4H (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 15 Feb 2009 04:56:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751492AbZBOJ4F
	(ORCPT <rfc822;git-outgoing>); Sun, 15 Feb 2009 04:56:05 -0500
Received: from mail-fx0-f20.google.com ([209.85.220.20]:48221 "EHLO
	mail-fx0-f20.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751285AbZBOJ4E (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 15 Feb 2009 04:56:04 -0500
Received: by fxm13 with SMTP id 13so4809283fxm.13
        for <git@vger.kernel.org>; Sun, 15 Feb 2009 01:56:02 -0800 (PST)
Received: by 10.103.226.10 with SMTP id d10mr2261108mur.105.1234691761967; 
	Sun, 15 Feb 2009 01:56:01 -0800 (PST)
In-Reply-To: <7vfxigniws.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/109986>

2009/2/15 Junio C Hamano <gitster@pobox.com>:
> Many options you add here are useful for git-log and not present in its
> completion, but as you point out not all git-log options necessarily make
> sense for gitk.  I think it would make sense to introduce an extra
> variable $__git_log_basic_options that holds the basic ones that can be in
> both, and add the ones that are specific to gitk or git-log in their own
> completion functions.  I suspect gitk's addition will be nil, while
> git-log would add --graph, --walk-reflogs and --no-merges to the basic
> set.

I sometimes use the --no-merges with gitk, normally within a range
(the last 'next' update or so).

Santi

From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: [PATCH] Make reflog query '@{1219188291}' act as '@{2008/08/19
	16:24:51}'
Date: Wed, 20 Aug 2008 21:35:57 +0200
Message-ID: <20080820193557.GB16626@blimp.local>
References: <20080819234433.GJ24212@spearce.org>
Reply-To: Alex Riesen <raa.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Wed Aug 20 21:37:18 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KVtUZ-0001JX-Oo
	for gcvg-git-2@gmane.org; Wed, 20 Aug 2008 21:37:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751648AbYHTTgE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 Aug 2008 15:36:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751837AbYHTTgB
	(ORCPT <rfc822;git-outgoing>); Wed, 20 Aug 2008 15:36:01 -0400
Received: from mo-p05-ob.rzone.de ([81.169.146.181]:26948 "EHLO
	mo-p05-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751648AbYHTTgA (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Aug 2008 15:36:00 -0400
X-RZG-CLASS-ID: mo05
X-RZG-AUTH: :YSxENQjhO8RswxTRIGdg201f5UW7
Received: from tigra.home (Faf2f.f.strato-dslnet.de [195.4.175.47])
	by post.webmailer.de (fruni mo10) (RZmta 16.47)
	with ESMTP id 90673ek7KJYVWP ; Wed, 20 Aug 2008 21:35:58 +0200 (MEST)
	(envelope-from: <raa.lkml@gmail.com>)
Received: from blimp (unknown [192.168.0.8])
	by tigra.home (Postfix) with ESMTP id 07F8F277AE;
	Wed, 20 Aug 2008 21:35:58 +0200 (CEST)
Received: by blimp (Postfix, from userid 1000)
	id E16DC36D18; Wed, 20 Aug 2008 21:35:57 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20080819234433.GJ24212@spearce.org>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/93017>

Shawn O. Pearce, Wed, Aug 20, 2008 01:44:33 +0200:
> The value 1112911993 was chosen for the limit as it is the commit
> timestamp for e83c516331 "Initial revision of "git" ...". Any
> reflogs in existance should contain timestamps dated later than
> the date Linus first stored Git into itself, as reflogs came about
> quite a bit after that.

Maybe I'm missing something, but aren't unsynchronized clocks a common
thing in personal computing? Even maybe less common, but noticably
frequent, the clocks with the date set way back in the past (by malice
or accident)?

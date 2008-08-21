From: Jonathan Nieder <jrnieder@uchicago.edu>
Subject: Re: [PATCH 3/3] git-add --intent-to-add (-N)
Date: Thu, 21 Aug 2008 16:14:32 -0500 (CDT)
Message-ID: <Pine.GSO.4.62.0808211608020.26161@harper.uchicago.edu>
References: <4b6f054f0808171702q10d89dfey98afa65634d26e91@mail.gmail.com>
 <alpine.LNX.1.00.0808181512160.19665@iabervon.org> <7vfxp2m5w8.fsf@gitster.siamese.dyndns.org>
 <alpine.LNX.1.00.0808181628420.19665@iabervon.org> <7viqtukbec.fsf@gitster.siamese.dyndns.org>
 <7v3akykb96.fsf_-_@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Aug 21 23:15:58 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KWHVa-000075-H3
	for gcvg-git-2@gmane.org; Thu, 21 Aug 2008 23:15:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753757AbYHUVOt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 21 Aug 2008 17:14:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754140AbYHUVOs
	(ORCPT <rfc822;git-outgoing>); Thu, 21 Aug 2008 17:14:48 -0400
Received: from smtp01.uchicago.edu ([128.135.12.77]:39361 "EHLO
	smtp01.uchicago.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752250AbYHUVOs (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Aug 2008 17:14:48 -0400
Received: from harper.uchicago.edu (harper.uchicago.edu [128.135.12.7])
	by smtp01.uchicago.edu (8.13.8/8.13.8) with ESMTP id m7LLEWZe006586;
	Thu, 21 Aug 2008 16:14:32 -0500
Received: from localhost (jrnieder@localhost)
	by harper.uchicago.edu (8.12.10/8.12.10) with ESMTP id m7LLEWjC026438;
	Thu, 21 Aug 2008 16:14:32 -0500 (CDT)
X-Authentication-Warning: harper.uchicago.edu: jrnieder owned process doing -bs
In-Reply-To: <7v3akykb96.fsf_-_@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/93209>

Hi,

Junio C Hamano wrote:

> This adds "--intent-to-add" option to "git add".

I quite like the idea of this patch series.  When I try to test it with
"git merge jc/ita; make test", t0020-crlf setup fails with

	error: invalid object e69de29bb2d1d6434b8b29ae775ad8c2e48c5391
	error: Error building trees
	* FAIL 1: setup

This could be me doing something wrong, but I thought you'd like to
know, anyway.  I'll try to diagnose it tonight.

Regards,
Jonathan

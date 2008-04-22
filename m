From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 4/8] Add a function to set a non-default work tree
Date: Mon, 21 Apr 2008 17:09:44 -0700
Message-ID: <7v3apeagxj.fsf@gitster.siamese.dyndns.org>
References: <alpine.LNX.1.00.0804171931550.19665@iabervon.org>
 <7vprslcdxf.fsf@gitster.siamese.dyndns.org>
 <alpine.LNX.1.00.0804201546340.19665@iabervon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Daniel Barkalow <barkalow@iabervon.org>
X-From: git-owner@vger.kernel.org Tue Apr 22 02:10:49 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jo65w-0002Wa-C5
	for gcvg-git-2@gmane.org; Tue, 22 Apr 2008 02:10:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757888AbYDVAJ6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Apr 2008 20:09:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757593AbYDVAJ6
	(ORCPT <rfc822;git-outgoing>); Mon, 21 Apr 2008 20:09:58 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:35224 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756805AbYDVAJ5 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Apr 2008 20:09:57 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id E417728C5;
	Mon, 21 Apr 2008 20:09:55 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id 4FB1A28C4; Mon, 21 Apr 2008 20:09:52 -0400 (EDT)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/80046>

Daniel Barkalow <barkalow@iabervon.org> writes:

> On Sat, 19 Apr 2008, Junio C Hamano wrote:
> ...
>> How should the setting of new work tree from sideways using this interface
>> interact with bareness of the repository?
>
> I'm only using it before any initialization and when I'm going to force 
> the repository (which doesn't even exist yet; I haven't set git_dir let 
> alone created it, let alone looked at its configuration) to be bare, so I 
> hadn't considered that.

That is not quite an explanation that builds confidence in a patch that
adds a generic-sounding helper function that could be called by later
callers.  Doesn't it have a very tempting name for people to call?

From: Martin Atukunda <matlads@dsmagic.com>
Subject: Re: cogito-0.15: Broken documentation
Date: Mon, 19 Sep 2005 23:19:23 +0300
Message-ID: <20050919201923.GA17503@igloo.ds.co.ug>
References: <200509190221.j8J2LUOf021975@inti.inf.utfsm.cl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Mon Sep 19 22:24:46 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EHS96-0008Ro-NF
	for gcvg-git@gmane.org; Mon, 19 Sep 2005 22:21:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932622AbVISUVq (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 19 Sep 2005 16:21:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932621AbVISUVq
	(ORCPT <rfc822;git-outgoing>); Mon, 19 Sep 2005 16:21:46 -0400
Received: from mail1.imul.com ([217.113.72.31]:1120 "EHLO mail1.infocom.co.ug")
	by vger.kernel.org with ESMTP id S932622AbVISUVp (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 19 Sep 2005 16:21:45 -0400
Received: from entandikwa.ds.co.ug ([::ffff:217.113.73.39])
  by mail1.infocom.co.ug with esmtp; Mon, 19 Sep 2005 23:21:29 +0300
  id 000E5E3A.432F1DC9.00002451
Received: from igloo.ds.co.ug (igloo.ds.co.ug [192.168.129.66])
	by entandikwa.ds.co.ug (Postfix) with ESMTP id 545AD525E
	for <git@vger.kernel.org>; Mon, 19 Sep 2005 23:22:52 +0300 (EAT)
Received: from matlads by igloo.ds.co.ug with local (Exim 4.52)
	id 1EHS6l-0004b7-AH
	for git@vger.kernel.org; Mon, 19 Sep 2005 23:19:23 +0300
To: git@vger.kernel.org
Mail-Followup-To: git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <200509190221.j8J2LUOf021975@inti.inf.utfsm.cl>
User-Agent: Mutt/1.5.10i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/8904>

On Sun, Sep 18, 2005 at 10:21:30PM -0400, Horst von Brand wrote:
> cg-parent-id.txt and cg-tree-id.txt don't validate as xml.

I traced this to the fact that cg-parent-id and cg-tree-id do not have
USAGE=... lines. btw, this also affects cg-commit-id.

Patch to follow soon.
-- 
Your entire blood supply is filtered through your kidneys in four minutes.

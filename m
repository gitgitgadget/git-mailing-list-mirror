From: Nicolas Pitre <nico@fluxnic.net>
Subject: Re: Enumerating all objects in the Git object store
Date: Fri, 26 Mar 2010 13:25:19 -0400 (EDT)
Message-ID: <alpine.LFD.2.00.1003261324350.694@xanadu.home>
References: <a1138db31003260831q34967f69u9fc8de861f7931b1@mail.gmail.com>
 <4BACD86E.4020803@viscovery.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Paul Richards <paul.richards@gmail.com>, git@vger.kernel.org
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Fri Mar 26 18:39:21 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NvDVA-0004KW-TL
	for gcvg-git-2@lo.gmane.org; Fri, 26 Mar 2010 18:39:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753191Ab0CZRjI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 26 Mar 2010 13:39:08 -0400
Received: from relais.videotron.ca ([24.201.245.36]:59330 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753113Ab0CZRjH (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Mar 2010 13:39:07 -0400
Received: from xanadu.home ([66.130.28.92]) by VL-MR-MR001.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-8.01 (built Dec 16 2008; 32bit))
 with ESMTP id <0KZW00GC2GE7JJA0@VL-MR-MR001.ip.videotron.ca> for
 git@vger.kernel.org; Fri, 26 Mar 2010 13:25:19 -0400 (EDT)
X-X-Sender: nico@xanadu.home
In-reply-to: <4BACD86E.4020803@viscovery.net>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/143262>

On Fri, 26 Mar 2010, Johannes Sixt wrote:

> Use 'git rev-list --objects --all' to find all objects connected to all
> refs (use something else than --all if you want to). Do *not* look at the
> path that the tree and blob objects have attached - it is not authorative
> information.

Really??


Nicolas

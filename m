From: Holger Schurig <hs4233@mail.mn-solutions.de>
Subject: Re: How to (re-)create .git/logs/refs
Date: Tue, 13 May 2008 08:42:06 +0200
Message-ID: <200805130842.06112.hs4233@mail.mn-solutions.de>
References: <200805081256.11465.hs4233@mail.mn-solutions.de> <alpine.LFD.1.10.0805081313190.23581@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
To: Nicolas Pitre <nico@cam.org>
X-From: git-owner@vger.kernel.org Tue May 13 08:46:22 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JvoHF-0003bZ-Av
	for gcvg-git-2@gmane.org; Tue, 13 May 2008 08:46:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754269AbYEMGpc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 May 2008 02:45:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755252AbYEMGpc
	(ORCPT <rfc822;git-outgoing>); Tue, 13 May 2008 02:45:32 -0400
Received: from s131.mittwaldmedien.de ([62.216.178.31]:17198 "EHLO
	s131.mittwaldmedien.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752894AbYEMGpb (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 May 2008 02:45:31 -0400
Received: from lin01.mn-solutions.de (pD95FB5E9.dip0.t-ipconnect.de [217.95.181.233])
	by s131.mittwaldmedien.de (Postfix) with ESMTP id 499A65E40BB;
	Tue, 13 May 2008 08:45:29 +0200 (CEST)
Received: by lin01.mn-solutions.de (Postfix, from userid 116)
	id D25451E004D; Tue, 13 May 2008 08:42:37 +0200 (CEST)
X-Spam-Checker-Version: SpamAssassin 3.1.7-deb (2006-10-05) on 
	lin01.mn-logistik.de
X-Spam-Level: 
X-Spam-Status: No, score=-4.4 required=5.0 tests=ALL_TRUSTED,AWL,BAYES_00 
	autolearn=ham version=3.1.7-deb
Received: from mnz66.mn-solutions.de (mnz66.mn-logistik.de [192.168.233.66])
	by lin01.mn-solutions.de (Postfix) with ESMTP id 890911E0004;
	Tue, 13 May 2008 08:42:34 +0200 (CEST)
User-Agent: KMail/1.9.7
In-Reply-To: <alpine.LFD.1.10.0805081313190.23581@xanadu.home>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/81994>

> > a) is there a way to re-create .git/logs/refs ?
>
> No.
>
> The reflog records how _you_ modified your various branches
> locally.

Okay, then I presume it's a shortcoming that the @{date} syntax 
uses .git/logs/ref. It could do otherwise, e.g. git bisect seems 
to able to go via bisection arbitrarily back in time without 
using log-refs.

> 	git log --pretty=format:"%H %ai"

Thanks.

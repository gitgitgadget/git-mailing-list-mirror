From: "Aneesh Kumar K.V" <aneesh.kumar@gmail.com>
Subject: Re: [PATCH (revised)] gitweb: Show project's git URL on summary page
Date: Wed, 16 Aug 2006 13:01:01 +0530
Message-ID: <ebuhjn$kdm$1@sea.gmane.org>
References: <200608152003.05693.jnareb@gmail.com> <200608152303.17994.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Wed Aug 16 09:31:59 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GDFsT-0003ZI-ER
	for gcvg-git@gmane.org; Wed, 16 Aug 2006 09:31:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750985AbWHPHbr (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 16 Aug 2006 03:31:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750984AbWHPHbr
	(ORCPT <rfc822;git-outgoing>); Wed, 16 Aug 2006 03:31:47 -0400
Received: from main.gmane.org ([80.91.229.2]:33422 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1750983AbWHPHbq (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 16 Aug 2006 03:31:46 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1GDFsA-0003Vd-UI
	for git@vger.kernel.org; Wed, 16 Aug 2006 09:31:30 +0200
Received: from palrel2.hp.com ([156.153.255.234])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 16 Aug 2006 09:31:30 +0200
Received: from aneesh.kumar by palrel2.hp.com with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 16 Aug 2006 09:31:30 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: palrel2.hp.com
User-Agent: Thunderbird 1.5.0.5 (X11/20060728)
In-Reply-To: <200608152303.17994.jnareb@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/25507>

Jakub Narebski wrote:
> From 31e4de9f22a3b17d4ad0ac800132e4e1a0a15006 Mon Sep 17 00:00:00 2001
> From: David Rientjes <rientjes@google.com>
> Date: Tue, 15 Aug 2006 11:43:04 -0700
> Subject: [PATCH] gitweb: Show project's git URL on summary page
> 
> Add support for showing multiple clone/fetch git URLs for project on
> a summary page. URL for project is created from base URL and project
> name.
> 
> For example for XMMS2 project (xmms.se) the git base URL would be
> git://git.xmms.se/xmms2.
> 
> With corrections from David Rientjes <rientjes@google.com>
>

this can give wrong value is some case with index.aux as projects_list. I have a setup where
project details are displayed via gitweb but not reachable via http:// url and some reachable via http:// url.

For the first one only ssh:// based clone mechanism will work and for the other both will work. How do we handle 
that

-aneesh

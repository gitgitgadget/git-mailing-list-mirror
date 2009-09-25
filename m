From: Douglas Campos <douglas@theros.info>
Subject: Re: [JGIT PATCH 7/9] removing eclipse project files
Date: Fri, 25 Sep 2009 10:25:24 -0300
Message-ID: <ed88cb980909250625g7ae4685dh96aae6174c8d90d1@mail.gmail.com>
References: <C89280B882467443A695734861B942B296767534@DEWDFECCR09.wdf.sap.corp> 
	<212350.78171.qm@web27802.mail.ukl.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Cc: MatthiasSohn <matthias.sohn@sap.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>,
	"spearce@spearce.org" <spearce@spearce.org>
To: Mark Struberg <struberg@yahoo.de>
X-From: git-owner@vger.kernel.org Fri Sep 25 15:27:07 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MrApC-0007qh-1D
	for gcvg-git-2@lo.gmane.org; Fri, 25 Sep 2009 15:27:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752096AbZIYN0w (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 25 Sep 2009 09:26:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752003AbZIYN0w
	(ORCPT <rfc822;git-outgoing>); Fri, 25 Sep 2009 09:26:52 -0400
Received: from mail-px0-f189.google.com ([209.85.216.189]:55073 "EHLO
	mail-px0-f189.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751786AbZIYN0v convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 25 Sep 2009 09:26:51 -0400
Received: by pxi27 with SMTP id 27so3057323pxi.22
        for <git@vger.kernel.org>; Fri, 25 Sep 2009 06:26:55 -0700 (PDT)
Received: by 10.114.45.13 with SMTP id s13mr56447was.167.1253885215512; Fri, 
	25 Sep 2009 06:26:55 -0700 (PDT)
In-Reply-To: <212350.78171.qm@web27802.mail.ukl.yahoo.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/129080>

Forwarding to list, as I always forgot to add all recipients (my bad :( )

> and no: currently the very file you mentioned contains a lot more stuff. In fact most of this are only editor settings, preferred formattings etc which has nothing to do with the build per se. Eclipse has the ability to import/export all those settings in a XML file which is version independent. We should go this way and also supply similar setting-files for Idea and NetBeans. But forcing those settings via an internal Eclipse plugin config file is imho bad practice.

The problem lies here. JGit, AFAIK, has very _strict_ rules, this is
the corner case that makes sense to enforce via IDE. It spares time
from everyone here.

I like the maven-generated eclipse projects, but I think that we need
the same level of service provided by the eclipse settings.

IMHO, as always.

-- 
Douglas Campos (qmx)
+55 11 7626 5959

From: Pascal Obry <pascal@obry.net>
Subject: Re: Automated/Daily build systems supporting git?
Date: Tue, 08 Apr 2008 18:12:21 +0200
Organization: Home - http://www.obry.net
Message-ID: <47FB9965.2080302@obry.net>
References: <1207666672.5698.4.camel@pitcairn.cambridgebroadband.com>
Reply-To: pascal@obry.net
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Alex Bennee <kernel-hacker@bennee.com>
X-From: git-owner@vger.kernel.org Tue Apr 08 18:13:36 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JjGRi-0002Rs-8u
	for gcvg-git-2@gmane.org; Tue, 08 Apr 2008 18:13:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752479AbYDHQMe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 Apr 2008 12:12:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752388AbYDHQMe
	(ORCPT <rfc822;git-outgoing>); Tue, 8 Apr 2008 12:12:34 -0400
Received: from ug-out-1314.google.com ([66.249.92.170]:43684 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752168AbYDHQMd (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Apr 2008 12:12:33 -0400
Received: by ug-out-1314.google.com with SMTP id z38so809556ugc.16
        for <git@vger.kernel.org>; Tue, 08 Apr 2008 09:12:28 -0700 (PDT)
Received: by 10.67.116.2 with SMTP id t2mr3240100ugm.62.1207671146767;
        Tue, 08 Apr 2008 09:12:26 -0700 (PDT)
Received: from ?192.168.0.100? ( [82.124.251.208])
        by mx.google.com with ESMTPS id j1sm10351702ugf.74.2008.04.08.09.12.24
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 08 Apr 2008 09:12:25 -0700 (PDT)
User-Agent: Thunderbird 2.0.0.12 (Windows/20080213)
In-Reply-To: <1207666672.5698.4.camel@pitcairn.cambridgebroadband.com>
X-Enigmail-Version: 0.95.6
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/79006>

Alex,

Savadur (at its early stage) supports Git and Subversion. This 
continuous builder is fully configurable in XML. Sources can be grabbed 
here: http://repo.or.cz/w/savadur.git.

It supports scheduled scenario, triggered scenario (post commit hook). 
It is based on a client/server model and has a Web interface.

As one of the developer of this tool I can tell you that yes we have in 
our todo list the plan to support bisect.

As I said it is at an early stage of development and I'll be more than 
happy to answer questions.

Pascal.

-- 

--|------------------------------------------------------
--| Pascal Obry                           Team-Ada Member
--| 45, rue Gabriel Peri - 78114 Magny Les Hameaux FRANCE
--|------------------------------------------------------
--|              http://www.obry.net
--| "The best way to travel is by means of imagination"
--|
--| gpg --keyserver wwwkeys.pgp.net --recv-key C1082595

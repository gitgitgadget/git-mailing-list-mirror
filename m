From: Wincent Colaiuta <win@wincent.com>
Subject: Re: Displaying Current Git Aliases
Date: Thu, 25 Jun 2009 18:02:20 +0200
Message-ID: <4D088847-3CD8-4DD2-B129-A8FC3B0E20D0@wincent.com>
References: <c115fd3c0906250859q661d2319i463d6eea7e9dbe54@mail.gmail.com>
Mime-Version: 1.0 (Apple Message framework v935.3)
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>
To: Tim Visher <tim.visher@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jun 25 18:02:35 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MJrPE-0000gZ-VC
	for gcvg-git-2@gmane.org; Thu, 25 Jun 2009 18:02:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753129AbZFYQCY convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 25 Jun 2009 12:02:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752804AbZFYQCX
	(ORCPT <rfc822;git-outgoing>); Thu, 25 Jun 2009 12:02:23 -0400
Received: from wincent1.inetu.net ([209.235.192.161]:37043 "EHLO
	wincent1.inetu.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752656AbZFYQCW convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 25 Jun 2009 12:02:22 -0400
Received: from [192.168.1.2] (221.Red-83-59-197.dynamicIP.rima-tde.net [83.59.197.221])
	(authenticated bits=0)
	by wincent1.inetu.net (8.13.8/8.13.8) with ESMTP id n5PG2KNo001257
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NO);
	Thu, 25 Jun 2009 12:02:23 -0400
In-Reply-To: <c115fd3c0906250859q661d2319i463d6eea7e9dbe54@mail.gmail.com>
X-Mailer: Apple Mail (2.935.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/122216>

El 25/6/2009, a las 17:59, Tim Visher escribi=F3:

> Can git display a list of all of your current aliases like bash's
> `alias` command?

Something like:

   git config --list | grep alias

Cheers,
Wincent

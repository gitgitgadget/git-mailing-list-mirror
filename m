From: =?ISO-8859-1?Q?Santi_B=E9jar?= <santi@agolina.net>
Subject: Re: Bug report - git show <tagname> together with --pretty=format
Date: Wed, 8 Apr 2009 18:37:21 +0200
Message-ID: <adf1fd3d0904080937v634c5b69rffa7a737f22a3768@mail.gmail.com>
References: <49DC9F07.4090105@gmx.de> <49DCC295.7010908@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Cornelius <c.r1@gmx.de>, git@vger.kernel.org
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Wed Apr 08 18:39:11 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lranl-0005Un-Mg
	for gcvg-git-2@gmane.org; Wed, 08 Apr 2009 18:39:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754702AbZDHQhZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 8 Apr 2009 12:37:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754002AbZDHQhY
	(ORCPT <rfc822;git-outgoing>); Wed, 8 Apr 2009 12:37:24 -0400
Received: from mail-fx0-f158.google.com ([209.85.220.158]:45193 "EHLO
	mail-fx0-f158.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752113AbZDHQhY (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 Apr 2009 12:37:24 -0400
Received: by fxm2 with SMTP id 2so217535fxm.37
        for <git@vger.kernel.org>; Wed, 08 Apr 2009 09:37:21 -0700 (PDT)
Received: by 10.103.227.13 with SMTP id e13mr672106mur.20.1239208641650; Wed, 
	08 Apr 2009 09:37:21 -0700 (PDT)
In-Reply-To: <49DCC295.7010908@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/116095>

2009/4/8 Michael J Gruber <git@drmicha.warpmail.net>:
> Cornelius venit, vidit, dixit 08.04.2009 14:56:
>> Hi,
>> I've a problem with git 1.6.2.2 (self compiled) and git show. I use it's
>> output for parsing the git data,

In addition to what Michael said, you should use the plumbing commands
instead of the porcelain (see man git). They are specifically for use
with scripts and parse their output. The output from the porcelain
commands can change.

Santi

From: "Randall S. Becker" <rsbecker@nexbridge.com>
Subject: RE: Some strange behavior of git
Date: Wed, 24 Feb 2016 18:10:00 -0500
Message-ID: <002a01d16f58$7fe9f7e0$7fbde7a0$@nexbridge.com>
References: <56CE31F8.7090706@ip-5.ru>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="UTF-8"
Content-Transfer-Encoding: 8BIT
To: "'Olga Pshenichnikova'" <olga@ip-5.ru>, <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Feb 25 00:10:17 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aYiZU-0002yk-8g
	for gcvg-git-2@plane.gmane.org; Thu, 25 Feb 2016 00:10:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750719AbcBXXKN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 24 Feb 2016 18:10:13 -0500
Received: from elephants.elehost.com ([216.66.27.132]:35134 "EHLO
	elephants.elehost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753747AbcBXXKM convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 24 Feb 2016 18:10:12 -0500
X-Virus-Scanned: amavisd-new at elehost.com
Received: from pangea (CPE00fc8d49d843-CM00fc8d49d840.cpe.net.cable.rogers.com [174.112.90.66])
	(authenticated bits=0)
	by elephants.elehost.com (8.14.9/8.14.9) with ESMTP id u1ONA7EW042381
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
	Wed, 24 Feb 2016 18:10:08 -0500 (EST)
	(envelope-from rsbecker@nexbridge.com)
In-Reply-To: <56CE31F8.7090706@ip-5.ru>
X-Mailer: Microsoft Outlook 16.0
thread-index: AQHmTzn4svV8r2ogX48t2hAW/Hi5vZ8SEhKA
Content-Language: en-ca
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/287276>

On February 24, 2016 5:43 PM, Olga Pshenichnikova wrote
> What can be cause for further confusing behavior?
> 
>      git@ip5server:~$ git status
>      On branch master
>      Untracked files:
>        (use "git add <file>..." to include in what will be committed)
> 
>          app/addons/arliteks/
> 
>      nothing added to commit but untracked files present (use "git add"
> to track)
>      git@ip5server:~$ git clean -dn
>      Would remove app/addons/arliteks/
>      Would remove design/
>      Would remove js/
>      Would remove var/langs/en/
> 
> Why I don't see all 4 directories in first command?

What do your .gitignore files contain in this project?

Cheers,
Randall
-- Brief whoami: NonStop&UNIX developer since approximately UNIX(421664400)/NonStop(211288444200000000)
-- In my real life, I talk too much.

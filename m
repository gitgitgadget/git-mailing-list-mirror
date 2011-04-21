From: =?iso-8859-1?Q?Peter_J=F6nsson_P?= <peter.p.jonsson@ericsson.com>
Subject: RE: Fork or branch?
Date: Thu, 21 Apr 2011 15:23:01 +0200
Message-ID: <41F80411E3CC644A844E6BED6E472FD91AE14979CC@ESESSCMS0363.eemea.ericsson.se>
References: <1303390999618-6293910.post@n2.nabble.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
To: adam_kb <a-kyle@hotmail.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Apr 21 15:23:14 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QCtqh-0005zh-Kj
	for gcvg-git-2@lo.gmane.org; Thu, 21 Apr 2011 15:23:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752179Ab1DUNXG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 21 Apr 2011 09:23:06 -0400
Received: from mailgw10.se.ericsson.net ([193.180.251.61]:52365 "EHLO
	mailgw10.se.ericsson.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750981Ab1DUNXF convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 21 Apr 2011 09:23:05 -0400
X-AuditID: c1b4fb3d-b7bd5ae000002ba3-03-4db02fb65a84
Received: from esessmw0184.eemea.ericsson.se (Unknown_Domain [153.88.253.125])
	by mailgw10.se.ericsson.net (Symantec Mail Security) with SMTP id 9C.27.11171.6BF20BD4; Thu, 21 Apr 2011 15:23:02 +0200 (CEST)
Received: from ESESSCMS0363.eemea.ericsson.se ([169.254.1.202]) by
 esessmw0184.eemea.ericsson.se ([153.88.115.81]) with mapi; Thu, 21 Apr 2011
 15:23:02 +0200
Thread-Topic: Fork or branch?
Thread-Index: AcwAJIWoWVvO7xVeTM+6J6AlAVg6QgAAkVeg
In-Reply-To: <1303390999618-6293910.post@n2.nabble.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
acceptlanguage: en-US
X-Brightmail-Tracker: AAAAAA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/171906>

Hi!

Will you be sharing anything between the projects? If you have data that will be shared between the two different implementations it would be enough with just a simple directory structure while still inside the same git repo.

repo.git:
 - <python based>
 - <c based>
 - ... 
 - <some other language based>
 - shared_data

Just create a new branch on the current code based and start working on the C based one. Then you can merge it back to the "main" code line if it works out.

Good luck!

// Peter

-----Original Message-----
From: git-owner@vger.kernel.org [mailto:git-owner@vger.kernel.org] On Behalf Of adam_kb
Sent: den 21 april 2011 15:03
To: git@vger.kernel.org
Subject: Fork or branch?

I am new to git and understand most of it except for merge. My question is - if I have project X on branch master and its coded in python but I then want to take that same project and code it in say C or C++ would I fork or branch the project? 

--
View this message in context: http://git.661346.n2.nabble.com/Fork-or-branch-tp6293910p6293910.html
Sent from the git mailing list archive at Nabble.com.
--
To unsubscribe from this list: send the line "unsubscribe git" in the body of a message to majordomo@vger.kernel.org More majordomo info at  http://vger.kernel.org/majordomo-info.html

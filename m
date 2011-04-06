From: =?iso-8859-1?Q?Peter_J=F6nsson_P?= <peter.p.jonsson@ericsson.com>
Subject: RE: blobs (once more)
Date: Wed, 6 Apr 2011 13:12:41 +0200
Message-ID: <41F80411E3CC644A844E6BED6E472FD91196D0CD30@ESESSCMS0363.eemea.ericsson.se>
References: <BANLkTim3kg1ycGkgWsqaZiqMY9LTKV6DBw@mail.gmail.com>
 <vpqmxk3prki.fsf@bauges.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Git Mailing List <git@vger.kernel.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Andrey Devyatkin <andrey.devyatkin@ericsson.com>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Pau Garcia i Quiles <pgquiles@elpauer.org>
X-From: git-owner@vger.kernel.org Wed Apr 06 13:12:56 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q7QfP-0001U4-Uc
	for gcvg-git-2@lo.gmane.org; Wed, 06 Apr 2011 13:12:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755760Ab1DFLMu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 Apr 2011 07:12:50 -0400
Received: from mailgw9.se.ericsson.net ([193.180.251.57]:55037 "EHLO
	mailgw9.se.ericsson.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755802Ab1DFLMs convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 6 Apr 2011 07:12:48 -0400
X-AuditID: c1b4fb39-b7c6dae0000023f2-fb-4d9c4aae7e05
Received: from esessmw0247.eemea.ericsson.se (Unknown_Domain [153.88.253.125])
	by mailgw9.se.ericsson.net (Symantec Mail Security) with SMTP id 5F.41.09202.EAA4C9D4; Wed,  6 Apr 2011 13:12:47 +0200 (CEST)
Received: from ESESSCMS0363.eemea.ericsson.se ([169.254.1.133]) by
 esessmw0247.eemea.ericsson.se ([10.2.3.116]) with mapi; Wed, 6 Apr 2011
 13:12:43 +0200
Thread-Topic: blobs (once more)
Thread-Index: Acv0SsubhuyRP8xPTcmV+Otq0HaV1wAADVKg
In-Reply-To: <vpqmxk3prki.fsf@bauges.imag.fr>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/170965>

Hi!

How about using Google's repo-tool instead of submodules? Is that a better solution if one really needs to keep binaries together (in some way) with the source code?

We are starting to prototype Git and since we need to distribute cross-compilers with the code it would be nice to keep it in a separate repo. Currently we are _heavy_ ClearCase users (oh the horror) with many bad old habits that we are trying to break :)

// Peter 

-----Original Message-----
From: git-owner@vger.kernel.org [mailto:git-owner@vger.kernel.org] On Behalf Of Matthieu Moy
Sent: den 6 april 2011 13:06
To: Pau Garcia i Quiles
Cc: Git Mailing List; Johannes Schindelin
Subject: Re: blobs (once more)

Pau Garcia i Quiles <pgquiles@elpauer.org> writes:

> I have read about:
> - submodules + using different repositories once one "blob repository"
> grows too much. This will be probably rejected because it is quite 
> contrived.
> - git-annex (does not get the files in when cloning, pulling, checking 
> out; you need to do it manually)
> - git-media (same as git-annex)
> - boar (no, we do not want to use a VCS for binaries in addition to 
> git)
> - and a few more
>
> So far the only good solution seems to be git-bigfiles but it's still 
> in development.

This seems to be the hot topic of the moment in Git ;-). Loot at the mailing-list's archive, like

http://thread.gmane.org/gmane.comp.version-control.git/170649
https://git.wiki.kernel.org/index.php/SoC2011Ideas#Better_big-file_support

there may be a GSoC on the topic. I don't think there's a really good solution for you right now (but I didn't really look closely), but the situation is improving.

--
Matthieu Moy
http://www-verimag.imag.fr/~moy/
--
To unsubscribe from this list: send the line "unsubscribe git" in the body of a message to majordomo@vger.kernel.org More majordomo info at  http://vger.kernel.org/majordomo-info.html

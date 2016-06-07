From: =?UTF-8?Q?Torsten_B=c3=b6gershausen?= <tboegi@web.de>
Subject: Re: What's cooking in git.git (Jun 2016, #02; Mon, 6)
Date: Tue, 7 Jun 2016 09:37:01 +0200
Message-ID: <5756799D.8030206@web.de>
References: <xmqqshwpsfor.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
To: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jun 07 09:37:34 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1bABZu-0005ia-1E
	for gcvg-git-2@plane.gmane.org; Tue, 07 Jun 2016 09:37:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753058AbcFGHhP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 Jun 2016 03:37:15 -0400
Received: from mout.web.de ([212.227.15.4]:58565 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750893AbcFGHhL (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Jun 2016 03:37:11 -0400
Received: from [192.168.88.199] ([194.47.243.242]) by smtp.web.de (mrweb002)
 with ESMTPSA (Nemesis) id 0MSazE-1b0Bgy0hue-00RWvW; Tue, 07 Jun 2016 09:37:04
 +0200
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:38.0) Gecko/20100101
 Icedove/38.7.0
In-Reply-To: <xmqqshwpsfor.fsf@gitster.mtv.corp.google.com>
X-Provags-ID: V03:K0:Iy/3ZT+IMVuK+fqq/3JHtqFeN9HbKUbVuvJxyLySgbLzF+RulUE
 bJ1b6diYzETe7oqHmE4qJKOnHtTOhcJATfTiCYXEHOmiOJOa1YZJralJWGCKBWEa1hXDg/E
 VL1MdURfiIT6zkiZGazDYOWi9NXQpSChH7P288VZHRGtxx5nX2/AklhEeNb4d33GHV8jkyM
 NuWnwwHzKxj3Xn3DtyF6A==
X-UI-Out-Filterresults: notjunk:1;V01:K0:iVjw4Qjz+9A=:MMgzje1YdUNx3IJJ3WvKhY
 tIJrPHbCYz9sej8EW6hZUyRnhCmMvGMxyQJmODtKrcptcsEA87kzxYvCjdzQ2PAaFyDC8UuaB
 fUrZbvN2sxP2o8wbzDGJ4WKTTzUXj3/Hh2puIxFWeyCIVwS4+eINYZIfw9Rv+rGxrdIUfe2l1
 TYUODpk3qAlgQm76J38xDQkhdZPTqdrE/Cx3gW96jhYgYzIZh7s5qjnPS+ddyrVg9IUg4jO1P
 iarMQ6/h2rNBJtANt3+baDLv7nz5+xpWKfWEs+fys63h2DSoqryZ5Dec3XUaNMixqLeEcHkKt
 T3EwpwHKFC3XmaeHpybPDCsloVQkpKbJIFz+fr5/+6EggZfbKGrbxjLoksFvQy1Jpm9jgKsuc
 JVRyGtD9p6WuIbzwdKQrHEe7R6M4JvB8RbV6IwVK2tiQklXw9fbmOgMStWkI+UD29r0ZFdGNv
 84I/SE12Ss9HdxGV/D1ZxMFBc5OwMnwle0lmP3oa9ESNVFUuacZ8NkbRUfx/uFTOgLFO9HE+A
 euICO4roymj1zIjLssyFrVEUV9SS+HixL2Epfrc5RXCR+YXfHFLdFZY8duB6ZBCHbKA0OfTrR
 E+4gaIIyiAWjCl8t/NbLJhtUOdFdvMQ7M2aJ7JEXmv3QA4Hdm/bkPGTJ35mVxZ6pLyWDrAJrV
 8JeFfhZSGK7L/BJ91Nhy+HbKk8U7nka8umebQU2oyCB7IOTKPaKSFuVTmAlHVbqf1sieGJYqZ
 rn/LALoV7VzIFNgjt9lZNYo7PmnTYOl11uN1VWUMjEQz1/fv3ewBGewgYTrwIswHNBotv0K5 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/296610>



>* mh/connect (2016-06-06) 10 commits
> - connect: [host:port] is legacy for ssh
> - connect: move ssh command line preparation to a separate function
> - connect: actively reject git:// urls with a user part
> - connect: change the --diag-url output to separate user and host
> - connect: make parse_connect_url() return the user part of the url as a separate value
> - connect: group CONNECT_DIAG_URL handling code
> - connect: make parse_connect_url() return separated host and port
> - connect: re-derive a host:port string from the separate host and port variables
> - connect: call get_host_and_port() earlier
> - connect: document why we sometimes call get_port after get_host_and_port

> Ok, folks, is everybody happy with this version?


I am.

>* tb/convert-peek-in-index (2016-05-24) 2 commits
> - convert: ce_compare_data() checks for a sha1 of a path
> - read-cache: factor out get_sha1_from_index() helper
> The motivation is rather iffy.

Will be re-rolled.

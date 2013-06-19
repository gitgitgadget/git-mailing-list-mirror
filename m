From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [PATCH mz/rebase-tests] rebase topology tests: fix commit names
 on case-insensitive file systems
Date: Wed, 19 Jun 2013 07:52:33 +0200
Message-ID: <51C14721.2050500@viscovery.net>
References: <1370292135-1236-1-git-send-email-martinvonz@gmail.com> <1370585503-11374-1-git-send-email-martinvonz@gmail.com> <51C00C07.6080600@viscovery.net> <CANiSa6gWkaC62U8oxo0mRc-G-m3UJJSjq8YSuywBh-omtHO=zQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	Chris Webb <chris@arachsys.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: Martin von Zweigbergk <martinvonz@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jun 19 07:52:48 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UpBK1-0005Lp-Q0
	for gcvg-git-2@plane.gmane.org; Wed, 19 Jun 2013 07:52:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756469Ab3FSFwi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Jun 2013 01:52:38 -0400
Received: from so.liwest.at ([212.33.55.13]:19416 "EHLO so.liwest.at"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756463Ab3FSFwh (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Jun 2013 01:52:37 -0400
Received: from [81.10.228.254] (helo=theia.linz.viscovery)
	by so.liwest.at with esmtpa (Exim 4.77)
	(envelope-from <j.sixt@viscovery.net>)
	id 1UpBJq-0006am-Ft; Wed, 19 Jun 2013 07:52:34 +0200
Received: from [192.168.1.95] (J6T.linz.viscovery [192.168.1.95])
	by theia.linz.viscovery (Postfix) with ESMTP id 34D8F1660F;
	Wed, 19 Jun 2013 07:52:34 +0200 (CEST)
User-Agent: Mozilla/5.0 (Windows NT 5.1; rv:17.0) Gecko/20130509 Thunderbird/17.0.6
In-Reply-To: <CANiSa6gWkaC62U8oxo0mRc-G-m3UJJSjq8YSuywBh-omtHO=zQ@mail.gmail.com>
X-Enigmail-Version: 1.5.1
X-Spam-Score: -1.0 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/228345>

Am 6/18/2013 17:53, schrieb Martin von Zweigbergk:
> On Tue, Jun 18, 2013 at 12:28 AM, Johannes Sixt <j.sixt@viscovery.net> wrote:
>>  Knowing that the tests would take their time to complete on Windows,
> 
> I'm curious just how slow it is. Are we talking minutes?

D:\Src\mingw-git\t>bash -c "time make t342[15]*"
...
real    5m7.160s
user    0m21.831s
sys     0m6.376s

The real time is correct, but I don't think that we can trust user or sys
times as the box was otherwise idle.

-- Hannes

From: "Philip Oakley" <philipoakley@iee.org>
Subject: Re: Tracking vendor release with Git
Date: Tue, 11 Jun 2013 19:43:11 +0100
Organization: OPDS
Message-ID: <32BB10B036234E0F9A6AFEF05C25880F@PhilipOakley>
References: <1370970410-7935-1-git-send-email-ydroneaud@opteya.com>
Reply-To: "Philip Oakley" <philipoakley@iee.org>
Mime-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="iso-8859-1";
	reply-type=original
Content-Transfer-Encoding: 7bit
Cc: "Yann Droneaud" <ydroneaud@opteya.com>
To: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Jun 11 20:43:16 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UmTXH-0000jg-MT
	for gcvg-git-2@plane.gmane.org; Tue, 11 Jun 2013 20:43:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752688Ab3FKSnK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Jun 2013 14:43:10 -0400
Received: from out1.ip05ir2.opaltelecom.net ([62.24.128.241]:63123 "EHLO
	out1.ip05ir2.opaltelecom.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754782Ab3FKSnJ (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 11 Jun 2013 14:43:09 -0400
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: AjERAE9vt1FZ8YhC/2dsb2JhbABZgwkwiHy2EgQBAQIBgQAXdIIeBQEBBQgBAS4eAQEhCwIDBQIBAxUBCyUUAQQaBgcXBhMIAgECAwGIAAi6LwSOKCAYAQRNHYJpYQOIaIYGkwKHEoMQOw
X-IronPort-AV: E=Sophos;i="4.87,846,1363132800"; 
   d="scan'208";a="421728692"
Received: from host-89-241-136-66.as13285.net (HELO PhilipOakley) ([89.241.136.66])
  by out1.ip05ir2.opaltelecom.net with SMTP; 11 Jun 2013 19:43:07 +0100
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.5931
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.6157
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/227492>

From: "Yann Droneaud" <ydroneaud@opteya.com>
Sent: Tuesday, June 11, 2013 6:06 PM
> Hi,
>
> I'm trying to setup a workflow to track vendor releases (upstream).
> Each new release are provided as an archive of source code, data,
> documentation, etc.
>
> For each vendor releases, fixes need to be applied before making them
> available to users (downstream).
>
> Seems to be a rather common use case, ...

Have you looked at the msysgit process that has to cope with upstream 
git ;-)

e.g. 
https://code.google.com/p/msysgit/source/browse/share/msysGit/merging-rebase.sh?name=python
https://github.com/msysgit/msysgit/blob/master/share/msysGit/merging-rebase.sh
and
https://github.com/msysgit/msysgit/blob/master/share/msysGit/rebasing-merge.sh

whereby the guys re-apply all the patches that haven't been accepted 
upstream, along with local fixups to get each new release working.

Philip 

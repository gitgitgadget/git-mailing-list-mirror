From: Thomas Ackermann <th.acker@arcor.de>
Subject: Aw: Re: [PATCH] Sort howto documents in howto-index.txt
Date: Sat, 22 Dec 2012 20:54:17 +0100 (CET)
Message-ID: <1937031575.96914.1356206057592.JavaMail.ngmail@webmail06.arcor-online.net>
References: <7v8v8pri3w.fsf@alter.siamese.dyndns.org> <1870890640.302608.1356201267202.JavaMail.ngmail@webmail13.arcor-online.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: gitster@pobox.com, th.acker@arcor.de
X-From: git-owner@vger.kernel.org Sat Dec 22 20:54:42 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TmV9a-0000G7-3R
	for gcvg-git-2@plane.gmane.org; Sat, 22 Dec 2012 20:54:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752032Ab2LVTyU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 22 Dec 2012 14:54:20 -0500
Received: from mail-in-13.arcor-online.net ([151.189.21.53]:53187 "EHLO
	mail-in-13.arcor-online.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750853Ab2LVTyT (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 22 Dec 2012 14:54:19 -0500
Received: from mail-in-01-z2.arcor-online.net (mail-in-01-z2.arcor-online.net [151.189.8.13])
	by mx.arcor.de (Postfix) with ESMTP id 9FF802126D9;
	Sat, 22 Dec 2012 20:54:17 +0100 (CET)
Received: from mail-in-01.arcor-online.net (mail-in-01.arcor-online.net [151.189.21.41])
	by mail-in-01-z2.arcor-online.net (Postfix) with ESMTP id 9972D7DB3D9;
	Sat, 22 Dec 2012 20:54:17 +0100 (CET)
Received: from webmail06.arcor-online.net (webmail06.arcor-online.net [151.189.8.133])
	by mail-in-01.arcor-online.net (Postfix) with ESMTP id 8AF3F5A4F1;
	Sat, 22 Dec 2012 20:54:17 +0100 (CET)
X-DKIM: Sendmail DKIM Filter v2.8.2 mail-in-01.arcor-online.net 8AF3F5A4F1
Received: from [94.217.21.153] by webmail06.arcor-online.net (151.189.8.133) with HTTP (Arcor Webmail); Sat, 22 Dec 2012 20:54:17 +0100 (CET)
In-Reply-To: <7v8v8pri3w.fsf@alter.siamese.dyndns.org>
X-ngMessageSubType: MessageSubType_MAIL
X-WebmailclientIP: 94.217.21.153
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/212070>


> 
> I think $(wildcard) used to sort but in recent GNU make it no longer
> does, so this is probably a good change.
> 
> Do we need to explicitly sort the api-index as well?  $(API_DOCS) is
> fed to the script that reads filenames one at a time in the given
> order, but I do not see anybody asking for a sorted list while
> producing that list.  The result looks to be sorted in my build
> farm with GNU make 3.82, but that could be by accident.
> 

$(API_DOCS) is not fed to api-index.sh; it's only in the dependencies.
api-index.sh uses "ls api-*.txt" internally which produces a correct sorting.

Unifying api-index.sh and howto-index.sh is on my todo list ...


---
Thomas

From: Daniel Stenberg <daniel@haxx.se>
Subject: Re: [PATCH 1/2] http.c: prompt for SSL client certificate password
Date: Fri, 12 Jun 2009 09:59:16 +0200 (CEST)
Message-ID: <alpine.DEB.2.00.0906120957400.5566@yvahk2.pbagnpgbe.fr>
References: <1243480563-5954-1-git-send-email-lodatom@gmail.com> <7vprdaarka.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: Mark Lodato <lodatom@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jun 12 10:19:28 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MF1yv-0007mq-GM
	for gcvg-git-2@gmane.org; Fri, 12 Jun 2009 10:19:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756065AbZFLITN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Jun 2009 04:19:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752933AbZFLITM
	(ORCPT <rfc822;git-outgoing>); Fri, 12 Jun 2009 04:19:12 -0400
Received: from kluster1.contactor.se ([91.191.140.11]:53871 "EHLO
	kluster1.contactor.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752672AbZFLITL (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Jun 2009 04:19:11 -0400
Received: from linux2.contactor.se (linux2.contactor.se [91.191.140.14])
	by kluster1.contactor.se (8.13.8/8.13.8/Debian-3) with ESMTP id n5C7vBlJ031574;
	Fri, 12 Jun 2009 09:57:11 +0200
X-X-Sender: dast@linux2.contactor.se
In-Reply-To: <7vprdaarka.fsf@alter.siamese.dyndns.org>
User-Agent: Alpine 2.00 (DEB 1167 2008-08-23)
X-fromdanielhimself: yes
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/121397>

On Thu, 11 Jun 2009, Junio C Hamano wrote:

>    #if !defined(CURLOPT_KEYPASSWD)
>    # if defined(CURLOPT_SSLKEYPASSWD)
>    #  define CURLOPT_KEYTPASSWD CURLOPT_SSLKEYPASSWD
>    # elif defined(CURLOPT_SSLCERTPASSWD
>    #  define CURLOPT_KEYTPASSWD CURLOPT_SSLCERTPASSWD
>    # endif
>    #endif

Just note that these CURLOPT_* symbols provided by libcurl are enums, not 
defines, so unfortunately you can't do it this exact #ifdef way.

-- 

  / daniel.haxx.se

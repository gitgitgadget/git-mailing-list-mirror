From: Daniel Stenberg <daniel@haxx.se>
Subject: Re: [PATCH][v2] http authentication via prompts (with correct line
  lengths)
Date: Thu, 12 Mar 2009 09:59:34 +0100 (CET)
Message-ID: <alpine.DEB.1.10.0903120956460.18527@yvahk2.pbagnpgbe.fr>
References: <49B5AF67.6050508@gmail.com>  <7v1vt6dxg9.fsf@gitster.siamese.dyndns.org>  <49B5F0BA.3070806@gmail.com>  <7v63ihdgy6.fsf@gitster.siamese.dyndns.org> <e2b179460903120153u5fdb58b6tf3027eea23673df0@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: Junio C Hamano <gitster@pobox.com>,
	Mike Gaffney <mr.gaffo@gmail.com>, git@vger.kernel.org
To: Mike Ralphson <mike.ralphson@gmail.com>
X-From: git-owner@vger.kernel.org Thu Mar 12 10:01:46 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LhgnG-0000pb-OJ
	for gcvg-git-2@gmane.org; Thu, 12 Mar 2009 10:01:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751659AbZCLJAG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 Mar 2009 05:00:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751690AbZCLJAE
	(ORCPT <rfc822;git-outgoing>); Thu, 12 Mar 2009 05:00:04 -0400
Received: from kluster1.contactor.se ([91.191.140.11]:45835 "EHLO
	kluster1.contactor.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751156AbZCLJAD (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Mar 2009 05:00:03 -0400
Received: from linux2.contactor.se (linux2.contactor.se [91.191.140.14])
	by kluster1.contactor.se (8.13.8/8.13.8/Debian-3) with ESMTP id n2C8xl9S031437;
	Thu, 12 Mar 2009 09:59:47 +0100
X-X-Sender: dast@linux2.contactor.se
In-Reply-To: <e2b179460903120153u5fdb58b6tf3027eea23673df0@mail.gmail.com>
User-Agent: Alpine 1.10 (DEB 962 2008-03-14)
X-fromdanielhimself: yes
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/113023>

On Thu, 12 Mar 2009, Mike Ralphson wrote:

> Elsewhere we seem to protect use of CURL_NETRC_OPTIONAL by checking for 
> LIBCURL_VERSION_NUM >= 0x070907. I have an ancient curl here 
> (curl-7.9.3-2ssl) which doesn't seem to have this option, so building next 
> is broken on AIX for me from this morning (c33976cb).
>
> Is there a specific minimum version of curl we want to continue supporting?

May I suggest perhaps require a libcurl version that is no older than three 
years or something like that?

Perhaps this list can serve as some help:

 	http://curl.haxx.se/docs/releases.html

(spoiler: libcurl 7.9.3 is more than seven years old!)

-- 

  / daniel.haxx.se

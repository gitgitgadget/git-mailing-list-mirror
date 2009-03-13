From: Daniel Stenberg <daniel@haxx.se>
Subject: Re: [PATCH][v2] http authentication via prompts (with correct line
  lengths)
Date: Fri, 13 Mar 2009 08:58:04 +0100 (CET)
Message-ID: <alpine.DEB.1.10.0903130855240.24124@yvahk2.pbagnpgbe.fr>
References: <49B5AF67.6050508@gmail.com> <7v1vt6dxg9.fsf@gitster.siamese.dyndns.org> <49B5F0BA.3070806@gmail.com> <7v63ihdgy6.fsf@gitster.siamese.dyndns.org> <e2b179460903120153u5fdb58b6tf3027eea23673df0@mail.gmail.com>
 <7vsklihsti.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: Mike Ralphson <mike.ralphson@gmail.com>,
	Mike Gaffney <mr.gaffo@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Mar 13 09:01:00 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Li2KA-0005nn-UD
	for gcvg-git-2@gmane.org; Fri, 13 Mar 2009 09:00:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751099AbZCMH62 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 13 Mar 2009 03:58:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752169AbZCMH62
	(ORCPT <rfc822;git-outgoing>); Fri, 13 Mar 2009 03:58:28 -0400
Received: from kluster1.contactor.se ([91.191.140.11]:34963 "EHLO
	kluster1.contactor.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750876AbZCMH61 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 Mar 2009 03:58:27 -0400
Received: from linux2.contactor.se (linux2.contactor.se [91.191.140.14])
	by kluster1.contactor.se (8.13.8/8.13.8/Debian-3) with ESMTP id n2D7wGIW001229;
	Fri, 13 Mar 2009 08:58:16 +0100
X-X-Sender: dast@linux2.contactor.se
In-Reply-To: <7vsklihsti.fsf@gitster.siamese.dyndns.org>
User-Agent: Alpine 1.10 (DEB 962 2008-03-14)
X-fromdanielhimself: yes
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/113153>

On Thu, 12 Mar 2009, Junio C Hamano wrote:

> http://curl.haxx.se/libcurl/c/curl_easy_setopt.html seems to say "added in 
> 7.X.Y" for some options but does say when CURLOPT_USERPWD was added, so I am 
> assuming it was available even in very early versions...

Yes it was.

Driven by use cases such as this, I also recently produced the 
"symbols-in-versions" document in the libcurl tree which should help apps to 
know what should works when:

http://cool.haxx.se/cvs.cgi/curl/docs/libcurl/symbols-in-versions?rev=HEAD&content-type=text/vnd.viewcvs-markup

-- 

  / daniel.haxx.se

From: Daniel Stenberg <daniel@haxx.se>
Subject: Re: large publicly accessible HTTP archive?
Date: Fri, 31 Oct 2008 20:01:53 +0100 (CET)
Message-ID: <alpine.LRH.1.10.0810311959330.17280@yvahk3.pbagnpgbe.fr>
References: <S1751776AbYJaQ5O/20081031165714Z+111@vger.kernel.org> <490B3B35.60508@larsen.st>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
To: git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Oct 31 20:20:59 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KvzYI-0001im-6O
	for gcvg-git-2@gmane.org; Fri, 31 Oct 2008 20:20:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751673AbYJaTTo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 31 Oct 2008 15:19:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751663AbYJaTTo
	(ORCPT <rfc822;git-outgoing>); Fri, 31 Oct 2008 15:19:44 -0400
Received: from kluster1.contactor.se ([91.191.140.11]:46129 "EHLO
	kluster1.contactor.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751600AbYJaTTo (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 31 Oct 2008 15:19:44 -0400
X-Greylist: delayed 904 seconds by postgrey-1.27 at vger.kernel.org; Fri, 31 Oct 2008 15:19:43 EDT
Received: from linux3.contactor.se (linux3.contactor.se [91.191.140.23])
	by kluster1.contactor.se (8.13.8/8.13.8/Debian-3) with ESMTP id m9VJ4ZVv025337
	for <git@vger.kernel.org>; Fri, 31 Oct 2008 20:04:35 +0100
X-X-Sender: dast@linux3.contactor.se
In-Reply-To: <490B3B35.60508@larsen.st>
User-Agent: Alpine 1.10 (LRH 962 2008-03-14)
X-fromdanielhimself: yes
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/99623>

On Fri, 31 Oct 2008, Bryan Larsen wrote:

> We "fixed" the problem by turning off CURL_MULTI and ignored the problem. 
>
> Our problems were against curl 7.16.2.

Right, libcurl has had 8 releases since with perhaps an average of 30 bugfixes 
per release so...

I'm not aware of any current known libcurl bugs with the multi interface and 
"simple" HTTP transfers such as this.

-- 

  / daniel.haxx.se - libcurl hacker

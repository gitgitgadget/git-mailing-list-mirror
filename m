From: Nils Adermann <naderman@naderman.de>
Subject: Re: subtree merge tries to merge into wrong directory
Date: Sat, 02 Jan 2010 19:17:14 +0100
Message-ID: <4B3F8DAA.8090908@naderman.de>
References: <4B206DCF.90202@naderman.de>    <32541b130912100638v1f701183w909367cd97c8325@mail.gmail.com> <c10155f8a7a2dd451f0b74e323f3a989.squirrel@www.naderman.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Avery Pennarun <apenwarr@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jan 02 19:17:42 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NR8Xd-0003A3-2I
	for gcvg-git-2@lo.gmane.org; Sat, 02 Jan 2010 19:17:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751466Ab0ABSR0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 2 Jan 2010 13:17:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751456Ab0ABSRZ
	(ORCPT <rfc822;git-outgoing>); Sat, 2 Jan 2010 13:17:25 -0500
Received: from naderman.de ([85.119.157.185]:55233 "EHLO naderman.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751022Ab0ABSRZ (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 2 Jan 2010 13:17:25 -0500
Received: by naderman.de (Postfix, from userid 65534)
	id DE12CBE9B7AF; Sat,  2 Jan 2010 18:17:18 +0000 (UTC)
Received: from [192.168.0.6] (p508B4FC2.dip.t-dialin.net [80.139.79.194])
	by naderman.de (Postfix) with ESMTPA id 7B100BE9B7AC;
	Sat,  2 Jan 2010 18:17:18 +0000 (UTC)
User-Agent: Thunderbird 2.0.0.23 (X11/20090817)
In-Reply-To: <c10155f8a7a2dd451f0b74e323f3a989.squirrel@www.naderman.de>
X-Bogosity: Ham, tests=bogofilter, spamicity=0.000000, version=1.1.7
   int  cnt   prob  spamicity histogram
  0.00   38 0.016459 0.014739 ######################################
  0.10    2 0.108058 0.019799 ##
  0.20    0 0.000000 0.019799 
  0.30    0 0.000000 0.019799 
  0.40    0 0.000000 0.019799 
  0.50    0 0.000000 0.019799 
  0.60    0 0.000000 0.019799 
  0.70    0 0.000000 0.019799 
  0.80    0 0.000000 0.019799 
  0.90    3 0.982411 0.258908 ###
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/136036>

naderman@naderman.de schrieb:
> So I finally got around to trying this. This was my first result:
>
> $ git merge -Xsubtree=lib/ezc/trunk/Reflection/ FETCH_HEAD
> fatal: entry  not found in tree 60270661e0d2a5ee03b24609fac5c6d00d048988
>   
Turns out that only happens because of the trailing slash. 
lib/ezc/trunk/Reflection works reliably.

Nils

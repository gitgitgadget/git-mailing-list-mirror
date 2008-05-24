From: =?UTF-8?B?RGlyayBTw7xzc2Vyb3R0?= <newsletter@dirk.my1.cc>
Subject: Re: git-diff cr/nl files on linux
Date: Sat, 24 May 2008 15:01:51 +0200
Message-ID: <483811BF.3090302@dirk.my1.cc>
References: <fcaeb9bf0805240554j71693d5eo2a425ee0efe2f364@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Sat May 24 15:03:28 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JztOu-000643-J2
	for gcvg-git-2@gmane.org; Sat, 24 May 2008 15:03:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752358AbYEXNBy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 24 May 2008 09:01:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752047AbYEXNBy
	(ORCPT <rfc822;git-outgoing>); Sat, 24 May 2008 09:01:54 -0400
Received: from smtprelay01.ispgateway.de ([80.67.18.13]:58648 "EHLO
	smtprelay01.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751968AbYEXNBy (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 24 May 2008 09:01:54 -0400
Received: from [84.176.123.174] (helo=[192.168.2.100])
	by smtprelay01.ispgateway.de with esmtpa (Exim 4.68)
	(envelope-from <newsletter@dirk.my1.cc>)
	id 1JztNg-0002eZ-CH; Sat, 24 May 2008 15:01:52 +0200
User-Agent: Thunderbird 2.0.0.14 (Windows/20080421)
In-Reply-To: <fcaeb9bf0805240554j71693d5eo2a425ee0efe2f364@mail.gmail.com>
X-Df-Sender: 757646
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/82813>

Nguyen Thai Ngoc Duy schrieb:
> Hi,
>
> Is there any way that can make git-diff show cr/nl ending files on
> linux without ^M at the end?
>
> Thanks
>   
What about 'git diff -w'? It drops any whitespace changes, including ^M's.
Not sure whether that is what you meant.

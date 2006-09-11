From: Rene Scharfe <rene.scharfe@lsrfire.ath.cx>
Subject: Re: [PATCH] git-upload-archive: add config option to allow only specified
 formats
Date: Mon, 11 Sep 2006 23:55:51 +0200
Message-ID: <4505DB67.8060104@lsrfire.ath.cx>
References: <7vpse4tcyc.fsf@assigned-by-dhcp.cox.net>	 <7vk64ctctv.fsf@assigned-by-dhcp.cox.net>	 <7v1wqkt2v4.fsf_-_@assigned-by-dhcp.cox.net>	 <20060910155837.GA15974@lsrfire.ath.cx> <cda58cb80609101207y420bd034n9a76b661374e1edf@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Sep 11 23:56:05 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GMtky-0004mz-8l
	for gcvg-git@gmane.org; Mon, 11 Sep 2006 23:55:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965022AbWIKVzx convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Mon, 11 Sep 2006 17:55:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964999AbWIKVzw
	(ORCPT <rfc822;git-outgoing>); Mon, 11 Sep 2006 17:55:52 -0400
Received: from static-ip-217-172-187-230.inaddr.intergenia.de ([217.172.187.230]:39562
	"EHLO neapel230.server4you.de") by vger.kernel.org with ESMTP
	id S965022AbWIKVzw (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Sep 2006 17:55:52 -0400
Received: from [10.0.1.3] (p508E65FD.dip.t-dialin.net [80.142.101.253])
	by neapel230.server4you.de (Postfix) with ESMTP id A51FB20049;
	Mon, 11 Sep 2006 23:55:50 +0200 (CEST)
User-Agent: Thunderbird 1.5.0.5 (Windows/20060719)
To: Franck Bui-Huu <vagabon.xyz@gmail.com>
In-Reply-To: <cda58cb80609101207y420bd034n9a76b661374e1edf@mail.gmail.com>
X-Enigmail-Version: 0.94.0.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/26861>

=46ranck Bui-Huu schrieb:
> just out of curiousity, why "free(daemon_formats)" right before a
> "die()" ?

Hmm, do I show signs of a cleaning fetish? ;-)

A bit more seriously, it helps reduce the number of false positives
emitted by automatic memory checkers.

Ren=E9

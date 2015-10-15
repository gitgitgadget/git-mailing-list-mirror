From: Sven Helmberger <sven.helmberger@gmx.de>
Subject: Re: Alternative to manual editing with git add --patch
Date: Thu, 15 Oct 2015 17:22:55 +0200
Message-ID: <561FC4CF.9010505@gmx.de>
References: <561E6FBB.7060302@gmx.de>
 <xmqqk2qp8hlj.fsf@gitster.mtv.corp.google.com> <561EE700.3020002@gmx.de>
 <alpine.DEB.1.00.1510151152470.31610@s15462909.onlinehome-server.info>
 <561FAC12.5020007@gmx.de>
 <alpine.DEB.1.00.1510151702420.31610@s15462909.onlinehome-server.info>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Thu Oct 15 17:23:16 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZmkN2-0003NT-8e
	for gcvg-git-2@plane.gmane.org; Thu, 15 Oct 2015 17:23:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752300AbbJOPXC (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 Oct 2015 11:23:02 -0400
Received: from mout.gmx.net ([212.227.17.22]:60010 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751677AbbJOPXA (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Oct 2015 11:23:00 -0400
Received: from [192.168.2.61] ([79.245.214.86]) by mail.gmx.com (mrgmx102)
 with ESMTPSA (Nemesis) id 0MAkkB-1ZsZGl1QJn-00Bt90; Thu, 15 Oct 2015 17:22:56
 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.3.0
In-Reply-To: <alpine.DEB.1.00.1510151702420.31610@s15462909.onlinehome-server.info>
X-Provags-ID: V03:K0:086hufCix61f45KtZjbI/PSdvR2JDkwm7Qsz8v4jItkPXXLzQvs
 iJDABXSfwSUpcG9BLBgAMNzDhimF2ZDt9JsGCO4sg6covyg7f8QAtk9AkikOzW3M2Yk3Fnl
 SqjOXl9MC+uBiZSbIP+02m62l+zypMYP4e9FerxjIQgwGNvje3uFSfy6qapRbpgtsNFpXzs
 9EgBSG23+zuUFVVfuIe9Q==
X-UI-Out-Filterresults: notjunk:1;V01:K0:Yt2vIvLL/nM=:cXGTpHJJSBMWxvfeaieh4o
 W49oem56m32ke7N57sg77T1B/njVcUoS1LAC55duvfZ9FFjiEPZalCRuXQjll8WFg0vXA7hjF
 i23kYt41d0bMeZnZvMsGHx8RTiwMsgUEhrxdqZBLhRaejVe73En2dOdf5IpEfFTZDj5A4VsyI
 pxP64q7jkw18q6LGX2WYlMEZF3aLn9wWbtiuuYj1lR5huPqir5eP0wSXZwBHfTF6TVLnMJS7R
 Fk045YILh67ZBraJ/tPFu3qWXHn7Q2dXCg65INrVerCMvgSZXZ4NZjRUCckDMs0lX9g968B9w
 UZNBGN76z0VgVv2V93n6hCZhFgKl1YZ/qs7tFMy/vgRn8RZJO7QvCZc+gluRRg1t2XjhVeF+1
 9LlaMvO2BUyYMdqCIG00AMKB6D7pDVMSOm6dCMo8DnVrMvK/Hpr35LtaBjP7b1zQTGqs16E4l
 bFywEmDndMMEeJvxQncfdofQXyKyqQXSFbC/uBdDsUw5964xpcLnczJDjFdqYR3oe8QNTTOEk
 RqlvZXBB1JiAni9JLmCNp87MJSvuZo7hMCDsA/OkAWtsi68si0XuzLyCs9ViSow36qGZt49Ai
 JLSpmUJCzrh0+VKL5RaJ05weLgrp8GdYLpBOQanhKf+J+kIyt51o7B+z7tpzLiO3L+2mQ7gJB
 A0ifUtEuHcS3/D4ZyJPAvpUt2FdZWO09dA2gMC6ZXdGYMvrKgfPp6r+xDAlWt+oEZAkn6QCoR
 Ltg+PiPhWwuTpMzvrEf8Zyf3yaystl8yxqUA0BSDrzWnktr/gYEqGRk+MBpHlEZt9GV0jnmF 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/279670>

Am 15.10.2015 um 17:06 schrieb Johannes Schindelin:

> 
> Because sometimes more is less. If users are overwhelmed with many, many
> options, they are *less* likely to benefit from the few that are easy to
> use because they won't find out about them.
> 

Going from "I want to split at 'x'" to doing so seems just fine. More
than "Ok.. let's find the match I want to search for to have the split I
want", which seems like the opposite of usable.

There are 13 options now not counting help. Not sure it matters much if
we increase that to 14 or 15.

Regards,
Sven

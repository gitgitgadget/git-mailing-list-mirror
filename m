From: Ben Aveling <bena.001@optusnet.com.au>
Subject: Re: Files excluded but not ignored
Date: Sat, 02 Feb 2013 10:54:58 +1100
Message-ID: <510C55D2.20103@optusnet.com.au>
References: <loom.20130130T161911-66@post.gmane.org> <7v38ximyr2.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Jason Wenger <jcwenger@gmail.com>
X-From: git-owner@vger.kernel.org Sat Feb 02 00:55:29 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U1QS8-0005W6-1R
	for gcvg-git-2@plane.gmane.org; Sat, 02 Feb 2013 00:55:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756243Ab3BAXzG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 1 Feb 2013 18:55:06 -0500
Received: from mail06.syd.optusnet.com.au ([211.29.132.187]:32809 "EHLO
	mail06.syd.optusnet.com.au" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755633Ab3BAXzE (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 1 Feb 2013 18:55:04 -0500
Received: from [10.1.1.7] (d110-33-194-207.mas801.nsw.optusnet.com.au [110.33.194.207])
	(authenticated sender bena.001)
	by mail06.syd.optusnet.com.au (8.13.1/8.13.1) with ESMTP id r11NssUe016172
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Sat, 2 Feb 2013 10:54:55 +1100
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:14.0) Gecko/20120713 Thunderbird/14.0
In-Reply-To: <7v38ximyr2.fsf@alter.siamese.dyndns.org>
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.0 cv=RbTIkCRv c=1 sm=1 a=kfTud4QeKxsA:10
	a=OeJE13a6dSgA:10 a=8nJEP1OIZ-IA:10 a=PO7r1zJSAAAA:8 a=YC0M7niL4NYA:10
	a=pGLkceISAAAA:8 a=Zx_lQvsMsP3VFSgDhvAA:9 a=wPNLvfGTeEIA:10
	a=MSl-tDqOz04A:10 a=8hDSsFRbc579JZyDoJakvw==:117
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/215280>

On 31/01/2013 3:17 AM, Junio C Hamano wrote:
> Jason Wenger <jcwenger@gmail.com> writes:
>
>> Trying to start up discussion of whether there would be merit to a "half-
>> ignored" state -- Files which are excluded from tracking, but which still
>> show in git status, and which are removed by git clean.
> I see no merit for "ignored and never to be tracked, but are still
> shown loudly in the untracked list" myself.  Use cases for "ignored
> and never to be tracked, but not expendable" class were mentioned
> often in the past, though.

A new state seems over the top.

Jason, would adding a parameter to "git status" telling it to ignore all 
.gitignores give you what you need?

Regards, Ben

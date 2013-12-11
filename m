From: Paulo Matos <paulo@matos-sorge.com>
Subject: Re: Unexpected cherry-pick behaviour
Date: Wed, 11 Dec 2013 10:04:26 +0000
Message-ID: <7050e7272bb83d083a56a2c391228ed8@matos-sorge.com>
References: <118044938ad8ebf6b069bcc1d220a986@matos-sorge.com>
 <xmqqvbywts9d.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Dec 11 11:04:33 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vqgee-0002Bz-K6
	for gcvg-git-2@plane.gmane.org; Wed, 11 Dec 2013 11:04:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750882Ab3LKKE3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 Dec 2013 05:04:29 -0500
Received: from matos-sorge.com ([176.58.118.32]:58690 "EHLO
	centauri.matos-sorge.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1750800Ab3LKKE1 (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 11 Dec 2013 05:04:27 -0500
Received: from mail.matos-sorge.com (localhost [127.0.0.1])
	by centauri.matos-sorge.com (Postfix) with ESMTP id 6CD7871C701;
	Wed, 11 Dec 2013 10:04:26 +0000 (GMT)
In-Reply-To: <xmqqvbywts9d.fsf@gitster.dls.corp.google.com>
X-Sender: paulo@matos-sorge.com
User-Agent: Roundcube Webmail/0.9.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/239183>

On 10/12/2013 19:34, Junio C Hamano wrote:
> Perhaps immediately after "cherry-pick" stopped and asked your help
> to resolve the conflicts, running
> 
> 	$ git checkout --conflicts=diff3 gcc/tree-ssa-threadedge.c
> 
> and looking at the file again may show you what is going on better.

I don't know how to interpret the fact that the line you sent (with the 
obvious --conflicts being --conflict) outputs nothing...

Any suggestions?

-- 
Paulo Matos

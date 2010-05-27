From: Ivan Uemlianin <ivan@llaisdy.com>
Subject: Re: git pull works remotely but not locally
Date: Thu, 27 May 2010 16:37:08 +0100
Message-ID: <4BFE91A4.5000205@llaisdy.com>
References: <4BFE750B.5030007@llaisdy.com> <AANLkTikmrBQ1aUQeAZKB8pdgwXjureozZOzEHq8CF4kb@mail.gmail.com> <4BFE83A7.4020604@llaisdy.com> <AANLkTinn_D2nrZDoczHqvAFKdCxxubK0N0jHr-nE94JP@mail.gmail.com> <4BFE8A99.5060906@llaisdy.com> <20100527151514.GB18590@coredump.intra.peff.net> <4BFE8DF8.8050301@llaisdy.com> <4BFE8FB4.60002@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
To: unlisted-recipients:; (no To-header on input)
X-From: git-owner@vger.kernel.org Thu May 27 17:37:21 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OHf97-0001EW-0X
	for gcvg-git-2@lo.gmane.org; Thu, 27 May 2010 17:37:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932333Ab0E0PhN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 27 May 2010 11:37:13 -0400
Received: from mail.ukfsn.org ([77.75.108.10]:52711 "EHLO mail.ukfsn.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932207Ab0E0PhJ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 27 May 2010 11:37:09 -0400
Received: from localhost (smtp-filter.ukfsn.org [192.168.54.205])
	by mail.ukfsn.org (Postfix) with ESMTP id DB709DEBA5
	for <git@vger.kernel.org>; Thu, 27 May 2010 16:37:08 +0100 (BST)
Received: from mail.ukfsn.org ([192.168.54.25])
	by localhost (smtp-filter.ukfsn.org [192.168.54.205]) (amavisd-new, port 10024)
	with ESMTP id K1zQaLnP4T5l for <git@vger.kernel.org>;
	Thu, 27 May 2010 16:37:08 +0100 (BST)
Received: from ivan-uemlianins-macbook-pro.local (unknown [217.33.230.66])
	by mail.ukfsn.org (Postfix) with ESMTP id A7BB9DEBA2
	for <git@vger.kernel.org>; Thu, 27 May 2010 16:37:08 +0100 (BST)
User-Agent: Mozilla/5.0 (Macintosh; U; Intel Mac OS X 10.6; en-GB; rv:1.9.1.9) Gecko/20100317 Thunderbird/3.0.4
In-Reply-To: <4BFE8FB4.60002@viscovery.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/147880>

Yes, that would be odd.  I can run /bin/sh :)

On 27/05/2010 16:28, Johannes Sixt wrote:
> Please Reply-To-All, do not cull Cc list.
>
> Am 5/27/2010 17:21, schrieb Ivan Uemlianin:
>    
>> $ GIT_TRACE=1 git pull
>> trace: exec: 'git-pull'
>> trace: run_command: 'git-pull'
>> fatal: cannot exec 'git-pull': Permission denied
>>      
> You get 'Permission denied' also if you cannot execute the shell that the
> first line of the script references. But that would be really odd...
>
> -- Hannes
>    


-- 
============================================================
Ivan A. Uemlianin
Speech Technology Research and Development

                     ivan@llaisdy.com
                      www.llaisdy.com
                          llaisdy.wordpress.com
                      www.linkedin.com/in/ivanuemlianin

     "Froh, froh! Wie seine Sonnen, seine Sonnen fliegen"
                      (Schiller, Beethoven)
============================================================

From: Ivan Uemlianin <ivan@llaisdy.com>
Subject: Re: ssh communication not working
Date: Fri, 23 Jul 2010 11:43:10 +0100
Message-ID: <4C49723E.2080507@llaisdy.com>
References: <4C45A7C5.1050601@llaisdy.com> <20100720153553.GA2931@localhost.localdomain> <4C496419.5070902@llaisdy.com> <20100723100712.GA11889@LK-Perkele-V2.elisa-laajakaista.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Jul 23 12:43:19 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OcFip-0004U5-1r
	for gcvg-git-2@lo.gmane.org; Fri, 23 Jul 2010 12:43:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755798Ab0GWKnN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 23 Jul 2010 06:43:13 -0400
Received: from mail.ukfsn.org ([77.75.108.10]:50997 "EHLO mail.ukfsn.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754825Ab0GWKnM (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 Jul 2010 06:43:12 -0400
Received: from localhost (smtp-filter.ukfsn.org [192.168.54.205])
	by mail.ukfsn.org (Postfix) with ESMTP id 3B359DF646
	for <git@vger.kernel.org>; Fri, 23 Jul 2010 11:43:11 +0100 (BST)
Received: from mail.ukfsn.org ([192.168.54.25])
	by localhost (smtp-filter.ukfsn.org [192.168.54.205]) (amavisd-new, port 10024)
	with ESMTP id biZQNfViQU27 for <git@vger.kernel.org>;
	Fri, 23 Jul 2010 11:43:11 +0100 (BST)
Received: from ivan-uemlianins-macbook-pro.local (unknown [217.33.230.66])
	by mail.ukfsn.org (Postfix) with ESMTP id 0D9BFDF627
	for <git@vger.kernel.org>; Fri, 23 Jul 2010 11:43:11 +0100 (BST)
User-Agent: Mozilla/5.0 (Macintosh; U; Intel Mac OS X 10.6; en-GB; rv:1.9.1.11) Gecko/20100711 Thunderbird/3.0.6
In-Reply-To: <20100723100712.GA11889@LK-Perkele-V2.elisa-laajakaista.fi>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/151526>

Aha!  It works!

Dear Ilari

Thanks very much!

Best wishes

Ivan

On 23/07/2010 11:07, Ilari Liusvaara wrote:
> On Fri, Jul 23, 2010 at 10:42:49AM +0100, Ivan Uemlianin wrote:
>    
>> I tried cloning over ssh and got an error:
>>
>>      $ git clone ivan@myserver.com:/path/to/git/myproject.git
>>      Initialized empty Git repository in /Users/ivan/.git/
>>      ivan@85.92.88.62's password: ...
>>      bash: git-upload-pack: command not found
>>      fatal: The remote end hung up unexpectedly
>>      
> You don't have git-upload-pack in non-interactive $PATH (it is not the same
> as $PATH for interactive logins). Edit ~/.bashrc on remote side?
>
> -Ilari
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

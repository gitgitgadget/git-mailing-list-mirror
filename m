From: Ivan Uemlianin <ivan@llaisdy.com>
Subject: Re: A sudden lack of permission
Date: Mon, 27 Sep 2010 17:30:32 +0100
Message-ID: <4CA0C6A8.8050304@llaisdy.com>
References: <4CA0AFC4.1060001@llaisdy.com> <20100927160759.GB10256@sigill.intra.peff.net> <4CA0C36B.5000708@llaisdy.com> <20100927162235.GA10575@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Sep 27 18:30:41 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P0GbA-0008CN-PR
	for gcvg-git-2@lo.gmane.org; Mon, 27 Sep 2010 18:30:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759777Ab0I0Qae (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 27 Sep 2010 12:30:34 -0400
Received: from mail.ukfsn.org ([77.75.108.10]:50790 "EHLO mail.ukfsn.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759773Ab0I0Qae (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 27 Sep 2010 12:30:34 -0400
Received: from localhost (smtp-filter.ukfsn.org [192.168.54.205])
	by mail.ukfsn.org (Postfix) with ESMTP id 114D9DEC05;
	Mon, 27 Sep 2010 17:30:33 +0100 (BST)
Received: from mail.ukfsn.org ([192.168.54.25])
	by localhost (smtp-filter.ukfsn.org [192.168.54.205]) (amavisd-new, port 10024)
	with ESMTP id C0n4jmu0k9CV; Mon, 27 Sep 2010 17:30:32 +0100 (BST)
Received: from ivan-uemlianins-macbook-pro.local (unknown [217.33.230.66])
	by mail.ukfsn.org (Postfix) with ESMTP id C64E1DEBC4;
	Mon, 27 Sep 2010 17:30:32 +0100 (BST)
User-Agent: Mozilla/5.0 (Macintosh; U; Intel Mac OS X 10.6; en-GB; rv:1.9.2.9) Gecko/20100915 Thunderbird/3.1.4
In-Reply-To: <20100927162235.GA10575@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/157352>

  On 27/09/2010 17:22, Jeff King wrote:
> On Mon, Sep 27, 2010 at 05:16:43PM +0100, Ivan Uemlianin wrote:
>
>> Yes, I can ssh onto the server, cd to /var/www/git/my_repos.git and
>> add, edit files, etc.
> Did you check specifically the /var/www/git/my_repos.git/objects
> directory?

I can add files to the objects directory, but files in subdirectories 
(eg ff/, info/, pack/) are read only.

I have tried pushing to other reposes on the same server and some I can 
push to some I can't.  Ones I /can/ push to, their objects/ff/ etc 
directories are read only.

I'm using git a lot, but as (a) it generally just works and (b) I'm 
doing very basic things (pull, push, add, commit, status), I know very 
little about what is really going on.

Best wishes

Ivan


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

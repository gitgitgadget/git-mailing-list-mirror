From: Ivan Uemlianin <ivan@llaisdy.com>
Subject: ssh communication not working
Date: Fri, 23 Jul 2010 10:42:49 +0100
Message-ID: <4C496419.5070902@llaisdy.com>
References: <4C45A7C5.1050601@llaisdy.com> <20100720153553.GA2931@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Jul 23 11:42:56 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OcEmO-0007Qu-7h
	for gcvg-git-2@lo.gmane.org; Fri, 23 Jul 2010 11:42:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753509Ab0GWJmv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 23 Jul 2010 05:42:51 -0400
Received: from mail.ukfsn.org ([77.75.108.10]:59574 "EHLO mail.ukfsn.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752867Ab0GWJmu (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 Jul 2010 05:42:50 -0400
Received: from localhost (smtp-filter.ukfsn.org [192.168.54.205])
	by mail.ukfsn.org (Postfix) with ESMTP id 665D8DF681
	for <git@vger.kernel.org>; Fri, 23 Jul 2010 10:42:49 +0100 (BST)
Received: from mail.ukfsn.org ([192.168.54.25])
	by localhost (smtp-filter.ukfsn.org [192.168.54.205]) (amavisd-new, port 10024)
	with ESMTP id GsU1fnqkx6I0 for <git@vger.kernel.org>;
	Fri, 23 Jul 2010 10:42:49 +0100 (BST)
Received: from ivan-uemlianins-macbook-pro.local (unknown [217.33.230.66])
	by mail.ukfsn.org (Postfix) with ESMTP id 2DC24DF680
	for <git@vger.kernel.org>; Fri, 23 Jul 2010 10:42:49 +0100 (BST)
User-Agent: Mozilla/5.0 (Macintosh; U; Intel Mac OS X 10.6; en-GB; rv:1.9.1.11) Gecko/20100711 Thunderbird/3.0.6
In-Reply-To: <20100720153553.GA2931@localhost.localdomain>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/151510>

Dear All

Thank you for your comments.  I apologise for my delayed response.

I can't remember why I set up smart-http.  There was a good reason at 
the time, but it's possible that the reason is no longer in effect.

I tried cloning over ssh and got an error:

     $ git clone ivan@myserver.com:/path/to/git/myproject.git
     Initialized empty Git repository in /Users/ivan/.git/
     ivan@85.92.88.62's password: ...
     bash: git-upload-pack: command not found
     fatal: The remote end hung up unexpectedly

I have ssh access to the server, but it's possible that I haven't set up 
the server to serve git over ssh.  Please could someone point me to the 
appropriate place in the documentation?  The command git upload-pack is 
available on the client and on the server.

With thanks and best wishes

Ivan


On 20/07/2010 16:35, Jared Hance wrote:
> On Tue, Jul 20, 2010 at 02:42:29PM +0100, Ivan Uemlianin wrote:
>    
>> Is smart-http not entirely reliable?  In which case what is the
>> preferred way to communicate remotely (we need to push as well as
>> pull; there are a very small number of active developers)?
>>      
> I'm not entirely sure why the error is occuring, but the preferred way
> to communicate is over SSH. You can use the git protocol for anonymous
> pulling (but not pushing).
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

From: Eyvind Bernhardsen <eyvind-git@orakel.ntnu.no>
Subject: Re: [PATCH] Respect crlf attribute even if core.autocrlf has not been set
Date: Wed, 23 Jul 2008 21:20:48 +0200
Message-ID: <FB7ABDC5-8505-4FD1-8082-9BB5013E73C6@orakel.ntnu.no>
References: <alpine.DEB.1.00.0807222255450.8986@racer>  <7vy73tihl6.fsf@gitster.siamese.dyndns.org>  <alpine.DEB.1.00.0807230203350.8986@racer>  <7vej5kfs0w.fsf@gitster.siamese.dyndns.org>  <alpine.DEB.1.00.0807231817460.8986@racer>  <488772BC.80207@workspacewhiz.com> <32541b130807231133x37083278u1badd82b5c48e57b@mail.gmail.com> <alpine.DEB.1.00.0807231956280.8986@racer>
Mime-Version: 1.0 (Apple Message framework v928.1)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Cc: Avery Pennarun <apenwarr@gmail.com>,
	Joshua Jensen <jjensen@workspacewhiz.com>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed Jul 23 21:56:35 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KLkRm-0004IT-CU
	for gcvg-git-2@gmane.org; Wed, 23 Jul 2008 21:56:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752675AbYGWTz2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Jul 2008 15:55:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751394AbYGWTz2
	(ORCPT <rfc822;git-outgoing>); Wed, 23 Jul 2008 15:55:28 -0400
Received: from eyvind.bernhardsens.net ([84.49.228.97]:59075 "EHLO
	eyvind.bernhardsens.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752649AbYGWTz1 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Jul 2008 15:55:27 -0400
X-Greylist: delayed 2076 seconds by postgrey-1.27 at vger.kernel.org; Wed, 23 Jul 2008 15:55:27 EDT
Received: from vredefort.d.eyvind.bernhardsens.net (vredefort.d.eyvind.bernhardsens.net [172.16.3.221])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by eyvind.bernhardsens.net (Postfix) with ESMTP id 302E81AF796;
	Wed, 23 Jul 2008 21:20:49 +0200 (CEST)
In-Reply-To: <alpine.DEB.1.00.0807231956280.8986@racer>
X-Mailer: Apple Mail (2.928.1)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/89762>

On 23. juli. 2008, at 20.57, Johannes Schindelin wrote:

> Hi,
>
> On Wed, 23 Jul 2008, Avery Pennarun wrote:
>
>> 1. always CRLF on all platforms (eg. for .bat files)
>> 2. always LF on all platforms (eg. for shell scripts and perl  
>> scripts)
>> 3. just leave it alone no matter what (eg. for binary files)
>
> These are not different, but equal.  "Do no harm to the contents of  
> this
> file".

That is only true until someone edits the file in an editor which  
prefers the wrong end-of-line marker, and converts to it when saving.   
It will be obvious that this has happened if the user does a "git  
diff" before committing, but I think the intent of nos. 1 and 2 is for  
git to automatically convert the line endings back instead of kicking  
up a fuss.

Might be too magical, though.

Eyvind Bernhardsen

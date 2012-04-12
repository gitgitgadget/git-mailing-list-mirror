From: Rolf Leggewie <foss@rolf.leggewie.biz>
Subject: Re: prevent push of irrelevant tags
Date: Fri, 13 Apr 2012 04:45:22 +0800
Message-ID: <4F873EE2.5090203@rolf.leggewie.biz>
References: <4F873153.9060004@rolf.leggewie.biz> <7v1uns67f4.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Apr 12 22:46:04 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SIQu4-00045d-3z
	for gcvg-git-2@plane.gmane.org; Thu, 12 Apr 2012 22:46:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762741Ab2DLUp6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 Apr 2012 16:45:58 -0400
Received: from mail-in-16.arcor-online.net ([151.189.21.56]:33879 "EHLO
	mail-in-16.arcor-online.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1762664Ab2DLUp5 (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 12 Apr 2012 16:45:57 -0400
Received: from mail-in-01-z2.arcor-online.net (mail-in-01-z2.arcor-online.net [151.189.8.13])
	by mx.arcor.de (Postfix) with ESMTP id B6D6988DF;
	Thu, 12 Apr 2012 22:45:55 +0200 (CEST)
Received: from mail-in-18.arcor-online.net (mail-in-18.arcor-online.net [151.189.21.58])
	by mail-in-01-z2.arcor-online.net (Postfix) with ESMTP id B2EB715B5B1;
	Thu, 12 Apr 2012 22:45:55 +0200 (CEST)
Received: from [192.168.3.54] (unknown [110.55.115.205])
	(Authenticated sender: leggewie@arcor.de)
	by mail-in-18.arcor-online.net (Postfix) with ESMTPA id 7BE323DC674;
	Thu, 12 Apr 2012 22:45:34 +0200 (CEST)
X-DKIM: Sendmail DKIM Filter v2.8.2 mail-in-18.arcor-online.net 7BE323DC674
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.9.2.28) Gecko/20120313 Thunderbird/3.1.20
In-Reply-To: <7v1uns67f4.fsf@alter.siamese.dyndns.org>
X-Enigmail-Version: 1.1.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/195368>

Hamano-San,

thank you very much for the ultra-quick reply and your explanation.

On 13.04.2012 04:07, Junio C Hamano wrote:
>> Git has the information to know...
> 
> No, it doesn't.  
> 
>>  that tag X will be useless in repo Y
>> because the commit Z it points to does not exist in Y.
> 
> Think of a case where:

I am only a simple user so I hope you will not be angry with me if I
misunderstand you.  I believe you are saying that "git push" does not
have the necessary information which I take your word for.  But git
itself surely should know if commit Z is available from repo Y or am I
mistaken?  For example I can do "git log repoY:master|grep $ZcommitID".
 That would return empty if the master branch at repoY didn't have
information about Z*.

Thank you for bearing with me.

Regards

Rolf


* Of course, it's possible that Z is not part of master but another
  branch at Y.

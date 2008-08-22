From: Federico Lucifredi <flucifredi@acm.org>
Subject: Re: Suggestion: "man git clone"
Date: Thu, 21 Aug 2008 20:07:56 -0400
Message-ID: <48AE035C.8000504@acm.org>
References: <48ACB29C.7000606@zytor.com> <48ADE2FF.4080704@acm.org> <48ADF542.9010105@zytor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
To: "H. Peter Anvin" <hpa@zytor.com>
X-From: git-owner@vger.kernel.org Fri Aug 22 02:09:05 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KWKD9-00041L-0N
	for gcvg-git-2@gmane.org; Fri, 22 Aug 2008 02:09:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752614AbYHVAH7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 21 Aug 2008 20:07:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752329AbYHVAH6
	(ORCPT <rfc822;git-outgoing>); Thu, 21 Aug 2008 20:07:58 -0400
Received: from mail7.sea5.speakeasy.net ([69.17.117.9]:48395 "EHLO
	mail7.sea5.speakeasy.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752554AbYHVAH6 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Aug 2008 20:07:58 -0400
Received: (qmail 15297 invoked from network); 22 Aug 2008 00:07:57 -0000
Received: from unknown (HELO spaceman.local) (federico@[130.57.22.201])
          (envelope-sender <flucifredi@acm.org>)
          by mail7.sea5.speakeasy.net (qmail-ldap-1.03) with AES256-SHA encrypted SMTP
          for <hpa@zytor.com>; 22 Aug 2008 00:07:57 -0000
User-Agent: Thunderbird 2.0.0.16 (Macintosh/20080707)
In-Reply-To: <48ADF542.9010105@zytor.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/93234>

H. Peter Anvin wrote:
> Federico Lucifredi wrote:

[...]

>>  I am open to ideas, but so far the two options above are better than 
>> anything else that has been so far suggested...
>>
> 
> One option would be to support "man foo bar" showing the page labelled 
> foo-bar.  That way you'd get at least a modicum of bass-ackwards 
> compatibility.

I am all for bass-ackwards compatibility, and I think the suggestion of 
going on "man foo bar" :

  1) look for foo-bar; if success, terminate search
  2) look for foo
  3) look for bar
  ....

may be acceptable - I don't see drawbacks at a first glance, and it 
would allow for groups of pages to be meaningful.

Are you willing to put your patch where your mouth is? :-)

  Best -F
> 
> However, at some point we have to be willing to do things other 
> platforms won't, or we'll never do anything new...
> 
>     -hpa


-- 
_________________________________________
-- "'Problem' is a bleak word for challenge" - Richard Fish
(Federico L. Lucifredi) - flucifredi@acm.org

From: David Lang <david@lang.hm>
Subject: RE: Repository Code Security (Plan Text)
Date: Wed, 24 Jun 2015 13:10:49 -0700 (PDT)
Message-ID: <alpine.DEB.2.02.1506241308140.4148@nftneq.ynat.uz>
References: <BLUPR0701MB19693B73E05DF433C6B70182D7AF0@BLUPR0701MB1969.namprd07.prod.outlook.com> <20150624213111.61ce6933040bbb7220d5903c@domain007.com> <BLUPR0701MB196947C0396E91F8CCE39200D7AF0@BLUPR0701MB1969.namprd07.prod.outlook.com>
 <alpine.DEB.2.02.1506241217010.4148@nftneq.ynat.uz> <BLUPR0701MB1969E8CB9B348504F02231F3D7AF0@BLUPR0701MB1969.namprd07.prod.outlook.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: Konstantin Khomoutov <kostix+git@007spb.ru>,
	"git@vger.kernel.org" <git@vger.kernel.org>,
	David Turner <dturner@twopensource.com>
To: BGaudreault Brian <BGaudreault@edrnet.com>
X-From: git-owner@vger.kernel.org Wed Jun 24 22:11:47 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z7r1M-0002sN-Eb
	for gcvg-git-2@plane.gmane.org; Wed, 24 Jun 2015 22:11:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753275AbbFXULj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 24 Jun 2015 16:11:39 -0400
Received: from mail.lang.hm ([64.81.33.126]:56155 "EHLO bifrost.lang.hm"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752943AbbFXULb (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Jun 2015 16:11:31 -0400
Received: from asgard.lang.hm (asgard.lang.hm [10.0.0.100])
	by bifrost.lang.hm (8.13.4/8.13.4/Debian-3) with ESMTP id t5OKAnR4012630;
	Wed, 24 Jun 2015 13:10:49 -0700
X-X-Sender: dlang@asgard.lang.hm
In-Reply-To: <BLUPR0701MB1969E8CB9B348504F02231F3D7AF0@BLUPR0701MB1969.namprd07.prod.outlook.com>
User-Agent: Alpine 2.02 (DEB 1266 2009-07-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/272604>

On Wed, 24 Jun 2015, BGaudreault Brian wrote:

> Hi David Lang,
>
> I'm sorry, but I'm confused by your first two responses.  Am I not contacting 
> Git when I e-mail this e-mail address?  You sound like you don't know exactly 
> how GitHub works.  Should I be contacting someone else for GitHub support?

git is the opensource distributed version control software that github uses as 
part of their offering. This is the mailing list used by the developers of git. 
Very few of the developers here work for github.

For github support, you will need to contact the company github.

David Lang

> Thanks,
> Brian
>
> -----Original Message-----
> From: David Lang [mailto:david@lang.hm]
> Sent: Wednesday, June 24, 2015 3:20 PM
> To: BGaudreault Brian
> Cc: Konstantin Khomoutov; git@vger.kernel.org
> Subject: RE: Repository Code Security (Plan Text)
>
> On Wed, 24 Jun 2015, BGaudreault Brian wrote:
>
>> Thanks.  Yes, I meant that "local code" is code pulled down to a person's PC, so we don't want them to leave the company with access to this code.  So we can only prevent this scenario by running GitLab in our environment instead of running GitHub in the cloud?  Would removing a GitHub account from the GitHub repository prevent them from accessing the code on their PC?
>>
>> How do you prevent private GitHub repositories from being pulled down to unauthorized PCs?
>
> policy, you say that it's against policy for someone to put company info on a personal machine.
>
> You probably run your own repository that's only available within your network (or over your VPN) rather than using a cloud service like github (you may want to check with github to see if they can lock down a private repo to only be accessed from specific IP addresses)
>
> you will also need to make sure that people don't plug personal laptops into your corporate network, and that they don't use personal phones to access company e-mail.
>
> The bottom line is that it's no different from preventing them from having access to any other sensitive data in your company. What measures do you have in place to keep them from taking sensitive Word Docs or spreadsheets when they leave? do the same thing to deal with their access to code.
>
> David Lang
>
>> Thanks,
>> Brian
>>
>> -----Original Message-----
>>
>> On Wed, 24 Jun 2015 18:18:00 +0000
>> BGaudreault Brian <BGaudreault@edrnet.com> wrote:
>>
>>> If someone downloads code to their notebook PC and leaves the
>>> company, what protection do we have against them not being able to
>>> access the local code copy anymore?
>>
>> What do you mean by "local code"?
>> That one which is on the notebook?
>> Then you can do literally nothing except for not allowing cloning your Git repositories onto random computers in the first place.
>>
>> If you instead mean the copy of code available in the repositories hosted in your enterprise then all you need to do is to somehow terminate the access of that employee who's left to those repositories.
>> (This assumes they're accessible from the outside; if they aren't, the
>> problem simply do not exist.)
>> --
>> To unsubscribe from this list: send the line "unsubscribe git" in the
>> body of a message to majordomo@vger.kernel.org More majordomo info at
>> http://vger.kernel.org/majordomo-info.html
>>
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>

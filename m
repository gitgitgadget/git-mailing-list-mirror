From: David Turner <dturner@twopensource.com>
Subject: Re: Repository Code Security (Plan Text)
Date: Wed, 24 Jun 2015 15:21:12 -0400
Organization: Twitter
Message-ID: <1435173672.6499.2.camel@twopensource.com>
References: <BLUPR0701MB19693B73E05DF433C6B70182D7AF0@BLUPR0701MB1969.namprd07.prod.outlook.com>
	 <20150624213111.61ce6933040bbb7220d5903c@domain007.com>
	 <BLUPR0701MB196947C0396E91F8CCE39200D7AF0@BLUPR0701MB1969.namprd07.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: Konstantin Khomoutov <kostix+git@007spb.ru>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: BGaudreault Brian <BGaudreault@edrnet.com>
X-From: git-owner@vger.kernel.org Wed Jun 24 21:21:22 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z7qEb-00034V-Ib
	for gcvg-git-2@plane.gmane.org; Wed, 24 Jun 2015 21:21:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753271AbbFXTVS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 24 Jun 2015 15:21:18 -0400
Received: from mail-ig0-f176.google.com ([209.85.213.176]:38230 "EHLO
	mail-ig0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753312AbbFXTVQ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Jun 2015 15:21:16 -0400
Received: by igin14 with SMTP id n14so40768214igi.1
        for <git@vger.kernel.org>; Wed, 24 Jun 2015 12:21:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:organization:content-type:mime-version
         :content-transfer-encoding;
        bh=49LVg4IjBxF+nXxPy1FRZOEQOAkiyBmRGLWTRKTgsbk=;
        b=DseaQ5m28se8x0C0ugKTUlMwuZpqYOyn36cbxE+oLzl/3e43zx9jBtP5tdv3JaMzEB
         nvKn7xdsWwLVhVeD+899Q811heNwwAPgZwBQgx4+6+za59qX8Fcf0h6A2bJ3ITndPT4k
         45U9so0NXaGR6hnMPO92AwjvPHOJKsuL44CUWG23rIWl9CmJoXjmioOJWiL/Vnm1YJi5
         UPWl3miO7zMRsDwTqPFCRyD26zDTdun3N7PJmqVRJtUm4P+BjFfnG/xfGOFoGt+0srDF
         k3kGUkoHXgLO2jw1/8nGJTFCBRhbNBpotkrpQvdmJdGBqBbyOgbGyQ05auPupoBxZAbL
         38FQ==
X-Gm-Message-State: ALoCoQlE/3ogB2mNX3cOG1yaIXwmwJH/ZjXVbwYMGOsAoIlLt7drDma1t4PpfGUTlDuKnJ5c5iol
X-Received: by 10.107.136.42 with SMTP id k42mr36349684iod.63.1435173675668;
        Wed, 24 Jun 2015 12:21:15 -0700 (PDT)
Received: from ubuntu (207-38-164-98.c3-0.43d-ubr2.qens-43d.ny.cable.rcn.com. [207.38.164.98])
        by mx.google.com with ESMTPSA id h128sm17939431ioh.38.2015.06.24.12.21.13
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 24 Jun 2015 12:21:14 -0700 (PDT)
In-Reply-To: <BLUPR0701MB196947C0396E91F8CCE39200D7AF0@BLUPR0701MB1969.namprd07.prod.outlook.com>
X-Mailer: Evolution 3.12.10-0ubuntu1~14.10.1 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/272588>

What most companies do is this: they issue their employees computers,
and then when the employee leaves, they take the computers away.  Of
course, someone could have copied the code before leaving the company.
The typical remedy for this is a contract saying "don't do that".  But I
guess some companies just go straight to the FBI see e.g.:
https://en.wikipedia.org/wiki/Sergey_Aleynikov

There is no technological solution that will prevent someone from
accessing something that lives on their own computer (just ask the movie
and music industries, which tried to find one for about twenty years).  

On Wed, 2015-06-24 at 18:59 +0000, BGaudreault Brian wrote:
> Thanks.  Yes, I meant that "local code" is code pulled down to a person's PC, so we don't want them to leave the company with access to this code.  So we can only prevent this scenario by running GitLab in our environment instead of running GitHub in the cloud?  Would removing a GitHub account from the GitHub repository prevent them from accessing the code on their PC?
> 
> How do you prevent private GitHub repositories from being pulled down to unauthorized PCs?
> 
> Thanks,
> Brian
> 
> -----Original Message-----
> From: Konstantin Khomoutov [mailto:kostix+git@007spb.ru] 
> Sent: Wednesday, June 24, 2015 2:31 PM
> To: BGaudreault Brian
> Cc: git@vger.kernel.org
> Subject: Re: Repository Code Security (Plan Text)
> 
> On Wed, 24 Jun 2015 18:18:00 +0000
> BGaudreault Brian <BGaudreault@edrnet.com> wrote:
> 
> > If someone downloads code to their notebook PC and leaves the company, 
> > what protection do we have against them not being able to access the 
> > local code copy anymore?
> 
> What do you mean by "local code"?
> That one which is on the notebook?
> Then you can do literally nothing except for not allowing cloning your Git repositories onto random computers in the first place.
> 
> If you instead mean the copy of code available in the repositories hosted in your enterprise then all you need to do is to somehow terminate the access of that employee who's left to those repositories.
> (This assumes they're accessible from the outside; if they aren't, the problem simply do not exist.)
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

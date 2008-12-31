From: "Thomas Amsler" <tpamsler@ucdavis.edu>
Subject: Re: gitweb $export_ok question
Date: Wed, 31 Dec 2008 10:56:46 -0800
Message-ID: <6db6bed70812311056y6bdb4a52x4d361677b5915bb3@mail.gmail.com>
References: <9B3762519053E645820D9CEBD18B3734023A9FBA00@XEDAMAIL2.ex.ad3.ucdavis.edu>
	 <m3sko5b84t.fsf@localhost.localdomain>
	 <6db6bed70812302037w54fe5640of234cd611f5ab45e@mail.gmail.com>
	 <200812311000.25818.jnareb@gmail.com>
	 <6db6bed70812311013l3cf575c1y874e71e70d1dde57@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: "Jakub Narebski" <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Wed Dec 31 19:58:13 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LI6Gh-0001rL-O0
	for gcvg-git-2@gmane.org; Wed, 31 Dec 2008 19:58:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756394AbYLaS4u (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 31 Dec 2008 13:56:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756380AbYLaS4t
	(ORCPT <rfc822;git-outgoing>); Wed, 31 Dec 2008 13:56:49 -0500
Received: from wa-out-1112.google.com ([209.85.146.182]:31086 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756303AbYLaS4s (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 31 Dec 2008 13:56:48 -0500
Received: by wa-out-1112.google.com with SMTP id v27so2910550wah.21
        for <git@vger.kernel.org>; Wed, 31 Dec 2008 10:56:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:sender
         :to:subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references
         :x-google-sender-auth;
        bh=nzZZHlWl9DiP1YAwxUfBnQt+W7Q20aeBrs9pgO8WY4M=;
        b=w5KFFu2pE0vZ2ZDVO+XRq/+vK3aOaScpiBwuCF3tJGdaod0Zs4kzVEK9D9RkOQzlwR
         5zZjm1pXheLPjjZfc7TleOfeYKc4ehB5Igr0wUW9z1X9B/EdmXJ7v4Qby1xpTs1E0Znd
         p/ylor86W9I8maGKzlPpdz29ppUfG0iKQrrKo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references:x-google-sender-auth;
        b=h5vCKG4QX74GM+/PI8DiTVLZ3DCKQAkEs7kH1uYr+1oQpXX3LcHPqO9OmeMygAIPib
         /+ejH3pbmcHAA9Rw+4001KfDua7aNy5wpeexWF7b/MHkM6uuzS0jMvT0P/ydydzewIpD
         mA1GL6iMusWISOAw1XETYSMUXN+FrYVivgXpY=
Received: by 10.114.147.7 with SMTP id u7mr10656663wad.138.1230749806483;
        Wed, 31 Dec 2008 10:56:46 -0800 (PST)
Received: by 10.115.58.4 with HTTP; Wed, 31 Dec 2008 10:56:46 -0800 (PST)
In-Reply-To: <6db6bed70812311013l3cf575c1y874e71e70d1dde57@mail.gmail.com>
Content-Disposition: inline
X-Google-Sender-Auth: e9a3515c79942468
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/104282>

One more question. Now, on the gitweb home page, the project name
hyper link shows up as:

authz.git/.git

where it used to be just:

authz.git/

is there a way to configure this so that it doesn't show the trailing .git?

Best,
-- Thomas




On Wed, Dec 31, 2008 at 10:13 AM, Thomas Amsler <tpamsler@ucdavis.edu> wrote:
> That did the trick. It wasn't quite clear from the documentation that the
> file defined by $export_ok has to be located in repository/.git/
>
> Thank you for your help.
>
> Best,
> -- Thomas
>
>
>
> On Wed, Dec 31, 2008 at 1:00 AM, Jakub Narebski <jnareb@gmail.com> wrote:
>>
>> Thomas Amsler wrote:
>>
>> > Thank you for your information.
>> >
>> > I have just tried that but the repository doesn't show up in gitweb
>> >
>> > - added to /etc/gitweb.conf
>> > -- $export_ok = "gitweb-export-ok"
>> > - touched the "gitweb-export-ok" file in the repository
>> > -- touch /path-to-repo/repository/authz.git/gitweb-export-ok
>> >
>> > Then gitweb reports:
>> >
>> > 404 - No projects found
>> >
>> > Does the gitweb-export-ok file need to be part of  the repo so that it
>> > is
>> > tracked?
>>
>> No, gitweb-export-ok file has to be in $GIT_DIR (like description file),
>> not part of repo.
>>
>> As to "No projects found" error: what is your $projectroot? Is it
>> either "/path-to-repo/repository" or "/path-to-repo"? Is repository
>> readable and searchable for the web server user (does it have correct
>> permissions)?
>> --
>> Jakub Narebski
>> Poland
>> --
>> To unsubscribe from this list: send the line "unsubscribe git" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
>

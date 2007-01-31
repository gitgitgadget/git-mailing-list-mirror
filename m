From: "Chris Lee" <clee@kde.org>
Subject: Re: Qt git repository report
Date: Wed, 31 Jan 2007 02:34:08 -0800
Message-ID: <204011cb0701310234k4cb87eadhcf8669e364be4d6@mail.gmail.com>
References: <200701310912.59102.andyparkins@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Andy Parkins" <andyparkins@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jan 31 11:34:14 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HCCn7-00042Q-Ua
	for gcvg-git@gmane.org; Wed, 31 Jan 2007 11:34:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932944AbXAaKeK (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 31 Jan 2007 05:34:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932952AbXAaKeK
	(ORCPT <rfc822;git-outgoing>); Wed, 31 Jan 2007 05:34:10 -0500
Received: from wr-out-0506.google.com ([64.233.184.225]:25309 "EHLO
	wr-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932944AbXAaKeJ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 31 Jan 2007 05:34:09 -0500
Received: by wr-out-0506.google.com with SMTP id 68so142118wri
        for <git@vger.kernel.org>; Wed, 31 Jan 2007 02:34:08 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references:x-google-sender-auth;
        b=lhBYEo/vEF7Qwp/zfjHph/Flig99O1zAeHsoBrpNlMJJ0ohcEiaoFKjAbHlbRnVbru1izFCtlLUEGjArJtj1UXPIGwvu3fv0ylMRNIX1doyWorl5+Cw+BuY0QDYNty3v2E9Vm0SDh2iajyhXmfAYbkn7HMxXhz6KPcVHADjZXhk=
Received: by 10.90.78.9 with SMTP id a9mr849416agb.1170239648549;
        Wed, 31 Jan 2007 02:34:08 -0800 (PST)
Received: by 10.90.83.16 with HTTP; Wed, 31 Jan 2007 02:34:08 -0800 (PST)
In-Reply-To: <200701310912.59102.andyparkins@gmail.com>
Content-Disposition: inline
X-Google-Sender-Auth: d649a112ca9b1332
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/38238>

On 1/31/07, Andy Parkins <andyparkins@gmail.com> wrote:
> Hello,
>
> It's always nice to read positive reports, so I thought I'd point you all at
> this one.
>
> One of the Qt developers posted a blog entry describing the conversion of the
> Qt repository from perforce to git.
>
> http://qtdeveloper.net/archives/2007/01/30/fun-with-git/
>
> Key facts:
>  * 13 years worth of changes
>  * 94000 revisions
>  * 736774 objects
>  * Took 3 hours to convert using git-fast-import and a custom script
>  * Repository size: 500MB
>  * Checkd out tree size: 330MB
>
> I never cease to be amazed by how good git is at its job.

Of course, nobody outside of Trolltech happens to have access to the
Trolltech p4 depot, however... if you happen to use p4 internally
(like Trolltech) and you wanted to try out the same script, you could
clone:

git://repo.or.cz/fast-export.git

You'll also need Shawn's git-fast-import, available from:

git://repo.or.cz/git/fastimport.git

Enjoy!

From: Marius Storm-Olsen <mstormo@gmail.com>
Subject: Re: untracked file deleted from the master branch, when checked out
 to it from a local branch
Date: Tue, 20 May 2014 13:44:57 -0500
Message-ID: <537BA2A9.3020708@gmail.com>
References: <2525467.KRXv8a3gWS@linux-wzza.site> <2726779.MFtIaLB4b4@linux-wzza.site> <xmqqk39gz4tw.fsf@gitster.dls.corp.google.com> <2654529.8c5AhJCJsq@linux-wzza.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: Arup Rakshit <aruprakshit@rocketmail.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 20 20:45:05 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wmp27-0002iR-Ec
	for gcvg-git-2@plane.gmane.org; Tue, 20 May 2014 20:45:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751459AbaETSo7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 20 May 2014 14:44:59 -0400
Received: from mail-oa0-f43.google.com ([209.85.219.43]:39196 "EHLO
	mail-oa0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750826AbaETSo6 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 May 2014 14:44:58 -0400
Received: by mail-oa0-f43.google.com with SMTP id l6so1007575oag.30
        for <git@vger.kernel.org>; Tue, 20 May 2014 11:44:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:subject:references
         :in-reply-to:content-type:content-transfer-encoding;
        bh=8fCR54UUwdgtHzHuLzF88DOA9ZXaUsFQSOpiMW6cvF0=;
        b=tSlWQhu/K28wGG3KDKm234Hs2y0FN43V/XZ6FOBMqTAxiNRNKl5jL7dqCWSglVmi0R
         fqRop8A5LhFsnxfYinMeBViNHkPVJsptvgFUOZZH3KAleWLUAK6UmcXZx6O83ulaj9qi
         kRYIf7VabulLGhG94Iyp/Wa8tvaT+DQRI/gzfzIlDKN6wbvwFXLas3uf+4G6TlyFY3Pb
         b7esepj5xiowUs1PdrGpdpMPZtcSI8pKzbHDLKjOIIjSLodZ9z+o4q0QGI17oTN/6GXF
         zDHYhq2QgryGfnKGeFTHAlwZH38EMSLD+UI7+HfVjwZz2KJ7tPEYdKKko5Iy7yaioMVE
         TGkA==
X-Received: by 10.182.94.209 with SMTP id de17mr44689369obb.60.1400611497899;
        Tue, 20 May 2014 11:44:57 -0700 (PDT)
Received: from [10.3.3.221] ([199.227.34.94])
        by mx.google.com with ESMTPSA id ci10sm51065876oec.0.2014.05.20.11.44.57
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Tue, 20 May 2014 11:44:57 -0700 (PDT)
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:24.0) Gecko/20100101 Thunderbird/24.5.0
In-Reply-To: <2654529.8c5AhJCJsq@linux-wzza.site>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/249725>

On 5/20/2014 12:40 PM, Arup Rakshit wrote:
> On Tuesday, May 20, 2014 11:24:11 AM you wrote:
>> Arup Rakshit <aruprakshit@rocketmail.com> writes:
>>
>> Untracked files and modifications to files in your working directory
>> do not belong to your current branch.  This is to allow you, after
>> starting to work on one branch then realizing that the changes and
>> additions you are making do not belong there, to switch to a more
>> appropriate branch at that point without losing your work so far,
>> taking these changes and additions with you to the branch you want
>> to commit your changes to.
>>
> Now, It makes sense. I gave it another try and this time I walk from back to
> front.
>
> Now you can see, that I have created, a new file called *file.txt*, in the
> *master branch*.

NO, you didn't.

 > arup@linux-wzza:~/Git_tutorial> git status
 > # On branch master
 > # Untracked files:
 > #   (use "git add <file>..." to include in what will be committed)
 > #
 > #       file.txt

See that file.txt is listed under "Untracked files"?
Git sees the file, but since you haven't added it with "git add", it's 
untracked and Git doesn't care about it.

It lists it with the status command, so you will see that it's not yet 
tracked.

-- 
.marius

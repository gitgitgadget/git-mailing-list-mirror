From: Peter Harris <git@peter.is-a-geek.org>
Subject: Re: sparse support in pu
Date: Mon, 17 Aug 2009 10:30:29 -0400
Message-ID: <eaa105840908170730w248d966an5714365a40d039b9@mail.gmail.com>
References: <2729632a0908162309ma6e7d41kc3bafe4575120630@mail.gmail.com>
	 <fcaeb9bf0908170117v67e9f8b1ga56edcda14821e91@mail.gmail.com>
	 <2729632a0908170149o425544dcw52aeb6ac6ee1437d@mail.gmail.com>
	 <fcaeb9bf0908170321o43fa4a6bv95dd78ff7889686f@mail.gmail.com>
	 <4A8932BB.7030002@viscovery.net>
	 <fcaeb9bf0908170441o30005085nb0d4e08f333b6146@mail.gmail.com>
	 <alpine.DEB.1.00.0908171425410.4991@intel-tinevez-2-302>
	 <eaa105840908170552m3eaf0f92j523ddad98dd67a3@mail.gmail.com>
	 <alpine.DEB.1.00.0908171522510.4991@intel-tinevez-2-302>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Johannes Sixt <j.sixt@viscovery.net>, skillzero@gmail.com,
	git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon Aug 17 16:30:47 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Md3EM-0003gM-DU
	for gcvg-git-2@lo.gmane.org; Mon, 17 Aug 2009 16:30:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754706AbZHQOa3 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 17 Aug 2009 10:30:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754664AbZHQOa3
	(ORCPT <rfc822;git-outgoing>); Mon, 17 Aug 2009 10:30:29 -0400
Received: from mail-ew0-f214.google.com ([209.85.219.214]:33401 "EHLO
	mail-ew0-f214.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754663AbZHQOa2 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 17 Aug 2009 10:30:28 -0400
Received: by ewy10 with SMTP id 10so2985700ewy.37
        for <git@vger.kernel.org>; Mon, 17 Aug 2009 07:30:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:sender:received:in-reply-to
         :references:date:x-google-sender-auth:message-id:subject:from:to:cc
         :content-type:content-transfer-encoding;
        bh=vTVqG8xf1HSviukoxht0cv2ZJmGgvryoBp4RQBevOIU=;
        b=xyw04fAPk2iV+jSfKW1BjvqMMSi5xYOcNJH0KgIdn5cWEHGSNGEz7irqfXRu0nLyPq
         jGgQg+88wN8c6XnYuGFA1tj1BN0E6qY36xK8wyhiOF0V0W/SzofewhoPquyNwGFY8VZe
         yzg+XWkF7x3ycp8Wt52z2/DTDyzeJzOrBQ37w=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        b=YLvR0sOF+aFbSaHX7ch8U/57XBU0/AeduiF9AFjkNAfU+RPSxtuqGP9u3xQgLD9hP/
         btA/S3bYuBmRc9sCJvrPfBtNr3OIPzTjV9BWFyr8Lfye8t1zakwLBXiS4wcVXKrovrMl
         LJ7X2uyAQr1LY1H6OR0p5N5iyHe53COYbFtas=
Received: by 10.210.127.13 with SMTP id z13mr2813962ebc.1.1250519429161; Mon, 
	17 Aug 2009 07:30:29 -0700 (PDT)
In-Reply-To: <alpine.DEB.1.00.0908171522510.4991@intel-tinevez-2-302>
X-Google-Sender-Auth: e140aa0341f60b70
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/126187>

On Mon, Aug 17, 2009 at 9:23 AM, Johannes Schindelin wrote:
> On Mon, 17 Aug 2009, Peter Harris wrote:
>> On Mon, Aug 17, 2009 at 8:29 AM, Johannes Schindelin wrote:
>> > If I want to have a sparse checkout, I know which files I _want_.
>>
>> That's funny. I have a git tree that would benefit from sparse check=
out.
>> I know which path I _don't_ want. Specifying all the paths I want wo=
uld
>> be a rather longer (and more error-prone) list. I suspect it would b=
e
>> best to support both.
>
> Yes, I agree, but the common case is for people to know what they are
> working on, right?

I would presume so, but anecdotal "evidence" points the other way. I
don't have a statistically significant number of samples. Maybe it
should have been asked in the Git User's Survey? ;-)

>> Does sparse use the same parser as .gitignore? (I guess not, if it
>> handles trailing slashes differently?) If so, it would be trivial to
>> turn "exclude path" into "exclude all but path" (or vice-versa) with=
:
>>
>> *
>> !path
>
> That was the idea behind my suggestion to allow .gitignore syntax. =A0=
And
> indeed, that is what happened.

Excellent. In that case, I don't care which way around the default is.

Thanks,
 Peter Harris

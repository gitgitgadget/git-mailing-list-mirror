From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [PATCH] format-patch: add --prefix to prepend a prefix to output 
	file names
Date: Wed, 10 Jun 2009 09:14:14 +1000
Message-ID: <fcaeb9bf0906091614y7392bfa8p20a4e5c3c37a051b@mail.gmail.com>
References: <1244547227-6466-1-git-send-email-pclouds@gmail.com> 
	<4A2E576D.704@op5.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Andreas Ericsson <ae@op5.se>
X-From: git-owner@vger.kernel.org Wed Jun 10 01:14:45 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MEAWg-0004oc-SI
	for gcvg-git-2@gmane.org; Wed, 10 Jun 2009 01:14:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755988AbZFIXOe convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 9 Jun 2009 19:14:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755451AbZFIXOd
	(ORCPT <rfc822;git-outgoing>); Tue, 9 Jun 2009 19:14:33 -0400
Received: from an-out-0708.google.com ([209.85.132.242]:35342 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752496AbZFIXOc convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 9 Jun 2009 19:14:32 -0400
Received: by an-out-0708.google.com with SMTP id d40so455394and.1
        for <git@vger.kernel.org>; Tue, 09 Jun 2009 16:14:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=102I4qJfoA9lNkAoa4I6EZg805BHwC4669vvJVnOt5U=;
        b=VkNn0UWxQkZeELOIwzOA+EOjwHfl/3UJPlIMxQNdEB+CSCelVSulBxZRnwpuAC+D1A
         Y6B2ZWM985szlcwbwI20a0yjCh9lFtOHZksPx1qdDGB6m+Hno21lBmYCgBihdrVnyPi8
         jwWs7swMvjMc4VW/w2Eu1HZjdf2780aZKjgTs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=fy5lMin/BXbwNCPjg4pBNxyaFugCGLjUKJaQTjXDBbuSDrTIQPZ6N6OC/tkF7xls+j
         vagVGw+eV6RBp+boA3UpL6TWJHAg8bBMnoBvcENnhE1VEk6WRIpejUlhF19yAPupOmk5
         MZPA7kU2hMLAho9hOXf2XLj2S3P5Cl5n78b2o=
Received: by 10.100.41.9 with SMTP id o9mr685404ano.155.1244589274706; Tue, 09 
	Jun 2009 16:14:34 -0700 (PDT)
In-Reply-To: <4A2E576D.704@op5.se>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/121235>

2009/6/9 Andreas Ericsson <ae@op5.se>:
> Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy wrote:
>>
>> I use git to manages patches in my Gentoo development. In Gentoo,
>> all ebuilds (another form of RPM spec) corresponding to different
>> versions of the same package are grouped into one directory. So patc=
hes
>> for each versions usually have a prefix to separate them from the on=
es
>> for other versions. With --prefix it comes handy to produce such pat=
ches,
>> for example:
>>
>> git format-patch --prefix dbus-1.2.3- HEAD~5
>>
>> will generate patches for dbus-1.2.3 for me, all starting with
>> "dbus-1.2.3-".
>>
>> This might be handy for RPM developers as well.
>>
>
> I'm thinking this could be confused with '--subject-prefix' which was
> given the long option to *not* confuse it with cover-letters and file=
name
> prefixes. Any chance you could make it --filename-prefix instead? Sin=
ce
> it already lacks a short option, the extra typing will probably be wo=
rth
> it to avoid unnecessary confusion.

I made it --prefix because I see --suffix for file names already. Yes
--filename-prefix may be less confusing than plain --prefix.
--=20
Duy

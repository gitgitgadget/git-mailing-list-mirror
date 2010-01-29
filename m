From: John Tapsell <johnflux@gmail.com>
Subject: Re: Stepping through a single file's history
Date: Fri, 29 Jan 2010 03:47:41 +0000
Message-ID: <43d8ce651001281947m2505dbcco992ad98ddbfeaeae@mail.gmail.com>
References: <5699F80A-4B27-4BAB-BEE8-5C48938A970B@flownet.com>
	 <43d8ce651001281758x79965b5fn8760b69d4fe82a36@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: John Tapsell <johnflux@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jan 29 04:48:06 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nahq0-0001IV-EW
	for gcvg-git-2@lo.gmane.org; Fri, 29 Jan 2010 04:48:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756627Ab0A2Drm convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 28 Jan 2010 22:47:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754934Ab0A2Drm
	(ORCPT <rfc822;git-outgoing>); Thu, 28 Jan 2010 22:47:42 -0500
Received: from mail-pw0-f42.google.com ([209.85.160.42]:64305 "EHLO
	mail-pw0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754638Ab0A2Drl convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 28 Jan 2010 22:47:41 -0500
Received: by pwi21 with SMTP id 21so1022696pwi.21
        for <git@vger.kernel.org>; Thu, 28 Jan 2010 19:47:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=z29w1KJqteyEPcAQY0TLEkt5uWb3YT7Jhv2xDbJa7n8=;
        b=Jx39Gq+j421Er+5IUBoGEfwDBeUb/gZp6DS3r+wBNZE/vEw7JA+E+WkEwcNlufKKyZ
         4Hc/5Yd5Y1Cdbekj+BYTRThMOVaq9HiOY6DU8Hfc4mJJ9NKcH4fFQHzEDfDF+yMp8EdT
         ca1wv3W8aMjB0J9VAsFMNGBM7YOw+MSHjQXhk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=YlPtUtS4lKg/ervmL3DGYOl5arkUFcf2k9SCiYs5+PfsNj1x4ljXMxua4CQDl/83ZH
         8eLESAHRdUpGfKTCs1BxVs3UISOikBH89zLaeIJQyOlrpV5XktnCzjQJOmaGm2VLRxP4
         aZtghZUAach7Q4GIKO/CvjqW04UDXisx8votw=
Received: by 10.115.132.12 with SMTP id j12mr166999wan.121.1264736861310; Thu, 
	28 Jan 2010 19:47:41 -0800 (PST)
In-Reply-To: <43d8ce651001281758x79965b5fn8760b69d4fe82a36@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/138299>

2010/1/29 John Tapsell <johnflux@gmail.com>:
> 2010/1/29 Ron Garret <ron@flownet.com>:
>> Hello,
>>
>> Is there an easy way to step through the history of a single file? =C2=
=A0To be more specific:
> ...
>> (The use case here is remembering that back in the day there was som=
e useful code in this file that I want to retrieve, but not remembering=
 exactly when it was deleted. =C2=A0So I want to step back through this=
 file's history and do diffs against HEAD.)
>
> How about simply doing:
>
> git log -p filename

You can also do like:

git show HEAD~3:path/filename

where path is the path from the top of the git repository.  This would
show the file as it was 3 revisions ago.

You can also do like:

git checkout HEAD~3 filename

to checkout the first as it was 3 revisions ago.

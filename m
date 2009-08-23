From: Thomas Adam <thomas.adam22@gmail.com>
Subject: Re: [PATCH] Add script for importing bits-and-pieces to Git.
Date: Sun, 23 Aug 2009 21:28:23 +0100
Message-ID: <18071eea0908231328r58b0e22ap20e664d2904420a0@mail.gmail.com>
References: <20090823201624.206F52FC20@perkele>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Peter Krefting <peter@softwolves.pp.se>
X-From: git-owner@vger.kernel.org Sun Aug 23 22:28:55 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MfJgN-0001El-0K
	for gcvg-git-2@lo.gmane.org; Sun, 23 Aug 2009 22:28:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934113AbZHWU2n convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 23 Aug 2009 16:28:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S934105AbZHWU2n
	(ORCPT <rfc822;git-outgoing>); Sun, 23 Aug 2009 16:28:43 -0400
Received: from mail-ew0-f207.google.com ([209.85.219.207]:57935 "EHLO
	mail-ew0-f207.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934090AbZHWU2m convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 23 Aug 2009 16:28:42 -0400
Received: by ewy3 with SMTP id 3so1882809ewy.18
        for <git@vger.kernel.org>; Sun, 23 Aug 2009 13:28:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=1xTHb/ZOIs4OuTOFSJ5huT0EIXQRAeLNAeq+NcFsHOA=;
        b=YpVXVRdHPb8QG12TWlaog2WWrOIYUt6jlc1J+6lMWvB8CcOfGZczskWaQxXlaxGpty
         yJaa9BH08OPxR4HMVm3mmqkaslbQPCpNVBiSvoou909mGRu4PqLWRBMYr4GqyWQSUWmI
         yPs/3i2UEP8YqZ55VfZRlLPBOji42bofDu8tw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=J8LxLFqmSnQUVK3nvkz9jdvAXy2bVakjxl0Bb/V7JoUKCyB5Yoq9g0vUF+o29CICPF
         B0FiXzsvmw5cpiY3M7OdUhwXxjNrGWOe1VOV8iZkpzBGH/F84vx2aEshESc314fGL1ZA
         1kLXucttnGyKyv1Bxossv7nrF1DUFpLYpgCXo=
Received: by 10.216.0.81 with SMTP id 59mr789153wea.77.1251059323074; Sun, 23 
	Aug 2009 13:28:43 -0700 (PDT)
In-Reply-To: <20090823201624.206F52FC20@perkele>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/126872>

2009/8/23 Peter Krefting <peter@softwolves.pp.se>:
> + =A0 =A0 =A0 my (undef, undef, undef, undef, undef, undef,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 undef, $size, undef, $time, undef, unde=
f, undef) =3D stat FILE;

Minor nit.  Better written as:

my ($size, $mtime) =3D (stat(FILE))[7,9];

-- Thomas Adam

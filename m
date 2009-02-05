From: Harry Vangberg <ichverstehe@gmail.com>
Subject: Fwd: git-svn doesn't fetch anything
Date: Thu, 5 Feb 2009 09:43:27 +0100
Message-ID: <941ff7dd0902050043v39989d4fk54ee739c1bc5843f@mail.gmail.com>
References: <941ff7dd0902041549y238f8460m3e1173cee6f44328@mail.gmail.com>
	 <86d4c5e00902042223n11caac95k2b226e3c2ce8658@mail.gmail.com>
	 <941ff7dd0902050033r5fa07533iac6dd3b4b5222af1@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Feb 05 09:45:23 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LUzrN-0003BL-LV
	for gcvg-git-2@gmane.org; Thu, 05 Feb 2009 09:45:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754318AbZBEInb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 Feb 2009 03:43:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753221AbZBEInb
	(ORCPT <rfc822;git-outgoing>); Thu, 5 Feb 2009 03:43:31 -0500
Received: from fk-out-0910.google.com ([209.85.128.188]:24056 "EHLO
	fk-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752228AbZBEIna (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Feb 2009 03:43:30 -0500
Received: by fk-out-0910.google.com with SMTP id f33so100079fkf.5
        for <git@vger.kernel.org>; Thu, 05 Feb 2009 00:43:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:content-type
         :content-transfer-encoding;
        bh=KweX+bQCrEcq2pYzq2B/CP2PM6XnUPNI9fF8U2diT6M=;
        b=QV9iezxkmnLV1vd7EicsNsc82OuRFfQxjUXedVmJ/9YyQ2u8SXv4qBbyRXOT0wvOhv
         g0JhCroYgoq0zxFHlqiVVRBVKdz7hT9enOQAqcJ1FglI/LUFU1XovPIIuc4GpQYHXMqg
         0/lpUtYPOzOGekmZh2eLodPezkUu+1TkQmqE0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :content-type:content-transfer-encoding;
        b=iHqcVvaVT/N2ludn+S0g8a1HU2BjD3IDLz97PBV3uRVSflS8Y0YsH0/NIwm8JMoz/e
         NoxPSj/pe2lO0xZcgKOyb7d6CLkS5CzmB3HUilqx0S2hgso49He5vfTfS5N+v0GOoxWU
         nOzooPByJyWXzBKlcvsXGP92EudPO5G/wWRGg=
Received: by 10.181.145.6 with SMTP id x6mr93343bkn.25.1233823407142; Thu, 05 
	Feb 2009 00:43:27 -0800 (PST)
In-Reply-To: <941ff7dd0902050033r5fa07533iac6dd3b4b5222af1@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/108540>

2009/2/5 Deskin Miller <deskinm@gmail.com>:
> This is what prints when the path you're interested in doesn't exist
> in early revisions, which is very common in large shared svn
> repositories.  Git has to ask svn at each revision, essentially,
> whether that path has been born.  'This may take a while on large
> repositories' is quite accurate; if you wait long enough, you'll get
> revisions.

I wait until it is finished - but it never gets to fetching revisions,
it just exists quietly and returns to commando prompt.

The branches/tags config is what is generated for me. The path for
branches and tags is:

https://svn.turntool.com/svn/turntool/plantool/branches/
https://svn.turntool.com/svn/turntool/plantool/tags/

I have tried changing the config for these, but can't find the right
one. Anyways, not even trunk is being fetched.

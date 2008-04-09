From: "=?ISO-8859-1?Q?Andr=E9_Goddard_Rosa?=" <andre.goddard@gmail.com>
Subject: Re: git annoyances
Date: Wed, 9 Apr 2008 20:56:03 -0300
Message-ID: <b8bf37780804091656s2f24ebe5h758884e63cea4845@mail.gmail.com>
References: <20080409101428.GA2637@elte.hu>
	 <7vfxtu3fku.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "Ingo Molnar" <mingo@elte.hu>, git@vger.kernel.org
To: "Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Apr 10 01:56:52 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jjk9r-0002Lo-EO
	for gcvg-git-2@gmane.org; Thu, 10 Apr 2008 01:56:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752737AbYDIX4H convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 9 Apr 2008 19:56:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752714AbYDIX4G
	(ORCPT <rfc822;git-outgoing>); Wed, 9 Apr 2008 19:56:06 -0400
Received: from fk-out-0910.google.com ([209.85.128.190]:47501 "EHLO
	fk-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752483AbYDIX4E convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 9 Apr 2008 19:56:04 -0400
Received: by fk-out-0910.google.com with SMTP id 19so3598036fkr.5
        for <git@vger.kernel.org>; Wed, 09 Apr 2008 16:56:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=Syc5FhPRljc9KhAZ56hC5BIgLagu71i8NWFK+c2Y2eE=;
        b=STFbRVAoKQhM7NLxYBqVsr80C/MPT9JARGgfzdcLSEtt6ff7J4QBmYkQYDAFfqNlp7qSw0VHbW3bzm0qpSWKm322REYdJeo10ay5xI90Mv9QWi38lePqhrbgRak6mc5Asm/S8sFZ7bCB36HHMJKdmFrDHGmFuTo5VpgOpeT94oY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=vPhxA5hjHOP/pS1HA3OKsaLCG8nOFtbljhvD2NUugcSV0GYGO7sNyUg3cZLTcaSaPJ3ozPgF1zQsflPsojBcjAFIJ9IRFzYqXINrnmEIsQa46aAI/o8zJcx3ohz/cC8Xce/fz2Ug6l/vRDXgI+AyRJRaHFOK3ScR8n1WFsefCEA=
Received: by 10.78.175.8 with SMTP id x8mr994108hue.0.1207785363185;
        Wed, 09 Apr 2008 16:56:03 -0700 (PDT)
Received: by 10.78.120.2 with HTTP; Wed, 9 Apr 2008 16:56:03 -0700 (PDT)
In-Reply-To: <7vfxtu3fku.fsf@gitster.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/79148>

>  > but it was a PITA and all of git's messages about the problem were=
 not
>  > only unhelpful, they confused me into looking for problems where t=
here
>  > were none IMO.
>
>  Yes, we need to teach "git" to do more mind-reading (I am not being
>  sarcastic).  There should be a pattern in common user errors that sh=
are
>  their roots to the same user misperception, and if we can identify t=
hat,
>  maybe we can make git guess what the user was really trying to do an=
d give
>  better error messages than it currently does.

Something along the lines of:

Error description
Why it happened
How to solve/Sugestion

--=20
[]s,
Andr=E9 Goddard

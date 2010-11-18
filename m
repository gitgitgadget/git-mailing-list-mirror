From: Tor Arntsen <tor@spacetec.no>
Subject: Re: patch for AIX system
Date: Thu, 18 Nov 2010 10:13:17 +0100
Message-ID: <AANLkTi=94zL-nuBeGcrAdWVBu6VTuqX3xcM9oGNNUwvQ@mail.gmail.com>
References: <4CE38472.8070206@Nemec-online.de>
	<7vr5ejg7oi.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Norbert Nemec <Norbert@nemec-online.de>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Nov 18 10:13:28 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PJ0YZ-0007DR-Hw
	for gcvg-git-2@lo.gmane.org; Thu, 18 Nov 2010 10:13:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754681Ab0KRJNV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Nov 2010 04:13:21 -0500
Received: from mail-qw0-f46.google.com ([209.85.216.46]:49484 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751145Ab0KRJNS (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Nov 2010 04:13:18 -0500
Received: by qwf7 with SMTP id 7so18154qwf.19
        for <git@vger.kernel.org>; Thu, 18 Nov 2010 01:13:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:sender:received
         :in-reply-to:references:date:x-google-sender-auth:message-id:subject
         :from:to:cc:content-type;
        bh=okf/lVIm+zUuxU8E+gFRLGJ8Ex43Cbuwaz092uwupj8=;
        b=dSa/LcmlJw2WrWH/qT9D6Ip5sBsUr0C+8LEDdb6QSd1yOIKWRSWorc8Y04eOwnJvzC
         IML48o6DKducNHVzgH165UnkktE5H3eoblOUtWfYAUed91o9O8qkefaZ7795Kc4QOqlf
         gkEntV+ccW7PPBsJiTZWak1zXNPTp1qp0ukcU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type;
        b=QATLlESbd6/h9Zb20UbWokqs3zMpgBetWipjVv6grAqkqOiZbKfd2ztQfHjuF1fBvZ
         fXrFWM+NB+tHWMe5jUo0t0bwrnXfZTpzFDmGx729AytMZUrHGYx0rzLmjMkiLEZJFxmv
         GCFACAVrG79w6R6/zEEc+K5MJSKvDr+/44cMg=
Received: by 10.229.81.148 with SMTP id x20mr370051qck.18.1290071597603; Thu,
 18 Nov 2010 01:13:17 -0800 (PST)
Received: by 10.229.80.6 with HTTP; Thu, 18 Nov 2010 01:13:17 -0800 (PST)
In-Reply-To: <7vr5ejg7oi.fsf@alter.siamese.dyndns.org>
X-Google-Sender-Auth: PTkRKXG6aPa3miHzWyyMJVfXLEQ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/161655>

On Wed, Nov 17, 2010 at 18:51, Junio C Hamano <gitster@pobox.com> wrote:

> I'd defer this section to AIX experts; I've always assumed that people
> on non-gnu platforms used ginstall, but perhaps AIX doesn't have one?

All my AIX systems have the coreutils RPM from the IBM Toolbox
installed (extra CD, or, these days, from ftp.software.ibm.com), so I
never ran into the incompatible install issue.
However, for those without coreutils a patch to make installbsd work
(with comments from Junio taken into account) would be reasonable I
guess. Particularly if the patch could be made so that it's easy
enough to switch to coreutils install if you wish to.

-Tor

From: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
Subject: Re: [PATCH 5/7] gitweb: auxiliary functions to group data
Date: Fri, 17 Sep 2010 08:54:03 +0200
Message-ID: <AANLkTikk7vUFMr31Azdcpe+PK0-yA2sp2EcnHjdfw0Zn@mail.gmail.com>
References: <1284629465-14798-1-git-send-email-giuseppe.bilotta@gmail.com>
 <1284629465-14798-6-git-send-email-giuseppe.bilotta@gmail.com> <201009170324.25801.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Fri Sep 17 08:54:32 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OwUq7-0003cM-P8
	for gcvg-git-2@lo.gmane.org; Fri, 17 Sep 2010 08:54:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754783Ab0IQGy0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 17 Sep 2010 02:54:26 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:59749 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753126Ab0IQGyZ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 17 Sep 2010 02:54:25 -0400
Received: by iwn5 with SMTP id 5so1730607iwn.19
        for <git@vger.kernel.org>; Thu, 16 Sep 2010 23:54:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:cc:content-type;
        bh=80+rbOyPqwYOfz9A+mXXVQavAP11h5IG091iykBpI5U=;
        b=J9eRZsU6YBk/Aqnd1fr3BVyOZQM23iBFxnIiC5heF0nW291QXo/e6h+5lu6hpvnrOD
         mTNemyp3ew+2EZ9Jc97EmsG2NXml4sLlFi0U1gVtUptAJwTfyotGylo8idn4RLOTe6fZ
         8qhw6nzZPmUtckR/3NhYldIikfYV91M41Xy9s=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=FGqYHnxqhejNDS3Yr6gnlUYIqQQDBVxB4MYWSTDJ/1TSo5JfiPVW2GoSHK1vC0WPW7
         dNxJEX6YBalrEsk0p1j50R5gIaKjjYyO4+HnZ6q3JRUaZofu0b/GAW91R4DWCEPYhIiG
         uoVoNLu2YQE1EYSEbNDIFZSOFmVcD7JhylcPc=
Received: by 10.231.185.142 with SMTP id co14mr4200165ibb.97.1284706463195;
 Thu, 16 Sep 2010 23:54:23 -0700 (PDT)
Received: by 10.231.150.202 with HTTP; Thu, 16 Sep 2010 23:54:03 -0700 (PDT)
In-Reply-To: <201009170324.25801.jnareb@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/156372>

On Fri, Sep 17, 2010 at 3:24 AM, Jakub Narebski <jnareb@gmail.com> wrote:
>
> ... but I think that having separate subroutines for opening and
> closing tags is a bad design / bad API (except in some rare cases).
> It is begging for unbalanced HTML.
>
> It would be better if it was a single subroutine wrapping 'div' around
> contents given either as a string, or via callback (subroutine reference),
> in my opinion.

I'm not sure that in this case the string or callback approach would
be any cleaner. I'll see if perl supports closures or something like
that.

-- 
Giuseppe "Oblomov" Bilotta

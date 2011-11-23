From: Philippe Vaucher <philippe.vaucher@gmail.com>
Subject: Re: git reset --merge documentation improvments
Date: Wed, 23 Nov 2011 12:39:39 +0100
Message-ID: <CAGK7Mr4UGc3jx2AQpRK_sotWHU-ibmGz87jx4hi-==8qY04QOg@mail.gmail.com>
References: <CAGK7Mr59bN8rjhLHAK0Vq=bOBBHG=N02CgGe-np=OBdTyS+rsA@mail.gmail.com>
 <4ECCB565.9020706@lyx.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Vincent van Ravesteijn <vfr@lyx.org>
X-From: git-owner@vger.kernel.org Wed Nov 23 12:40:29 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RTBBk-00037g-0Q
	for gcvg-git-2@lo.gmane.org; Wed, 23 Nov 2011 12:40:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753602Ab1KWLkP convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 23 Nov 2011 06:40:15 -0500
Received: from mail-iy0-f174.google.com ([209.85.210.174]:49445 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753583Ab1KWLkK convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 23 Nov 2011 06:40:10 -0500
Received: by iage36 with SMTP id e36so1463675iag.19
        for <git@vger.kernel.org>; Wed, 23 Nov 2011 03:40:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=/860VMcsjOleA0k9iMrQYs/24UfXdRTKsON0c2zDOwA=;
        b=xIDDEmzZCTOLFam0m51++0wVnuUuWNChfZzwv0/BtuaVAqnEs/CAjytzCgXGUsDHL4
         eQUJUxpwF7k0HP4ZA0nEQN+MmEGMecH76LHyPsEfIqZ1DDzqS1wo0ZoYDsD/JsB4K2a/
         tam9rfVMMt3aIQZJGg7bjF5IpsX/MjvFccA+g=
Received: by 10.231.41.9 with SMTP id m9mr6172120ibe.96.1322048410052; Wed, 23
 Nov 2011 03:40:10 -0800 (PST)
Received: by 10.50.195.199 with HTTP; Wed, 23 Nov 2011 03:39:39 -0800 (PST)
In-Reply-To: <4ECCB565.9020706@lyx.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/185841>

>> "Updates the files in the working tree that are different between
>> <commit> =A0and HEAD, but keeps those which are different between th=
e
>> index and working tree, and finally resets the index."
>
> There is nothing to update as long as the index is not reset.

Well then I simply don't understand what --merge does. Is it like
--keep but instead of failing when a file-to-be-overwritten has
changes it simply ignores the overwriting and continues?

Philippe

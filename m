From: Erik Faye-Lund <kusmabite@googlemail.com>
Subject: Re: Stamp Git commit id into file during build process
Date: Sat, 16 Jan 2010 20:14:44 +0100
Message-ID: <40aa078e1001161114w5a65bebbhaf43317634899925@mail.gmail.com>
References: <a1138db31001161050i73eade1bif968ca1256dcef2c@mail.gmail.com>
Reply-To: kusmabite@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Paul Richards <paul.richards@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jan 16 20:14:52 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NWE6l-0003US-Df
	for gcvg-git-2@lo.gmane.org; Sat, 16 Jan 2010 20:14:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753597Ab0APTOr convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 16 Jan 2010 14:14:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753525Ab0APTOr
	(ORCPT <rfc822;git-outgoing>); Sat, 16 Jan 2010 14:14:47 -0500
Received: from ey-out-2122.google.com ([74.125.78.27]:47648 "EHLO
	ey-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753429Ab0APTOq convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 16 Jan 2010 14:14:46 -0500
Received: by ey-out-2122.google.com with SMTP id 22so145574eye.5
        for <git@vger.kernel.org>; Sat, 16 Jan 2010 11:14:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:mime-version:received:reply-to:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=4/lYvXJqSHrRzGpxLxkCOy7Fx0kavyvzXWZqhSSHWLs=;
        b=ds6XEqxzeDmuajhgJnfhG2JfPZKwnwIYXGSs8CP4mcmrxf8uEDeTJOh8/bR6ScbTq7
         vWf+nOcypAwNWwV/uNefFIBLg0fc/H0gkgKEHFDZd2kbX57D28h0jCEPZgjP5+xcfmTX
         ve9R/LDmg1TTVoQISViwuE75MHBFZT86AErx0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=mime-version:reply-to:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type:content-transfer-encoding;
        b=nPI4GbkR26Bt18PHINNp61OW9fR8NwVXhFc8iwief+USeWgvzINfJutjDhpWSqHu6F
         ht2aurKa+3ljNykiFCEVt5yQkBnaQA991GTeYY+poxiIeWk9vEht9DEVYMIPHvKi+kpC
         ykqi1ZWh3otb9aPOmP3493oqhUARi6GevAg+g=
Received: by 10.216.89.85 with SMTP id b63mr1381746wef.175.1263669284384; Sat, 
	16 Jan 2010 11:14:44 -0800 (PST)
In-Reply-To: <a1138db31001161050i73eade1bif968ca1256dcef2c@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/137251>

On Sat, Jan 16, 2010 at 7:50 PM, Paul Richards <paul.richards@gmail.com=
> wrote:
> Hi,
> I am in the process of migrating from Subversion to Git. =A0One thing=
 I
> am unsure of is how to stamp the 'version' or 'commit id' into a file
> as part of a build process.
>
> With subversion I used the SubWCRev tool from TortoiseSVN
> (http://tortoisesvn.net/docs/release/TortoiseSVN_en/tsvn-subwcrev.htm=
l).
>
> With Git I imagine that I'd like to put a copy of the current commit
> id (either the full hash or a truncated version of that) into a file
> which then gets included into the program source code in some way.
>
> Is there a recommended way of doing this with git? =A0Perhaps with
> something similar to SubWCRev?
>
> Currently I am thinking about using "git log", and grepping the outpu=
t
> in some way so that I just get the hash.
>

I think you are looking for "git rev-parse HEAD". This outputs the
hash of HEAD as a single line on stdout. Or even better, you can use
the "git describe"-tool, which gives a nice and short description of
the commit relative to the most recent commit.

--=20
Erik "kusma" Faye-Lund

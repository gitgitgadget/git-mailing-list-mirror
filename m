From: "Carlos Rica" <jasampler@gmail.com>
Subject: Re: [PATCH] mktag.c: improve verification of tagger field and tests
Date: Wed, 26 Mar 2008 12:21:57 +0100
Message-ID: <1b46aba20803260421t4db4987gc6fc8b2e556032e0@mail.gmail.com>
References: <1206490795-13247-1-git-send-email-casey@nrlssc.navy.mil>
	 <47E99B98.1060506@nrlssc.navy.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Git Mailing List" <git@vger.kernel.org>
To: "Brandon Casey" <casey@nrlssc.navy.mil>
X-From: git-owner@vger.kernel.org Wed Mar 26 12:22:43 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JeTiM-0002td-G4
	for gcvg-git-2@gmane.org; Wed, 26 Mar 2008 12:22:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752426AbYCZLWA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 26 Mar 2008 07:22:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752654AbYCZLWA
	(ORCPT <rfc822;git-outgoing>); Wed, 26 Mar 2008 07:22:00 -0400
Received: from wx-out-0506.google.com ([66.249.82.234]:62562 "EHLO
	wx-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751172AbYCZLV7 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 26 Mar 2008 07:21:59 -0400
Received: by wx-out-0506.google.com with SMTP id h31so4043604wxd.4
        for <git@vger.kernel.org>; Wed, 26 Mar 2008 04:21:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=82ajmZBotSwA2sx+co2uKg/hPGj7v8bHR0SdkOKd4S8=;
        b=oqs8PMgcSFeRzE8a/CUOZoAhsnzpxOE8fWfnO1abVHzXGtsze+pYgVF1eCBhJ34NDp6GxLVCMX0FXKqJyXcfN2pX6WZbhmWJn1O3GYc9nz0uuto9DWWysvHVNtpS0n+v7uduSTsAXOfdcRzVe7838ppP7RDKLo+x7O9y/lWro8o=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=UM5y/woUJa33kAnZhOoUrcoI+lKywxG8c5T5qgtutmV8cdvkqaBxpwcAxOOpSGDrvt1EUzA8Q3mih0HPTm2nCM8xaIigo+AOUNo5nBHFsd/f0HyGoy2iauZiMHCl/UuTIvRD1yKqGOdzBr2WtLdKuqdBDx0FAhYEW+7MlLn95cw=
Received: by 10.141.91.12 with SMTP id t12mr4301078rvl.138.1206530517901;
        Wed, 26 Mar 2008 04:21:57 -0700 (PDT)
Received: by 10.141.115.5 with HTTP; Wed, 26 Mar 2008 04:21:57 -0700 (PDT)
In-Reply-To: <47E99B98.1060506@nrlssc.navy.mil>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/78281>

On Wed, Mar 26, 2008 at 1:40 AM, Brandon Casey <casey@nrlssc.navy.mil> wrote:
>  Well, since I looked at this code and used it in filter-branch, I figured I
>  should fix the verification code for the tagger field (even though it's
>  probably dieing soon).
>
>  I'm thinking this utility should be fairly strict about the format it accepts.

Why not using git-tag to make tags in filter-branch?

git-mktag was used in git-tag.sh before convert it into
builtin-tag.c, and I didn't know that anyone was using it.

I agree that, if this program exists and it is used,
we should double-check the accepted format and data,
so this patch is a good addition.

However, I think that we should progressively deprecate its
use to avoid mantaining two different ways for creating tags,
so you must have a very good reason to keep using
this tool in a script...

Regards

--
Carlos

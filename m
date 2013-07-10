From: Antoine Pelisse <apelisse@gmail.com>
Subject: Re: t0008 hang on streaming test (OS X)
Date: Wed, 10 Jul 2013 22:35:53 +0200
Message-ID: <CALWbr2zWVLGNAPFEc7QGjozxXFyuDLD639c=yZkzWhusq1kV8Q@mail.gmail.com>
References: <6050FACA-CAD4-4E41-B7DC-D7A2036AA233@gernhardtsoftware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "git@vger.kernel.org List" <git@vger.kernel.org>
To: Brian Gernhardt <brian@gernhardtsoftware.com>
X-From: git-owner@vger.kernel.org Wed Jul 10 22:36:03 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ux17K-00047G-48
	for gcvg-git-2@plane.gmane.org; Wed, 10 Jul 2013 22:36:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754995Ab3GJUfy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Jul 2013 16:35:54 -0400
Received: from mail-qc0-f176.google.com ([209.85.216.176]:36177 "EHLO
	mail-qc0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754908Ab3GJUfx (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Jul 2013 16:35:53 -0400
Received: by mail-qc0-f176.google.com with SMTP id z10so3863251qcx.21
        for <git@vger.kernel.org>; Wed, 10 Jul 2013 13:35:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=N5VphSgry5oovNHSIUebpOumeX39cySVdskCxy2MfXY=;
        b=RL36FNCCcysdxYyCdsNmj/KV8CS7vDN3YNmcrev3LnZlkCHMCM3ZXtmSqD9nJ0vBeN
         IZz4TMfA67WFgJ0++1Q/pxZS+Bm+Z379yPbLuXSL9WPiWimqsuqX0NNCZNptDb4J+cwU
         PC1Xr+qAXKyvWN7IGcfeWWmcHhglISzyXmE1z5gm82mD7JzadChkaKwKwSTQSVG2VnFu
         22CXg1qNA5qN2+YsvrErXxPpC6SBXlwR11SR6R0uh05jQau9hmjE7jwKMEJlz3bvQp3i
         9TDVBM/reGYrjrZryXOjLqLx0R7tdP6y6X+2bK5Q2rfPrq8Nohg8FPNLGZnK7kyib6zc
         qbMg==
X-Received: by 10.224.182.79 with SMTP id cb15mr30263383qab.48.1373488553164;
 Wed, 10 Jul 2013 13:35:53 -0700 (PDT)
Received: by 10.49.108.105 with HTTP; Wed, 10 Jul 2013 13:35:53 -0700 (PDT)
In-Reply-To: <6050FACA-CAD4-4E41-B7DC-D7A2036AA233@gernhardtsoftware.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/230072>

On Wed, Jul 10, 2013 at 6:36 PM, Brian Gernhardt
<brian@gernhardtsoftware.com> wrote:
> I am somewhat stuck on how to fix it.  Any ideas?

I don't have anything to reproduce here, but usually I start
investigating this kind of problems by attaching the hung process with
gdb to see the current state (if it's stuck in a specific state), or
to investigate the end-less loop.
That usually help finding a good starting point.

Cheers,
Antoine

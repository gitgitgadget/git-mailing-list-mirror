From: Frans Klaver <fransklaver@gmail.com>
Subject: Re: Broken git-svn tests known?
Date: Wed, 1 Aug 2012 08:51:23 +0200
Message-ID: <CAH6sp9PyFan=JEL_Hmjxf54j3up2ArPb2qQP5hsWCGLzaWj5BA@mail.gmail.com>
References: <CAMvPOPuxdtaQPD6T4M7knPFhQbWGk8psp+DKn4gaHxW48WPFOw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Ammon Riley <ammon.riley@gmail.com>
X-From: git-owner@vger.kernel.org Wed Aug 01 08:51:31 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SwSmI-0004qI-3N
	for gcvg-git-2@plane.gmane.org; Wed, 01 Aug 2012 08:51:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753887Ab2HAGvZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 1 Aug 2012 02:51:25 -0400
Received: from mail-qa0-f46.google.com ([209.85.216.46]:55816 "EHLO
	mail-qa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753606Ab2HAGvY (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Aug 2012 02:51:24 -0400
Received: by qadb17 with SMTP id b17so2304403qad.19
        for <git@vger.kernel.org>; Tue, 31 Jul 2012 23:51:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=NHIj3glg72TxQ9aIHSmDPSqQfAfnQrTXDbt0LelnCbI=;
        b=Kg70CBN5kjMgfk8R9qPI7n6DpRlAlnGQ5frf/EtQcbSHIEm0xbiP6E9hAB5EK9ZI1H
         eNXVAfQwfP80VyvAdIdviU3YJoAFAgfbNesjFj37DOBRL8nKzhKj4wHvp30dz7RP9cJm
         yX941VQFLm/RVcxSSSFhuc/gaYKjomDUe68SuHWC63k4VZJ6WFrnv4pH+zaUpnnhAY0C
         4q6sGtFEg/EeYQ4SJY5jHielWbpUUnJbaihlKQ69kpKkG0p0Hk9pZItRhKWSnQXKCjZ9
         j9mUyhn5uvPujhrbetYvdduSG/wGhW/MuIbSRBmHtFc24dVMUAoFA9qhCM0XeawWFM2B
         Wcbw==
Received: by 10.224.179.7 with SMTP id bo7mr6907510qab.15.1343803883716; Tue,
 31 Jul 2012 23:51:23 -0700 (PDT)
Received: by 10.224.106.135 with HTTP; Tue, 31 Jul 2012 23:51:23 -0700 (PDT)
In-Reply-To: <CAMvPOPuxdtaQPD6T4M7knPFhQbWGk8psp+DKn4gaHxW48WPFOw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/202706>

On Wed, Aug 1, 2012 at 1:44 AM, Ammon Riley <ammon.riley@gmail.com> wrote:
> Hi,
>
> On a freshly checked out copy of the maint branch (0e4c8822), the
> t9100-git-svn-basic.sh tests are failing 21 of 25 tests. Is this
> known, or am I missing some dependencies? Is it possibly due to
> using subversion 1.7?

Yes, and work is done on it as we speak[1].


> I've run into a small bug with git-svn, and wanted to make sure
> the test suite still passed with my patch applied.

You would probably have to base your work on this work in progress, or
test with svn 1.6 for the time being.

[1] http://thread.gmane.org/gmane.comp.version-control.git/202419

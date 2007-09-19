From: "Dana How" <danahow@gmail.com>
Subject: Re: [PATCH] [git-p4] Detect exec bit in more cases.
Date: Wed, 19 Sep 2007 12:31:52 -0700
Message-ID: <56b7f5510709191231g22385e32y9c34d711d65b3bb7@mail.gmail.com>
References: <119022570352-git-send-email-git@davidb.org>
	 <200709192103.53526.simon@lst.de>
	 <20070919191412.GA6475@old.davidb.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: "Simon Hausmann" <simon@lst.de>, git@vger.kernel.org,
	danahow@gmail.com
X-From: git-owner@vger.kernel.org Wed Sep 19 21:39:42 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IY5HH-0003qg-9B
	for gcvg-git-2@gmane.org; Wed, 19 Sep 2007 21:32:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752717AbXISTb5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Sep 2007 15:31:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754459AbXISTb4
	(ORCPT <rfc822;git-outgoing>); Wed, 19 Sep 2007 15:31:56 -0400
Received: from ug-out-1314.google.com ([66.249.92.170]:13116 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753972AbXISTby (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Sep 2007 15:31:54 -0400
Received: by ug-out-1314.google.com with SMTP id z38so295400ugc
        for <git@vger.kernel.org>; Wed, 19 Sep 2007 12:31:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=1bo1j1FMLmEsswqSkM9a80gq8gePY3MdusOiBDO3MY0=;
        b=N8QX14PGjyGarfBZcB8doN4NSzlSQ00GeMyEljnclFw7Fna0yLqNWA/Vs3oW9n87jJi1p1L79egBHu3wp4f/pkEE5VxtkF7NesMB7I3ci559caYY0562/b4tANNa8r+jJRpHJ096/svSlz+o2mnVq5BMIHfplOdABcdENvmWdTk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=K60oyqn4i5qgaurfB8KPj4o7EUC/MBsAMEbKcvhGdRV+GIHPUMWqb7dgMkWWJhNg/zhVmQdoYuIUMFBcIICtF8Ut3ajN32Jn9svg94YEFcNPwGiwmuEpbqeXOth7r4uJFUEtZLZitW+CR/etbbZJQjXKc3l3Xw30s5C0aDes0I8=
Received: by 10.78.149.13 with SMTP id w13mr332052hud.1190230312884;
        Wed, 19 Sep 2007 12:31:52 -0700 (PDT)
Received: by 10.78.106.15 with HTTP; Wed, 19 Sep 2007 12:31:52 -0700 (PDT)
In-Reply-To: <20070919191412.GA6475@old.davidb.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/58727>

On 9/19/07, David Brown <git@davidb.org> wrote:
> On Wed, Sep 19, 2007 at 09:03:50PM +0200, Simon Hausmann wrote:
> >On Wednesday 19 September 2007 20:15:03 David Brown wrote:
> >> git-p4 was missing the execute bit setting if the file had other attribute
> >> bits set.
> >
> >I'm fine with this, so unless you find a better way:
>
> Well, I just tested it, and it still doesn't work, so I need to take some
> time and try to figure out what is happening.
>
> I'm sometimes getting back 'xtext', and sometimes things like 'text+mx'
> back from perforce, so I need to read up, and really figure out what to
> look for.

The output of "git p4 filetypes" was enough for me
when I wrote my p4 front-end to fast-import;
I never did read the p4 manual.

Have fun,
-- 
Dana L. How  danahow@gmail.com  +1 650 804 5991 cell

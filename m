From: "Alex Riesen" <raa.lkml@gmail.com>
Subject: Re: [PATCH] Avoid perl in t1300-repo-config
Date: Wed, 27 Jun 2007 17:47:55 +0200
Message-ID: <81b0412b0706270847j1bfc8a68ge6213643f02391ec@mail.gmail.com>
References: <81b0412b0706270545w65ca2556yaafaac6ff31b5961@mail.gmail.com>
	 <20070627151545.GF12721@planck.djpig.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Git Mailing List" <git@vger.kernel.org>,
	"Junio C Hamano" <gitster@pobox.com>
To: "Frank Lichtenheld" <frank@lichtenheld.de>
X-From: git-owner@vger.kernel.org Wed Jun 27 17:48:05 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I3ZkO-0004zz-4g
	for gcvg-git@gmane.org; Wed, 27 Jun 2007 17:48:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754731AbXF0Pr6 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 27 Jun 2007 11:47:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752890AbXF0Pr6
	(ORCPT <rfc822;git-outgoing>); Wed, 27 Jun 2007 11:47:58 -0400
Received: from ug-out-1314.google.com ([66.249.92.168]:41656 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754217AbXF0Pr5 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Jun 2007 11:47:57 -0400
Received: by ug-out-1314.google.com with SMTP id j3so355062ugf
        for <git@vger.kernel.org>; Wed, 27 Jun 2007 08:47:56 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=KfsrfqeprIXndjFPNv8YaX7Kj74NTNHTpJq0D+FRGy0mC8kTLkYzL6HP0svlIzQ92plXuOZsQ82Z3/bxn4rNk3+bAgaPNCet8JMOA7jrSsvvkt24jkUflfzEub3lKa2kBsuUJ/Yc7rsKZbzR69uViIKA3UgB2HWrzunUrrzGYok=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=UzlinpeFHgcd125O5pLHwgxraECDgMFSK/6QdoGGWdTfAyrYq7xFPdRd4qiZ1GEm6MjWhPAQ9AFuwX1oQUpnTdDSe+5jADYMhyuFl5W+ahGVI6m4AkY1/gOdGK5PuhOLhXK90fCg6/N5lGkIM9wfZABnYeXKbGf91yEy38N6oIo=
Received: by 10.78.168.1 with SMTP id q1mr343957hue.1182959275885;
        Wed, 27 Jun 2007 08:47:55 -0700 (PDT)
Received: by 10.78.100.16 with HTTP; Wed, 27 Jun 2007 08:47:55 -0700 (PDT)
In-Reply-To: <20070627151545.GF12721@planck.djpig.de>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/51052>

On 6/27/07, Frank Lichtenheld <frank@lichtenheld.de> wrote:
> On Wed, Jun 27, 2007 at 02:45:40PM +0200, Alex Riesen wrote:
> > It fixes the test on system where ActiveState Perl is used.
> > It is also shorter.
>
> Thanks :)
>
> For future reference: What in my code broke with ActiveState Perl?
> The command line options?
>

Nothing really, the code is perfect and options are correct.
ActiveState is just clueless, and activates \r\n line endings
on stdout/stderr by default, unless the stream is binmoded
(irrespective of whether the stream is tty or not).

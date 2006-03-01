From: "Martin Langhoff" <martin.langhoff@gmail.com>
Subject: Re: Quick question: end of lines
Date: Wed, 1 Mar 2006 21:31:52 +1300
Message-ID: <46a038f90603010031g31f8bc33xd3f45f2e19950c78@mail.gmail.com>
References: <f898cca90602281032n6603bf14q@mail.gmail.com>
	 <46a038f90602281215n259066b1qe2e6421625b82e75@mail.gmail.com>
	 <f898cca90602281612n777a4f17m@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Mar 01 09:32:11 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FEMkZ-0000vE-7p
	for gcvg-git@gmane.org; Wed, 01 Mar 2006 09:31:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932241AbWCAIby (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 1 Mar 2006 03:31:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932279AbWCAIby
	(ORCPT <rfc822;git-outgoing>); Wed, 1 Mar 2006 03:31:54 -0500
Received: from wproxy.gmail.com ([64.233.184.198]:41799 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932241AbWCAIbx convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>); Wed, 1 Mar 2006 03:31:53 -0500
Received: by wproxy.gmail.com with SMTP id i34so82092wra
        for <git@vger.kernel.org>; Wed, 01 Mar 2006 00:31:52 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=qIHwyX2NZGUTvOXYBUlFWS5TOyE9vgHNK22JXKGYzSof2KLMo5PRZlq6mbkcsPk8alOEEPtrMUSd/9TUgLIN63rhcwDQjZ3DCuSUFxx0figjX37wktGQXVkHXUVRji4pWU8bWAn/rYCY/5kvlEGk1hGDf/TrmGm+Kr8DpuanKOI=
Received: by 10.54.117.5 with SMTP id p5mr1731963wrc;
        Wed, 01 Mar 2006 00:31:52 -0800 (PST)
Received: by 10.54.71.5 with HTTP; Wed, 1 Mar 2006 00:31:52 -0800 (PST)
To: "Emmanuel Guerin" <emmanuel@guerin.fr.eu.org>
In-Reply-To: <f898cca90602281612n777a4f17m@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/16966>

On 3/1/06, Emmanuel Guerin <emmanuel@guerin.fr.eu.org> wrote:
> What I begin to realize is that the only possibility probably lies in
> using a tool that converts the modified files "on the fly" before
> commits. I just want to make sure that no other solution was found by
> others facing a similar problem.

Perhaps a pre-commit hook? Read the documentation (and search the list
archives). I'm pretty sure you can do newline cleanup before commit or
at least newline checks before commits.

There's always the option of filing a bug in MS's bugzilla ;-)

cheers,


martin

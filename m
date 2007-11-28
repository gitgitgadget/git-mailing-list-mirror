From: "Lars Hjemli" <hjemli@gmail.com>
Subject: Re: [PATCH v2] Teach 'git pull' about --rebase
Date: Wed, 28 Nov 2007 22:10:34 +0100
Message-ID: <8c5c35580711281310h8764a33pba48e65010abf859@mail.gmail.com>
References: <Pine.LNX.4.64.0710252351130.4362@racer.site>
	 <alpine.LFD.0.999.0710251602160.30120@woody.linux-foundation.org>
	 <Pine.LNX.4.64.0710260007450.4362@racer.site>
	 <7v3avy21il.fsf@gitster.siamese.dyndns.org>
	 <Pine.LNX.4.64.0710261047450.4362@racer.site>
	 <7v3aurcjpq.fsf@gitster.siamese.dyndns.org>
	 <Pine.LNX.4.64.0711281307420.27959@racer.site>
	 <27E5EF3C-19EF-441C-BB12-0F5B29BEAEDB@midwinter.com>
	 <Pine.LNX.4.64.0711282039430.27959@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: "Steven Grimm" <koreth@midwinter.com>,
	"Junio C Hamano" <gitster@pobox.com>,
	"Linus Torvalds" <torvalds@linux-foundation.org>,
	git@vger.kernel.org
To: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed Nov 28 22:11:09 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IxUBS-0006zn-MZ
	for gcvg-git-2@gmane.org; Wed, 28 Nov 2007 22:11:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754228AbXK1VKh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 Nov 2007 16:10:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754290AbXK1VKh
	(ORCPT <rfc822;git-outgoing>); Wed, 28 Nov 2007 16:10:37 -0500
Received: from nz-out-0506.google.com ([64.233.162.233]:22451 "EHLO
	nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753560AbXK1VKg (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Nov 2007 16:10:36 -0500
Received: by nz-out-0506.google.com with SMTP id s18so1222641nze
        for <git@vger.kernel.org>; Wed, 28 Nov 2007 13:10:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=fdrbH+PEliwbWGibSZYDM9oSRxMj7+/JCkeqJEK4ipo=;
        b=pnTa+qrKCLo/vzYbaDfXlF5ktFzYzQWlnNyr769I//WYJpJDxM08jGmBBgpHnysMlZ+QhNWfjGXPiueL0L4d5ez8e169Bn8dEbdeAyWjmsrQP5erpwT9nRvttmISEjWweFQmFeqBU301JFCOwtCpRUS6OLSpkYT2q5nqomfUQyU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=tbTvOxaKDJpuDjfkDyWUBJPJH/oHD2NVlY/GwmpxXR1NlxsOsEIGEnxZp6RHO21NWCPzQkqysYjoWQWLbBgzmI1zaAODlVZBZuqJEY4KpCRZ0Qzscz3Fe5AV/oeJb1twapxHDHX+L7FLF+7M3kjM3llBxO0LanyymAw96UHJfVs=
Received: by 10.114.93.17 with SMTP id q17mr266394wab.1196284234432;
        Wed, 28 Nov 2007 13:10:34 -0800 (PST)
Received: by 10.114.234.1 with HTTP; Wed, 28 Nov 2007 13:10:34 -0800 (PST)
In-Reply-To: <Pine.LNX.4.64.0711282039430.27959@racer.site>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/66426>

On 11/28/07, Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> On Wed, 28 Nov 2007, Steven Grimm wrote:
> > I wonder if this shouldn't be branch.<name>.pulltype or something like
> > that, so we can represent more than just "rebase or not." Values could
> > be "rebase", "merge" (the default) and maybe even "manual" to specify
> > that git-pull should neither merge nor rebase a particular branch even
> > if it matches a wildcard refspec.
>
> I am not convinced that this is a good thing... We already have
> branch.<name>.mergeOptions for proper merges, and I want to make clear
> that this is about rebase, and not about merge.

Maybe branch.<name>.pullOptions ?

--
larsh

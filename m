From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH] config: Use parseopt.
Date: Sat, 14 Feb 2009 21:14:10 +0200
Message-ID: <94a0d4530902141114s7352841cmf5c4259211a793e3@mail.gmail.com>
References: <1234577142-22965-1-git-send-email-felipe.contreras@gmail.com>
	 <7vab8pweod.fsf@gitster.siamese.dyndns.org>
	 <94a0d4530902140237o7d26ff4j1c7350d926d12c1a@mail.gmail.com>
	 <alpine.DEB.1.00.0902141230250.10279@pacific.mpi-cbg.de>
	 <94a0d4530902140415j4168d09dh8abac0d6eba0b8cf@mail.gmail.com>
	 <alpine.DEB.1.00.0902142003300.10279@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sat Feb 14 20:15:43 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LYPzI-00082G-H5
	for gcvg-git-2@gmane.org; Sat, 14 Feb 2009 20:15:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751841AbZBNTON (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 14 Feb 2009 14:14:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751628AbZBNTON
	(ORCPT <rfc822;git-outgoing>); Sat, 14 Feb 2009 14:14:13 -0500
Received: from fg-out-1718.google.com ([72.14.220.154]:38800 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751269AbZBNTOM (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 14 Feb 2009 14:14:12 -0500
Received: by fg-out-1718.google.com with SMTP id 16so70276fgg.17
        for <git@vger.kernel.org>; Sat, 14 Feb 2009 11:14:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=8u2Ba+VuZjK75O9PmNPtsouo4wcduuCd9++Lj8f+Llo=;
        b=ACHh6pEv9Mf1HDzncv4DPRVoB2iGUlvtFgp47x8O7DIxblZseP0+C5ncTQJ5TuvZce
         alF+PHmu6VAsxCkmmJe4qRmDBuwM+8QARe66h8UN5wcUiv5UnU06pmTPkqSv588qokMQ
         tRF6o4ReLYWdwJwfuB18ZSzyWx10s/S4xgIq0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=XXbWmmH3YEIbgDCf0SXp96W3Lo8IFosEbqD+rq1l/DgW1M3u3sOm7TyVwuGgsaQJpF
         YuPhq9Ow9ovkatdJwhSeCpXAAZa+cofRAU+fIlzwaNC+4inA/vS7bMs8NkBA0PC1yvIg
         qSHgqEgtdX2hS/cqYT0kyo4BQDb8vW0S+iHOY=
Received: by 10.86.51.10 with SMTP id y10mr489558fgy.9.1234638850817; Sat, 14 
	Feb 2009 11:14:10 -0800 (PST)
In-Reply-To: <alpine.DEB.1.00.0902142003300.10279@pacific.mpi-cbg.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/109895>

On Sat, Feb 14, 2009 at 9:11 PM, Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
> Hi,
>
> On Sat, 14 Feb 2009, Felipe Contreras wrote:
>
>> 1) --list when no config file is given uses all the config files,
>> wouldn't it make sense to have a --repo option?
>
> The idea of --list is not "cat .git/config".  The idea is to help users or
> scripts to list the current settings (_including_ the global settings).
>
> You can force showing the repo-specific config with "git --file
> .git/config", though.

When you are on the root directory of the repo, and you don't have
GIT_DIR, or --git-dir.

-- 
Felipe Contreras

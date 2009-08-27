From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: [PATCH v5 5/6] fast-import: add option command
Date: Thu, 27 Aug 2009 12:40:38 -0700
Message-ID: <fabb9a1e0908271240la7cefd9k8476c0ab5ffd69d8@mail.gmail.com>
References: <1251396736-928-1-git-send-email-srabbelier@gmail.com> 
	<1251396736-928-2-git-send-email-srabbelier@gmail.com> <1251396736-928-3-git-send-email-srabbelier@gmail.com> 
	<1251396736-928-4-git-send-email-srabbelier@gmail.com> <1251396736-928-5-git-send-email-srabbelier@gmail.com> 
	<alpine.LNX.2.00.0908271942090.6501@reaper.quantumfyre.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Junio C Hamano <gitster@pobox.com>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Git List <git@vger.kernel.org>,
	Ian Clatworthy <ian.clatworthy@canonical.com>,
	Matt McClure <mlm@aya.yale.edu>,
	Miklos Vajna <vmiklos@frugalware.org>
To: Julian Phillips <julian@quantumfyre.co.uk>
X-From: git-owner@vger.kernel.org Thu Aug 27 21:41:07 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MgkqI-0002S6-Ji
	for gcvg-git-2@lo.gmane.org; Thu, 27 Aug 2009 21:41:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752122AbZH0Tk6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 27 Aug 2009 15:40:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752095AbZH0Tk6
	(ORCPT <rfc822;git-outgoing>); Thu, 27 Aug 2009 15:40:58 -0400
Received: from mail-ew0-f206.google.com ([209.85.219.206]:42653 "EHLO
	mail-ew0-f206.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752025AbZH0Tk5 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 27 Aug 2009 15:40:57 -0400
Received: by ewy2 with SMTP id 2so1537636ewy.17
        for <git@vger.kernel.org>; Thu, 27 Aug 2009 12:40:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type;
        bh=6rQy4533ojE0EEENbH31FEQkZ/lRLsGwujV/k9alzg0=;
        b=rsEF5Wu9RpWNjTbdwxz4TuI/QmlaqGcbW5zWhxMqy1cbFMB/1HbfiuZ78Xry4i/p0I
         Ssy9c073Jijhd/DyzZfU/FmB9XphYve3ybUnbw8NKfjFjR2kaw1EHbaCt5txnT7+lsgr
         f2WVPXN1cfka20SeOftLifwasXat8XQSshc04=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=TVsx6Y/VGG4Ctb+y3e476e1eOAjtLBenWtdBBMKGd2rq5U5FcO+NkHVnlO93IAclUS
         1KFD8lvOeKvG3WHRhqc5KgYP4eCAqNTJ9wMqN+P5e8VascMkt1kfmNPK8LTKyyfro/E2
         y8kQzCNmEYYpLflODJ5rO3kEmf9Sndyk+tRo8=
Received: by 10.216.88.79 with SMTP id z57mr46453wee.22.1251402058123; Thu, 27 
	Aug 2009 12:40:58 -0700 (PDT)
In-Reply-To: <alpine.LNX.2.00.0908271942090.6501@reaper.quantumfyre.co.uk>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/127201>

Heya,

On Thu, Aug 27, 2009 at 11:44, Julian Phillips<julian@quantumfyre.co.uk> wrote:
> On Thu, 27 Aug 2009, Sverre Rabbelier wrote:
>> +Option commands must be the first commands on the input, to give an
>> +option command after any non-option command is an error.
>
> Er ... shouldn't that be the first thing _after_ the "feature git-options"
> command?

Correct, updated the code but not the docs. Fixed.

-- 
Cheers,

Sverre Rabbelier

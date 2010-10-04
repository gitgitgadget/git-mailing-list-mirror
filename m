From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [PATCH 4/7] setup: make sure git dir path is in a permanent buffer
Date: Mon, 4 Oct 2010 16:25:00 +0700
Message-ID: <AANLkTinmmtVCed9A0uwJ1kc-VF3J=oZKjUxM7YmCbDix@mail.gmail.com>
References: <wes62zknmki.fsf@kanis.fr> <7v1va760ip.fsf@alter.siamese.dyndns.org>
 <20100810032647.GA2386@burratino> <20101002082752.GA29638@burratino> <20101002083652.GE29638@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Lars Hjemli <hjemli@gmail.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Mon Oct 04 11:25:34 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P2hIX-0000by-0n
	for gcvg-git-2@lo.gmane.org; Mon, 04 Oct 2010 11:25:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754369Ab0JDJZW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 4 Oct 2010 05:25:22 -0400
Received: from mail-wy0-f174.google.com ([74.125.82.174]:39231 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754349Ab0JDJZV (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Oct 2010 05:25:21 -0400
Received: by wyb28 with SMTP id 28so4700245wyb.19
        for <git@vger.kernel.org>; Mon, 04 Oct 2010 02:25:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:cc:content-type;
        bh=vKlQ+zE1m/TVlEC1mfUzTS0bJjw6Jh9F331c9mwyWKI=;
        b=CyVr5U2ooaEKfb2ebOncLGcmFfh49k+Y0DGac+0OOKjiw5SHonHCU7Kz1WiljR8dFk
         6ficw7WxRIGRtVt3MHFSnqOuYZf5GO0F15ror4+MPpcdvFjGJwNEiNOVJfp3rfOp5/XL
         xRXnjrZNvGIYyTkcC1Hy/PWX5d8fEqsv8wd6I=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=ba6lRkweKoAvk2flgRD2tmuI61NiL4en8j16FbXxhszSZkB+5XYvczYm38qqga3Y00
         vdXWYMjdXIBCb64UNiLmlFMftwV5NMl1oBoiB++t50Ny4ineCbNsTG2tka47qyKkT4yW
         lIVFLf9Ul7AzkeTGaswR8O3wfR2BDZ7rsyQTE=
Received: by 10.216.71.66 with SMTP id q44mr7377047wed.44.1286184320618; Mon,
 04 Oct 2010 02:25:20 -0700 (PDT)
Received: by 10.216.153.195 with HTTP; Mon, 4 Oct 2010 02:25:00 -0700 (PDT)
In-Reply-To: <20101002083652.GE29638@burratino>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/158015>

On Sat, Oct 2, 2010 at 3:36 PM, Jonathan Nieder <jrnieder@gmail.com> wrote:
> It is not obvious whether any existing code in git will trigger the
> problem, but in any case, it is worth a few dozen bytes to copy the
> return value from make_absolute_path() for some added peace of mind.

It looks like make_absolute_path() is only used when git_dir has not
been set in stone yet. Anyway, yes yes yes! I don't want to pull my
hair when I find out this bug hits me.
-- 
Duy

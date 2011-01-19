From: Tuncer Ayaz <tuncer.ayaz@gmail.com>
Subject: Re: filter-branch --env-filter GIT_AUTHOR_DATE
Date: Wed, 19 Jan 2011 11:12:12 +0100
Message-ID: <AANLkTik43suRRzcPdBZMKifxKx8cwi01H+zGvj5nnvWa@mail.gmail.com>
References: <AANLkTinx7cs6YTvSTTv-njHA+vk264u1EaJettSdBF9U@mail.gmail.com>
 <4D368C49.3080105@viscovery.net> <AANLkTi=TAhYeWbyocag2myBXA2TfH7_r=hmam51YKbhm@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Wed Jan 19 11:12:58 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PfV2A-0001k0-1B
	for gcvg-git-2@lo.gmane.org; Wed, 19 Jan 2011 11:12:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753868Ab1ASKMx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Jan 2011 05:12:53 -0500
Received: from mail-px0-f174.google.com ([209.85.212.174]:42148 "EHLO
	mail-px0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753824Ab1ASKMx (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Jan 2011 05:12:53 -0500
Received: by pxi15 with SMTP id 15so113483pxi.19
        for <git@vger.kernel.org>; Wed, 19 Jan 2011 02:12:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type;
        bh=vkvbx5CrbgpVcIUV1IbaZgzuXHHVn3DOY2Oarq/CS5Q=;
        b=vHMGjU7s6YK5GHzFWSbL3SrVsHAyusfYI7ZiImfqGZrR27RUu/9RPuK8om17BnqLwG
         V02yCadFpMffq4SOQMuNF57M0vMNCdGClV+Zc977izqzv86bbwGU+3vvOAbliQPSrDg7
         qKS7aJNVl98B+VFSUt25tpcz+WsuDiC7lZIGE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=En4eSgvCQkm8hyX4ccUlb7/qLC2EM/CYrFKqzZkjls0mmlLUKqhKkhhdp3RW6GEty7
         WAy5d+OsXOrq+IIb7PWNvKb8FiVIygM0JWqaH5/BmXnb7cazw/0p/fRBrhBwZPMCVUOl
         jg+XIFP9A6RuYsca+B3/PXkcisp/vBm+oC93s=
Received: by 10.142.53.11 with SMTP id b11mr427855wfa.250.1295431972739; Wed,
 19 Jan 2011 02:12:52 -0800 (PST)
Received: by 10.142.76.11 with HTTP; Wed, 19 Jan 2011 02:12:12 -0800 (PST)
In-Reply-To: <AANLkTi=TAhYeWbyocag2myBXA2TfH7_r=hmam51YKbhm@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/165256>

On Wed, Jan 19, 2011 at 11:08 AM, Tuncer Ayaz wrote:
> git cat-file $REV

To be correct:
git cat-file -p $REV

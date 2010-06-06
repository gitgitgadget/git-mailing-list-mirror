From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: Installing on AIX fails
Date: Sun, 6 Jun 2010 22:29:40 +0000
Message-ID: <AANLkTik6QJhQpy8-W0dNDLd8HPgvVFkImKl_4Dm-2phR@mail.gmail.com>
References: <AANLkTinKjEBkn-9ajO4QXyHqY0EOQBGPRgNREaC_p_vQ@mail.gmail.com>
	<m3631xr9bm.fsf@localhost.localdomain>
	<AANLkTikbAShMuOvFra8bLT2PmU7s_iUQhr4RY7oD3LLa@mail.gmail.com>
	<201006070026.20363.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Dario Rodriguez <soft.d4rio@gmail.com>,
	Tor Arntsen <tor@spacetec.no>, git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jun 07 00:29:49 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OLOLj-0004x1-19
	for gcvg-git-2@lo.gmane.org; Mon, 07 Jun 2010 00:29:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751518Ab0FFW3m (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 6 Jun 2010 18:29:42 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:48237 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751395Ab0FFW3l (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 6 Jun 2010 18:29:41 -0400
Received: by iwn37 with SMTP id 37so2758701iwn.19
        for <git@vger.kernel.org>; Sun, 06 Jun 2010 15:29:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type;
        bh=m+JKMZYimIFPyP38CxWxgYDobawmqctUEGjbkeDbDVM=;
        b=MWiTpCfhHDGOag+93tZb4bl/PjiOyWc1zZpzOByWvqL007By4/u7sy+tcw5Qjze4eR
         aQ5CVJXFRag7A4WQckaDpvY4C37IqFD7FRU/LLPH7FcgZy/ZVmeREtVdhBe35DIUSvkx
         UuT7+M1Kb92inzk2hWsEn7LUu4oeTHJcbxpNI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=J4O7AXrtGWytYy5OjvcoHWUbnp35bsnVcAHNXTgrEMrofI1yvPK0wajB8OQozNqZaE
         7cemmJVNHECnXzg0OmOZ9w4FyPS+bnXXXC/BWs5alEnme7UCeXMm91jC0RNBfdvrbvAr
         RXCXSAfJIRQ3mV6rf3dhMtcSbK8geh58WCcLs=
Received: by 10.231.124.40 with SMTP id s40mr3727314ibr.172.1275863381007; 
	Sun, 06 Jun 2010 15:29:41 -0700 (PDT)
Received: by 10.231.171.145 with HTTP; Sun, 6 Jun 2010 15:29:40 -0700 (PDT)
In-Reply-To: <201006070026.20363.jnareb@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/148558>

On Sun, Jun 6, 2010 at 22:26, Jakub Narebski <jnareb@gmail.com> wrote:
> So I guess we should also prefer install program for speed, even if we
> do not use ./configure script.

Is the time it takes to run install, whether it's a shell script or C
program, really an issue?

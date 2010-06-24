From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH 5/9] Add string-specific memory pool
Date: Thu, 24 Jun 2010 21:19:47 +0200
Message-ID: <AANLkTinqW1l3zmyrwtgmyueVaOKqYxyvC8r9SGXZ_O4E@mail.gmail.com>
References: <20100624105004.GA12336@burratino> <20100624105813.GE12376@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org, David Michael Barr <david.barr@cordelta.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Daniel Shahaf <d.s@daniel.shahaf.name>,
	Eric Wong <normalperson@yhbt.net>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jun 24 21:20:51 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ORryg-0007WV-14
	for gcvg-git-2@lo.gmane.org; Thu, 24 Jun 2010 21:20:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755075Ab0FXTUK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 Jun 2010 15:20:10 -0400
Received: from mail-gy0-f174.google.com ([209.85.160.174]:53676 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751204Ab0FXTUI (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Jun 2010 15:20:08 -0400
Received: by gye5 with SMTP id 5so4607527gye.19
        for <git@vger.kernel.org>; Thu, 24 Jun 2010 12:20:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:cc:content-type;
        bh=JJ0D0nJ2CTZcCASlizvz45L1jFasxEIfeJPsl1KmpKI=;
        b=RltosVQ87q/Bzg9nkrZsHSuRvUlmVwKIRK8VFyNtdWDaeTgOj5GZat6Z+b04J+fG1v
         bphzI31IZluiP9sQn4py0YxgEftS1HL5KkpIamycnLrmJYhSGkpXEvkh9IYUgfSFNTAB
         sy2LMf2NFmKsNvTlkel+1ulj1lVv452bR2lA4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=if1V8d4BnSDssaU5mpnNlrhxM9hVeENITZx8z1il/VYOlbG1ByFV1FbnEoxThKtSDs
         qjkkidKzYuLqzmKLFXgeecA4d7OkpKUWO9FVFmiHn41FZZt1eURS+aFnwyrTFYfRpK8O
         H4vxQ+upkxMVsI299FFQtFDTMpVjneZdWi6mo=
Received: by 10.229.237.149 with SMTP id ko21mr5966969qcb.45.1277407207206; 
	Thu, 24 Jun 2010 12:20:07 -0700 (PDT)
Received: by 10.229.45.71 with HTTP; Thu, 24 Jun 2010 12:19:47 -0700 (PDT)
In-Reply-To: <20100624105813.GE12376@burratino>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/149623>

Hi,

Jonathan Nieder wrote:
> Intern strings so they can be compared by address and stored without
> wasting space.

It's unlikely that this'll change much, if at all. It should go in
without any issues. I'm not sure this is appropriate since I've
already signed off, but anyway:
Reviewed-by: Ramkumar Ramachandra <artagnon@gmail.com>

-- Ram

From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: t7400 broken on pu (Mac OS X)
Date: Fri, 11 Jan 2013 18:03:47 +0700
Message-ID: <CACsJy8C4GQVQzwP3K1N_vP25MHkaJ4-oAbwrpfqEsqKHO4UXsQ@mail.gmail.com>
References: <50EDBA37.30205@web.de> <20130110062838.GA11634@duynguyen-vnpc.dek-tpc.internal>
 <7v38y83ooo.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: =?UTF-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jan 11 12:04:39 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TtcPe-00009d-JF
	for gcvg-git-2@plane.gmane.org; Fri, 11 Jan 2013 12:04:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754863Ab3AKLES (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 11 Jan 2013 06:04:18 -0500
Received: from mail-ob0-f172.google.com ([209.85.214.172]:43797 "EHLO
	mail-ob0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754394Ab3AKLER (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Jan 2013 06:04:17 -0500
Received: by mail-ob0-f172.google.com with SMTP id za17so1603180obc.17
        for <git@vger.kernel.org>; Fri, 11 Jan 2013 03:04:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=Im1qz5NZJKw2qK1g/i2qToHBwmWTO1ZDTH+o0AnqH1k=;
        b=Ky6zLYif1D0h7omgqYaaDEx5xYeo5IeQQCPWoZD3aSxt60y8n6Ou0X4t8NbAvxsDx6
         zwzeurV469YRTJ0n7NXaRu4zGcyuSA8EPzXBTpHjTbquWM7Mmo1rLYemYrqs1OrA8vT3
         UXVWG/oeSSVFf8nVMA9LWOAOHq0fgQLBoKSdIwcVfLhxhvI136eTLmGUYI/m/CVsliIS
         fMbPlWydmpj3WIRjBwgqaZpQCgF+43t0mYjFXuBHyjyFC+RCpJVuyIHoqR4B293OUNxa
         G3HV6CgMB4tKFb2nCIxmBXpEh4LxH1L6BFAuL4VXIrNxRAbnVf+DtNW16X45eAiv017d
         et7w==
Received: by 10.182.18.133 with SMTP id w5mr55453733obd.64.1357902257294; Fri,
 11 Jan 2013 03:04:17 -0800 (PST)
Received: by 10.182.153.69 with HTTP; Fri, 11 Jan 2013 03:03:47 -0800 (PST)
In-Reply-To: <7v38y83ooo.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/213189>

On Fri, Jan 11, 2013 at 12:58 AM, Junio C Hamano <gitster@pobox.com> wrote:
> I can see why it is wrong to let pathspec.raw be rewritten without
> making matching change to the containing pathspec, but I find it
> strange why it matters only on case-insensitive codepath.

Yeah, I don't get it either. I can see that core.ignorecase exercises
some more code, but still fail to see the link. I should get to the
bottom of this and write some tests to for core.ignorecase-only code.
-- 
Duy

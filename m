From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [PATCH 0/9] magic pathspec updates
Date: Tue, 10 May 2011 20:47:04 +0700
Message-ID: <BANLkTimLsNU0rLHRxxPmzFH_-1U5m3GoCw@mail.gmail.com>
References: <1304852906-29272-1-git-send-email-pclouds@gmail.com> <1305006678-4051-1-git-send-email-gitster@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue May 10 15:47:48 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QJnHv-0000D9-Dv
	for gcvg-git-2@lo.gmane.org; Tue, 10 May 2011 15:47:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932329Ab1EJNrh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 May 2011 09:47:37 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:36915 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932315Ab1EJNrf (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 May 2011 09:47:35 -0400
Received: by fxm17 with SMTP id 17so4315217fxm.19
        for <git@vger.kernel.org>; Tue, 10 May 2011 06:47:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type;
        bh=qlgpwObI6khAFrUdZ6qUHfYIQhLVWohOpISFG7DRioY=;
        b=s8tmsF7h1RaevpjWSddxzEnmedZ0jYl/JT7QYaHE+FKeK902JTzWqdUppq/p7Yj7W6
         P2bqV0Q2Y9cFYPJietG3P7lUNLP7Em0NIf2vCHfbefRuf1Hh+AeVuSaqRJxt6kimuBgf
         XbJuA7Qmxl39qgz/tOAnxtgcdY786s54GhcoE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=mldyhbbUzZF913vYuN//D3oAEavtil7ztfBjfE9aZpiqjmNzlpziXGAFSkEdbGMMU0
         3HXyqalo9uKiCuIp9qYvlOIi1tMAjQEGPEeJEt/k5FhZOsrRvxRVaSVlhJX+Qeg9YyRx
         /FAve/S4mXXScQ1joGz6IcntRZjCLhk3YKQVQ=
Received: by 10.223.98.141 with SMTP id q13mr270361fan.96.1305035254412; Tue,
 10 May 2011 06:47:34 -0700 (PDT)
Received: by 10.223.126.145 with HTTP; Tue, 10 May 2011 06:47:04 -0700 (PDT)
In-Reply-To: <1305006678-4051-1-git-send-email-gitster@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/173336>

On Tue, May 10, 2011 at 12:51 PM, Junio C Hamano <gitster@pobox.com> wrote:
> This is a series to update the magic pathspec topic, primarily the area
> around the empty ':' pathspec.

I think you missed git-commit and git-reset. "git commit --include :"
may get past parse_and_validate_options() (ie. not dying) but later on
in prepare_index(), there's no pathspec. I did not check very careful
though.

> Other than that, I think the current code is probably more or less safe to
> dogfood with known rough edges.

Agreed.
-- 
Duy

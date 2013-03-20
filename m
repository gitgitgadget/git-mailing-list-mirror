From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH v1 39/45] parse_pathspec: make sure the prefix part is wildcard-free
Date: Wed, 20 Mar 2013 08:32:00 +0700
Message-ID: <CACsJy8DjrB45kDRiOs9b=VS5Z5=_sdh37Z3Q20sT6iDacLmM+Q@mail.gmail.com>
References: <1363327620-29017-1-git-send-email-pclouds@gmail.com>
 <1363327620-29017-40-git-send-email-pclouds@gmail.com> <7vli9ji6gu.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Mar 20 02:33:00 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UI7tj-0003TQ-2k
	for gcvg-git-2@plane.gmane.org; Wed, 20 Mar 2013 02:32:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754888Ab3CTBcc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Mar 2013 21:32:32 -0400
Received: from mail-ob0-f173.google.com ([209.85.214.173]:44943 "EHLO
	mail-ob0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753258Ab3CTBcb (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Mar 2013 21:32:31 -0400
Received: by mail-ob0-f173.google.com with SMTP id dn14so1144025obc.18
        for <git@vger.kernel.org>; Tue, 19 Mar 2013 18:32:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=MrDFl4mSGwIsYCuWSyAFx+G9XtwEgsT+188o7Mb+v0U=;
        b=fMw36/eMg2dYyaL3lyVAnJtlpOu2m6/GihfAjUSueImF1t8DzpEBhxIaOQAswRcJnz
         jay2or0MMTa1ibN3Q8GTq14iYqF99P91XvynMl1cjUQlwCSEWxMcWQsE/I+ALEOjlj/+
         dGOD4PuA6do1wuKHh7OTTATvuj9hkJfWLH7DCy8jL5HL5IfTtRXk2BeZyQ1iONkC4+YU
         L2H5FVmbtmsmEhHypd6OkkAH5v3aO5F4lDldn6UYMdiUJzSDHDzKqTaH+mR1wDK5AY5N
         CRgBTcVsiGPfHXEywksZ60n+5+MVw7w1KHfNeHe2Au7QeNacEECaOG5qPMgnR5EzPIYN
         wJdw==
X-Received: by 10.182.147.2 with SMTP id tg2mr2949929obb.47.1363743150837;
 Tue, 19 Mar 2013 18:32:30 -0700 (PDT)
Received: by 10.76.27.200 with HTTP; Tue, 19 Mar 2013 18:32:00 -0700 (PDT)
In-Reply-To: <7vli9ji6gu.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/218569>

On Wed, Mar 20, 2013 at 1:34 AM, Junio C Hamano <gitster@pobox.com> wrote:
> This seems to break t7300-clean.sh #8

Repeatedly? I saw some t7300-clean.sh failures when running tests in
parallel, but never been able to reproduce it alone.
-- 
Duy

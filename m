From: Andy Parkins <andyparkins@gmail.com>
Subject: Re: User-wide ignore list
Date: Thu, 15 Feb 2007 11:12:04 +0000
Message-ID: <200702151112.06729.andyparkins@gmail.com>
References: <vpq4ppnvi1j.fsf@olympe.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Matthieu Moy <Matthieu.Moy@imag.fr>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Feb 15 12:12:20 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HHeXB-0001AU-32
	for gcvg-git@gmane.org; Thu, 15 Feb 2007 12:12:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965638AbXBOLMN (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 15 Feb 2007 06:12:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965640AbXBOLMN
	(ORCPT <rfc822;git-outgoing>); Thu, 15 Feb 2007 06:12:13 -0500
Received: from ug-out-1314.google.com ([66.249.92.170]:9597 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965638AbXBOLMM (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Feb 2007 06:12:12 -0500
Received: by ug-out-1314.google.com with SMTP id 44so114395uga
        for <git@vger.kernel.org>; Thu, 15 Feb 2007 03:12:11 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=BaWqB9IaG9dRwk5Tav+7CPiaycnq/6rHGlZ8JtbRLHoQqbn5KFQvhHlN92oVZIJ3BPyHsBS7h50YQFbc/xzlam79GlSDlOdgeQmntfFxYwqqJuDpOqEfPjgfLI667F+ON+vwAlZNe5BWkOmxQLvIflICCSzcAbObaRotVZxiIoo=
Received: by 10.66.252.4 with SMTP id z4mr1534084ugh.1171537931013;
        Thu, 15 Feb 2007 03:12:11 -0800 (PST)
Received: from 360run094l ( [194.70.53.227])
        by mx.google.com with ESMTP id s1sm2011550uge.2007.02.15.03.12.08;
        Thu, 15 Feb 2007 03:12:08 -0800 (PST)
User-Agent: KMail/1.9.5
In-Reply-To: <vpq4ppnvi1j.fsf@olympe.imag.fr>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/39817>

On Thursday 2007 February 15 10:20, Matthieu Moy wrote:

> Is there a way to have a per-user ignore list in git?

Yep; in repository-layout.txt it says:

info/exclude::
    This file, by convention among Porcelains, stores the
    exclude pattern list. `.gitignore` is the per-directory
    ignore file.  `git status`, `git add`, `git rm` and `git
    clean` look at it but the core git commands do not look
    at it.  See also: gitlink:git-ls-files[1] `--exclude-from`
    and `--exclude-per-directory`.


Andy
-- 
Dr Andy Parkins, M Eng (hons), MIEE
andyparkins@gmail.com

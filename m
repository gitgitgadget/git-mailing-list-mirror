From: "Dmitry Potapov" <dpotapov@gmail.com>
Subject: Re: How to rewrite author history
Date: Fri, 21 Mar 2008 21:40:55 +0300
Message-ID: <37fcd2780803211140h7308d868t1555e0fc1f2716fc@mail.gmail.com>
References: <216e54900803210938q4981b5d1t535af419f5b15ad8@mail.gmail.com>
	 <216e54900803210941i7fe345c2va850fa3ded8eabc8@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Andrew Arnott" <andrewarnott@gmail.com>
X-From: git-owner@vger.kernel.org Fri Mar 21 19:42:45 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JcmC8-00018B-9M
	for gcvg-git-2@gmane.org; Fri, 21 Mar 2008 19:42:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758768AbYCUSlB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 21 Mar 2008 14:41:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755928AbYCUSlB
	(ORCPT <rfc822;git-outgoing>); Fri, 21 Mar 2008 14:41:01 -0400
Received: from el-out-1112.google.com ([209.85.162.181]:18330 "EHLO
	el-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753186AbYCUSlA (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 Mar 2008 14:41:00 -0400
Received: by el-out-1112.google.com with SMTP id v27so1111316ele.17
        for <git@vger.kernel.org>; Fri, 21 Mar 2008 11:40:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=lB6UKXnJdFP9pgwvgyg3wmZWyGP1FOwdakb+nHVybwQ=;
        b=Lnf6loBoQX9mQ0KVBRISShd0B1YCIFuX2sjzQsL8b7Uj6YOMWiaJRTJ+NRvaOEN2YrBf21vFuCdIrcpN8aj4y/XDggJCMn5/5RgWTFX3S8r0lf1+zR17FEk3QgDi0yLgL/LUvtCbhN8IDYkibkOWBP9X5PuBfOoTFNZjP4H0wJQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=EDMlJGo6kFfd4Rl++dWkOo2IFxJ8k/fB6K2qAMRiKV53osvAyYNLSlhjSnx3Skxv2Sd+ZBtDRAwIzJOvO+EvXW1KDRbKbMhq4M/13355+dBIbLeEcFvysS2XjxstrsqKySNpYm6CW6iWo7YGUTFqj8e0GM60jz68scyLpVzVcXU=
Received: by 10.143.8.10 with SMTP id l10mr2596013wfi.181.1206124855824;
        Fri, 21 Mar 2008 11:40:55 -0700 (PDT)
Received: by 10.142.81.18 with HTTP; Fri, 21 Mar 2008 11:40:55 -0700 (PDT)
In-Reply-To: <216e54900803210941i7fe345c2va850fa3ded8eabc8@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/77756>

On Fri, Mar 21, 2008 at 7:41 PM, Andrew Arnott <andrewarnott@gmail.com> wrote:
> I imported my git repo from an SVN repo, and the authors have
>  email@SOME-GUID for their email address rather than their actual one
>  (probably courtesy of Google Code hosting).  Rewriting history and
>  changing all the commit hashes isn't a problem at this point in
>  development, so how can I do a massive search-and-replace to replace
>  several specific author emails with the valid ones?

Please, take a look at man git-filter-branch. I believe you can do
that using env-filter,
but I have never used this filter myself.

Dmitry

From: Michael Witten <mfwitten@gmail.com>
Subject: Re: Why Git is so fast (was: Re: Eric Sink's blog - notes on git, 
	dscms and a "whole product" approach)
Date: Thu, 30 Apr 2009 07:56:35 -0500
Message-ID: <b4087cc50904300556s359c91dfu444fa40ea85bd66e@mail.gmail.com>
References: <46a038f90904270155i6c802fceoffc73eb5ab57130e@mail.gmail.com>
	 <m3ocugod96.fsf@localhost.localdomain>
	 <m3fxfqnxn5.fsf_-_@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Martin Langhoff <martin.langhoff@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Thu Apr 30 14:56:45 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LzVoi-00066B-UI
	for gcvg-git-2@gmane.org; Thu, 30 Apr 2009 14:56:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757103AbZD3M4h (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 30 Apr 2009 08:56:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755541AbZD3M4h
	(ORCPT <rfc822;git-outgoing>); Thu, 30 Apr 2009 08:56:37 -0400
Received: from mail-qy0-f196.google.com ([209.85.221.196]:60852 "EHLO
	mail-qy0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754000AbZD3M4g (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 30 Apr 2009 08:56:36 -0400
Received: by qyk34 with SMTP id 34so2278063qyk.33
        for <git@vger.kernel.org>; Thu, 30 Apr 2009 05:56:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=yzxRP+oNzq99QChXlIOV4ZG//9+dH4bcxv1+kgihLpE=;
        b=KqPCIwPi8lwocZIT1SaoAnZFSQIfKczGCJrSh4WWMjsYVJn2eVu2AiXskrUi7bW71V
         NBSF7rGMI1BKBJuye52ZNmCMfS5Yq5A5/1N62XkcgKJj7G5RB7+ionfodfm2xltBitwN
         B7cJk+ADRl3AuD5fxurSYnkkm7rUnpW8bGEh4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=nrP/ZFnM21gDV/CZpkUFZ+g5izKueSHblO5hcl/eEmmvDwT08iW9wKKZpMc0FtDdox
         1Uf95kmfqTfOjk4vHnKuSSKhQjpkp0j9oarJvf6lNlSIOMyfsI/aefLqu8xyAedYAaeF
         sOdeJMg1rUPCPg+YO9niXd8aPlJpyUC2R0sTw=
Received: by 10.224.11.17 with SMTP id r17mr1740931qar.183.1241096195225; Thu, 
	30 Apr 2009 05:56:35 -0700 (PDT)
In-Reply-To: <m3fxfqnxn5.fsf_-_@localhost.localdomain>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/118016>

On Thu, Apr 30, 2009 at 07:17, Jakub Narebski <jnareb@gmail.com> wrote:
> I hope that JGit developers can
> tell us whether using higher level language affects performance, how
> much, and what features of higher-level language are causing decrease
> in performance.

Java is definitely higher than C, but you can do some pretty low-level
operations on bits and bytes and the like, not to mention the presence
of a JIT.

My point: I don't think that Java can tell us anything special in this regard.

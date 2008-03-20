From: "Elijah Newren" <newren@gmail.com>
Subject: Re: How to undo git-rm?
Date: Wed, 19 Mar 2008 20:53:34 -0600
Message-ID: <51419b2c0803191953y7842ddf8l7a6de37226cb12e2@mail.gmail.com>
References: <20080318230441.GA664@arctrix.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Neil Schemenauer" <nas@arctrix.com>
X-From: git-owner@vger.kernel.org Thu Mar 20 03:54:20 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JcAv3-0008SW-Jq
	for gcvg-git-2@gmane.org; Thu, 20 Mar 2008 03:54:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752727AbYCTCxh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Mar 2008 22:53:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752824AbYCTCxh
	(ORCPT <rfc822;git-outgoing>); Wed, 19 Mar 2008 22:53:37 -0400
Received: from wa-out-1112.google.com ([209.85.146.179]:30339 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752312AbYCTCxf (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Mar 2008 22:53:35 -0400
Received: by wa-out-1112.google.com with SMTP id v27so778252wah.23
        for <git@vger.kernel.org>; Wed, 19 Mar 2008 19:53:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=WmbPCkZSOaA76b+S8s5CFmDsUCfaZC7ZvYqkWuweVBo=;
        b=RQ5yXgeItTvayCqjh5PxO2VsLb2KhvygN1C4E8tV2Ob8W6mOEM/H/hW5iDqf3yPciPJNlLt1+kAhRr+FAw2R9EzaEiNLRWhzpiwcdah6K0u2H2abE/QOSppQcJfB5MzBQO34U1qVwb6l+iLV53/9kYroAgt1gQrRJQepuAUde6E=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=fJU1Vvlg3ZJg2obDp9RPdS+R8GeSbaTsdyJqIzBttEfJbwa0ARgLhGEXPbtkOMnXyjQKTNak/d2X3ehrZd9RTqSFvQ+pL2iIjERHI7bWeHSaGHvkTQGi/aAUJgFGkIroZm8S90ZkYMWr1HWW+JhulEy2bpkAV0bM+LQ4Cb/KAhs=
Received: by 10.114.106.1 with SMTP id e1mr2612710wac.95.1205981614895;
        Wed, 19 Mar 2008 19:53:34 -0700 (PDT)
Received: by 10.114.205.19 with HTTP; Wed, 19 Mar 2008 19:53:34 -0700 (PDT)
In-Reply-To: <20080318230441.GA664@arctrix.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/77616>

On Tue, Mar 18, 2008 at 5:04 PM, Neil Schemenauer <nas@arctrix.com> wrote:
> Hi,
>
>  This seemingly simple operation has me stumped.  I removed something
>  from my try using "git rm" and now I want it back.  With SVN I would
>  use "svn cat <path> > <path>".  After some searching around, I
>  though git-cat-file would do the trick.  Alas, it appears as though
>  it looks up the SHA for the path in the index and so it too fails.

Try
  git checkout HEAD eg
or
  git show HEAD:<path> > <path>

From: "Thomas Adam" <thomas.adam22@gmail.com>
Subject: Re: Adding custom hooks to a bare repository.
Date: Mon, 28 Jul 2008 13:32:19 +0100
Message-ID: <18071eea0807280532l69d12e3ehb8377da9d24e035@mail.gmail.com>
References: <18071eea0807280404w3365748cjcd11f536bf5d27eb@mail.gmail.com>
	 <alpine.DEB.1.00.0807281324350.2725@eeepc-johanness>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "git mailing list" <git@vger.kernel.org>
To: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon Jul 28 14:33:25 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KNRui-0007qz-Q3
	for gcvg-git-2@gmane.org; Mon, 28 Jul 2008 14:33:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751032AbYG1McU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Jul 2008 08:32:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751012AbYG1McU
	(ORCPT <rfc822;git-outgoing>); Mon, 28 Jul 2008 08:32:20 -0400
Received: from wf-out-1314.google.com ([209.85.200.174]:11132 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750838AbYG1McT (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Jul 2008 08:32:19 -0400
Received: by wf-out-1314.google.com with SMTP id 27so5707408wfd.4
        for <git@vger.kernel.org>; Mon, 28 Jul 2008 05:32:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=Zj/F8XEZ6ZNVlxztgXegB6ME78upZvV/2j1VFZvUseo=;
        b=xCnz+0sPFwHqAaCvS2XEgNkJZnyVV2VpZqn7jH/OY2W6vjhnMw1RuFTYoKpZImHOMX
         1d0v3vibpcPy3mRbewvPu3Inyq9y3bsv7H1chxh54Kgz6GVGKAF15fqfAjabq11N+sqN
         T3fvmbzdk/z3gxivF4armMMqilJUufv1d8XbA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=AZzLOPfpO9c9KruUhx7xfmffA9AGkbtUvxI5WdJ5GaQXCgJ0rKIU6dTxBwS9viDoGJ
         ehspiH89Bo+QKv69mjF9Qz/HWVY5oVWg3er3AvLkM4yRi5Z2wkkZuuNq3VRT8E6D6+LZ
         0lKbxHAEEoaFMnCXGNPvxaxkDLZQyKWVOkwq8=
Received: by 10.142.78.10 with SMTP id a10mr1584253wfb.37.1217248339172;
        Mon, 28 Jul 2008 05:32:19 -0700 (PDT)
Received: by 10.142.104.15 with HTTP; Mon, 28 Jul 2008 05:32:19 -0700 (PDT)
In-Reply-To: <alpine.DEB.1.00.0807281324350.2725@eeepc-johanness>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/90450>

2008/7/28 Johannes Schindelin <Johannes.Schindelin@gmx.de>:
> Yes.  Hooks, just as the config and reflogs, are supposed to be local
> things.  Rationale being: it is rude, and also insecure, to install
> something that potentially calls other programs without the user saying
> so.

Oh absolutely, I agree with that.

> All you can do is checking in a copy of the hook, and ask your users/check
> in your build system that it is installed.

Hmm -- perhaps I am being unintentionally dense, but I am assuming
that when you say "checking in a copy" you mean anywhere other than
.git/hooks/ since that isn't tracked by git.  I have no problem with
the rationale you've just described -- but it would be handy to add
this post-merge hook script into hooks/ (exec bit removed) such that
on a clone, all one would need to do is chmod +x it.   If that's
possible, I'm clearly missing the steps to enable this.

Thanks,

-- Thomas Adam

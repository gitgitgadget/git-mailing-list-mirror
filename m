From: Justin Spahr-Summers <justin.spahrsummers@gmail.com>
Subject: Re: Bug: Recursive submodules fail when the repo path contains
 spaces
Date: Sat, 28 Jul 2012 10:53:45 -0700
Message-ID: <AE66EC4E32FD431287B84B3A0DBEEE3B@gmail.com>
References: <1CE02EC2D88646D48EE7B7D71AD36234@gmail.com>
 <500F00C7.4040209@web.de> <7va9yogb37.fsf@alter.siamese.dyndns.org>
 <9ADC1C4EF43A4237BC7971884C50C0EB@gmail.com>
 <20120728162132.GC98893@book.hvoigt.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Heiko Voigt <hvoigt@hvoigt.net>
X-From: git-owner@vger.kernel.org Sat Jul 28 19:54:31 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SvBDf-00076K-HT
	for gcvg-git-2@plane.gmane.org; Sat, 28 Jul 2012 19:54:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752954Ab2G1Rxs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 28 Jul 2012 13:53:48 -0400
Received: from mail-pb0-f46.google.com ([209.85.160.46]:54540 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752933Ab2G1Rxr (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 28 Jul 2012 13:53:47 -0400
Received: by pbbrp8 with SMTP id rp8so7059888pbb.19
        for <git@vger.kernel.org>; Sat, 28 Jul 2012 10:53:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:message-id:in-reply-to:references:subject:x-mailer
         :mime-version:content-type:content-transfer-encoding
         :content-disposition;
        bh=5bJLGSSd10Nnv7yqvYCPpMEy8mzlEBmci5gaYXLX3wk=;
        b=oIoRzNkyCDQWAOwgEHVLGR/jlqOysCahgnFGBxeHezKuWI2dssrhoBEmOZRYeAGQpQ
         xXa5FGXv8ZuDvCRIwesbDo/2VWLBR4BiJUcjBxLOg6Do4mgCM1IDd/v3F+XvUJNoSEiQ
         QKnPBAnCJpJFdeg5h2PP0TX5dG56ZNhGkNbqrkhdJGD7xJxhhpBjAEyMNjvksLKv0sdV
         qczA8M1Q74CLrT+VQsEvT8fHMTFPEusO3Syxzb6jU9b+anV1ZSWLAtWPoZlalWQOiBmO
         foO1GPYbOke8nYTdd/VDNNAPRP82KQd8llCn7eAw1G482WKyYjVUDiPFopAbW8hUTr4m
         38TQ==
Received: by 10.68.220.163 with SMTP id px3mr23007973pbc.167.1343498027259;
        Sat, 28 Jul 2012 10:53:47 -0700 (PDT)
Received: from [10.168.1.100] (c-24-16-145-254.hsd1.wa.comcast.net. [24.16.145.254])
        by mx.google.com with ESMTPS id wf7sm4328182pbc.34.2012.07.28.10.53.45
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sat, 28 Jul 2012 10:53:46 -0700 (PDT)
In-Reply-To: <20120728162132.GC98893@book.hvoigt.net>
X-Mailer: sparrow 1.6.2 (build 1143.6)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/202449>

On Saturday, 28. July 2012 at 09:21, Heiko Voigt wrote:
> On Tue, Jul 24, 2012 at 01:33:44PM -0700, Justin Spahr-Summers wrote:
> > Here's some real output, with a couple specific names removed, starting from the root of the top-level repository (where External/twui is a submodule):
> > 
> > $ cd External/twui
> > $ git submodule add git://github.com/petejkim/expecta.git (http://github.com/petejkim/expecta.git) TwUITests/expecta
> > Cloning into 'TwUITests/expecta'...
> > remote: Counting objects: 988, done.
> > remote: Compressing objects: 100% (404/404), done.
> > remote: Total 988 (delta 680), reused 842 (delta 535)
> > Receiving objects: 100% (988/988), 156.30 KiB, done.
> > Resolving deltas: 100% (680/680), done.
> > fatal: Not a git repository: ../../../../../../../../Volumes/drive name with spaces/Users/justin/Documents/Programming/project name with spaces/.git/modules/External/twui/modules/TwUITests/expecta
> 
> 
> 
> Is this a copy&paste artefact or is the path in the error truncated? 
There's apparently some weird wrapping from my email client (the git error is on a single line in the terminal), but there is no truncation. That's the full path. Thanks for clarifying, though.

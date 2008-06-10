From: "Sverre Rabbelier" <alturin@gmail.com>
Subject: Re: [PATCH - stgit] Patch to allow import of compressed files
Date: Tue, 10 Jun 2008 10:07:25 +0200
Message-ID: <bd6139dc0806100107y415a292eqe22af7a7b2215e65@mail.gmail.com>
References: <484D78BF.6030504@gmail.com>
	 <20080610063328.GB26965@diana.vm.bytemark.co.uk>
	 <alpine.DEB.1.10.0806092335420.17180@swallowtail>
Reply-To: sverre@rabbelier.nl
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "=?ISO-8859-1?Q?Karl_Hasselstr=F6m?=" <kha@treskal.com>,
	"Clark Williams" <clark.williams@gmail.com>,
	"Catalin Marinas" <catalin.marinas@gmail.com>, git@vger.kernel.org
To: "Asheesh Laroia" <asheesh@asheesh.org>
X-From: git-owner@vger.kernel.org Tue Jun 10 10:08:55 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K5yu1-0003uw-Gg
	for gcvg-git-2@gmane.org; Tue, 10 Jun 2008 10:08:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753086AbYFJIH3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Jun 2008 04:07:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753098AbYFJIH3
	(ORCPT <rfc822;git-outgoing>); Tue, 10 Jun 2008 04:07:29 -0400
Received: from wf-out-1314.google.com ([209.85.200.171]:11883 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753031AbYFJIH1 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Jun 2008 04:07:27 -0400
Received: by wf-out-1314.google.com with SMTP id 27so2488069wfd.4
        for <git@vger.kernel.org>; Tue, 10 Jun 2008 01:07:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:reply-to
         :to:subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=qtAeUazzAQ5INyJegZvihiunyRW3/i+/mC77YL/8dWE=;
        b=gDcl7xdhF4cAAYzR0kVpNdw1HfMYgj+07JcCgUx6ieZAnOYSEHCtFr9GcI8+gHbndV
         g7tlkdmHnMsh+2oaQ9rZKFUQbQcKs8QMXJXSrh8XhmNd9rYH9ufuYbaQjj7YdSdyEEXR
         dnB9BA1Df9Nvzjkw81CqvFNtoXOJgRzKHH74g=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:reply-to:to:subject:cc:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:references;
        b=WwB26zbm80tqizfyC7R0hONWwEkImsYO08jqDB6o3VGE/k9PgqD+HZhZ2vV7y27GDO
         DbL/OGXlbs0D50bvHi9q5ezPxiUFxqyaOZPug9WhJ2cD7+kR0A0S+NMmK32ErVm7tus6
         oPvblO+7yqy3WSX1U+QqqysJGbfDfbeE78/KQ=
Received: by 10.142.90.13 with SMTP id n13mr1914831wfb.75.1213085245574;
        Tue, 10 Jun 2008 01:07:25 -0700 (PDT)
Received: by 10.143.38.17 with HTTP; Tue, 10 Jun 2008 01:07:25 -0700 (PDT)
In-Reply-To: <alpine.DEB.1.10.0806092335420.17180@swallowtail>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/84479>

On Tue, Jun 10, 2008 at 8:38 AM, Asheesh Laroia <asheesh@asheesh.org> wrote:
> Peanut gallery question: Why not just always try these methods and catch
> some format exception if they fail, proceeding to the next possible
> decompressor (proceeding on to no decompressor)?
>
> That way if a file is called .GZ, it will still be handled properly; in
> fact, all files would still be handled properly.  And these formats leave
> notes in the first few bytes of the file as to if they should be tried, so
> it's not as if it would come at some performance cost.

How about adding in '.tar' decompression as well, -after- the '.gz'
decompression? That way you can have .tar.gz's and still be fine.

-- 
Cheers,

Sverre Rabbelier

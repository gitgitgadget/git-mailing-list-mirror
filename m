From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: [PATCH] git-add: introduce --edit (to edit the diff vs. the 
	index)
Date: Fri, 10 Apr 2009 20:59:34 +0200
Message-ID: <fabb9a1e0904101159w7ab19247k81f4b67b8a91198f@mail.gmail.com>
References: <cover.1239225986u.git.johannes.schindelin@gmx.de> 
	<61c07126e28aba0a36730da06112bd2d16eabc1b.1239225986u.git.johannes.schindelin@gmx.de> 
	<46dff0320904081900n7bff2280rc49315e3db427919@mail.gmail.com> 
	<46dff0320904091843p3e034647j3c78506b4d0c2b4@mail.gmail.com> 
	<alpine.DEB.1.00.0904102009440.10279@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Ping Yin <pkufranky@gmail.com>, git@vger.kernel.org,
	gitster@pobox.com
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Fri Apr 10 21:03:18 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LsLzC-0003wE-EF
	for gcvg-git-2@gmane.org; Fri, 10 Apr 2009 21:01:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S939550AbZDJS7w (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 10 Apr 2009 14:59:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S939543AbZDJS7w
	(ORCPT <rfc822;git-outgoing>); Fri, 10 Apr 2009 14:59:52 -0400
Received: from mail-fx0-f158.google.com ([209.85.220.158]:50864 "EHLO
	mail-fx0-f158.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933289AbZDJS7v (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 10 Apr 2009 14:59:51 -0400
Received: by fxm2 with SMTP id 2so1178442fxm.37
        for <git@vger.kernel.org>; Fri, 10 Apr 2009 11:59:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=Kv2iUAyqV2rIL0wwk+gRH4sYw359xMDRLWNtzMoYIlg=;
        b=k87eNPRm+RGG/HnjDEfn8u84uUg44TDp3KoXMtn69MO4KqspeZiWPnOMLYIYqmCI6A
         4IT3RFl9p3dtabpZ42rCGeznHxiaUT1L5E7lFECni0gguT8W6sBMf4MChVBok1vqqtI/
         B7bo0Ju/i/FCpsvzqjAZlol9GoS+Vc2xEynF8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=ZRJfm4uIs244oeWd4/wQYuwuw0/vlG3MsLL0dtWtAv+jsYgUWhjTX+qq4uMJCbZoJb
         7eZQNPurngw119mnNyEFrSVFZwLFETr36c2vP7YFDqPr2HZMcXldUZsNynojJ1QewHX+
         AhA2Wf78kYsHDbGOQIA8mo+axOdCszCjx7Lss=
Received: by 10.103.171.6 with SMTP id y6mr1997724muo.110.1239389989446; Fri, 
	10 Apr 2009 11:59:49 -0700 (PDT)
In-Reply-To: <alpine.DEB.1.00.0904102009440.10279@pacific.mpi-cbg.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/116275>

Heya,

On Fri, Apr 10, 2009 at 20:10, Johannes Schindelin
<Johannes.Schindelin@gmx.de> > As others have mentioned, there _is_ a
reason we have a working directory.
> Please understand this as a "I do not like the idea of editing the index
> directly at all".

I do not intend use it as a replacement of the working directory, but
mostly as a way to split up patches easier. Mainly to _remove_ lines
that I staged that I would like to be in a different patch in the
series (possibly after doing 'git reset --soft'). I always go through
my a longer patch series multiple times until I am satisfied with the
result, this addition would make that a lot easier.

-- 
Cheers,

Sverre Rabbelier

From: "Sverre Rabbelier" <alturin@gmail.com>
Subject: Re: [GitStats] Bling bling or some statistics on the git.git repository
Date: Sun, 13 Jul 2008 00:36:23 +0200
Message-ID: <bd6139dc0807121536u41591b1cv3258505b9a742851@mail.gmail.com>
References: <bd6139dc0807090621n308b0159n92d946c165d3a5dd@mail.gmail.com>
	 <bd6139dc0807111404y1d3dd48ao6d2903da4cd1aa56@mail.gmail.com>
	 <alpine.DEB.1.00.0807112215050.8950@racer>
	 <bd6139dc0807111452x778759d4jd6ac71338974018e@mail.gmail.com>
	 <alpine.DEB.1.00.0807112257450.8950@racer>
	 <bd6139dc0807111550w1f4a9e5fl636df73572bd27de@mail.gmail.com>
	 <alpine.DEB.1.00.0807120028280.8950@racer>
Reply-To: sverre@rabbelier.nl
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Git Mailinglist" <git@vger.kernel.org>,
	"David Symonds" <dsymonds@gmail.com>
To: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sun Jul 13 00:37:26 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KHniU-0001oy-CE
	for gcvg-git-2@gmane.org; Sun, 13 Jul 2008 00:37:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752627AbYGLWgY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 12 Jul 2008 18:36:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752407AbYGLWgY
	(ORCPT <rfc822;git-outgoing>); Sat, 12 Jul 2008 18:36:24 -0400
Received: from wf-out-1314.google.com ([209.85.200.175]:22698 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752493AbYGLWgX (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 12 Jul 2008 18:36:23 -0400
Received: by wf-out-1314.google.com with SMTP id 27so4243622wfd.4
        for <git@vger.kernel.org>; Sat, 12 Jul 2008 15:36:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:reply-to
         :to:subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=Ie7dSZU0eUvpADzpi45mRA/KNdUJXtS7y7dXuLg1BVI=;
        b=wIYhCoKGnfczuj0eV5QHkYnKwC9nlas/68YycjxszFtuOCN+F+Y0xsCElmQ3h/haOy
         XPgKXYv2JSE6MqBADp0+Xd+NXEXcV9sOPLMGHEA9JMTqc7k/Xr4fV6vzVv5sJOfRoile
         mLyGSwhNaQaJtfuMeEr1hhUce2vPPaPnx5y2o=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:reply-to:to:subject:cc:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:references;
        b=J1IJ9CpbqE3EW1+SX+gvIoIWTPkml+cLVHjpqxbCUl8mEjHGKGhbxNex2yubwKaC1u
         4MxawogQQilX+V7AGQ4xOUqcuDW8110BATgtREW75+67gWFGbm3Tl+jR4Y4HGwG8fozC
         0FthaxnNfovnuynjwT7EIMM/tXMOOIzqMt6xs=
Received: by 10.142.214.5 with SMTP id m5mr650773wfg.257.1215902183200;
        Sat, 12 Jul 2008 15:36:23 -0700 (PDT)
Received: by 10.143.38.17 with HTTP; Sat, 12 Jul 2008 15:36:23 -0700 (PDT)
In-Reply-To: <alpine.DEB.1.00.0807120028280.8950@racer>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/88272>

On Sat, Jul 12, 2008 at 1:33 AM, Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
> Fair enough.  As long as you use a language that is easy to prototype
> quickly and dirtily in.  Such as Python.

It turned out to work really nicely, especially since I already had a
parser for diffs ;).

> Let's go for it, then!

My first attempt at something usable is at [0].

> That is why I was suggesting using the diff tool with munged input to find
> out what works best.

I used python's difflib so that I didn't have to write out to a file.

> When that is done, I'll turn it into C.

Goodluckwiththat ;D.

[0] http://repo.or.cz/w/git-stats.git?a=commit;h=ac2a192f1dcec387e96f2a7eb5d66a38401b0722

-- 
Cheers,

Sverre Rabbelier

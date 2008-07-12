From: "Sverre Rabbelier" <alturin@gmail.com>
Subject: Re: [PATCH] Add pretty format %aN which gives the author name, respecting .mailmap
Date: Sat, 12 Jul 2008 10:44:08 +0200
Message-ID: <bd6139dc0807120144wbf0460bq3ace1f6119ace68c@mail.gmail.com>
References: <bd6139dc0807090621n308b0159n92d946c165d3a5dd@mail.gmail.com>
	 <alpine.DEB.1.00.0807112215050.8950@racer>
	 <alpine.DEB.1.00.0807112238350.8950@racer>
	 <bd6139dc0807111455s127c5a35hfd3f01cc75614f65@mail.gmail.com>
	 <alpine.DEB.1.00.0807112310140.8950@racer>
	 <bd6139dc0807111514j75d1ae6dl3c3f5dbfb55961c7@mail.gmail.com>
	 <alpine.DEB.1.00.0807120000580.8950@racer>
	 <alpine.DEB.1.00.0807120027330.8950@racer>
	 <bd6139dc0807111630j306f0225m90b501296a508552@mail.gmail.com>
	 <alpine.DEB.1.00.0807120041300.8950@racer>
Reply-To: sverre@rabbelier.nl
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: gitster@pobox.com, "Git Mailinglist" <git@vger.kernel.org>,
	"David Symonds" <dsymonds@gmail.com>
To: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sat Jul 12 10:45:15 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KHaj9-0005zm-Mb
	for gcvg-git-2@gmane.org; Sat, 12 Jul 2008 10:45:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751018AbYGLIoL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 12 Jul 2008 04:44:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751157AbYGLIoK
	(ORCPT <rfc822;git-outgoing>); Sat, 12 Jul 2008 04:44:10 -0400
Received: from wf-out-1314.google.com ([209.85.200.168]:35552 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750902AbYGLIoJ (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 12 Jul 2008 04:44:09 -0400
Received: by wf-out-1314.google.com with SMTP id 27so3997459wfd.4
        for <git@vger.kernel.org>; Sat, 12 Jul 2008 01:44:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:reply-to
         :to:subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=XIy8QXehjSiVJVEINZLQ5AN7Ps5EFW9mFCnH3Fg267Y=;
        b=TQV2OoHpgbwo5hMEUaHDyz2cRvVJ9JWDZHXyWDiCzVRRts78h88GWshBZizTiWuZfu
         Je+C6izqhMHakAmqIRXjSdLMhGybNrvCs+72zxKM+lPTAxp0rfhvtpp71h2YcEEOaJWQ
         uBh/hKhPiSBnXLSgjJTP7Uv5Cl6kNf0e/yXwI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:reply-to:to:subject:cc:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:references;
        b=cDT9RQ/wPItmF+X1VSX57Nnw5iHv5977zdzXOMWcyzvtih33E7OyicK1sjnECrYcq5
         2nOKxZyxV73U8r+6tGAgAgZAkl/nu3T8U73Gj6WFSIQ51z60F4ScyaEzevorUCqdllyB
         +ThkqCNLGhyty8wkctRfTn9XhRy8h6YDqk9MU=
Received: by 10.142.81.6 with SMTP id e6mr3496068wfb.205.1215852248537;
        Sat, 12 Jul 2008 01:44:08 -0700 (PDT)
Received: by 10.143.38.17 with HTTP; Sat, 12 Jul 2008 01:44:08 -0700 (PDT)
In-Reply-To: <alpine.DEB.1.00.0807120041300.8950@racer>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/88227>

On Sat, Jul 12, 2008 at 1:42 AM, Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
> Heh.  The price is that my patches are usually more buggy than other
> contributors' patches.

Pick Two: Good, Fast, and Cheap...? ;)

>> I'm not sure what to do though, if I use this new %cN GitStats will
>> only work with the latest git version... :(
>
> Yes, that is correct.  But my impression was that GitStats was never meant
> as a pure add-on, but rather some integral part of Git, no?  IOW at least
> contrib/ stuff.

Aye, that is true. Currently it should run with pretty much any
version, but if it does end up in git.git there is no reason not to
benefit from the most recent changes.

-- 
Cheers,

Sverre Rabbelier

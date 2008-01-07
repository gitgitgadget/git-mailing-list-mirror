From: "Marco Costalba" <mcostalba@gmail.com>
Subject: Re: gitk dev branch: F5 gives error after commit
Date: Mon, 7 Jan 2008 19:19:23 +0100
Message-ID: <e5bfff550801071019q50f62800t866d4570c7847731@mail.gmail.com>
References: <478258B6.20006@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: "Paul Mackerras" <paulus@samba.org>,
	"Git Mailing List" <git@vger.kernel.org>
To: "Johannes Sixt" <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Mon Jan 07 19:19:56 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JBwZk-0006vx-QN
	for gcvg-git-2@gmane.org; Mon, 07 Jan 2008 19:19:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754662AbYAGSTZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 7 Jan 2008 13:19:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754430AbYAGSTZ
	(ORCPT <rfc822;git-outgoing>); Mon, 7 Jan 2008 13:19:25 -0500
Received: from rv-out-0910.google.com ([209.85.198.185]:12977 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752858AbYAGSTY (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 Jan 2008 13:19:24 -0500
Received: by rv-out-0910.google.com with SMTP id k20so7171731rvb.1
        for <git@vger.kernel.org>; Mon, 07 Jan 2008 10:19:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=ObKtZUdaJOf43a+O/wrUe4ndFPSJY/Ysr3gqtTcqUTs=;
        b=F54wHWy6qyPD4FbI4duTzb5x7womu41Mwwqgjpuvy4SptfRERAkYdupwdyryssp6yHqT3Lm9YHEs1PPDF6GMp8XfKMS3tjEyBenTVnM2m+z8CB9folXdric7LNudGRBjppyQFJeOIlpzaq+kRbp3yeMnJrjYJoAGcBubsb1hi3Y=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=AtHR6cEul5o9HQg+NDwb9z+RsJnhVWmRksV/e5tDQKyGkS4A9/H5jB5zqLxI1N13JsJnulpyFFDmGPADvl5qJMOqq2dHFMm08H4cEOo+Gv+xKmzYAYqQx3BjJ3zrQMFNzELqQG3mhEucfN7emwOEaPqIgPFY0FLUnEBvontUWWA=
Received: by 10.141.171.6 with SMTP id y6mr10777596rvo.143.1199729963329;
        Mon, 07 Jan 2008 10:19:23 -0800 (PST)
Received: by 10.141.76.1 with HTTP; Mon, 7 Jan 2008 10:19:23 -0800 (PST)
In-Reply-To: <478258B6.20006@viscovery.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/69797>

On Jan 7, 2008 5:52 PM, Johannes Sixt <j.sixt@viscovery.net> wrote:
> I use the dev branch of gitk (on Windows), commit 476ca63 (gitk: Index
> [fnvr]highlights by id rather than row).
>
> 1. Start it with:
>
>     gitk --all -300
>
> 2. Make a commit.
> 3. Hit F5. Here I see the error message:
>
>    Error reading commits:
>    fatal: bad revision '^-300'
>

Windows command line does not handles the  ^ symbol.

Try open a console with cmd.exe and type

git log HEAD^


Marco

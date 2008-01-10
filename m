From: "Paolo Ciarrocchi" <paolo.ciarrocchi@gmail.com>
Subject: Re: gmail smtp server and git-send-mail. Is this combination working?
Date: Thu, 10 Jan 2008 12:17:26 +0100
Message-ID: <4d8e3fd30801100317x29a12b9eke303dc5e23c6b2d7@mail.gmail.com>
References: <4d8e3fd30801080858h5f109b47v87abc6b315fcfa08@mail.gmail.com>
	 <fm1h7t$nnr$1@ger.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Douglas Stockwell" <doug@11011.net>
X-From: git-owner@vger.kernel.org Thu Jan 10 12:18:04 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JCvQ6-0001gW-Df
	for gcvg-git-2@gmane.org; Thu, 10 Jan 2008 12:17:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752598AbYAJLR3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 Jan 2008 06:17:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752547AbYAJLR3
	(ORCPT <rfc822;git-outgoing>); Thu, 10 Jan 2008 06:17:29 -0500
Received: from wx-out-0506.google.com ([66.249.82.232]:20989 "EHLO
	wx-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752491AbYAJLR2 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Jan 2008 06:17:28 -0500
Received: by wx-out-0506.google.com with SMTP id h31so337499wxd.4
        for <git@vger.kernel.org>; Thu, 10 Jan 2008 03:17:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=J8I2lfLtD2Gt5qXY9GKqEUWeB6muvV3famajZolFleQ=;
        b=kpjRezvsYj1ZyS/mNvU4DxW/F7SkIyip6uwLeR/B+0T6faYlyaQl4qNbk2y3q/EwBHJQ8Z0Ozj/fdaW3VoIMKp0yt4/kT2tQgFIKhZa2bBXER793VFQGBdeB8Rbgih3l8SDUqB+JPuPjq6Ne8+ZtGxFhKeHa6xpiowiErHJ6SMk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=fwfk/OeomYsoZJfSFvJLWhM2Qa/0NFiIkxlN0DnJ2n4H5K9fmQ5/L4c7D4K9tAzDckGY0wIJ3Psj5Cv+e+euwFXFCiGAJ0UnXEFXxfEoET+dI9DUCo8COfXVPjl0+eGjm3oqCOiVIUtmezJNDuRt+TMjtalWprc6i2rQTw4uiEA=
Received: by 10.142.225.11 with SMTP id x11mr810950wfg.141.1199963846487;
        Thu, 10 Jan 2008 03:17:26 -0800 (PST)
Received: by 10.143.195.1 with HTTP; Thu, 10 Jan 2008 03:17:26 -0800 (PST)
In-Reply-To: <fm1h7t$nnr$1@ger.gmane.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/70059>

On Jan 9, 2008 5:06 AM, Douglas Stockwell <doug@11011.net> wrote:
> Paolo Ciarrocchi wrote:
> > " Mailing off a set of patches to a mailing list can be quite neatly
> > done by git-send-email.
> > One of the problems you may encounter there is figuring out which machine
> > is going to send your mail.
> > I tried smtp.gmail.com, but that one requires tls and a password,
> > and git-send-email could not handle that "
> >
> > From http://git.or.cz/gitwiki/GitTips.
> >
> > Is this statemant still correct ?
> > Is msmtp the only solution for using git-send-mail with gmail? (tls +
> > autentication).
>
> No, as of 34cc60ce2b48f6037997543ddbab1ed9903df4a8 you can use SSL and
> SMTP-Auth.
>
> [sendemail]
>          smtpserver = smtp.gmail.com
>          smtpuser = <user>@gmail.com
>          smtppass = <password>
>          smtpssl = true
>
> Can you suggest changes to the documentation if these options are unclear?

I got confuse by the ssl part in the name of the option,
I was looking and grepping for tls.

As I wrote in my previous email I think it's worth to add this very useful
information into the wiki as well.

Thanks.
-- 
Paolo
http://paolo.ciarrocchi.googlepages.com/

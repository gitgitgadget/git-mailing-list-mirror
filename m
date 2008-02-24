From: "Paolo Ciarrocchi" <paolo.ciarrocchi@gmail.com>
Subject: Re: gmail smtp server and git-send-mail. Is this combination working?
Date: Mon, 25 Feb 2008 01:12:13 +0330
Message-ID: <4d8e3fd30802241342u33bb1bbclad2208c1e0256c3d@mail.gmail.com>
References: <4d8e3fd30801080858h5f109b47v87abc6b315fcfa08@mail.gmail.com>
	 <fm1h7t$nnr$1@ger.gmane.org>
	 <4d8e3fd30801091509q49c02e1dua4ca42805ba891d6@mail.gmail.com>
	 <fm44ck$299$1@ger.gmane.org>
	 <4d8e3fd30801101449u11aabd73mba233301df157160@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Douglas Stockwell" <doug@11011.net>
X-From: git-owner@vger.kernel.org Sun Feb 24 22:42:57 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JTOcZ-0001yQ-Ti
	for gcvg-git-2@gmane.org; Sun, 24 Feb 2008 22:42:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753990AbYBXVmT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 24 Feb 2008 16:42:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753972AbYBXVmT
	(ORCPT <rfc822;git-outgoing>); Sun, 24 Feb 2008 16:42:19 -0500
Received: from el-out-1112.google.com ([209.85.162.180]:7170 "EHLO
	el-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753937AbYBXVmS (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 Feb 2008 16:42:18 -0500
Received: by el-out-1112.google.com with SMTP id v27so1023079ele.23
        for <git@vger.kernel.org>; Sun, 24 Feb 2008 13:42:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=/w6jstO4mFGkzd0ss719fBsFZeo+uhI6DlQA3l+bpt4=;
        b=YNo1SOKCdrO2Whjt4XL37hDlFTeWcOLrYraIRHXZJAjOGF5wHaiwzpQqE5XCye1IBs9frN9HjGV6bvG9OHBFdo1O6n/bqCKdsQbGqRm0F5LP2r2xTu/WbT7JBnYun3Al1HVuJhUjetvWwpjl7hU5rv+QzfS6ygtkzfDRWJePuwk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=WhNyl1bG48TqUMMtz37Xcf3bg8Qal2Z3nD72yGvOaPc/KMMWXeknyZEDLAwjIWQnCfGULITh+WYej8SAESzrCT0KAtab4OzSmhBa7s2r/i8Z/Wc8MlW0bDKI9DW97rwuglE2Mc0OOjJNMNi6fXVMqznnK02Q31faAMRMDzeqcRc=
Received: by 10.142.222.21 with SMTP id u21mr1570324wfg.41.1203889333561;
        Sun, 24 Feb 2008 13:42:13 -0800 (PST)
Received: by 10.143.196.10 with HTTP; Sun, 24 Feb 2008 13:42:13 -0800 (PST)
In-Reply-To: <4d8e3fd30801101449u11aabd73mba233301df157160@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/74965>

On 1/11/08, Paolo Ciarrocchi <paolo.ciarrocchi@gmail.com> wrote:
> > perl -MCPAN -e 'install Net::SMTP::SSL'

still no luck:
git-send-email --to paolo.ciarrocchi@gmail.com --smtp-server
smtp.gmail.com --smtp-user paolo.ciarrocchi --smtp-pass XXXX
/home/paolo/Desktop/patch/*
[...]
Who should the emails appear to be from? [Paolo
Ciarrocchi <paolo.ciarrocchi@gmail.com>]
Emails will be sent from: Paolo Ciarrocchi <paolo.ciarrocchi@gmail.com>
Message-ID to be used as In-Reply-To for the first
email?
(mbox) Adding cc: Paolo Ciarrocchi <paolo.ciarrocchi@gmail.com> from
line 'From: Paolo Ciarrocchi <paolo.ciarrocchi@gmail.com>'
(sob) Adding cc: Paolo Ciarrocchi <paolo.ciarrocchi@gmail.com> from
line 'Signed-off-by: Paolo Ciarrocchi <paolo.ciarrocchi@gmail.com>
'
Unable to initialize SMTP properly. Is there something wrong with
your config? at /home/paolo/bin/git-send-email line 719.

Ciao,
--
Paolo
http://paolo.ciarrocchi.googlepages.com/

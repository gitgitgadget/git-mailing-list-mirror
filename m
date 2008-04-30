From: "Avery Pennarun" <apenwarr@gmail.com>
Subject: Re: git-rebase and reflog
Date: Wed, 30 Apr 2008 13:22:34 -0400
Message-ID: <32541b130804301022l3a072f2p47ccb5639cd8a24e@mail.gmail.com>
References: <46dff0320804300904i3402b5e7wf827f6759bc52901@mail.gmail.com>
	 <m3d4o7nvt2.fsf@localhost.localdomain>
	 <46dff0320804300956x7e4f34efle39f6cad2e98a2de@mail.gmail.com>
	 <4818A6CA.5000409@nrlssc.navy.mil>
	 <46dff0320804301013o17da30cg1fd847beca94ff58@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Brandon Casey" <casey@nrlssc.navy.mil>,
	"Jakub Narebski" <jnareb@gmail.com>,
	"Git Mailing List" <git@vger.kernel.org>
To: "Ping Yin" <pkufranky@gmail.com>
X-From: git-owner@vger.kernel.org Wed Apr 30 19:23:54 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JrG1w-0003hp-Tu
	for gcvg-git-2@gmane.org; Wed, 30 Apr 2008 19:23:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758096AbYD3RWi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Apr 2008 13:22:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758092AbYD3RWi
	(ORCPT <rfc822;git-outgoing>); Wed, 30 Apr 2008 13:22:38 -0400
Received: from fk-out-0910.google.com ([209.85.128.188]:30680 "EHLO
	fk-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758004AbYD3RWh (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Apr 2008 13:22:37 -0400
Received: by fk-out-0910.google.com with SMTP id 18so387288fkq.5
        for <git@vger.kernel.org>; Wed, 30 Apr 2008 10:22:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=ji8mxq7JOWEmeNRx8jkw237VNJecuV3S3ELLdfTY6zw=;
        b=CChSM/OGkWClOZC7dDxx2OkmDAPfgYK9Wm1GeDmc7Uw54meLsc5oEpSdF/KkOVo9YXfaFcalFNoFwCVFIp0KyQvytcCS8xvxjb89yDt30GjABfLoiMcPK0LL9It2BY8HnL2cmmi9s85pwT2+Y+Q6DT2GqupvvCFdarOng2ZZNuU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=MIm4r6QC+x+PIPlngrkBmlgPA6+R88WEXVvW8fL7ZGlSnVVK8caK9WdHkULG9FfjY6ra/c9QNad+mMhr8rVl60EhssGXuQQWUld+8d9w78yTXJCtRG2aDepnpossn5UFo7WiNbnodCql36XmgVL1YyKzfBzF5DJux5KkBySH/kE=
Received: by 10.82.161.19 with SMTP id j19mr151727bue.48.1209576154339;
        Wed, 30 Apr 2008 10:22:34 -0700 (PDT)
Received: by 10.82.166.12 with HTTP; Wed, 30 Apr 2008 10:22:34 -0700 (PDT)
In-Reply-To: <46dff0320804301013o17da30cg1fd847beca94ff58@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/80853>

On 4/30/08, Ping Yin <pkufranky@gmail.com> wrote:
>  However, i still think the intemediate commits of git-rebase needn't
>  go into HEAD's reflog because it's totally useless.

I don't know, I can imagine a situation where I'm doing a rebase, I
get a conflict, I type the wrong command, and so I lose a bunch of my
intermediate work because I was an idiot.  The reflog sounds like it
would be helpful here as much as anywhere.

Have fun,

Avery

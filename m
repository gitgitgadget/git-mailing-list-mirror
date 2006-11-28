X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: "Martin Langhoff" <martin.langhoff@gmail.com>
Subject: Re: git and bzr
Date: Wed, 29 Nov 2006 11:14:22 +1300
Message-ID: <46a038f90611281414y165ed376r80e3dbc3c7888985@mail.gmail.com>
References: <45357CC3.4040507@utoronto.ca>
	 <845b6e870611280410j58bdcd99nc05d0f67489293e4@mail.gmail.com>
	 <ekhaeg$etk$1@sea.gmane.org>
	 <Pine.LNX.4.63.0611281433270.30004@wbgn013.biozentrum.uni-wuerzburg.de>
	 <Pine.LNX.4.64.0611280754050.30076@woody.osdl.org>
	 <456C7592.6020700@ableton.com> <ekhtnt$rkk$1@sea.gmane.org>
	 <456C9DFF.1040407@onlinehome.de>
	 <46a038f90611281340u521fb5fct745ebe1ded9a630e@mail.gmail.com>
	 <456CADE9.7060503@onlinehome.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Tue, 28 Nov 2006 22:14:43 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Qbzel8Urofw9gp3FehfPBcY75794Tdrn5sjY35hoPk01X6+YW1gd0bWvRX4lh/HAGUBrYCBR/4OvAbtLtp7wuIhqF3wmRpUBEpAuVqX4oOt5MyXN3W6mALKd4jVXS2I6YmD8JjgWLahTdVjKtgDJNhrtKI2lMKtVSwOji6TzbC0=
In-Reply-To: <456CADE9.7060503@onlinehome.de>
Content-Disposition: inline
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/32593>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GpBDf-000580-Gh for gcvg-git@gmane.org; Tue, 28 Nov
 2006 23:14:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1757481AbWK1WOY (ORCPT <rfc822;gcvg-git@m.gmane.org>); Tue, 28 Nov 2006
 17:14:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757545AbWK1WOY
 (ORCPT <rfc822;git-outgoing>); Tue, 28 Nov 2006 17:14:24 -0500
Received: from nf-out-0910.google.com ([64.233.182.190]:39174 "EHLO
 nf-out-0910.google.com") by vger.kernel.org with ESMTP id S1757481AbWK1WOY
 (ORCPT <rfc822;git@vger.kernel.org>); Tue, 28 Nov 2006 17:14:24 -0500
Received: by nf-out-0910.google.com with SMTP id o25so2706530nfa for
 <git@vger.kernel.org>; Tue, 28 Nov 2006 14:14:22 -0800 (PST)
Received: by 10.49.93.13 with SMTP id v13mr12796953nfl.1164752062439; Tue, 28
 Nov 2006 14:14:22 -0800 (PST)
Received: by 10.49.60.1 with HTTP; Tue, 28 Nov 2006 14:14:22 -0800 (PST)
To: "Nicholas Allen" <nick.allen@onlinehome.de>, "Git Mailing List"
 <git@vger.kernel.org>
Sender: git-owner@vger.kernel.org

On 11/29/06, Nicholas Allen <nick.allen@onlinehome.de> wrote:
> yes I can see if you just use plain patches. In bzr though there are
> bundles that store extra data along with the patch and if you use this
> instead of a simple patch this will never be a problem as bzr can then
> notice the same bundle being merged into 2 branches.

Well, there you start depending on everyone using bzr and providing
metadata-added patches. Git is really good at dealing with scenarios
where not everyone is using Git.. so the
content-is-kind-and-metadata-be-damned pays off handsomely.

And the "scenarios where not everyone is using Git" are everytime that
we are tracking a project that uses a different SCM. For me, the
"killer-app" of git is that, as it does not rely on magic metadata, it
is perfectly useful on projects that I track that use CVS or SVN.

I submit or commit patches upstream and git spots the commits being
echoed back in just right because it does not rely on the metadata.
Only on the content.

cheers,


martin

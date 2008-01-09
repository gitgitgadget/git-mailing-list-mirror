From: "Imran M Yousuf" <imyousuf@gmail.com>
Subject: Re: gmail smtp server and git-send-mail. Is this combination working?
Date: Wed, 9 Jan 2008 09:12:46 +0600
Message-ID: <7bfdc29a0801081912x6e0361d5r360c45686bc1d002@mail.gmail.com>
References: <4d8e3fd30801080858h5f109b47v87abc6b315fcfa08@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Paolo Ciarrocchi" <paolo.ciarrocchi@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jan 09 04:13:17 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JCRNU-0003I4-GW
	for gcvg-git-2@gmane.org; Wed, 09 Jan 2008 04:13:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752032AbYAIDMu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 Jan 2008 22:12:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751938AbYAIDMt
	(ORCPT <rfc822;git-outgoing>); Tue, 8 Jan 2008 22:12:49 -0500
Received: from hu-out-0506.google.com ([72.14.214.228]:3923 "EHLO
	hu-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751811AbYAIDMs (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Jan 2008 22:12:48 -0500
Received: by hu-out-0506.google.com with SMTP id 19so26456hue.21
        for <git@vger.kernel.org>; Tue, 08 Jan 2008 19:12:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=mJdHsDiy73xndBicUZL4NFz9zkb4YJnYjrWqaVDlLus=;
        b=fRG7ahj7AkXJGphtQtqZ+PX442Aq6Fx8p72A/ZMhz5SB3hrMi+r0Pf5z1Yplm1Ag8g8LQi/0bOfifPXUHjHoJMcRnn8FSNmEUT9b3MYZ1atf46xsUyw5m0BaZ5JDmRk8gYlW0ULrtS+qhacBVDbku0HSBJSWfkKDE0c/xqTpy3M=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=x928kYOHnLEMPmTiF2UmwRToHZw6kxh03ghCq8zFcOeOWYpa9zULF1/3LM+x3mK44vYC468pAqvci07bqDS80/9qFfLgbSZwslOpHxHK3Vjrh7UsmMTT6JnxsImgeRRyLDFZYP44BG5UeHJ6awzeFlaJcrZo7SM96qXd9CMYlpo=
Received: by 10.78.170.17 with SMTP id s17mr59452hue.35.1199848366947;
        Tue, 08 Jan 2008 19:12:46 -0800 (PST)
Received: by 10.78.50.5 with HTTP; Tue, 8 Jan 2008 19:12:46 -0800 (PST)
In-Reply-To: <4d8e3fd30801080858h5f109b47v87abc6b315fcfa08@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/69947>

Hi Paolo,

I just setup GMail with git-send-email using
http://git.or.cz/gitwiki/GitTips#head-a015948617d9becbdc9836776f96ad244ba87cb8.

Just add port 587 below the host and it should work fine. In the
username it should some.user.name@gmail.com.

Best regards,

Imran

On Jan 8, 2008 10:58 PM, Paolo Ciarrocchi <paolo.ciarrocchi@gmail.com> wrote:
> Hi all,
> as I previously wrote I would like to use git-send-email to send out a series
> of patches.
> While I was looking for documentation I saw the following statement in the
> git wiki:
>
> " Mailing off a set of patches to a mailing list can be quite neatly
> done by git-send-email.
> One of the problems you may encounter there is figuring out which machine
> is going to send your mail.
> I tried smtp.gmail.com, but that one requires tls and a password,
> and git-send-email could not handle that "
>
> From http://git.or.cz/gitwiki/GitTips.
>
> Is this statemant still correct ?
> Is msmtp the only solution for using git-send-mail with gmail? (tls +
> autentication).
>
> Thanks.
>
> regards,
> --
> Paolo
> http://paolo.ciarrocchi.googlepages.com/
> -
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>



-- 
Imran M Yousuf
Entrepreneur & Software Engineer
Smart IT Engineering
Dhaka, Bangladesh
Email: imran@smartitengineering.com
Mobile: +880-1711402557

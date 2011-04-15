From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH/RFC 6/5] Documentation/format-patch: suggest Toggle Word
 Wrap add-on for Thunderbird
Date: Fri, 15 Apr 2011 15:17:06 -0500
Message-ID: <20110415201706.GC13735@elie>
References: <1302719749.21047.6.camel@drew-northup.unet.maine.edu>
 <87mxjtn8x7.fsf@rho.meyering.net>
 <20110413221736.GA773@elie>
 <7vzkntkc9d.fsf@alter.siamese.dyndns.org>
 <20110414211125.GA15277@elie>
 <7vlizcfpz8.fsf@alter.siamese.dyndns.org>
 <20110415021100.GA19829@elie>
 <4DA7F6C0.4050707@viscovery.net>
 <7vtydzcse4.fsf@alter.siamese.dyndns.org>
 <4DA887FF.4070606@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	Johannes Sixt <j.sixt@viscovery.net>,
	Jim Meyering <jim@meyering.net>,
	Drew Northup <drew.northup@maine.edu>,
	git list <git@vger.kernel.org>,
	Yann Dirson <ydirson@altern.org>,
	Stephen Boyd <bebarino@gmail.com>
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Fri Apr 15 22:17:22 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QApS9-0000q4-2Z
	for gcvg-git-2@lo.gmane.org; Fri, 15 Apr 2011 22:17:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754172Ab1DOURM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 15 Apr 2011 16:17:12 -0400
Received: from mail-yx0-f174.google.com ([209.85.213.174]:45057 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753477Ab1DOURL (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 Apr 2011 16:17:11 -0400
Received: by yxs7 with SMTP id 7so1235311yxs.19
        for <git@vger.kernel.org>; Fri, 15 Apr 2011 13:17:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=y3QcQHg0kJ5sRmWcR+QbLGRxub5kCjTXUmipbnNwU6w=;
        b=YpfjekMlgLueqGIJxDA8sB3HS6caqXip+AcPnx0frQSRKmKffgE5G/qt06UaR0sxca
         fZcUAvtLAQ9+CPsq7ql6uOlSm85OJiyQMELY0zx8IZXEahms1gF8GheoY3yBcggc5jSr
         P7a+HCxSpXzNS+155LKS3nZ7K2bth4WfJo0Vk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=XxJPZYqPQV6suwqc5uKe6awkChZjqtabTr9KaGmkbMZxTEHIjybHorrWFnC19FFMQ+
         bzjl9oo80ki10I072TiQ9jtKpIslKTyrlZTm6qrGNZoUh686mbr7W61B7Jq5vUtgzRze
         ycV9MTrhF+WU4ytupvLzemLipAJtRQ/d/wQEY=
Received: by 10.43.48.131 with SMTP id uw3mr2879138icb.405.1302898631153;
        Fri, 15 Apr 2011 13:17:11 -0700 (PDT)
Received: from elie (adsl-69-209-64-230.dsl.chcgil.sbcglobal.net [69.209.64.230])
        by mx.google.com with ESMTPS id xc15sm1697256icb.14.2011.04.15.13.17.08
        (version=SSLv3 cipher=OTHER);
        Fri, 15 Apr 2011 13:17:09 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <4DA887FF.4070606@drmicha.warpmail.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/171637>

Michael J Gruber wrote:

> Does this add-on toggle "format fl[oa]wed" also?

Yep, it does.  Great find, Hannes.

> BTW: "AboutConfig" was great while it was needed, but these days you can
> access Thunderbird's about:config from the options.

So to summarize the three approaches (this is not a proposed wording;
I'm just trying to clear things up for myself):

 By default, Thunderbird will send HTML mail, wrap outgoing mail to 72
 characters for plain text mail, and transforms plain text mail to
 match the follow=flowed spec.

 To disable HTML mail, use Edit->Account Settings to uncheck the
 "Compose messages in HTML format" setting in the "Composition &
 Addressing" panel of the account to be used to send the patch.
 You've probably done this already --- many development lists do not
 like HTML mail for ordinary discussion, either.

 To disable wrapping and format=flowed, install the Toggle Word Wrap
 add-on that is available from
 https://addons.mozilla.org/thunderbird/addon/toggle-word-wrap/
 It adds a menu entry "Enable Word Wrap" that you can tick off. Now you
 can compose the message as you otherwise do (cut + paste,
 'git format-patch' | 'git imap-send', etc), but you have to insert
 line breaks manually in any additional text that you type.

 That's it.

 If for some reason that add-on doesn't work (maybe you don't like
 add-ons?), use the Config Editor (under Edit->Preferences->Advanced)
 to set

	mailnews.send_plaintext_flowed  => false

 to disable format=flowed and one of the following (?)

	mail.wrap_long_lines => false
	mailnews.wraplength => 0

 to disable line wrapping.

 You might also find the External Editor add-on from
 http://globs.org/articles.php?lng=en&pg=8 useful.
 There is a script in contrib/thunderbird-patch-inline which can be used
 as an external editor to include patches with Thunderbird and populate
 the "To:", "Subject:", and "Cc:" fields.

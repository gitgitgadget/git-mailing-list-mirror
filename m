From: Samuel GROOT <samuel.groot@grenoble-inp.org>
Subject: Re: [RFC-PATCH 1/2] send-email: new option to quote an email and
 reply to
Date: Tue, 24 May 2016 14:43:47 +0200
Message-ID: <0285f901-a1d1-2715-4207-68c7d103da5e@grenoble-inp.org>
References: <1464031829-6107-1-git-send-email-tom.russello@grenoble-inp.org>
 <1464031829-6107-2-git-send-email-tom.russello@grenoble-inp.org>
 <20160523195504.GA8957@dcvr.yhbt.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, matthieu.moy@grenoble-inp.fr,
	erwan.mathoniere@grenoble-inp.org,
	Jordan DE GEA <jordan.de-gea@ensimag.grenoble-inp.fr>
To: Eric Wong <e@80x24.org>,
	Tom Russello <tom.russello@grenoble-inp.org>
X-From: git-owner@vger.kernel.org Tue May 24 14:43:56 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b5Bgi-00057v-FL
	for gcvg-git-2@plane.gmane.org; Tue, 24 May 2016 14:43:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755365AbcEXMnw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 May 2016 08:43:52 -0400
Received: from zm-smtpout-1.grenet.fr ([130.190.244.97]:44573 "EHLO
	zm-smtpout-1.grenet.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754436AbcEXMnw (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 May 2016 08:43:52 -0400
Received: from localhost (localhost [127.0.0.1])
	by zm-smtpout-1.grenet.fr (Postfix) with ESMTP id D167A24D7;
	Tue, 24 May 2016 14:43:47 +0200 (CEST)
Received: from zm-smtpout-1.grenet.fr ([127.0.0.1])
	by localhost (zm-smtpout-1.grenet.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id R1iIvChe6USj; Tue, 24 May 2016 14:43:47 +0200 (CEST)
Received: from zm-smtpauth-2.grenet.fr (zm-smtpauth-2.grenet.fr [130.190.244.123])
	by zm-smtpout-1.grenet.fr (Postfix) with ESMTP id C1DF52167;
	Tue, 24 May 2016 14:43:47 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by zm-smtpauth-2.grenet.fr (Postfix) with ESMTP id BB8D02077;
	Tue, 24 May 2016 14:43:47 +0200 (CEST)
Received: from zm-smtpauth-2.grenet.fr ([127.0.0.1])
	by localhost (zm-smtpauth-2.grenet.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id rMc0bvMnu6Vp; Tue, 24 May 2016 14:43:47 +0200 (CEST)
Received: from wificampus-030221.grenet.fr (wificampus-030221.grenet.fr [130.190.30.221])
	by zm-smtpauth-2.grenet.fr (Postfix) with ESMTPSA id 6EDE12066;
	Tue, 24 May 2016 14:43:47 +0200 (CEST)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.0
In-Reply-To: <20160523195504.GA8957@dcvr.yhbt.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/295491>



On 05/23/2016 09:55 PM, Eric Wong wrote:
> Tom Russello <tom.russello@grenoble-inp.org> wrote:
>> This new option takes an email message file, parses it, fills the "To",
>> "Subject" and "Cc" fields appropriately and quote the message.
>> This option involves the `--compose` mode to edit the cover letter quoting the
>> given email.
>
> Cool!  There should probably be some help text to encourage
> trimming down the quoted text to only relevant portions.

What kind of help text would you want to see?

Maybe something like this:

   GIT: Quoted message body below.
   GIT: Feel free to trim down the quoted text
   GIT: to only relevant portions.

As "GIT:" portions are ignored when parsed by `git send-email`.

From: Pat Thoyts <patthoyts@gmail.com>
Subject: Re: [PATCH v2] git-gui: bring Wish process to front on Mac
Date: Sun, 16 Jun 2013 00:07:21 +0100
Message-ID: <CABNJ2GL3zK9UqsQ-ZCVVkZwXEesjGnmuVbUeQfSKZhL6njm3BA@mail.gmail.com>
References: <1l424u5.uk987q18u3oxfM%lists@haller-berlin.de>
	<1370642211-34416-1-git-send-email-stefan@haller-berlin.de>
	<7vwqpwo9wd.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Stefan Haller <stefan@haller-berlin.de>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Jun 16 01:07:28 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UnzZ8-0004Kg-Fq
	for gcvg-git-2@plane.gmane.org; Sun, 16 Jun 2013 01:07:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754764Ab3FOXHW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 15 Jun 2013 19:07:22 -0400
Received: from mail-pd0-f181.google.com ([209.85.192.181]:34510 "EHLO
	mail-pd0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754752Ab3FOXHW (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 15 Jun 2013 19:07:22 -0400
Received: by mail-pd0-f181.google.com with SMTP id 14so1632403pdj.12
        for <git@vger.kernel.org>; Sat, 15 Jun 2013 16:07:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=p9SzBy+/ebA0pyAnry8Wt3Zj7zrEjWNyymKOlrQpmHE=;
        b=04U3rpRfOZIlQ/EEAdOaMr0+rNu8QcfFg01vc5jVm30LxATzN/HmlMIKIF35A6Q5in
         Yq5Fa3kFk5+oP2yPnp4/mlUTPtWDt5YbKTNDV2E+hLi1BHgso5W+Kk1ds3S357fKE7Ay
         3yNObDqXXtdpNuEVX3Q5nQWyWzh91BqGw3qr3QTDy6TTSf/8tk0Eux4XOFpdBfCZtiZR
         wwFV8bELTAdMle1mlKEtRPXwCAR902lQKqneLWfn4XPXw5t/Y6b159ddZmsF+UFZTGPz
         OD/bduDnwB9MGkRX83as2AZcmNZjoJd1c6TuQqCnaWNgG3ictIa12zPE3TQCIDCczJrT
         Jl2A==
X-Received: by 10.68.134.40 with SMTP id ph8mr7582653pbb.177.1371337641692;
 Sat, 15 Jun 2013 16:07:21 -0700 (PDT)
Received: by 10.68.63.132 with HTTP; Sat, 15 Jun 2013 16:07:21 -0700 (PDT)
In-Reply-To: <7vwqpwo9wd.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/227976>

On 14 June 2013 18:54, Junio C Hamano <gitster@pobox.com> wrote:
> Stefan Haller <stefan@haller-berlin.de> writes:
>
>> On Mac OS X, any application that is started from the Terminal will open
>> behind all running applications; as a work-around, manually bring ourselves
>> to the front. (Stolen from gitk, commit 76bf6ff93e.)
>>
>> We do this as the very first thing, so that any message boxes that might pop
>> up during the rest of the startup sequence are actually seen by the user.
>>
>> Signed-off-by: Stefan Haller <stefan@haller-berlin.de>
>> ---
>
> Pat, is there any progress on this?  I do not mind, and I actually
> would prefer, a pull request early in the development cycle.
>

yep - I applied this and a couple of others and sent up a pull request
now. I see there are some commits in git's tree that I don't have on
this side so I'll merge those in here shortly.

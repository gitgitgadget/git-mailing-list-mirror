From: Nick Edelen <sirnot@gmail.com>
Subject: Re: What's cooking in git.git (Aug 2009, #06; Sun, 30)
Date: Tue, 1 Sep 2009 18:25:05 -0400
Message-ID: <c77435a80909011525m3a6e7917xe066d61f3863e615@mail.gmail.com>
References: <7viqg48nxi.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Sep 02 00:25:18 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mibmv-0006Wy-Bi
	for gcvg-git-2@lo.gmane.org; Wed, 02 Sep 2009 00:25:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755280AbZIAWZF convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 1 Sep 2009 18:25:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755272AbZIAWZF
	(ORCPT <rfc822;git-outgoing>); Tue, 1 Sep 2009 18:25:05 -0400
Received: from mail-fx0-f217.google.com ([209.85.220.217]:46050 "EHLO
	mail-fx0-f217.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755241AbZIAWZE convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 1 Sep 2009 18:25:04 -0400
Received: by fxm17 with SMTP id 17so396678fxm.37
        for <git@vger.kernel.org>; Tue, 01 Sep 2009 15:25:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=I/4nkWliiX5uoS3MaLTeR6iAZ/YxCO9vvsf7hWQY27o=;
        b=vpKkEoYl7EHvHnBR0jIc5bjl+9MLZs4bdAIz/zfcHFE0XtnGJssTnuK7Zu5enV7V7t
         drIt9NAMti8BMjjKRqtzF9LkjHPpAz5jt4RUaZjlQ0NRGObLQ4hWPCrE27Y+cGctdCDj
         ZekslpzAZwHa9P/cK2um0BsYhazhhy8bt6Xes=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=lCudNHzqRQlgLlaZfMhC97tZCszFettV65KlFMmn3JjFxcyN9r6UhlB20S7S1R4+HT
         oATBkpRp8+3a7PKOFBhhoGOU20MKnP7MSUXE2JkNkPBekaw5eQduKGU9N8vdlC5em87l
         Sh6d8EaIr4I2mll8EC+v0uxc6t07Af4lCuXdI=
Received: by 10.204.32.206 with SMTP id e14mr6003513bkd.22.1251843905118; Tue, 
	01 Sep 2009 15:25:05 -0700 (PDT)
In-Reply-To: <7viqg48nxi.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/127561>

> * ne/rev-cache (2009-08-21) 6 commits
> =A0. support for path name caching in rev-cache
> =A0. full integration of rev-cache into git, completed test suite
> =A0. administrative functions for rev-cache, start of integration int=
o git
> =A0. support for non-commit object caching in rev-cache
> =A0. basic revision cache system, no integration or features
> =A0. man page and technical discussion for rev-cache
>
> Updated but seems to break upload-pack tests when merged to 'pu'; giv=
en
> what this series touches, breakages in that area are expected.
> May discard if a working reroll comes, to give it a fresh start.

I vaguely remember something concerning those tests when starting the
project.  I'm a bit disconnected from everything right now, but I'll
try to get those fixed as soon as I can.

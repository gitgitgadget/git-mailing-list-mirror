From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH v3] config: Add new option to open an editor.
Date: Thu, 5 Feb 2009 01:39:29 +0200
Message-ID: <94a0d4530902041539w6e4e747fg804faaaf272e3f58@mail.gmail.com>
References: <94a0d4530902040741t4333b132v886d7057353ed52a@mail.gmail.com>
	 <1233786856-6571-1-git-send-email-felipe.contreras@gmail.com>
	 <7vmyd1lrnx.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Feb 05 00:41:11 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LUrMb-0002xO-D7
	for gcvg-git-2@gmane.org; Thu, 05 Feb 2009 00:41:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752163AbZBDXjc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 Feb 2009 18:39:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753478AbZBDXjb
	(ORCPT <rfc822;git-outgoing>); Wed, 4 Feb 2009 18:39:31 -0500
Received: from fg-out-1718.google.com ([72.14.220.153]:63240 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753006AbZBDXjb (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Feb 2009 18:39:31 -0500
Received: by fg-out-1718.google.com with SMTP id 16so1387471fgg.17
        for <git@vger.kernel.org>; Wed, 04 Feb 2009 15:39:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=I2tEPUO6j86QabSUDE8BcOf1uRNuDHr4F4H1smgiSyU=;
        b=hypODACMPBKbGSIwfZaq2tU41/zp1bXkSBNQGt8rM67OE3P61rHxabsPyuvqoQ48yK
         StNFPZUR9EFT8e6YAMAvKCJV/PqC+WZMgNZMJ/0p4ToIgizPQc7U2zUyyGjc7cvVI3UX
         D3DWdTE3bGS3j8+ap385+jkOMPxFSVNa/9dkA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=FwljF8fDIorXS2KtXLsrK/NmvGK/QF2f1Q5DUjEznCwYp6OsMZLmG5qUGEkHhxqwe3
         RLXwYNPH2EIwXdMSDgXG5i6nNgYLrwwaG/wEi7Mudqnr1eGZRDbRB5LU2kZlObUztNS7
         yfCLutoYCkQt+1Ej5BbSQhNyh09ri+tzc1s6A=
Received: by 10.86.57.9 with SMTP id f9mr2263798fga.38.1233790770174; Wed, 04 
	Feb 2009 15:39:30 -0800 (PST)
In-Reply-To: <7vmyd1lrnx.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/108467>

On Thu, Feb 5, 2009 at 1:16 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Felipe Contreras <felipe.contreras@gmail.com> writes:
>
>> The idea was originated by discussion about usability of manually
>> editing the config file in 'special needs' systems such as Windows. Now
>> the user can forget a bit about where the config files actually are.
>
> Does this honor core.editor setting in existing configuration files?

Nope. I guess I need to add git_config(git_default_config, NULL) for that.

-- 
Felipe Contreras

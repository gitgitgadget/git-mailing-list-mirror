From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH 2/2] bundle: rewrite builtin to use parse-options
Date: Thu, 8 Dec 2011 23:08:00 +0530
Message-ID: <CALkWK0m89D02aku8J0OXbpyrovHCOpsYS4Qpx2jH-pFG4rOG2A@mail.gmail.com>
References: <1323349817-15737-1-git-send-email-artagnon@gmail.com>
 <1323349817-15737-4-git-send-email-artagnon@gmail.com> <20111208163946.GB2394@elie.hsd1.il.comcast.net>
 <CALkWK0mmjKSzSbxq2i7=JvcB4LTro-MYDCwQLUUwqcf8qS0zPA@mail.gmail.com> <20111208170319.GD2394@elie.hsd1.il.comcast.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Git List <git@vger.kernel.org>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Thu Dec 08 18:38:29 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RYhvP-0002SI-G6
	for gcvg-git-2@lo.gmane.org; Thu, 08 Dec 2011 18:38:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752710Ab1LHRiW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 Dec 2011 12:38:22 -0500
Received: from mail-qw0-f46.google.com ([209.85.216.46]:45385 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752478Ab1LHRiW (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Dec 2011 12:38:22 -0500
Received: by qadb40 with SMTP id b40so832518qad.19
        for <git@vger.kernel.org>; Thu, 08 Dec 2011 09:38:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=dmWBjfaD5b/WzSJ53gbW9GEeuIRxBsbeP9RhkPxVUYQ=;
        b=se23ET4MnOLDNAlNqUaoFnBOvvoQoP2NkHrBy1hZHAUXFibxOUl+QPCXFNrZGnvnnl
         UyCmGbzkmTvyyjAV+P/Lymnx0yhJmd0LSvd8XPioIBWKhgOlxqX1An2Vo5gxhfnBZ7qN
         fPsPMZUQROr1A4TQT7/Nn+WeZp5GMfahq9TFw=
Received: by 10.224.180.131 with SMTP id bu3mr3984236qab.5.1323365901227; Thu,
 08 Dec 2011 09:38:21 -0800 (PST)
Received: by 10.229.165.194 with HTTP; Thu, 8 Dec 2011 09:38:00 -0800 (PST)
In-Reply-To: <20111208170319.GD2394@elie.hsd1.il.comcast.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/186579>

Hi,

Jonathan Nieder wrote:
> Ramkumar Ramachandra wrote:
>
>> Sure, you can't create a
>> bundle named "verify", but that's the compromise you'll have to make
>> if you don't want to type out "--" with each option, no?
>
> Having to type "--" or prefix with "./" to escape ordinary filenames
> that do not start with "-" would be completely weird.

Hm, do you have any suggestions to work around this?  Can we use
something like a parse-stopper after the the first subcommand is
encountered, and treat the next argument as a non-subcommand (filename
or whatever else)?

-- Ram

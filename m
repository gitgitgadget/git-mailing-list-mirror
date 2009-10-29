From: Avery Pennarun <apenwarr@gmail.com>
Subject: Re: finding the merge of two or more commits
Date: Thu, 29 Oct 2009 17:34:45 -0400
Message-ID: <32541b130910291434q1b068918x38c5aec543cb1c2a@mail.gmail.com>
References: <3a69fa7c0910291412l439f7f61vd3b55a77cd7e10b5@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org
To: E R <pc88mxer@gmail.com>
X-From: git-owner@vger.kernel.org Thu Oct 29 22:35:24 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N3ceO-0000qg-QK
	for gcvg-git-2@lo.gmane.org; Thu, 29 Oct 2009 22:35:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756156AbZJ2VfB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 29 Oct 2009 17:35:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755868AbZJ2VfB
	(ORCPT <rfc822;git-outgoing>); Thu, 29 Oct 2009 17:35:01 -0400
Received: from mail-yw0-f202.google.com ([209.85.211.202]:37323 "EHLO
	mail-yw0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756148AbZJ2VfA (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 Oct 2009 17:35:00 -0400
Received: by ywh40 with SMTP id 40so2115762ywh.33
        for <git@vger.kernel.org>; Thu, 29 Oct 2009 14:35:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type;
        bh=Il25axofi74FyFSTQ+Bhw2KeYM4T0l9GiR5QeTucvP0=;
        b=hWV+OqjjA74EjKZdZ5HrsyFfQNiVRRPW3tGb3DSVkZ8EmQbGGuwOikEzSAkM1N7qBK
         Qm44gKANyusy40qT11u76rZ6LDwDr6Po2H10VbQcvgld50ILrWG2BzMaNiJRT1s2hSW4
         83KiJO6MZ2ZrM/3C64kusZ6VcanoETMV9lmuc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=IbqTC3ZksOX6T+fsHTqoQumT8fTinr8BQO/8KkrgVYd9pcD1ZdrBv1/YuTCUrGdhTf
         /xerUFLemxcI69GP1lsVIPOsauuI75qXmPYXKMwF6zVbKf8m77xXDqDSE343KhAE75dW
         F5ZL64SGijnlkGDi3PCKj/JeEVcNbzLCIJZJM=
Received: by 10.150.103.1 with SMTP id a1mr1310275ybc.198.1256852105099; Thu, 
	29 Oct 2009 14:35:05 -0700 (PDT)
In-Reply-To: <3a69fa7c0910291412l439f7f61vd3b55a77cd7e10b5@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/131655>

On Thu, Oct 29, 2009 at 5:12 PM, E R <pc88mxer@gmail.com> wrote:
> That is, I don't want to merge c1 and c2 myself, but I want to know if
> someone else has merged c1 and c2, performed any conflict resolution
> and committed the result.

Try this:

(git branch -a --contains c1; git branch -a --contains c2) | sort | uniq -d

It's not exactly pretty, but it works.

Have fun,

Avery

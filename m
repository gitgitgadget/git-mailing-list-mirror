From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: git pull behavior changed?
Date: Wed, 21 Apr 2010 23:59:05 +0200
Message-ID: <u2zfabb9a1e1004211459k74c23b56tbd8de958d82f0cca@mail.gmail.com>
References: <u2z3abd05a91004211413rcd2440fdq7946ef4764b24362@mail.gmail.com> 
	<v2hfabb9a1e1004211422ybbf47ef0gd5dfd1791eb03c16@mail.gmail.com> 
	<y2p3abd05a91004211455r30d13932t92dfbedff581b9a1@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git list <git@vger.kernel.org>
To: Aghiles <aghilesk@gmail.com>
X-From: git-owner@vger.kernel.org Wed Apr 21 23:59:37 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O4hxF-0004An-TH
	for gcvg-git-2@lo.gmane.org; Wed, 21 Apr 2010 23:59:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756003Ab0DUV72 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 21 Apr 2010 17:59:28 -0400
Received: from mail-bw0-f209.google.com ([209.85.218.209]:60315 "EHLO
	mail-bw0-f209.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753323Ab0DUV71 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Apr 2010 17:59:27 -0400
Received: by bwz1 with SMTP id 1so10745629bwz.2
        for <git@vger.kernel.org>; Wed, 21 Apr 2010 14:59:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:received:message-id:subject:to:cc:content-type;
        bh=mTowhz58IXEV5bU2yHV2lEX9/wrjsNOIlFxoXAukT3w=;
        b=xPyNSyiYWzmRizKDfRWSUxrE4LKdihsiqkRdgvOatwSLW3GASvkvRBLoldFa30I5uE
         BKPzBEthCSLDmWn+6bjcvXS9/hCwsxokjdFhziJ1xccyz4p+kyKJ0ODX9wJnW2F21fEG
         f6bwIn+sEDlV1FwNJ1sTnhCAiGD8uCCGneyP0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=KIiuevezO1tfvpMoKjNMaNFByslK+Cd6y38vwrCQA/esrYy1X8j2KHzGy/RTVqEYZi
         ZG5WnAsZDRl+I64wZ6xYqbpm4t0gLseWRJjtx485bUDBPA4qD6uC3AQcMgvC3V77JUka
         HElUAyoPiQNv+XNHt3GwctgNQoX9fMI/B3Ksc=
Received: by 10.103.168.14 with HTTP; Wed, 21 Apr 2010 14:59:05 -0700 (PDT)
In-Reply-To: <y2p3abd05a91004211455r30d13932t92dfbedff581b9a1@mail.gmail.com>
Received: by 10.103.79.19 with SMTP id g19mr1746648mul.75.1271887165159; Wed, 
	21 Apr 2010 14:59:25 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/145466>

Heya,

On Wed, Apr 21, 2010 at 23:55, Aghiles <aghilesk@gmail.com> wrote:
> Without the '--track' option it seems to work as expected: when I pull
> it downloads data form the remote but then stops before merging.
> This used to work! What happened ? :(

See the --track documentation, you need to tell it to track upstream
instead of master.

-- 
Cheers,

Sverre Rabbelier

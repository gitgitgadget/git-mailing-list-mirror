From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: [RFC/PATCH] commit notes workflow
Date: Thu, 3 Mar 2011 02:57:22 +0100
Message-ID: <AANLkTino7fGnLutJ3cAxcvx8O-JbcDPJDrYHznjoN-TC@mail.gmail.com>
References: <20110225133056.GA1026@sigill.intra.peff.net> <201102251658.22678.johan@herland.net>
 <20110301215907.GA23945@sigill.intra.peff.net> <201103020121.54690.johan@herland.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
To: Johan Herland <johan@herland.net>
X-From: git-owner@vger.kernel.org Thu Mar 03 02:58:13 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Puxnu-0006e6-Jg
	for gcvg-git-2@lo.gmane.org; Thu, 03 Mar 2011 02:58:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757348Ab1CCB6E (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 2 Mar 2011 20:58:04 -0500
Received: from mail-gy0-f174.google.com ([209.85.160.174]:52432 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756952Ab1CCB6C (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Mar 2011 20:58:02 -0500
Received: by gyh20 with SMTP id 20so234987gyh.19
        for <git@vger.kernel.org>; Wed, 02 Mar 2011 17:58:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type;
        bh=tdgQfgVg6trkyDma5pamYAUrCNzkbefE8t0zTsYjEQU=;
        b=psgwkZWU9pWVt21li629gmjPfsV9gNdltwl5JD8aC4xZJDZ4I/sOXwUVTIPRC7KUuD
         9WrNrnuyEGPi0xkd6B7tLv9ZpXSDWCWWhNLmGzkkrfF/Qs8MYogUsirv/7bc4ZkZg/iU
         SPGOKFr406px2M45JA2wLxVsBpbFhTqK/TMdc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=J1jgb9pcklRToA3WEsRkvYdoCNvUHOdhaQSsXwERKMT+43z4Mx4iym6JopJa3e7ED/
         duIzopAKv57xVHsZXe+uAzad7cfPgyshl5KsJUNTjxKazuynRJLuBp6wmVVKvavC79he
         ss2PBLNHYY8b+I594nbmheLu2PhmwkhLDhZL8=
Received: by 10.150.218.16 with SMTP id q16mr1002694ybg.349.1299117482239;
 Wed, 02 Mar 2011 17:58:02 -0800 (PST)
Received: by 10.151.11.12 with HTTP; Wed, 2 Mar 2011 17:57:22 -0800 (PST)
In-Reply-To: <201103020121.54690.johan@herland.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/168366>

Heya,

On Wed, Mar 2, 2011 at 01:21, Johan Herland <johan@herland.net> wrote:
>> I wonder if anyone actually uses
>> "-v" these days. It seems like "git add -p" would have superseded it in
>> most workflows.
>
> I find myself using -v every now and then, to just have the diff handy while
> I construct the commit message. Makes it easier to refer to function names,
> etc. in the commit message.

Can someone explain why -v does not output it's data prefixed by a
'#'? If someone really wanted to include it in their commit message
they can column-select-delete it, and if they don't, it just gets
deleted by the cleanup code?

-- 
Cheers,

Sverre Rabbelier

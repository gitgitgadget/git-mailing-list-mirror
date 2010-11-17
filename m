From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: Difference between 'git rebase' and 'git rebase -m'
Date: Wed, 17 Nov 2010 18:43:50 +0700
Message-ID: <AANLkTik7RML10gyQ19OV0KAH8Mn3=VZe92kU1qxER7wO@mail.gmail.com>
References: <4CE2C0ED.1030309@workspacewhiz.com> <20101116182749.GC14552@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Joshua Jensen <jjensen@workspacewhiz.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>,
	Stephen Bash <bash@genarts.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Wed Nov 17 12:44:51 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PIgRW-0003PC-Gq
	for gcvg-git-2@lo.gmane.org; Wed, 17 Nov 2010 12:44:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934550Ab0KQLon (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 17 Nov 2010 06:44:43 -0500
Received: from mail-ww0-f42.google.com ([74.125.82.42]:60050 "EHLO
	mail-ww0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934118Ab0KQLon (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Nov 2010 06:44:43 -0500
Received: by wwb39 with SMTP id 39so13097wwb.1
        for <git@vger.kernel.org>; Wed, 17 Nov 2010 03:44:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:cc:content-type;
        bh=jMxZqrjJ8//k98Zoo7Nuw1vgE8ii4Q0fV4fSlrQyNOs=;
        b=hqVJa15CuY0afcPauYr7YoN4KEeVCfv5zLszNhTT440r6KfE6H7a8hd3Op0szlmCpU
         C5haCnZrhYHLAGJ15mE+NNEvV+NbqRQv7WW89K8mzQ3a8quYDEYQDtRu9iEEkY5+WMpu
         pB6EL+3HK+m39bBpvh9N+IYcMDPTXzDgko68M=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=r2hll+ctq3g0sG/5YJQr5qGxMAuJDgN+I8Cj9TEuz8iT4FMvwNvU7AQR0gnfC1MblZ
         Ad8HWVbCsFm7i+JSD9q+XXwNAAsnWKsjkX3pDcmAaQf84PzpUvkT1wtRwh9S+P80UDIR
         xx3qZe3DIlClR8Dz7IHaNdVuhzWuut7VbS9bE=
Received: by 10.216.255.148 with SMTP id j20mr7935058wes.11.1289994277067;
 Wed, 17 Nov 2010 03:44:37 -0800 (PST)
Received: by 10.216.172.199 with HTTP; Wed, 17 Nov 2010 03:43:50 -0800 (PST)
In-Reply-To: <20101116182749.GC14552@burratino>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/161611>

On Wed, Nov 17, 2010 at 1:27 AM, Jonathan Nieder <jrnieder@gmail.com> wrote:
> Joshua Jensen wrote:
>
>> I'm curious as to why 'git rebase -m' isn't the default and what the
>> real difference is between 'git rebase' and 'git rebase -m'.
>
> git rebase is faster. :)

Perhaps a config option to let people to default to -m. Or perhaps
they can just make an alias.

By the way, can we make rebase even faster? Rebasing ~20 patches or
more seems slow to me. I don't know much how patching works though.
-- 
Duy

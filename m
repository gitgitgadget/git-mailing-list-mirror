From: Erik Faye-Lund <kusmabite@gmail.com>
Subject: Re: sys/param.h
Date: Wed, 19 Dec 2012 08:59:27 +0100
Message-ID: <CABPQNSZQk6hHm-dWqFFQf0HF34Mvbjc8-mgzCr=G0zbBKiYUvA@mail.gmail.com>
References: <20121217213730.GA17212@ftbfs.org> <50D02B9A.1040906@viscovery.net>
 <7vobhrgupr.fsf_-_@alter.siamese.dyndns.org>
Reply-To: kusmabite@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Dec 19 09:29:35 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TlF1y-0001jz-JW
	for gcvg-git-2@plane.gmane.org; Wed, 19 Dec 2012 09:29:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752723Ab2LSI3R (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Dec 2012 03:29:17 -0500
Received: from mail-da0-f43.google.com ([209.85.210.43]:60544 "EHLO
	mail-da0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752589Ab2LSI3Q (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Dec 2012 03:29:16 -0500
X-Greylist: delayed 1748 seconds by postgrey-1.27 at vger.kernel.org; Wed, 19 Dec 2012 03:29:16 EST
Received: by mail-da0-f43.google.com with SMTP id u36so799370dak.30
        for <git@vger.kernel.org>; Wed, 19 Dec 2012 00:29:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:reply-to:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=yxXY7gOEuD2ghNs6UGm+JSLJUOara89kc2v5DhUQJc4=;
        b=w3hKJNhaOOYvlYMMLC0+ezQaRq/nXtz+nT9JsyruCLNfOvQ5DVcPBz+C+PWzaxiJYj
         m9ezwI/k/YxI/9c5NnuoBzR9paeSZslr7Uy4y++Dz/3gCPlC7LMqujlMTkJZphmY6yG0
         QeH45IY0w0VOusLlfKXSFd7w2PMGQ3qH8v1vR1GmNkCJd6T950l+sqlMIGNex/gUvBSR
         /Ni2SnD1fSOzjQ5YsupE5sP+ul7KQOTbjpCGVZFXTF95vwi0qeYOeFFk8/+ipOxZkxHS
         6bHSwa+raKCvb+8VFO/4Sk5AxLcYI0QyjPfH482T/n3MkgqC5RPjq4/cjCNr0WVwl2n1
         UEUA==
Received: by 10.68.189.163 with SMTP id gj3mr15816822pbc.110.1355904007753;
 Wed, 19 Dec 2012 00:00:07 -0800 (PST)
Received: by 10.66.126.51 with HTTP; Tue, 18 Dec 2012 23:59:27 -0800 (PST)
In-Reply-To: <7vobhrgupr.fsf_-_@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/211812>

On Tue, Dec 18, 2012 at 6:01 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Johannes Sixt <j.sixt@viscovery.net> writes:
>
>>> Junio C Hamano wrote:
>>>> It could turn out that we may be able to get rid of sys/param.h
>>>> altogether, but one step at a time.  Inputs from people on minority
>>>> platforms are very much appreciated---does your platform build fine
>>>> when the inclusion of the file is removed from git-compat-util.h?
>>
>> MinGW works fine with sys/param.h removed from git-compat-util.h.
>
> It seems that OpenBSD 5.2 does not mind it getting removed, either.
> Debian 5 and Debian 6 seem OK; so do Ubuntu 10.04 and 12.04.  I have
> a hunch that Fedora or anything based on glibc would be fine, too.

And just to be sure; Fedora 17: OK.

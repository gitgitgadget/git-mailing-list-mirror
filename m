From: "NODA, Kai" <nodakai@gmail.com>
Subject: Re: git tag --contains <commit> -n=1 ?
Date: Thu, 24 Dec 2009 05:37:35 +0900
Message-ID: <4B327F8F.2060106@gmail.com>
References: <4B324327.5010809@gmail.com> <m2fx71pq0p.fsf@whitebox.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Dec 23 21:38:06 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NNXy9-0002en-AX
	for gcvg-git-2@lo.gmane.org; Wed, 23 Dec 2009 21:38:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754496AbZLWUhl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Dec 2009 15:37:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752153AbZLWUhl
	(ORCPT <rfc822;git-outgoing>); Wed, 23 Dec 2009 15:37:41 -0500
Received: from mail-yx0-f187.google.com ([209.85.210.187]:50675 "EHLO
	mail-yx0-f187.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751889AbZLWUhj (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Dec 2009 15:37:39 -0500
Received: by yxe17 with SMTP id 17so7114007yxe.33
        for <git@vger.kernel.org>; Wed, 23 Dec 2009 12:37:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:subject:references:in-reply-to
         :content-type:content-transfer-encoding;
        bh=X79+9WN3uzAYCo3pgp1uM2j6m8kBF242+b5oa5CB3Io=;
        b=GZRRiwmg15S1Us1vvJKqae64w/226naDLjt0bUqYxuZSNQp4rHt0hTW9nssWFOHttP
         XVXo1iLM1VNpanQYshQInhDjoDyHR+o4J/GbBUo2oTcj7SzJfcD92ZXwgXRxB/851REr
         edlX0F/hBNUaYy1hgC8XyiwubGR703bpttWhE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:subject:references
         :in-reply-to:content-type:content-transfer-encoding;
        b=tENgmEq+p2YpWk2vdHcoA85CKnDoAm0MjT/YMKmQGeVMVjA6ZTTTugocTg07kwfC4a
         CfjfXDvXEwuz2WmBYQNR9AYhndJTmqFnhrV/QPrEaSzC9FJuqPEZPl/pdipQyliOR8Le
         P3bzNuu3h1MEEpaVrjEME35X+wnOc+ZfqXQZs=
Received: by 10.150.130.38 with SMTP id c38mr7573324ybd.213.1261600659300;
        Wed, 23 Dec 2009 12:37:39 -0800 (PST)
Received: from ?192.168.1.50? (i254229.dynamic.ppp.asahi-net.or.jp [61.125.254.229])
        by mx.google.com with ESMTPS id 20sm2898808ywh.47.2009.12.23.12.37.37
        (version=SSLv3 cipher=RC4-MD5);
        Wed, 23 Dec 2009 12:37:38 -0800 (PST)
User-Agent: Thunderbird 2.0.0.23 (Windows/20090812)
In-Reply-To: <m2fx71pq0p.fsf@whitebox.home>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/135635>

Thank you for your reply, Andreas

Andreas Schwab wrote:
...
>> Here I wonder whether "head -1" is generally correct or not when I want
>> the oldest tag.
> 
> Since the output of git tag is sorted by name, generally not.

Wow, I didn't know that.
But then, under the assumption that tags have names like verNNN,
that behavior ensures me that "head -1" works as intended.

Maybe I look at its implementation ( refs.c:do_for_each_ref , right?)
but this seems a tough code to comprehend, especially around
packed/loose/extra ...

Thanks,
Kai

From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: [PATCH] fast-import: Allow filemodify to set the root
Date: Thu, 7 Oct 2010 22:35:20 +0200
Message-ID: <AANLkTi=K0NsKB0uBpHs+mB=PubieX7jO7vFiqrs+dnqB@mail.gmail.com>
References: <1286448906-1424-1-git-send-email-david.barr@cordelta.com>
 <AANLkTikjzQ09XBxYZXXQf6XCme3FiLKtusZ0MLTa--mM@mail.gmail.com> <20101007202847.GA13234@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: David Barr <david.barr@cordelta.com>,
	Git Mailing List <git@vger.kernel.org>,
	Ramkumar Ramachandra <artagnon@gmail.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Thu Oct 07 22:35:47 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P3xBq-0007RT-OK
	for gcvg-git-2@lo.gmane.org; Thu, 07 Oct 2010 22:35:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755440Ab0JGUfl convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 7 Oct 2010 16:35:41 -0400
Received: from mail-gw0-f46.google.com ([74.125.83.46]:60258 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751721Ab0JGUfl convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 7 Oct 2010 16:35:41 -0400
Received: by gwj17 with SMTP id 17so102215gwj.19
        for <git@vger.kernel.org>; Thu, 07 Oct 2010 13:35:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=wtRDMyNQC+aQI2SjZtSWKHzsMlrEaglO+qTq8S/V2M8=;
        b=fysGRbwrBjhGyGpaLqKwdFZYvm/NXHlaHmi4RRbJrYVr25yxD6oKJN9K0sJ6Z9Tsp0
         F2bjOdH5mqI1ME/Z8rvjyqO1DQWB/n8Hgm2PR5a9peA0lB5CLfiu1kKHpcc/otAF/Aer
         COhD9zykD7GmMb0RAiLhPY6ZaMjdu0BrZMu9I=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=MIkWz809kvsaw+IGAStJDYJJtawHnpNhNj7aMprFI28wUY/k5y7De2cwOGeuR+OKEF
         Fq8ojVrVBzTuw6KXhX2TTUim4LFVO92Y/60etlZdkDQ+4selk9MnfqoUYyjANEVf9h+W
         H0xpF6Fs7E3SGHl2x9hGujL8w9i7P57cNIwXg=
Received: by 10.150.186.17 with SMTP id j17mr1774772ybf.272.1286483740326;
 Thu, 07 Oct 2010 13:35:40 -0700 (PDT)
Received: by 10.151.15.8 with HTTP; Thu, 7 Oct 2010 13:35:20 -0700 (PDT)
In-Reply-To: <20101007202847.GA13234@burratino>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/158456>

Heya,

On Thu, Oct 7, 2010 at 22:28, Jonathan Nieder <jrnieder@gmail.com> wrot=
e:
> | is a synonym for the deleteall command.

Thanks, the updated doc is more understandable.

> [*] how significant? =C2=A0Numbers are always nice. :)

Yes, numbers please! :)

>> Ok, so maybe I do understand, is it basically 'git read-tree
>> 4b825dc642cb6eb9a060e54bf8d69288fbee4904' for fast-import?
>
> Yep.

Perhaps mention that in the commit message as well then. Of course,
the fast-import doc needs updating, and it needs test.

--=20
Cheers,

Sverre Rabbelier

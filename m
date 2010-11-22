From: Francis Moreau <francis.moro@gmail.com>
Subject: Re: Can't build doc anymore (v1.7.3.2)
Date: Mon, 22 Nov 2010 21:44:36 +0100
Message-ID: <m2k4k5ks0b.fsf@gmail.com>
References: <m2oc9hkurl.fsf@gmail.com>
	<1290458128.29678.23.camel@drew-northup.unet.maine.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Drew Northup <drew.northup@maine.edu>
X-From: git-owner@vger.kernel.org Mon Nov 22 21:45:02 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PKdFy-0000SF-Pw
	for gcvg-git-2@lo.gmane.org; Mon, 22 Nov 2010 21:44:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757586Ab0KVUow (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Nov 2010 15:44:52 -0500
Received: from mail-wy0-f174.google.com ([74.125.82.174]:44777 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753921Ab0KVUow (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Nov 2010 15:44:52 -0500
Received: by wyb28 with SMTP id 28so7448188wyb.19
        for <git@vger.kernel.org>; Mon, 22 Nov 2010 12:44:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:references
         :date:in-reply-to:message-id:user-agent:mime-version:content-type;
        bh=7oRMXspBV8MxH01AMCSnDPJGaQLhoGLG1bsLQFfetrc=;
        b=DAc7wDHqCR+sBEwvNpH2XkxK+Em1Ao766N5Goh5meV50s0+yqn5M6Mbezu5qzzrl0I
         E/5WVBwqhnY9KF2ikwS8ZpGob36GVZcm40w6xXExWtszEhHg8oXi4eTaJsdhLu5swaLI
         62gNjIx8Eo+qqDlmq4IWtJPnlSt8tDqdS2Xq0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        b=BPPgD9hitzoAcsvxEOOaPH7pQK76Imauuv5rv66BA1zO1jmAztoHBvU7k4GbaXGpYX
         s51TBlelJ0BnF2VzUqK94XeKM8PZJq/BKgmwZxxJkLOj5DnJDA7HieurvijhPfSdkjoi
         Vz/Gol8R2uK/ChNbKOrqpPjk91aeBZUAJlBiI=
Received: by 10.227.135.144 with SMTP id n16mr6528898wbt.17.1290458680765;
        Mon, 22 Nov 2010 12:44:40 -0800 (PST)
Received: from localhost (au213-1-82-235-205-153.fbx.proxad.net [82.235.205.153])
        by mx.google.com with ESMTPS id ga16sm3585941wbb.19.2010.11.22.12.44.38
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 22 Nov 2010 12:44:39 -0800 (PST)
In-Reply-To: <1290458128.29678.23.camel@drew-northup.unet.maine.edu> (Drew
	Northup's message of "Mon, 22 Nov 2010 15:35:28 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/161911>

Drew Northup <drew.northup@maine.edu> writes:

> On Mon, 2010-11-22 at 20:45 +0100, Francis Moreau wrote:
>> Hello,
>> 
>> I'm trying to build the git's documentation, but after pulling v1.7.3.2,
>
>> it fails:
>> 
>>   $ make prefix=/usr/local doc
>>   make -C Documentation all
>>   make[1]: Entering directory `/home/fmoreau/git/Documentation'
>>   make[2]: Entering directory `/home/fmoreau/git'
>>   make[2]: `GIT-VERSION-FILE' is up to date.
>>   make[2]: Leaving directory `/home/fmoreau/git'
>>       XMLTO git-fetch.1
>>   xmlto: /home/fmoreau/git/Documentation/git-fetch.xml does not validate (status 3)
>>   xmlto: Fix document syntax or use --skip-validation option
>>   I/O error : Attempt to load network entity http://www.oasis-open.org/docbook/xml/4.5/docbookx.dtd
>>   /home/fmoreau/git/Documentation/git-fetch.xml:2: warning: failed to load external entity "http://www.oasis-open.org/docbook/xml/4.5/docbookx.dtd"
>>   D DocBook XML V4.5//EN" "http://www.oasis-open.org/docbook/xml/4.5/docbookx.dtd"
>>                                                                                  ^
>>   I/O error : Attempt to load network entity http://www.oasis-open.org/docbook/xml/4.5/docbookx.dtd
>>   warning: failed to load external entity "http://www.oasis-open.org/docbook/xml/4.5/docbookx.dtd"
>>   validity error : Could not load the external subset "http://www.oasis-open.org/docbook/xml/4.5/docbookx.dtd"
>>   Document /home/fmoreau/git/Documentation/git-fetch.xml does not validate
>>   make[1]: *** [git-fetch.1] Error 13
>>   make[1]: Leaving directory `/home/fmoreau/git/Documentation'
>> 
>> Could anybody tell me what's now wrong ?
>
> Without more information, not specifically. However, the fix may be
> fairly simple.

What do you need exactly ?

Sorry but I know nothing about these documentation generation tools.

> Some distributions are apparently so ancient that they don't include the
> version 4.5 and newer Docbook XML XSL & DTD files. RHEL 5 and older make
> this list.

Well I'm running Fedora 14, which I wouldn't call 'ancient'.

-- 
Francis

From: Todd Zullinger <tmz@pobox.com>
Subject: Re: [ANNOUNCE] GIT 1.6.5.2
Date: Wed, 11 Nov 2009 16:59:52 -0500
Message-ID: <20091111215952.GR31109@inocybe.localdomain>
References: <7vljiypw9s.fsf@alter.siamese.dyndns.org>
 <m3ljicsrg0.fsf@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Wed Nov 11 23:00:18 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N8LEe-0005ll-Mz
	for gcvg-git-2@lo.gmane.org; Wed, 11 Nov 2009 23:00:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759478AbZKKV7z (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 Nov 2009 16:59:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759338AbZKKV7z
	(ORCPT <rfc822;git-outgoing>); Wed, 11 Nov 2009 16:59:55 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:57783 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759325AbZKKV7y (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Nov 2009 16:59:54 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id DB7AF7CB44;
	Wed, 11 Nov 2009 16:59:58 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=date:from:to
	:cc:subject:message-id:references:mime-version:content-type
	:in-reply-to; s=sasl; bh=0VRMeua/JP6EO/XnDP23bkh7o2s=; b=qBK1+bA
	4K9E1jdL6NMNJFdzbNwFNWcTZqGA2Y5LlVcjdrZAFKixNQC/02ty2QuvQSidkRsg
	Ppr+/3JpAfKW4UH71R3uPTv64MiYGYGVaxZVBjH2ZPnQgk1i60P82bOwBZjiaAss
	ZuJo83HvXIMm+SEvCNEZydf8fUTyR7WfCuXo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=date:from:to:cc
	:subject:message-id:references:mime-version:content-type
	:in-reply-to; q=dns; s=sasl; b=ojLG8+98x6qav2IZTLXq1FFJv+oIsOxse
	Nm++2RezQSuWvSzwaxOtpPHgwqziPwY6oXlYUA2kL+SBOhVjjnxeillbw4TOGLcq
	XIAFuehTW6PMOPSOHj4VOsuK4rgdO6tbzlrr4+GLjuPuhEKp50Sq2m9t9ifeJeRY
	8RgoTCg3Vk=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id B17837CB3F;
	Wed, 11 Nov 2009 16:59:56 -0500 (EST)
Received: from inocybe.localdomain (unknown [98.117.251.177]) (using TLSv1
 with cipher AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 1ABF07CB3E; Wed, 11 Nov
 2009 16:59:54 -0500 (EST)
Content-Disposition: inline
In-Reply-To: <m3ljicsrg0.fsf@localhost.localdomain>
User-Agent: Mutt/1.5.20 (2009-06-14)
X-Pobox-Relay-ID: 8C863FF0-CF0D-11DE-9D96-9F3FEE7EF46B-09356542!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/132711>

Jakub Narebski wrote:
> Junio C Hamano <gitster@pobox.com> writes:
>
>> The RPM binary packages for a few architectures are found in:
>>
>>   RPMS/$arch/git-*-1.6.5.2-1.fc9.$arch.rpm	(RPM)
>
> I tried to install git from source RPM... and failed:
>
>   $ rpmbuild --rebuild git-1.6.5.2-1.fc11.src.rpm
>   Installing git-1.6.5.2-1.fc11.src.rpm
>   warning: user junio does not exist - using root
>   warning: group junio does not exist - using root
>   error: unpacking of archive failed on file
>     /home/local/builddir/SOURCES/git-1.6.5.2.tar.gz;
>     4afb1f6a: cpio: MD5 sum mismatch
>   error: git-1.6.5.2-1.fc11.src.rpm cannot be installed
>
> Error messages are line wrapped for better readibility.
>
> Redownloading the file didn't help
>
>   $ ls -l git-1.6.5.2-1.fc11.src.rpm
>   -rw-r--r--  1 jnareb users 2713416 Oct 26 03:59 git-1.6.5.2-1.fc11.src.rpm
>   $ md5sum git-1.6.5.2-1.fc11.src.rpm
>   9f89a01b65e1b8e8934c3a2252064632  git-1.6.5.2-1.fc11.src.rpm

It looks like the kernel.org builders are now using Fedora 11 to
create the packages.  Unfortunately, there were backward-incompatible
changes in rpm.  Stronger hashes are now used and older rpm versions
do not understand these, leading to the error you got.

I don't know what the process is for creating the rpm's, but if it's
under Junio's control, a fix to create packages which can be read by
older rpm versions would be to add:

    --define "_source_filedigest_algorithm md5" \
    --define "_binary_filedigest_algorithm md5"

to the rpmbuild invocation.

Perhaps like this (I didn't test this, though the defines are what we
use in Fedora to create packages on Fedora >= 11 for building on
CentOS and older releases):

-- >8 --
From: Todd Zullinger <tmz@pobox.com>
Subject: [PATCH] Makefile: Ensure rpm packages can be read by older rpm versions

The kernel.org hosts where the packages are built are now using Fedora
11, which defaults to sha256 for file digests instead of md5.  Older
versions of rpm can not handle these packages.  Tell rpmbuild to use md5
file digests for better compatibility.

Signed-off-by: Todd Zullinger <tmz@pobox.com>
---
 Makefile |    5 ++++-
 1 files changed, 4 insertions(+), 1 deletions(-)

diff --git a/Makefile b/Makefile
index 5d5976f..35f5294 100644
--- a/Makefile
+++ b/Makefile
@@ -1806,7 +1806,10 @@ dist: git.spec git-archive$(X) configure
 	gzip -f -9 $(GIT_TARNAME).tar
 
 rpm: dist
-	$(RPMBUILD) -ta $(GIT_TARNAME).tar.gz
+	$(RPMBUILD) \
+		--define "_source_filedigest_algorithm md5" \
+		--define "_binary_filedigest_algorithm md5" \
+		-ta $(GIT_TARNAME).tar.gz
 
 htmldocs = git-htmldocs-$(GIT_VERSION)
 manpages = git-manpages-$(GIT_VERSION)
-- 
1.6.5.2

-- 
Todd        OpenPGP -> KeyID: 0xBEAF0CE3 | URL: www.pobox.com/~tmz/pgp
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Does it follow that I reject all authority? Perish the thought. In the
matter of boots, I defer to the authority of the boot-maker.
    -- Mikhail Bakunin

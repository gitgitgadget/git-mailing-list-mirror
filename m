From: "Martin Langhoff" <martin.langhoff@gmail.com>
Subject: Re: git on MacOSX and files with decomposed utf-8 file names
Date: Thu, 24 Jan 2008 17:37:58 +1300
Message-ID: <46a038f90801232037t76e103edt1585d49b2ed19862@mail.gmail.com>
References: <34103945-2078-4983-B409-2D01EF071A8B@sb.org>
	 <alpine.LFD.1.00.0801230808440.1741@woody.linux-foundation.org>
	 <98F90EB6-1930-4643-8C6C-CA11CB123BAA@sb.org>
	 <76718490801231218i53c19e22lda34f2eec88627f8@mail.gmail.com>
	 <1DC841ED-634F-412C-9560-F37E4172A4CD@sb.org>
	 <76718490801231421l7b6552f8sec13f570360198b@mail.gmail.com>
	 <4F906435-A186-4E98-8865-F185D75F14D4@sb.org>
	 <76718490801231517h6d57e5bfkc19d394d38ad19db@mail.gmail.com>
	 <DE7B2DE6-03B1-4781-92C7-096E591369A1@sb.org>
	 <7vk5lzc3yr.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Kevin Ballard" <kevin@sb.org>,
	"Jay Soffian" <jaysoffian@gmail.com>,
	"Linus Torvalds" <torvalds@linux-foundation.org>,
	"Theodore Tso" <tytso@mit.edu>, "Mike Hommey" <mh@glandium.org>,
	"Git Mailing List" <git@vger.kernel.org>
To: "Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jan 24 05:38:37 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JHtrI-0003o5-S3
	for gcvg-git-2@gmane.org; Thu, 24 Jan 2008 05:38:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753410AbYAXEiB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Jan 2008 23:38:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753368AbYAXEiB
	(ORCPT <rfc822;git-outgoing>); Wed, 23 Jan 2008 23:38:01 -0500
Received: from ug-out-1314.google.com ([66.249.92.171]:55645 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753394AbYAXEiA (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Jan 2008 23:38:00 -0500
Received: by ug-out-1314.google.com with SMTP id z38so243338ugc.16
        for <git@vger.kernel.org>; Wed, 23 Jan 2008 20:37:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=jL6UMpPWFrEL3FtYJ0sxdlbrrNb+vIfwIar0oCY+0UQ=;
        b=C6AtjjVRmnC6ao8mHMQeKDPnOKN35brIg3zU9LSVOJ9bHMvIRv12+HNIlK3GPBWXApZC/uyX1+6b4RZf3RasHalbsXv9IAcORpKST4NfaUfdRYlTenZAFkCuslnlR5daOjwTr09ECoudgHtdTzdS5SGBcTi2aEblpC8u2V8c33k=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=KvdqQy50Qlk2YzLymVw0aiFG/iR6+W21VcY6AfmibK/xtXx6maXQsEmQBFJHfd4uPbyyWOhIzbPS/NS+8rf4jGmVLbw3PSOG2gcXVvcuzvZNyAJAJswwCai9KigB1qXsNEz5GMwifkJsP7LIcg3IKcMTyzenNC2AaLvXBO9EklM=
Received: by 10.67.196.2 with SMTP id y2mr1775669ugp.60.1201149479004;
        Wed, 23 Jan 2008 20:37:59 -0800 (PST)
Received: by 10.66.252.2 with HTTP; Wed, 23 Jan 2008 20:37:58 -0800 (PST)
In-Reply-To: <7vk5lzc3yr.fsf@gitster.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/71589>

On Jan 24, 2008 4:11 PM, Junio C Hamano <gitster@pobox.com> wrote:
> make you feel insulted.  Instead pretend that you heard "HFS+
> normalizes", "HFS+ is different", and "fixes problem on HFS+".
> Do not respond with "No it is not a corruption", "No, HFS+ is
> not broken" and "No, that is not a work around, but is a fix"
> with another long thread.

Indeed. And it'd be good if Kevin could consider that this forum is
for technical discussion - not democracy but meritocracy,
best-solution-cracy and perhaps "fix-patch-ocracy". And that people
that have written good code in the past, posted amazing patches, and
wondrous test cases can sometimes get a bit more opinionated. But
newcomers needs to earn a bit of respect before lecturing people.

Kevin, other people have already started posting nice nuggets of test
cases. Where are *your* test cases? That would be a nice way to "have
the last word" on this ;-)

cheers,



martin

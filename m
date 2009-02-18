From: Jay Soffian <jaysoffian@gmail.com>
Subject: Re: [PATCH] test suite: correct export var=val usage
Date: Wed, 18 Feb 2009 08:29:05 -0500
Message-ID: <76718490902180529w7520ba64kb7d0d6b284b406bd@mail.gmail.com>
References: <7vr61w3dug.fsf@gitster.siamese.dyndns.org>
	 <1234911457-37188-1-git-send-email-jaysoffian@gmail.com>
	 <0E74A2BF-1E59-4D82-A750-380697667F10@wincent.com>
	 <76718490902180519s3b5f4469m391aa34456059d37@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Brandon Casey <casey@nrlssc.navy.mil>,
	Thomas Rast <trast@student.ethz.ch>,
	Johannes Schindelin <johannes.schindelin@gmx.de>
To: Wincent Colaiuta <win@wincent.com>
X-From: git-owner@vger.kernel.org Wed Feb 18 14:30:48 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LZmVY-0003Nq-0L
	for gcvg-git-2@gmane.org; Wed, 18 Feb 2009 14:30:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752289AbZBRN3J (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 Feb 2009 08:29:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752001AbZBRN3H
	(ORCPT <rfc822;git-outgoing>); Wed, 18 Feb 2009 08:29:07 -0500
Received: from rv-out-0506.google.com ([209.85.198.232]:62577 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751582AbZBRN3G (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Feb 2009 08:29:06 -0500
Received: by rv-out-0506.google.com with SMTP id g9so2026807rvb.5
        for <git@vger.kernel.org>; Wed, 18 Feb 2009 05:29:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=grrve3Q/sbY4nsRfTb5+nIyBlN6d4o6M5zLXepVfBBg=;
        b=YBgi0cLfZ7mVaIaa/gGvv73f1Xksa/f7j4AFGdB5ojWNo0QtFfWuu/HrW26H43Diu4
         bR9AVMrl+NX8ICDhCcht0gm58eu3Q28x43CKdSPMT9HGGU34OaBFGB+CDnnuObYHJpiA
         brwxY6+7+l3vCE0Uxp5i0nQSavhV/yfdfE9PE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=pOu0qRgaNB1cp1Jfus9UeRdbn3U/5DxIJ9LI6CTuC8ISsGJQVIlbbAec9zjO15MBcu
         7nkG32G1C/1jaDRj9pzjoHtE2fKaZsrq7mejt5MNfYLsflzU0CbrhjYj9sQ9kqex2YUz
         Kde39xQ23XiqppvKLLbL4zDpJvPbgYs5WrE2M=
Received: by 10.141.48.10 with SMTP id a10mr3973871rvk.22.1234963745158; Wed, 
	18 Feb 2009 05:29:05 -0800 (PST)
In-Reply-To: <76718490902180519s3b5f4469m391aa34456059d37@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/110536>

On Wed, Feb 18, 2009 at 8:19 AM, Jay Soffian <jaysoffian@gmail.com> wrote:
> On Wed, Feb 18, 2009 at 5:06 AM, Wincent Colaiuta <win@wincent.com> wrote:
>> Perhaps my eyes are playing tricks on me but I see the original version
>> setting MSG to an empty string and exporting it, and your version setting
>> MSG to "1" and exporting it. So which one is wrong? The original or yours?
>
> http://thread.gmane.org/gmane.comp.version-control.git/109897/focus=110462

Rather, http://thread.gmane.org/gmane.comp.version-control.git/109897/focus=110457

(Cursed frame interface.)

(The original is wrong.)

j.

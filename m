From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [msysGit] Re: Pull request for msysGit patches
Date: Tue, 28 Sep 2010 23:54:17 -0400
Message-ID: <4CA2B869.6090207@sunshineco.com>
References: <87ocbitd33.fsf@fox.patthoyts.tk> <7vocbhsn03.fsf@alter.siamese.dyndns.org> <4CA29E06.705@sunshineco.com> <7vbp7hrzhb.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Johannes Sixt <j6t@kdbg.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	msysGit <msysgit@googlegroups.com>, git@vger.kernel.org,
	Pat Thoyts <patthoyts@users.sourceforge.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Sep 29 05:54:33 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P0nkU-0001D8-Ld
	for gcvg-git-2@lo.gmane.org; Wed, 29 Sep 2010 05:54:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754352Ab0I2DyX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 28 Sep 2010 23:54:23 -0400
Received: from mail-gx0-f174.google.com ([209.85.161.174]:52909 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754224Ab0I2DyV (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 Sep 2010 23:54:21 -0400
Received: by gxk9 with SMTP id 9so143375gxk.19
        for <git@vger.kernel.org>; Tue, 28 Sep 2010 20:54:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:sender:message-id:date:from
         :user-agent:mime-version:to:cc:subject:references:in-reply-to
         :content-type:content-transfer-encoding;
        bh=eZ405n7FtuEikkIJaxwOAJFcrLlF5YSQD517r6kzICg=;
        b=HCCYfE01kgFMVAVoR5ai1BoIgE4tPoMP+zMm4Zck3X8IMjpnux8oHadoiJHUg4IyDV
         w5sKLrtgX65R7swTVJ7LC/r3w4+a0G7V1BcavdizhcvAVl2qXoNZA12gfnzXan7esBkb
         2fMnMfuhrwVRvCH6LuxUlC51Fs58KE0F1A4EQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=sender:message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        b=O0WhvagRSYhfT6mRukTdVZ+8aZmM/wYPD4OK71IGXnKqRlzaU87Y1xjx1u8vxyNtq8
         gX6C1903GvKIKYip0hTatxTgCIAgJGVVtE2O55fa7GB066gvbDDnTsM7CR5VaaZ4k5lX
         ZQB3a65kIRKPwEO3v1zlBlpzDVRGuEQKRqXn0=
Received: by 10.101.71.10 with SMTP id y10mr1101691ank.94.1285732460799;
        Tue, 28 Sep 2010 20:54:20 -0700 (PDT)
Received: from [192.168.1.1] (user-12l2cil.cable.mindspring.com [69.81.50.85])
        by mx.google.com with ESMTPS id u14sm9362224ann.0.2010.09.28.20.54.19
        (version=SSLv3 cipher=RC4-MD5);
        Tue, 28 Sep 2010 20:54:20 -0700 (PDT)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 6.0; en-US; rv:1.9.2.9) Gecko/20100915 Thunderbird/3.1.4
In-Reply-To: <7vbp7hrzhb.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/157524>

On 9/28/2010 11:38 PM, Junio C Hamano wrote:
> Eric Sunshine<sunshine@sunshineco.com>  writes:
>
>> I am the author of this patch. Do I understand correctly that your
>> primary concern is that you find the comment misleading? I consider
>> the code
>>
>>    fmt = (len>  0&&  is_dir_sep(cwd[len-1])) ? "%s%s" : "%s/%s";
>>
>> sufficiently self-documenting that the comment is superfluous, and
>> would be happy to remove the comment. Would you prefer the patch
>> submitted with the comment removed?
>
> Yeah, that sounds sensible.  Thanks.

Thank you for the response. I will re-submit the patch with the noted 
changes: (1) parentheses surrounding conditional expression, (2) removal 
of superfluous comment.

-- ES

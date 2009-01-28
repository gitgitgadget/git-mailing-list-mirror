From: Jay Soffian <jaysoffian@gmail.com>
Subject: Re: [PATCH v2 1/2] git-am: emit usage when called w/o arguments and 
	w/o patch on stdin
Date: Wed, 28 Jan 2009 09:28:50 -0500
Message-ID: <76718490901280628y3761b41dhd2e544093e01e209@mail.gmail.com>
References: <1233113262-17491-1-git-send-email-jaysoffian@gmail.com>
	 <7vhc3kxdwm.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, sverre@rabbelier.nl
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jan 28 15:30:35 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LSBQm-0008V5-Sw
	for gcvg-git-2@gmane.org; Wed, 28 Jan 2009 15:30:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751203AbZA1O2w (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 Jan 2009 09:28:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751136AbZA1O2v
	(ORCPT <rfc822;git-outgoing>); Wed, 28 Jan 2009 09:28:51 -0500
Received: from rv-out-0506.google.com ([209.85.198.232]:13345 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751123AbZA1O2u (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Jan 2009 09:28:50 -0500
Received: by rv-out-0506.google.com with SMTP id k40so6972592rvb.1
        for <git@vger.kernel.org>; Wed, 28 Jan 2009 06:28:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=/dtrou8dAm972Ze+X7c9NGw1E/Z2lSYvWZaRf5xuJT0=;
        b=h3o0fEIkh3lk1UwW5KyAMuBvx23fUuec7G5E4mIhN7bOLqS8lXcluKjEiL/YddwMnE
         FddGHfS/DvBxANzcgS7wL/YElcY/lF98nze7wtv2xekiQBRfaUZk7y1Enx0tkInyMbOc
         Hxw5bP3AinL67BT3XdVSWLtXcQni+9OV26XIA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=uPkqsgrpElwFopmdZggH3bs5i3Mr3YJ7Lge93/AAtSqwIWuvi2xd3Io0wPy61pDriU
         NK7LDK4PS7e20sHr5OrDWu8tBr5qtHe796hQkGMYtSRG87g631hApeGxUuB3AN2vtUF1
         KFNVEAc96WoXXRihd7CXaGHELLYlQTkfdFf0o=
Received: by 10.141.13.13 with SMTP id q13mr2164520rvi.163.1233152930086; Wed, 
	28 Jan 2009 06:28:50 -0800 (PST)
In-Reply-To: <7vhc3kxdwm.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/107537>

On Tue, Jan 27, 2009 at 11:17 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Jay Soffian <jaysoffian@gmail.com> writes:
>
>> +     test $# = 0 && test -t 0 && usage
>
> Sorry to be dense.  Why isn't your patch the above single liner?
>

"Also ensure that $dotest is cleaned up if user manages to interupt mailsplit
while it is processing input, but not if mailsplit exits non-zero due to
error."

j.

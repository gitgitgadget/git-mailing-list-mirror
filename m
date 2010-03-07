From: Paolo Bonzini <bonzini@gnu.org>
Subject: Re: [PATCH v4 3/7] revert: add --ff option to allow fast forward
 when cherry-picking
Date: Sun, 07 Mar 2010 09:34:08 +0100
Message-ID: <4B936500.9020005@gnu.org>
References: <20100306203250.2960.30309.chriscool@tuxfamily.org> <20100306203447.2960.42019.chriscool@tuxfamily.org> <7v6358dbv8.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Christian Couder <chriscool@tuxfamily.org>, git@vger.kernel.org,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Stephan Beyer <s-beyer@gmx.net>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Stephen Boyd <bebarino@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Mar 07 09:35:10 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NoBwJ-0008O3-FM
	for gcvg-git-2@lo.gmane.org; Sun, 07 Mar 2010 09:34:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752752Ab0CGIeN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 7 Mar 2010 03:34:13 -0500
Received: from mail-fx0-f219.google.com ([209.85.220.219]:42149 "EHLO
	mail-fx0-f219.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752441Ab0CGIeM (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 7 Mar 2010 03:34:12 -0500
Received: by fxm19 with SMTP id 19so5432313fxm.21
        for <git@vger.kernel.org>; Sun, 07 Mar 2010 00:34:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:sender:message-id:date:from
         :user-agent:mime-version:to:cc:subject:references:in-reply-to
         :content-type:content-transfer-encoding;
        bh=WzxXSiW8f7z2JTO9w7rJVatwAIZWp8pAPqTlITZ9xok=;
        b=YfnN5D7b0fHTGysDeFaLPj/jShlgvCrsXAKlaRWkVSe064JyPJRdO8K6+OEFX8Ds+Q
         wKc9FhJTpMSeLKvCf3UtzGar2v8SiBaKbwCSp+sjzTatjbaCTe5g9w/EaZo6bS6mhhoB
         RFvvIyWcN/F+IVH5s3ZXbh5hPkZNWIkg2LyXE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=sender:message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        b=A15HmuSv3RvuAoi4Pdca9tGNm30LAmA9wko9YDeSYjJcRXqDFTl+vqJrBieyREDKJ+
         2u6KBEPH+PYwsOS9tqfhsiuBdS1u8MPPa5fLVoHV++si/3rCNSmBZTn/bXFPOgCZLKPq
         Bh0Ri90/YMylKBSAN+fCDv5rlBkR1JCUDEBMA=
Received: by 10.223.4.217 with SMTP id 25mr1992712fas.82.1267950850498;
        Sun, 07 Mar 2010 00:34:10 -0800 (PST)
Received: from yakj.usersys.redhat.com ([85.93.118.17])
        by mx.google.com with ESMTPS id 18sm6478329fks.5.2010.03.07.00.34.08
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 07 Mar 2010 00:34:09 -0800 (PST)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.7) Gecko/20100120 Fedora/3.0.1-1.fc12 Lightning/1.0b2pre Thunderbird/3.0.1
In-Reply-To: <7v6358dbv8.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/141672>

On 03/07/2010 04:55 AM, Junio C Hamano wrote:
> What was the real motive/use case of "cherry-pick --ff"?

Avoiding pointless separation of histories.  It's true that nowadays 
git-patch-id will make a good job of reconciling them, but they do look 
ugly in gitk.

Paolo

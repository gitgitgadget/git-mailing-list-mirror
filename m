From: Paolo Bonzini <bonzini@gnu.org>
Subject: Re: [PATCH 0/5] Update compat/regex
Date: Tue, 17 Aug 2010 13:46:52 +0200
Message-ID: <4C6A76AC.4000704@gnu.org>
References: <20100817080322.GA28476@burratino> <1282037082-12996-1-git-send-email-avarab@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Paolo Bonzini <paolo.bonzini@gmail.com>,
	Andreas Schwab <schwab@linux-m68k.org>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Frank Li <lznuaa@gmail.com>,
	Marius Storm-Olsen <mstormo@gmail.com>,
	Johannes Sixt <j6t@kdbg.org>
To: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Tue Aug 17 13:47:12 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OlKdK-0000Ce-CP
	for gcvg-git-2@lo.gmane.org; Tue, 17 Aug 2010 13:47:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752583Ab0HQLq6 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 17 Aug 2010 07:46:58 -0400
Received: from mail-qy0-f181.google.com ([209.85.216.181]:55430 "EHLO
	mail-qy0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751379Ab0HQLq5 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Aug 2010 07:46:57 -0400
Received: by qyk33 with SMTP id 33so597838qyk.19
        for <git@vger.kernel.org>; Tue, 17 Aug 2010 04:46:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:sender:message-id:date:from
         :user-agent:mime-version:to:cc:subject:references:in-reply-to
         :content-type:content-transfer-encoding;
        bh=VgjyETG51zQezwV/77cNDZeaHXxDw3ShQqundg9X++s=;
        b=ZAdmcpADWqmZtFWFVAYYg60EX+kk2UCtDxtTAD8gX13gKTSlW/wfANdKtfrhKaICgi
         b77pNEowfozV/9CvT16Rh9TDtiNI698cAnUwOCflbq9oDAczay6t2d+FG4LUt47Wif3T
         bbTPq1QrvfqxocfnHaF8CMHVFwuZ7NSuBdyVs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=sender:message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        b=qtyZE+hSlwRJhc2jGkcFgenazeZyw72MMJHlFqHugMhHglaCvhmLRN2fSIZtqqwAKm
         xCTGIRn5u51gB8eqI4ROuORfZ/84aiVPlUEADFd/todMtiey3gqr9C3M37ikocdQN/Qj
         DrxvdYhH6ReBMIihufyBqtKal623DdSfyHVO4=
Received: by 10.224.69.169 with SMTP id z41mr4259077qai.160.1282045616891;
        Tue, 17 Aug 2010 04:46:56 -0700 (PDT)
Received: from yakj.usersys.redhat.com (nat-pool-brq-t.redhat.com [209.132.186.34])
        by mx.google.com with ESMTPS id t1sm8674885qcs.33.2010.08.17.04.46.54
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 17 Aug 2010 04:46:55 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.10) Gecko/20100621 Fedora/3.0.5-1.fc13 Lightning/1.0b2pre Mnenhy/0.8.3 Thunderbird/3.0.5
In-Reply-To: <1282037082-12996-1-git-send-email-avarab@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/153746>

On 08/17/2010 11:24 AM, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
>    compat/regex: use the regex engine from gawk for compat
>    compat/regex: get the gawk regex engine to compile within git

Should these two be squashed to ensure bisectability over a wide range=20
of host systems?

Paolo

From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Which branch(es) contain certain commits? (was Re: (unknown))
Date: Wed, 05 Aug 2015 10:05:04 -0700
Message-ID: <xmqqio8t4qf3.fsf@gitster.dls.corp.google.com>
References: <349031438778845@web22j.yandex.ru>
	<xmqqmvy54qhe.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Ivan Chernyavsky <camposer@yandex.ru>
X-From: git-owner@vger.kernel.org Wed Aug 05 19:05:16 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZN27u-0004UI-3n
	for gcvg-git-2@plane.gmane.org; Wed, 05 Aug 2015 19:05:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752570AbbHERFH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 5 Aug 2015 13:05:07 -0400
Received: from mail-pd0-f176.google.com ([209.85.192.176]:33528 "EHLO
	mail-pd0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751867AbbHERFG (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Aug 2015 13:05:06 -0400
Received: by pdrh1 with SMTP id h1so2988636pdr.0
        for <git@vger.kernel.org>; Wed, 05 Aug 2015 10:05:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=pBaiB9+TcWjeRhwdU91nko1nF1KemEpOW8R97KVAmZ4=;
        b=m6EHbpTaZYxnBYii5fQdQC3N3Sp/pgJQqqpeCXz7fguiReP4YEvRzD4TnbDnNpgBZV
         0G/Mp42vn1SKE0QD5EEkOAY17aDOjmO38pM+NGdFoSNCIVHCqBUCMPk/kKuL4oHp3A52
         8la8aEB8+KvFJmGuL3Xhehsw4kEfjS2zQNGgCtZ67YT2qDtd+VeWrz7370BihfvFFXO2
         FFV06eQRkE3bL6frUdsRUazaQvak17M06f2xTeCndMQSqNlO+4LY13O9pV8CsF4A4wPK
         5YJfqf00bALBYxnTtQDyhogN5z0hUmQqqUbnVk8YNCLZ80V6RiM1L70XjtCrXYMmyDSt
         j62A==
X-Received: by 10.70.103.172 with SMTP id fx12mr1437718pdb.150.1438794305685;
        Wed, 05 Aug 2015 10:05:05 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:5cf0:2451:9503:37d])
        by smtp.gmail.com with ESMTPSA id fs13sm2046286pdb.29.2015.08.05.10.05.04
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Wed, 05 Aug 2015 10:05:04 -0700 (PDT)
In-Reply-To: <xmqqmvy54qhe.fsf@gitster.dls.corp.google.com> (Junio C. Hamano's
	message of "Wed, 05 Aug 2015 10:03:41 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/275377>

Junio C Hamano <gitster@pobox.com> writes:

> I think people do things like:
>
>     git log --all --decorate --grep=...

s/decorate/source/; sorry for the noise.

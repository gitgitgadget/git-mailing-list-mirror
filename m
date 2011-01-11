From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] t/README: hint about using $(pwd) rather than $PWD
 in tests
Date: Tue, 11 Jan 2011 09:47:06 -0800
Message-ID: <7vmxn749k5.fsf@alter.siamese.dyndns.org>
References: <201012302205.13728.j6t@kdbg.org>
 <201012311711.06989.j6t@kdbg.org> <20101231203019.GC5898@burratino>
 <201012312321.31294.j6t@kdbg.org> <7v62u8hz01.fsf@alter.siamese.dyndns.org>
 <4D2C09D7.3070700@viscovery.net> <4D2C0A5E.7090708@viscovery.net>
 <20110111075441.GB9445@burratino> <4D2C11A5.4050709@viscovery.net>
 <20110111083729.GD9445@burratino> <4D2C1AAE.1040002@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	git@vger.kernel.org
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Tue Jan 11 18:47:25 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PciJY-0005HH-Gl
	for gcvg-git-2@lo.gmane.org; Tue, 11 Jan 2011 18:47:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756237Ab1AKRrT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Jan 2011 12:47:19 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:40308 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932276Ab1AKRrS (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Jan 2011 12:47:18 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 7B5503649;
	Tue, 11 Jan 2011 12:47:59 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=XCSECRWHgKAyOKCU9Lj+ckUEluQ=; b=aSx1lB
	rsmVD/Kt39x5d/U6pvR5YvVsXAQp379py6SVYgxV3rpyp4c3YkGX30rP19ghrwSk
	vZDtkmc/Z1UKVarNREeXfXWBOrg8CvSpf5K7JTJpHMPJl/TOEEdvkjkiZ6Fq3IBn
	ovYQ7KFkExTBO5fWVtnQhov0zi7SnbL4BEGuM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=a4Fcm5IoAbkgmQetmEiPMk7vMcfKMRNY
	Hqmm4Wt/QjcqGXKen07ODhEKcFKeIUnsmHnovnYts+Lb0fRr3361UdC7uV4+zfQc
	Uwh6cJ18MZGh1WlQ0TsGiE+7C98luAIewi6OyDWnl4+jmWo7LsC+ohXqbFLhCPy3
	05Oa+gQYFJM=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 395B33643;
	Tue, 11 Jan 2011 12:47:55 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id E3662362C; Tue, 11 Jan 2011
 12:47:49 -0500 (EST)
In-Reply-To: <4D2C1AAE.1040002@viscovery.net> (Johannes Sixt's message of
 "Tue\, 11 Jan 2011 09\:54\:06 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: EB642D10-1DAA-11E0-8F18-CBB45B885003-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/164960>

Johannes Sixt <j.sixt@viscovery.net> writes:

> Am 1/11/2011 9:37, schrieb Jonathan Nieder:
>> I suspect that the reader will end up wondering "why does this have to
>> be so complicated" no matter what.
>
> Unfortunately, yes. Therefore, I'd like to keep the paragraph minimal,
> focused on how expected values should be constructed, which is where
> errors will happen primarily.

I really was hoping for something simple like "never use $PWD" myself,
though X-<.

Anyway, will queue for 1.7.4.  Thanks.

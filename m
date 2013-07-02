From: Chris Packham <judge.packham@gmail.com>
Subject: Re: [RFC/PATCHv2] submodule: add ability to configure update command
Date: Tue, 02 Jul 2013 21:59:17 +1200
Message-ID: <51D2A475.9010608@gmail.com>
References: <51D04F06.9000400@web.de> <1372673494-24286-1-git-send-email-judge.packham@gmail.com> <7v1u7ii5us.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Jens.Lehmann@web.de, iveqy@iveqy.com,
	stefan.naewe@atlas-elektronik.com, hvoigt@hvoigt.net
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jul 02 11:58:22 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UtxLp-0005Qs-Mf
	for gcvg-git-2@plane.gmane.org; Tue, 02 Jul 2013 11:58:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755287Ab3GBJ6S (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Jul 2013 05:58:18 -0400
Received: from mail-pa0-f42.google.com ([209.85.220.42]:34910 "EHLO
	mail-pa0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753549Ab3GBJ6R (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Jul 2013 05:58:17 -0400
Received: by mail-pa0-f42.google.com with SMTP id rl6so6127465pac.1
        for <git@vger.kernel.org>; Tue, 02 Jul 2013 02:58:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=a3QtR/w2E94JDAwRW1W0DkGesPya511Bx6pupBy4Yn0=;
        b=XNsSbvbS6fhATfrVAbzbrodYBB4PPPdPXe+lNzb9CmqM99hSHkKQs3SqV8CSVvR+BT
         7usXbJGNZH7P2USJ/BqJUYggFypk7LnnbOgB0L1+NeVn7sWQ3Lp2WK8iiHGqmn5uhmS8
         iBr+u6j8oY7VWh9CgvS+5iqGlP3Rl3Bv07WPWzWHVV5/MRsjz2+rd79R/quz3azbBahq
         aGVX+WSTzV8KkFFu+vbOywpaJf/WrFJqEM0FISf55At3a/1RBZGltF4WyU3TVdzLF74X
         vzHzbge+5eg0LmJ2420F7E/KI82wm68Ljj8kW7KulNGqxIJtik/lVbKyWAzjgQCAzshW
         aShA==
X-Received: by 10.68.35.131 with SMTP id h3mr28206194pbj.140.1372759096681;
        Tue, 02 Jul 2013 02:58:16 -0700 (PDT)
Received: from laptop.site (115-188-15-163.jetstream.xtra.co.nz. [115.188.15.163])
        by mx.google.com with ESMTPSA id fr1sm26687474pbb.26.2013.07.02.02.58.13
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Tue, 02 Jul 2013 02:58:16 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:17.0) Gecko/20130510 Thunderbird/17.0.6
In-Reply-To: <7v1u7ii5us.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/229388>

On 02/07/13 04:48, Junio C Hamano wrote:
> Chris Packham <judge.packham@gmail.com> writes:
> 
>> +			!*)
>> +				command="$(expr "$update_module" : '!\(.*\)')"
> 
> 	command=${command#!}
> 

Thanks, expr was my attempt to avoid using a ${command:1} bash-ism. v3
on it's way.

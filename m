From: Stefano Lattarini <stefano.lattarini@gmail.com>
Subject: Re: New special handing of '@' character broke my use case
Date: Wed, 14 Aug 2013 20:20:54 +0100
Message-ID: <520BD896.4020501@gmail.com>
References: <520BC017.7050907@gmail.com> <7vd2pgtagc.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Aug 14 21:21:06 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V9gcy-00053o-Na
	for gcvg-git-2@plane.gmane.org; Wed, 14 Aug 2013 21:21:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760026Ab3HNTU7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 Aug 2013 15:20:59 -0400
Received: from mail-we0-f171.google.com ([74.125.82.171]:50695 "EHLO
	mail-we0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758636Ab3HNTU6 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Aug 2013 15:20:58 -0400
Received: by mail-we0-f171.google.com with SMTP id q55so8250069wes.30
        for <git@vger.kernel.org>; Wed, 14 Aug 2013 12:20:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=+eYQv3q4Te3JdPBx8HVXQIP+KYWBeZHeLECTNiGBsYY=;
        b=a/NemFf1ZjybcP3lg9FZLv0NP1Hh/8nd3SSf3wx4yDedfubECG5FubhdLh83Mq4WJz
         9pjhAiwZU4rhHQS6OMxbNDUHG5xaXzgKJ3bAJSmgMWXNDHu01VpKT+xAAdKJkd1b2nAL
         7SP+YIPd+8edUcQqcy3BisWGCPxDOo/bQuU+HUNeKlSjRXl8zURfWVau3qJcTZIfUo+n
         EOSEITbJDXV58eY9EFUina6/guH1G6i4lVVYge7aKvPwLIbFVSBbrt1tRIzPaHETS+um
         52VYaF8//EJ7ApNH76ZMcd+dBj1aa0cvBhPZVS36UZLpSJkcBUbbChcGuaGFNYRvan7Q
         SpyA==
X-Received: by 10.180.10.99 with SMTP id h3mr2683351wib.0.1376508056718;
        Wed, 14 Aug 2013 12:20:56 -0700 (PDT)
Received: from marcovaldo.dub.corp.google.com ([2620:0:1040:205:8a51:fbff:fe5c:1cad])
        by mx.google.com with ESMTPSA id r6sm4791065wiw.0.2013.08.14.12.20.55
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Wed, 14 Aug 2013 12:20:55 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130804 Thunderbird/17.0.8
In-Reply-To: <7vd2pgtagc.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/232312>

[re-sending to the list, sorry Junio for the duplicate mail]

On 08/14/2013 07:05 PM, Junio C Hamano wrote:
 > Stefano Lattarini <stefano.lattarini@gmail.com> writes:
 >
 >> My problems is that some new automagical interpretation of the bare
 >> @' character (introduced after 1.8.3) has destroyed my use case:
 >> ...
 >> I don't want to ask you to revert this new behaviour, but I'd like to
 >> at least have an option to disable it.
 >
 > I do not think it is simply not worth the complexity to selectively
 > disable it.  If it is a regression, it is much better to simply
 > revert, if we can (it appears that cdfd9483 (Add new @ shortcut for
 > HEAD, 2013-05-07) can be reverted without any textual context, but
 > there may already be new stuff that depends on the "@").
 >
I'm not sure I want to force a revert simply to cater to a personal 
idiom of mine (and not that important).  I'd first like to hear what the 
community thinks about the issue (with silence meaning "don't revert").

 > For the upcoming release, I am very much tempted to revert it and
 > let the topic retried, by people who really want the "let's save
 > four keystrokes and replace it with @ aka Shift-<something>",
 > without hurting your use case (and others), after the upcoming
 > release.
 >
 > What do others think?
 >
I second this question :-)

Thanks,
   Stefano

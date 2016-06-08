From: Samuel GROOT <samuel.groot@grenoble-inp.org>
Subject: Re: [PATCH v4 1/6] t9001: non order-sensitive file comparison
Date: Wed, 8 Jun 2016 21:21:45 +0200
Message-ID: <596b7473-817a-1a92-8253-ca77a7bd88a8@grenoble-inp.org>
References: <20160607140148.23242-1-tom.russello@grenoble-inp.org>
 <20160608130142.29879-1-samuel.groot@grenoble-inp.org>
 <20160608130142.29879-2-samuel.groot@grenoble-inp.org>
 <xmqqr3c7mxg4.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, tom.russello@grenoble-inp.org,
	erwan.mathoniere@grenoble-inp.org, jordan.de-gea@grenoble-inp.org,
	matthieu.moy@grenoble-inp.fr, aaron@schrab.com, e@80x24.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jun 08 21:21:52 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1bAj31-0004OO-FT
	for gcvg-git-2@plane.gmane.org; Wed, 08 Jun 2016 21:21:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161931AbcFHTVr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 8 Jun 2016 15:21:47 -0400
Received: from zm-smtpout-1.grenet.fr ([130.190.244.97]:46256 "EHLO
	zm-smtpout-1.grenet.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754463AbcFHTVq (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 Jun 2016 15:21:46 -0400
Received: from localhost (localhost [127.0.0.1])
	by zm-smtpout-1.grenet.fr (Postfix) with ESMTP id EA7C62584;
	Wed,  8 Jun 2016 21:21:44 +0200 (CEST)
Received: from zm-smtpout-1.grenet.fr ([127.0.0.1])
	by localhost (zm-smtpout-1.grenet.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id yXokUuyM6rQd; Wed,  8 Jun 2016 21:21:44 +0200 (CEST)
Received: from zm-smtpauth-2.grenet.fr (zm-smtpauth-2.grenet.fr [130.190.244.123])
	by zm-smtpout-1.grenet.fr (Postfix) with ESMTP id DA51D222F;
	Wed,  8 Jun 2016 21:21:44 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by zm-smtpauth-2.grenet.fr (Postfix) with ESMTP id D4C9B2066;
	Wed,  8 Jun 2016 21:21:44 +0200 (CEST)
Received: from zm-smtpauth-2.grenet.fr ([127.0.0.1])
	by localhost (zm-smtpauth-2.grenet.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id LwhcSdphedCm; Wed,  8 Jun 2016 21:21:44 +0200 (CEST)
Received: from wificampus-030012.grenet.fr (wificampus-030012.grenet.fr [130.190.30.12])
	by zm-smtpauth-2.grenet.fr (Postfix) with ESMTPSA id BB6E42064;
	Wed,  8 Jun 2016 21:21:44 +0200 (CEST)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.1.0
In-Reply-To: <xmqqr3c7mxg4.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/296837>

On 06/08/2016 06:56 PM, Junio C Hamano wrote:
 > The earliest address patch@example.com and later addresses have
 > quite different meaning (the first one is meant to be the envelope
 > sender address, and does not name a recipient). While I think it is
 > a good idea to tell the test that the order of recipient addresses
 > given to the sendmail command (i.e. nobody, author, one and two)
 > does not matter by comparing sorted list of addresses, sorting the
 > whole argument list and comparing is making the test _too_ loose.
 > Don't you want to catch a potential bug that adds the envelope
 > sender address to the list of recipients by mistake, for example?

That could be an idea to make a more precise test. But I rather focus on 
our `--quote-email` option, I will put this one aside for now.

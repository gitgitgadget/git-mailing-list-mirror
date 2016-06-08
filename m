From: Samuel GROOT <samuel.groot@grenoble-inp.org>
Subject: Re: [PATCH v4 1/6] t9001: non order-sensitive file comparison
Date: Wed, 8 Jun 2016 16:29:37 +0200
Message-ID: <b79fa65c-c28b-534c-29f4-0998f75c2275@grenoble-inp.org>
References: <20160607140148.23242-1-tom.russello@grenoble-inp.org>
 <20160608130142.29879-1-samuel.groot@grenoble-inp.org>
 <20160608130142.29879-2-samuel.groot@grenoble-inp.org>
 <1755917243.420844.1465395729704.JavaMail.zimbra@ensimag.grenoble-inp.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, tom russello <tom.russello@grenoble-inp.org>,
	erwan mathoniere <erwan.mathoniere@grenoble-inp.org>,
	jordan de-gea <jordan.de-gea@grenoble-inp.org>,
	matthieu moy <matthieu.moy@grenoble-inp.fr>, gitster@pobox.com,
	aaron@schrab.com, e@80x24.org
To: Remi Galan Alfonso <remi.galan-alfonso@ensimag.grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Wed Jun 08 16:29:44 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1bAeUJ-0004Gv-PI
	for gcvg-git-2@plane.gmane.org; Wed, 08 Jun 2016 16:29:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932620AbcFHO3k (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 8 Jun 2016 10:29:40 -0400
Received: from zm-smtpout-2.grenet.fr ([130.190.244.98]:50879 "EHLO
	zm-smtpout-2.grenet.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932526AbcFHO3j (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 Jun 2016 10:29:39 -0400
Received: from localhost (localhost [127.0.0.1])
	by zm-smtpout-2.grenet.fr (Postfix) with ESMTP id B293B20B2;
	Wed,  8 Jun 2016 16:29:36 +0200 (CEST)
Received: from zm-smtpout-2.grenet.fr ([127.0.0.1])
	by localhost (zm-smtpout-2.grenet.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id dVsOuX0nH2ZC; Wed,  8 Jun 2016 16:29:36 +0200 (CEST)
Received: from zm-smtpauth-2.grenet.fr (zm-smtpauth-2.grenet.fr [130.190.244.123])
	by zm-smtpout-2.grenet.fr (Postfix) with ESMTP id 9BB2420A5;
	Wed,  8 Jun 2016 16:29:36 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by zm-smtpauth-2.grenet.fr (Postfix) with ESMTP id 985CE2066;
	Wed,  8 Jun 2016 16:29:36 +0200 (CEST)
Received: from zm-smtpauth-2.grenet.fr ([127.0.0.1])
	by localhost (zm-smtpauth-2.grenet.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Zw8iQO0QIz8n; Wed,  8 Jun 2016 16:29:36 +0200 (CEST)
Received: from wificampus-030012.grenet.fr (wificampus-030012.grenet.fr [130.190.30.12])
	by zm-smtpauth-2.grenet.fr (Postfix) with ESMTPSA id 7F2482064;
	Wed,  8 Jun 2016 16:29:36 +0200 (CEST)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.1.0
In-Reply-To: <1755917243.420844.1465395729704.JavaMail.zimbra@ensimag.grenoble-inp.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/296800>

On 06/08/2016 04:22 PM, Remi Galan Alfonso wrote:
>> +test_cmp_noorder () {
>> +        sort "$1" >"$1_noorder"
>> +        sort "$2" >"$2_noorder"
>> +        test_cmp $1 $2
>
> You meant `test_cmp "$1_noorder" "$2_noorder"`, I guess.

Yes, thanks for pointing it out!

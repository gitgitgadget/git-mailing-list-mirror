From: Samuel GROOT <samuel.groot@grenoble-inp.org>
Subject: Re: [PATCH v3 3/6] t9001: shorten send-email's output
Date: Wed, 8 Jun 2016 11:30:52 +0200
Message-ID: <94ee5590-2832-afc0-a717-f795d88f03c3@grenoble-inp.org>
References: <1464369102-7551-1-git-send-email-tom.russello@grenoble-inp.org>
 <20160607140148.23242-1-tom.russello@grenoble-inp.org>
 <20160607140148.23242-4-tom.russello@grenoble-inp.org>
 <20160608083607.GA9107@dcvr.yhbt.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, erwan.mathoniere@grenoble-inp.org,
	jordan.de-gea@grenoble-inp.org, matthieu.moy@grenoble-inp.fr,
	aaron@schrab.com, gitster@pobox.com
To: Eric Wong <e@80x24.org>,
	Tom Russello <tom.russello@grenoble-inp.org>
X-From: git-owner@vger.kernel.org Wed Jun 08 11:31:15 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1bAZpR-0005Iz-Mr
	for gcvg-git-2@plane.gmane.org; Wed, 08 Jun 2016 11:31:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423967AbcFHJa6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 8 Jun 2016 05:30:58 -0400
Received: from zm-smtpout-2.grenet.fr ([130.190.244.98]:44090 "EHLO
	zm-smtpout-2.grenet.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1422984AbcFHJay (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 Jun 2016 05:30:54 -0400
Received: from localhost (localhost [127.0.0.1])
	by zm-smtpout-2.grenet.fr (Postfix) with ESMTP id 9F8D720B2;
	Wed,  8 Jun 2016 11:30:51 +0200 (CEST)
Received: from zm-smtpout-2.grenet.fr ([127.0.0.1])
	by localhost (zm-smtpout-2.grenet.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id QSxTLvX4MDew; Wed,  8 Jun 2016 11:30:51 +0200 (CEST)
Received: from zm-smtpauth-2.grenet.fr (zm-smtpauth-2.grenet.fr [130.190.244.123])
	by zm-smtpout-2.grenet.fr (Postfix) with ESMTP id 8DA5320AD;
	Wed,  8 Jun 2016 11:30:51 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by zm-smtpauth-2.grenet.fr (Postfix) with ESMTP id 8A6352066;
	Wed,  8 Jun 2016 11:30:51 +0200 (CEST)
Received: from zm-smtpauth-2.grenet.fr ([127.0.0.1])
	by localhost (zm-smtpauth-2.grenet.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id fGE4x3HIU_Uj; Wed,  8 Jun 2016 11:30:51 +0200 (CEST)
Received: from wificampus-030012.grenet.fr (wificampus-030012.grenet.fr [130.190.30.12])
	by zm-smtpauth-2.grenet.fr (Postfix) with ESMTPSA id 712F92064;
	Wed,  8 Jun 2016 11:30:51 +0200 (CEST)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.1.0
In-Reply-To: <20160608083607.GA9107@dcvr.yhbt.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/296774>

On 06/08/2016 10:36 AM, Eric Wong wrote:
> Tom Russello <tom.russello@grenoble-inp.org> wrote:
>> Messages displayed by `send-email` should be shortened to avoid displaying
>> unnecesseray informations.
>
> unnecessary information.
>
> In some of your other patches, the 'grep' can probably
> be better replaced by 'fgrep' for fixed strings.
> Otherwise, the '.' in the 'example.com' would match any
> character instead of the intended dot.

Thanks, will re-roll

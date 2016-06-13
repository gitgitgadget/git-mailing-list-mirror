From: Samuel GROOT <samuel.groot@grenoble-inp.org>
Subject: Re: [PATCH v3 2/6] t9001: check email address is in Cc: field
Date: Tue, 14 Jun 2016 00:23:44 +0200
Message-ID: <274b83e5-3ac7-e1e5-4904-649c308cfaf4@grenoble-inp.org>
References: <1464369102-7551-1-git-send-email-tom.russello@grenoble-inp.org>
 <20160607140148.23242-1-tom.russello@grenoble-inp.org>
 <20160607140148.23242-3-tom.russello@grenoble-inp.org>
 <vpqinxiykgk.fsf@anie.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, erwan.mathoniere@grenoble-inp.org,
	jordan.de-gea@grenoble-inp.org, e@80x24.org, aaron@schrab.com,
	gitster@pobox.com, Tom RUSSELLO <tom.ressullo@grenoble-inp.org>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Tom Russello <tom.russello@grenoble-inp.org>
X-From: git-owner@vger.kernel.org Tue Jun 14 00:23:53 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1bCaGt-0006KX-K5
	for gcvg-git-2@plane.gmane.org; Tue, 14 Jun 2016 00:23:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1424229AbcFMWXs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 13 Jun 2016 18:23:48 -0400
Received: from zm-smtpout-1.grenet.fr ([130.190.244.97]:53663 "EHLO
	zm-smtpout-1.grenet.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1424172AbcFMWXr (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 Jun 2016 18:23:47 -0400
Received: from localhost (localhost [127.0.0.1])
	by zm-smtpout-1.grenet.fr (Postfix) with ESMTP id 54B0725BE;
	Tue, 14 Jun 2016 00:23:45 +0200 (CEST)
Received: from zm-smtpout-1.grenet.fr ([127.0.0.1])
	by localhost (zm-smtpout-1.grenet.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id PV9zjcJkR58U; Tue, 14 Jun 2016 00:23:45 +0200 (CEST)
Received: from zm-smtpauth-2.grenet.fr (zm-smtpauth-2.grenet.fr [130.190.244.123])
	by zm-smtpout-1.grenet.fr (Postfix) with ESMTP id 4233F25A0;
	Tue, 14 Jun 2016 00:23:45 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by zm-smtpauth-2.grenet.fr (Postfix) with ESMTP id 372D52066;
	Tue, 14 Jun 2016 00:23:45 +0200 (CEST)
Received: from zm-smtpauth-2.grenet.fr ([127.0.0.1])
	by localhost (zm-smtpauth-2.grenet.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id bq4Fqg5Q-VjO; Tue, 14 Jun 2016 00:23:45 +0200 (CEST)
Received: from localhost.localdomain (che44-2-88-185-231-114.fbx.proxad.net [88.185.231.114])
	by zm-smtpauth-2.grenet.fr (Postfix) with ESMTPSA id CFD8A2064;
	Tue, 14 Jun 2016 00:23:44 +0200 (CEST)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.1.0
In-Reply-To: <vpqinxiykgk.fsf@anie.imag.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/297254>

On 06/09/2016 07:55 AM, Matthieu Moy wrote:
> Tom Russello <tom.russello@grenoble-inp.org> writes:
>
>> Check if the given utf-8 email address is in the Cc: field.
>
> I wouldn't harm to explain what was the problem with existing code here.
> If I understand correctly, that would be:
>
>   Existing code just checked that the address appeared in a line starting
>   with a space, but not to which field the address belonged.
>
> But probably the real motivation for this was that you want to introduce
> code that changes the layout and breaks this "address appears on a line
> starting with space"?

Actually it was both, we wanted to make the tests less dependent to how 
data was displayed.

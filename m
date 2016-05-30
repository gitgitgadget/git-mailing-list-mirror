From: Samuel GROOT <samuel.groot@grenoble-inp.org>
Subject: Re: [WIP-PATCH 1/2] send-email: create email parser subroutine
Date: Mon, 30 May 2016 15:28:08 +0200
Message-ID: <982672c0-0642-06a2-46dd-8c538568f4bc@grenoble-inp.org>
References: <20160527140104.11192-1-samuel.groot@grenoble-inp.org>
 <20160527140104.11192-2-samuel.groot@grenoble-inp.org>
 <vpqeg8mi4wm.fsf@anie.imag.fr> <20160528233329.GA1132@dcvr.yhbt.net>
 <8904f487-985c-bd2d-a8d1-4a712c6ef558@grenoble-inp.org>
 <vpqpos4hht5.fsf@anie.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Eric Wong <e@80x24.org>, git@vger.kernel.org,
	erwan.mathoniere@grenoble-inp.org, jordan.de-gea@grenoble-inp.org,
	gitster@pobox.com, aaron@schrab.com,
	Tom RUSSELLO <tom.russello@grenoble-inp.org>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Mon May 30 15:28:27 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b7NF4-00066v-JN
	for gcvg-git-2@plane.gmane.org; Mon, 30 May 2016 15:28:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933371AbcE3N2N (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 30 May 2016 09:28:13 -0400
Received: from zm-smtpout-1.grenet.fr ([130.190.244.97]:37434 "EHLO
	zm-smtpout-1.grenet.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932192AbcE3N2L (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 May 2016 09:28:11 -0400
Received: from localhost (localhost [127.0.0.1])
	by zm-smtpout-1.grenet.fr (Postfix) with ESMTP id D8CFD24A7;
	Mon, 30 May 2016 15:28:07 +0200 (CEST)
Received: from zm-smtpout-1.grenet.fr ([127.0.0.1])
	by localhost (zm-smtpout-1.grenet.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id dl5FEm5irqqd; Mon, 30 May 2016 15:28:07 +0200 (CEST)
Received: from zm-smtpauth-2.grenet.fr (zm-smtpauth-2.grenet.fr [130.190.244.123])
	by zm-smtpout-1.grenet.fr (Postfix) with ESMTP id C8754246D;
	Mon, 30 May 2016 15:28:07 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by zm-smtpauth-2.grenet.fr (Postfix) with ESMTP id C28842077;
	Mon, 30 May 2016 15:28:07 +0200 (CEST)
Received: from zm-smtpauth-2.grenet.fr ([127.0.0.1])
	by localhost (zm-smtpauth-2.grenet.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Eppo_T5wzq5C; Mon, 30 May 2016 15:28:07 +0200 (CEST)
Received: from wificampus-028107.grenet.fr (wificampus-028107.grenet.fr [130.190.28.107])
	by zm-smtpauth-2.grenet.fr (Postfix) with ESMTPSA id AA11E2066;
	Mon, 30 May 2016 15:28:07 +0200 (CEST)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.0
In-Reply-To: <vpqpos4hht5.fsf@anie.imag.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/295894>

On 05/29/2016 07:53 PM, Matthieu Moy wrote:
> Samuel GROOT <samuel.groot@grenoble-inp.org> writes:
>
>> So should we merge parse_email and parse_header in one unique
>> subroutine?
>
> At least on the user (i.e. caller of the API) side, one function is
> probably enough.
>

I will do that, as soon as we decide what's best between including 
Email::Simple library or making our own API.

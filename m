From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [PATCH 09/19] tree-diff.c: reserve space in "base" for pathname
 concatenation
Date: Tue, 14 Dec 2010 09:21:04 +0100
Message-ID: <4D0728F0.9020807@viscovery.net>
References: <1292233616-27692-1-git-send-email-pclouds@gmail.com> <1292233616-27692-10-git-send-email-pclouds@gmail.com> <7vlj3t35ol.fsf@alter.siamese.dyndns.org> <AANLkTi=5QgkBd434=Z7MCA_ZNZCXVyXJYh_fd1A+B2ue@mail.gmail.com> <7vvd2wvs0m.fsf@alter.siamese.dyndns.org> <4D071DAA.3070400@viscovery.net> <AANLkTimzmq8gUpXUZ801Q+pua_mZMHTJ6wYt_CwcTr3v@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Tue Dec 14 09:21:21 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PSQ8O-0005Oc-Pe
	for gcvg-git-2@lo.gmane.org; Tue, 14 Dec 2010 09:21:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756301Ab0LNIVJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 14 Dec 2010 03:21:09 -0500
Received: from lilzmailso01.liwest.at ([212.33.55.23]:51718 "EHLO
	lilzmailso01.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756153Ab0LNIVI (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 14 Dec 2010 03:21:08 -0500
Received: from [81.10.228.254] (helo=theia.linz.viscovery)
	by lilzmailso01.liwest.at with esmtpa (Exim 4.69)
	(envelope-from <j.sixt@viscovery.net>)
	id 1PSQ88-0007NS-Iv; Tue, 14 Dec 2010 09:21:04 +0100
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.95])
	by theia.linz.viscovery (Postfix) with ESMTP id 511381660F;
	Tue, 14 Dec 2010 09:21:04 +0100 (CET)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; de; rv:1.9.2.12) Gecko/20101027 Thunderbird/3.1.6
In-Reply-To: <AANLkTimzmq8gUpXUZ801Q+pua_mZMHTJ6wYt_CwcTr3v@mail.gmail.com>
X-Enigmail-Version: 1.1.1
X-Spam-Score: -1.4 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/163634>

Am 12/14/2010 8:43, schrieb Nguyen Thai Ngoc Duy:
> On Tue, Dec 14, 2010 at 2:32 PM, Johannes Sixt <j.sixt@viscovery.net> wrote:
>> Am 12/14/2010 6:32, schrieb Junio C Hamano:
>>> Nguyen Thai Ngoc Duy <pclouds@gmail.com> writes:
>>>
>>>> All paths should not exceed PATH_MAX, right?
>>>
>>> Your PATH_MAX may be a lot shorter than the PATH_MAX on the system I
>>> created my trees on that you are reading.
>>
>> And that is not just gray theory: On Windows, PATH_MAX is whopping 260
>> characters!
> 
> Does that mean Windows won't accept any path longer than that, or
> PATH_MAX is defined just for fun?

It is the limit for path names that we can have without MAJOR extra
efforts. It is not a limit implied by the file system.

-- Hannes
